package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 解绑操作结果枚举
 *
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum UnbindResult {

    /**
     * 解绑成功
     */
    SUCCESS("success", "解绑成功"),

    /**
     * 用户未绑定该身份
     */
    NOT_BOUND("not_bound", "用户未绑定该身份"),

    /**
     * 用户已经处于解绑状态
     */
    ALREADY_UNBOUND("already_unbound", "用户已经处于解绑状态"),

    /**
     * 解绑失败
     */
    FAILED("failed", "解绑失败");

    /**
     * 结果代码
     */
    private final String code;

    /**
     * 结果描述
     */
    private final String message;
} 