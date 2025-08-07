package org.ruoyi.designer.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 岗位申请状态枚举
 *
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum JobApplicationStatus {
    
    /**
     * 待审核
     */
    PENDING("0", "待审核", "PENDING"),
    
    /**
     * 通过
     */
    APPROVED("1", "通过", "APPROVED"),
    
    /**
     * 拒绝
     */
    REJECTED("2", "拒绝", "REJECTED"),
    
    /**
     * 撤回
     */
    WITHDRAWN("3", "撤回", "WITHDRAWN");

    /**
     * 数据库存储值
     */
    private final String code;
    
    /**
     * 显示名称
     */
    private final String desc;
    
    /**
     * 英文常量名
     */
    private final String enumName;

    /**
     * 根据代码获取枚举
     *
     * @param code 状态代码
     * @return 对应的枚举，如果不存在则返回null
     */
    public static JobApplicationStatus getByCode(String code) {
        for (JobApplicationStatus status : values()) {
            if (status.getCode().equals(code)) {
                return status;
            }
        }
        return null;
    }

    /**
     * 根据英文名称获取枚举
     *
     * @param enumName 英文常量名
     * @return 对应的枚举，如果不存在则返回null
     */
    public static JobApplicationStatus getByEnumName(String enumName) {
        for (JobApplicationStatus status : values()) {
            if (status.getEnumName().equals(enumName)) {
                return status;
            }
        }
        return null;
    }

    /**
     * 将英文名称转换为数据库代码
     *
     * @param enumName 英文常量名（如：APPROVED）
     * @return 数据库代码（如：1），如果不存在则返回原值
     */
    public static String convertEnumNameToCode(String enumName) {
        if (enumName == null) {
            return null;
        }
        
        JobApplicationStatus status = getByEnumName(enumName);
        return status != null ? status.getCode() : enumName;
    }

    /**
     * 将数据库代码转换为英文名称
     *
     * @param code 数据库代码（如：1）
     * @return 英文常量名（如：APPROVED），如果不存在则返回原值
     */
    public static String convertCodeToEnumName(String code) {
        if (code == null) {
            return null;
        }
        
        JobApplicationStatus status = getByCode(code);
        return status != null ? status.getEnumName() : code;
    }

    /**
     * 检查状态是否为终态（已处理状态）
     *
     * @return true-终态，false-非终态
     */
    public boolean isTerminal() {
        return this == APPROVED || this == REJECTED || this == WITHDRAWN;
    }

    /**
     * 检查状态是否为成功状态
     *
     * @return true-成功，false-非成功
     */
    public boolean isSuccess() {
        return this == APPROVED;
    }
} 