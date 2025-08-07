package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 状态转换操作类型枚举
 * 
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum TransitionAction {
    
    ADMIN_REVIEW("系统管理员审核", "系统管理员对申请进行一级审核"),
    ENTERPRISE_REVIEW("企业管理员审核", "企业管理员对申请进行最终审核"),
    WITHDRAW("用户撤回", "申请人主动撤回申请"),
    SYSTEM_AUTO("系统自动", "系统自动触发的状态变更");
    
    /** 操作描述 */
    private final String description;
    
    /** 详细说明 */
    private final String detail;
    
    /**
     * 从字符串值获取枚举
     * 
     * @param value 字符串值
     * @return 转换操作枚举
     */
    public static TransitionAction fromString(String value) {
        for (TransitionAction action : values()) {
            if (action.name().equals(value)) {
                return action;
            }
        }
        throw new IllegalArgumentException("未知的转换操作: " + value);
    }
    
    /**
     * 检查是否为审核操作
     * 
     * @return 是否为审核操作
     */
    public boolean isReviewAction() {
        return this == ADMIN_REVIEW || this == ENTERPRISE_REVIEW;
    }
    
    /**
     * 检查是否为用户操作
     * 
     * @return 是否为用户操作
     */
    public boolean isUserAction() {
        return this == WITHDRAW;
    }
    
    /**
     * 检查是否为系统操作
     * 
     * @return 是否为系统操作
     */
    public boolean isSystemAction() {
        return this == SYSTEM_AUTO;
    }
} 