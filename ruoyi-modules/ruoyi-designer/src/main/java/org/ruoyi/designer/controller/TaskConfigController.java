package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckRole;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.core.validate.EditGroup;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.designer.domain.enums.ReviewMode;
import org.ruoyi.designer.util.TaskConfigService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

/**
 * 任务配置管理Controller
 * 提供审核模式动态配置和查询功能
 *
 * @author ruoyi
 */
@Slf4j
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/task-config")
public class TaskConfigController {

    private final TaskConfigService taskConfigService;

    /**
     * 获取当前任务配置信息
     * 仅超级管理员可访问
     */
    @SaCheckRole("superadmin")
    @GetMapping("/info")
    public R<Map<String, Object>> getConfigInfo() {
        Map<String, Object> config = new HashMap<>();
        config.put("reviewMode", taskConfigService.getReviewMode());
        config.put("reviewModeName", taskConfigService.getReviewMode().getName());
        config.put("reviewModeDescription", taskConfigService.getReviewMode().getDescription());
        config.put("isDualReviewMode", taskConfigService.isDualReviewMode());
        config.put("isEnterpriseReviewMode", taskConfigService.isEnterpriseReviewMode());
        config.put("adminReviewTimeoutHours", taskConfigService.getAdminReviewTimeoutHours());
        config.put("enterpriseReviewTimeoutHours", taskConfigService.getEnterpriseReviewTimeoutHours());
        config.put("autoWithdrawEnabled", taskConfigService.isAutoWithdrawEnabled());
        config.put("notificationEnabled", taskConfigService.isNotificationEnabled());
        config.put("logRetentionDays", taskConfigService.getLogRetentionDays());
        config.put("configSummary", taskConfigService.getConfigSummary());
        config.put("configValid", taskConfigService.isConfigValid());
        
        return R.ok(config);
    }

    /**
     * 动态更新审核模式
     * 仅超级管理员可操作
     * 
     * @param reviewMode 审核模式
     * @return 更新结果
     */
    @SaCheckRole("superadmin")
    @PostMapping("/review-mode/{reviewMode}")
    public R<String> updateReviewMode(@PathVariable String reviewMode) {
        try {
            ReviewMode mode = ReviewMode.valueOf(reviewMode.toUpperCase());
            boolean success = taskConfigService.updateReviewMode(mode);
            
            if (success) {
                log.info("审核模式已更新为: {} by user: {}", mode.getName(), LoginHelper.getUserId());
                return R.ok("审核模式已更新为: " + mode.getName());
            } else {
                return R.fail("审核模式更新失败");
            }
        } catch (IllegalArgumentException e) {
            return R.fail("无效的审核模式: " + reviewMode + "，支持的模式: DUAL, ENTERPRISE");
        }
    }

    /**
     * 重置配置为默认值
     * 仅超级管理员可操作
     */
    @SaCheckRole("superadmin")
    @PostMapping("/reset")
    public R<String> resetConfig() {
        taskConfigService.resetToDefault();
        log.info("任务配置已重置为默认值 by user: {}", LoginHelper.getUserId());
        return R.ok("配置已重置为默认值");
    }

    /**
     * 获取支持的审核模式列表
     * 仅超级管理员可访问
     */
    @SaCheckRole("superadmin")
    @GetMapping("/review-modes")
    public R<Map<String, Object>> getReviewModes() {
        Map<String, Object> modes = new HashMap<>();
        
        for (ReviewMode mode : ReviewMode.values()) {
            Map<String, String> modeInfo = new HashMap<>();
            modeInfo.put("name", mode.getName());
            modeInfo.put("description", mode.getDescription());
            modeInfo.put("isDual", String.valueOf(mode.isDual()));
            modeInfo.put("isEnterprise", String.valueOf(mode.isEnterprise()));
            modes.put(mode.name(), modeInfo);
        }
        
        return R.ok(modes);
    }
} 