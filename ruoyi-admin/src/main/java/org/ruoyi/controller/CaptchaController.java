package org.ruoyi.controller;

import cn.dev33.satoken.annotation.SaIgnore;
import cn.hutool.captcha.AbstractCaptcha;
import cn.hutool.captcha.generator.CodeGenerator;
import cn.hutool.core.util.IdUtil;
import cn.hutool.core.util.RandomUtil;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.core.constant.Constants;
import org.ruoyi.common.core.constant.GlobalConstants;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.service.ConfigService;
import org.ruoyi.common.core.utils.SpringUtils;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.core.utils.reflect.ReflectUtils;
import org.ruoyi.common.mail.utils.MailUtils;
import org.ruoyi.common.redis.utils.RedisUtils;
import org.ruoyi.common.sms.config.properties.SmsProperties;
import org.ruoyi.common.sms.core.SmsTemplate;
import org.ruoyi.common.sms.entity.SmsResult;
import org.ruoyi.common.web.config.properties.CaptchaProperties;
import org.ruoyi.common.web.enums.CaptchaType;
import org.ruoyi.system.domain.request.EmailRequest;
import org.ruoyi.system.domain.vo.CaptchaVo;
import org.ruoyi.system.service.ISysUserService;
import org.ruoyi.system.domain.bo.SysUserBo;
import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import java.time.Duration;
import java.util.HashMap;
import java.util.Map;

/**
 * 验证码操作处理
 *
 * @author Lion Li
 */
@SaIgnore
@Slf4j
@Validated
@RequiredArgsConstructor
@RestController
public class CaptchaController {

    private final CaptchaProperties captchaProperties;
    private final SmsProperties smsProperties;
    private final ConfigService configService;
    private final ISysUserService userService;

    /**
     * 短信验证码
     *
     * @param phonenumber 用户手机号
     * @param scene 使用场景：register-注册、login-登录、bind-绑定、reset-重置密码
     */
    @GetMapping("/resource/sms/code")
    public R<Void> smsCode(
        @NotBlank(message = "{user.phonenumber.not.blank}") String phonenumber,
        String scene) {
        
        if (!smsProperties.getEnabled()) {
            return R.fail("当前系统没有开启短信功能！");
        }
        
        // 验证手机号格式
        if (!phonenumber.matches("^1[3-9]\\d{9}$")) {
            return R.fail("手机号格式不正确");
        }
        
        // 根据使用场景验证手机号注册状态
        String normalizedScene = StringUtils.isBlank(scene) ? "login" : scene.toLowerCase();
        R<Void> validationResult = validatePhoneForScene(phonenumber, normalizedScene);
        if (!R.isSuccess(validationResult)) {
            return validationResult;
        }
        
        String key = GlobalConstants.CAPTCHA_CODE_KEY + phonenumber;
        String code = RandomUtil.randomNumbers(4);
        RedisUtils.setCacheObject(key, code, Duration.ofMinutes(Constants.CAPTCHA_EXPIRATION));
        
                // 验证码模板id
        String templateId = "SMS_324450504";
        Map<String, String> map = new HashMap<>(1);
        map.put("code", code);
        try {
            SmsTemplate smsTemplate = SpringUtils.getBean(SmsTemplate.class);
            log.info("开始发送短信验证码 - phone: {}, scene: {}, templateId: {}, code: {}", phonenumber, normalizedScene, templateId, code);
            
            SmsResult result = smsTemplate.send(phonenumber, templateId, map);
            
            // 详细记录阿里云API响应
            log.info("阿里云短信API响应 - phone: {}, success: {}, message: {}, result: {}", 
                    phonenumber, result.isSuccess(), result.getMessage(), result);
            
            if (!result.isSuccess()) {
                log.error("验证码短信发送失败 - phone: {}, result: {}", phonenumber, result);
                return R.fail("短信发送失败: " + result.getMessage());
            }
            
            log.info("短信验证码发送成功 - phone: {}, scene: {}, result: {}", 
                    phonenumber, normalizedScene, result);
        } catch (Exception e) {
            log.error("短信服务未正确配置或启用 - phone: {}, scene: {}, error: {}", phonenumber, normalizedScene, e.getMessage(), e);
            return R.fail("短信服务暂时不可用，请检查系统配置或联系管理员");
        }
        return R.ok();
    }
    
