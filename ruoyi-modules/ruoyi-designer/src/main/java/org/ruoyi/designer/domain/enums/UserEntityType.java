package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 用户实体类型枚举
 *
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum UserEntityType {

    DESIGNER("designer", "设计师"),
    ENTERPRISE("enterprise", "企业"),
    SCHOOL("school", "院校");

    private final String code;
    private final String name;

    public static UserEntityType getByCode(String code) {
        for (UserEntityType type : values()) {
            if (type.getCode().equals(code)) {
                return type;
            }
        }
        return null;
    }
} 