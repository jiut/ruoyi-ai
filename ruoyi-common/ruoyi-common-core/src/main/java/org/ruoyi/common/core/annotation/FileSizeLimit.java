package org.ruoyi.common.core.annotation;

import java.lang.annotation.*;

/**
 * 文件大小限制注解
 * 用于在Controller方法上声明文件大小限制
 *
 * @author ruoyi
 */
@Target({ElementType.METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface FileSizeLimit {

    /**
     * 最大文件大小（字节）
     * 默认50MB
     */
    long maxSize() default 50 * 1024 * 1024L;

    /**
     * 最大文件大小（MB）
     * 优先级高于maxSize，设置后会覆盖maxSize
     */
    long maxSizeMB() default -1;

    /**
     * 支持的文件类型
     * 默认为所有支持的类型
     */
    String[] allowedTypes() default {};

    /**
     * 错误消息
     */
    String message() default "文件大小超出限制";

    /**
     * 是否启用验证
     */
    boolean enabled() default true;
} 