    /**
     * 根据使用场景验证手机号状态
     *
     * @param phonenumber 手机号
     * @param scene 使用场景
     * @return 验证结果
     */
    private R<Void> validatePhoneForScene(String phonenumber, String scene) {
        // 检查手机号是否已被注册
        SysUserBo userBo = new SysUserBo();
        userBo.setPhonenumber(phonenumber);
        boolean phoneExists = !userService.checkPhoneUnique(userBo);
        
        switch (scene) {
            case "register":
                // 注册场景：手机号不能已被注册
                if (phoneExists) {
                    return R.fail("该手机号已被注册，请直接登录或使用其他手机号");
                }
                break;
                
            case "login":
                // 登录场景：手机号必须已被注册
                if (!phoneExists) {
                    return R.fail("该手机号尚未注册，请先注册或检查手机号是否正确");
                }
                break;
                
            case "reset":
                // 重置密码场景：手机号必须已被注册
                if (!phoneExists) {
                    return R.fail("该手机号尚未注册，无法重置密码");
                }
                break;
                
            case "bind":
                // 绑定场景：手机号不能已被其他用户注册（当前接口不需要用户登录信息，所以只能简单检查）
                if (phoneExists) {
                    return R.fail("该手机号已被其他用户使用，请选择其他手机号");
                }
                break;
                
            default:
                // 默认场景：不做限制，兼容原有逻辑
                log.warn("未知的短信验证码使用场景: {}, 跳过手机号验证", scene);
                break;
        }
        
        return R.ok();
    }

    /**
     * 邮箱验证码
     *
     * @param emailRequest 用户邮箱
     */
    @PostMapping("/resource/email/code")
    public R<Void> emailCode(@RequestBody @Valid EmailRequest emailRequest) {
        String key = GlobalConstants.CAPTCHA_CODE_KEY + emailRequest.getUsername();
        String code = RandomUtil.randomNumbers(4);
        RedisUtils.setCacheObject(key, code, Duration.ofMinutes(Constants.CAPTCHA_EXPIRATION));
        // 自定义邮箱模板
        String model = configService.getConfigValue("mail", "mailModel");
        String mailTitle = configService.getConfigValue("mail", "mailTitle");
        String replacedModel = model.replace("{code}", code);
        try {
            MailUtils.sendHtml(emailRequest.getUsername(), mailTitle, replacedModel);
        } catch (Exception e) {
            log.error("邮箱验证码发送异常 => {}", e.getMessage());
            return R.fail(e.getMessage());
        }
        return R.ok();
    }

    /**
     * 生成验证码
     */
    @GetMapping("/auth/code")
    public R<CaptchaVo> getCode() {
        CaptchaVo captchaVo = new CaptchaVo();
        boolean captchaEnabled = captchaProperties.getEnable();
        if (!captchaEnabled) {
            captchaVo.setCaptchaEnabled(false);
            return R.ok(captchaVo);
        }
        // 保存验证码信息
        String uuid = IdUtil.simpleUUID();
        String verifyKey = GlobalConstants.CAPTCHA_CODE_KEY + uuid;
        // 生成验证码
        CaptchaType captchaType = captchaProperties.getType();
        boolean isMath = CaptchaType.MATH == captchaType;
        Integer length = isMath ? captchaProperties.getNumberLength() : captchaProperties.getCharLength();
        CodeGenerator codeGenerator = ReflectUtils.newInstance(captchaType.getClazz(), length);
        AbstractCaptcha captcha = SpringUtils.getBean(captchaProperties.getCategory().getClazz());
        captcha.setGenerator(codeGenerator);
        captcha.createCode();
        String code = captcha.getCode();
        if (isMath) {
            ExpressionParser parser = new SpelExpressionParser();
            Expression exp = parser.parseExpression(StringUtils.remove(code, "="));
            code = exp.getValue(String.class);
        }
        RedisUtils.setCacheObject(verifyKey, code, Duration.ofMinutes(Constants.CAPTCHA_EXPIRATION));
        captchaVo.setUuid(uuid);
        captchaVo.setImg(captcha.getImageBase64());
        return R.ok(captchaVo);
    }

}
