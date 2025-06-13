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

    ILLUSTRATOR("illustrator", "插画师"),
    INTERACTION_DESIGNER("interaction_designer", "交互设计师"),
    BRAND_DESIGNER("brand_designer", "品牌设计师"),
    UI_DESIGNER("ui_designer", "UI设计师"),
    UX_DESIGNER("ux_designer", "UX设计师"),
    GRAPHIC_DESIGNER("graphic_designer", "平面设计师"),
    PRODUCT_DESIGNER("product_designer", "产品设计师"),
    MOTION_DESIGNER("motion_designer", "动效设计师");

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