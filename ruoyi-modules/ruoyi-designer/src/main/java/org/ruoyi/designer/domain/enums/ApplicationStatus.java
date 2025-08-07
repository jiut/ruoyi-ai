package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 任务申请状态枚举
 * 涵盖双重审核模式下的所有可能状态
 * 
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum ApplicationStatus {
    
    PENDING("0", "待审核", "申请已提交，等待审核"),
    ADMIN_APPROVED("1", "系统管理员审核通过", "已通过系统管理员审核，等待企业管理员审核"), 
    ADMIN_REJECTED("2", "系统管理员审核拒绝", "系统管理员审核未通过，申请流程结束"),
    ENTERPRISE_APPROVED("3", "企业管理员审核通过", "申请审核完全通过，可以开始任务执行"),
    ENTERPRISE_REJECTED("4", "企业管理员审核拒绝", "企业管理员审核未通过，申请流程结束"),
    WITHDRAWN("5", "已撤回", "申请人主动撤回申请");
    
    /** 状态代码 */
    private final String code;
    
    /** 状态名称 */
    private final String name;
    
    /** 状态描述 */
    private final String description;
    
    /**
     * 根据代码获取状态枚举
     * 
     * @param code 状态代码
     * @return 状态枚举
     * @throws IllegalArgumentException 如果代码不存在
     */
    public static ApplicationStatus fromCode(String code) {
        for (ApplicationStatus status : values()) {
            if (status.code.equals(code)) {
                return status;
            }
        }
        throw new IllegalArgumentException("未知的状态代码: " + code);
    }
    
    /**
     * 检查是否为终态
     * 终态是指不能再进行状态转换的状态
     * 
     * @return 是否为终态
     */
    public boolean isTerminal() {
        return this == ADMIN_REJECTED || 
               this == ENTERPRISE_APPROVED || 
               this == ENTERPRISE_REJECTED || 
               this == WITHDRAWN;
    }
    
    /**
     * 检查是否为成功状态
     * 
     * @return 是否为成功状态
     */
    public boolean isSuccess() {
        return this == ENTERPRISE_APPROVED;
    }
    
    /**
     * 检查是否为拒绝状态
     * 
     * @return 是否为拒绝状态
     */
    public boolean isRejected() {
        return this == ADMIN_REJECTED || this == ENTERPRISE_REJECTED;
    }
    
    /**
     * 检查是否为待审核状态
     * 
     * @return 是否为待审核状态
     */
    public boolean isPending() {
        return this == PENDING || this == ADMIN_APPROVED;
    }
} 