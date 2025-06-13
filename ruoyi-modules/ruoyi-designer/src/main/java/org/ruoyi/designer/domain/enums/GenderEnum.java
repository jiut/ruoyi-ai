package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 性别枚举
 *
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum GenderEnum {

    /**
     * 男性
     */
    MALE("0", "男"),

    /**
     * 女性
     */
    FEMALE("1", "女"),

    /**
     * 未知
     */
    UNKNOWN("2", "未知");

    /**
     * 数据库存储值
     */
    private final String code;

    /**
     * 显示名称
     */
    private final String name;

    /**
     * 根据代码获取枚举
     *
     * @param code 代码
     * @return 枚举值
     */
    public static GenderEnum getByCode(String code) {
        for (GenderEnum gender : values()) {
            if (gender.getCode().equals(code)) {
                return gender;
            }
        }
        return UNKNOWN;
    }

    /**
     * 根据名称获取枚举
     *
     * @param name 名称
     * @return 枚举值
     */
    public static GenderEnum getByName(String name) {
        for (GenderEnum gender : values()) {
            if (gender.getName().equals(name)) {
                return gender;
            }
        }
        return UNKNOWN;
    }

    /**
     * 转换中文名称为数据库代码
     *
     * @param name 中文名称
     * @return 数据库代码
     */
    public static String convertNameToCode(String name) {
        return getByName(name).getCode();
    }

    /**
     * 转换数据库代码为中文名称
     *
     * @param code 数据库代码
     * @return 中文名称
     */
    public static String convertCodeToName(String code) {
        return getByCode(code).getName();
    }
} 