package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 作品类型枚举
 *
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum WorkType {

    IMAGE("image", "图片"),
    VIDEO("video", "视频");

    private final String code;
    private final String name;

    public static WorkType getByCode(String code) {
        for (WorkType type : values()) {
            if (type.getCode().equals(code)) {
                return type;
            }
        }
        return null;
    }
} 