package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 设计师工作状态枚举
 *
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum WorkStatus {

    EMPLOYED("EMPLOYED", "在职"),
    FREELANCER("FREELANCER", "自由职业者"),
    UNEMPLOYED("UNEMPLOYED", "求职中"),
    STUDENT("STUDENT", "在校学生"),
    RETIRED("RETIRED", "退休");

    private final String code;
    private final String name;

    public static WorkStatus getByCode(String code) {
        for (WorkStatus status : values()) {
            if (status.getCode().equals(code)) {
                return status;
            }
        }
        return null;
    }
} 