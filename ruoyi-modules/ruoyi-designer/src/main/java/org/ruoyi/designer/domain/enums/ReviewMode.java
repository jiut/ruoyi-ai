package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 审核模式枚举
 * 
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum ReviewMode {
    
    DUAL("双重审核模式", "系统管理员→企业管理员"),
    ENTERPRISE("企业自主审核模式", "企业管理员直接审核");
    
    /** 模式名称 */
    private final String name;
    
    /** 模式描述 */
    private final String description;
    
    /**
     * 从字符串值获取枚举
     * 
     * @param value 字符串值
     * @return 审核模式枚举
     */
    public static ReviewMode fromString(String value) {
        for (ReviewMode mode : values()) {
            if (mode.name().equals(value)) {
                return mode;
            }
        }
        throw new IllegalArgumentException("未知的审核模式: " + value);
    }
    
    /**
     * 检查是否为双重审核模式
     * 
     * @return 是否为双重审核模式
     */
    public boolean isDual() {
        return this == DUAL;
    }
    
    /**
     * 检查是否为企业自主审核模式
     * 
     * @return 是否为企业自主审核模式
     */
    public boolean isEnterprise() {
        return this == ENTERPRISE;
    }
} 