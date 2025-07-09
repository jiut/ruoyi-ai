package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 设计师职业枚举
 *
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum DesignerProfession {

    ILLUSTRATOR("ILLUSTRATOR", "插画师"),
    INTERACTION_DESIGNER("INTERACTION_DESIGNER", "交互设计师"),
    BRAND_DESIGNER("BRAND_DESIGNER", "品牌设计师"),
    UI_DESIGNER("UI_DESIGNER", "UI设计师"),
    UX_DESIGNER("UX_DESIGNER", "UX设计师"),
    UI_UX_DESIGNER("UI_UX_DESIGNER", "UI/UX设计师"),
    VISUAL_DESIGNER("VISUAL_DESIGNER", "视觉设计师"),
    THREE_D_DESIGNER("THREE_D_DESIGNER", "3D设计师"),
    GRAPHIC_DESIGNER("GRAPHIC_DESIGNER", "平面设计师"),
    PRODUCT_DESIGNER("PRODUCT_DESIGNER", "产品设计师"),
    MOTION_DESIGNER("MOTION_DESIGNER", "动效设计师"),
    INTERIOR_DESIGNER("INTERIOR_DESIGNER", "室内设计师"),
    ARCHITECT("ARCHITECT", "建筑师"),
    LANDSCAPE_DESIGNER("LANDSCAPE_DESIGNER", "景观设计师");

    private final String code;
    private final String name;

    public static DesignerProfession getByCode(String code) {
        for (DesignerProfession profession : values()) {
            if (profession.getCode().equals(code)) {
                return profession;
            }
        }
        return null;
    }
} 