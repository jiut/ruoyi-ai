package org.ruoyi.common.web.aspect;

import cn.hutool.core.util.ObjectUtil;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.ruoyi.common.core.annotation.FileSizeLimit;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.utils.file.FileSizeLimitUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.lang.reflect.Method;
import java.lang.reflect.Parameter;

/**
 * 文件大小限制切面
 *
 * @author ruoyi
 */
@Slf4j
@Aspect
@Component
public class FileSizeLimitAspect {

    @Around("@annotation(org.ruoyi.common.core.annotation.FileSizeLimit)")
    public Object around(ProceedingJoinPoint point) throws Throwable {
        MethodSignature signature = (MethodSignature) point.getSignature();
        Method method = signature.getMethod();
        FileSizeLimit fileSizeLimit = method.getAnnotation(FileSizeLimit.class);

        if (!fileSizeLimit.enabled()) {
            return point.proceed();
        }

        // 获取方法参数
        Object[] args = point.getArgs();
        Parameter[] parameters = method.getParameters();

        // 查找MultipartFile参数
        for (int i = 0; i < parameters.length; i++) {
            if (parameters[i].getType() == MultipartFile.class) {
                MultipartFile file = (MultipartFile) args[i];
                if (ObjectUtil.isNotNull(file)) {
                    // 验证文件大小
                    String validationResult = FileSizeLimitUtils.validateFileSizeByAnnotation(file, fileSizeLimit);
                    if (validationResult != null) {
                        log.warn("文件大小验证失败: {} - 文件: {}, 大小: {}", 
                                validationResult, 
                                file.getOriginalFilename(),
                                FileSizeLimitUtils.formatFileSize(file.getSize()));
                        return R.fail(validationResult);
                    }
                }
            }
            // 处理MultipartFile数组
            else if (parameters[i].getType() == MultipartFile[].class) {
                MultipartFile[] files = (MultipartFile[]) args[i];
                if (ObjectUtil.isNotNull(files)) {
                    for (MultipartFile file : files) {
                        if (ObjectUtil.isNotNull(file) && !file.isEmpty()) {
                            String validationResult = FileSizeLimitUtils.validateFileSizeByAnnotation(file, fileSizeLimit);
                            if (validationResult != null) {
                                log.warn("文件大小验证失败: {} - 文件: {}, 大小: {}", 
                                        validationResult, 
                                        file.getOriginalFilename(),
                                        FileSizeLimitUtils.formatFileSize(file.getSize()));
                                return R.fail(validationResult);
                            }
                        }
                    }
                }
            }
        }

        return point.proceed();
    }
} 