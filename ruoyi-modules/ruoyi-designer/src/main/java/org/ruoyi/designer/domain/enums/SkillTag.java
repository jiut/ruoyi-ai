package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 设计师技能标签枚举
 *
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum SkillTag {

    MOTION_DESIGN("motion_design", "动效设计"),
    PROTOTYPE_DESIGN("prototype_design", "原型设计"),
    CHARACTER_DESIGN("character_design", "角色设计"),
    LOGO_DESIGN("logo_design", "LOGO设计"),
    WEB_DESIGN("web_design", "网页设计"),
    MOBILE_DESIGN("mobile_design", "移动端设计"),
    GRAPHIC_DESIGN("graphic_design", "平面设计"),
    TYPOGRAPHY("typography", "字体设计"),
    COLOR_THEORY("color_theory", "色彩理论"),
    USER_RESEARCH("user_research", "用户研究"),
    WIREFRAMING("wireframing", "线框设计"),
    VISUAL_DESIGN("visual_design", "视觉设计"),
    BRANDING("branding", "品牌设计"),
    ILLUSTRATION("illustration", "插画设计"),
    PHOTOGRAPHY("photography", "摄影"),
    VIDEO_EDITING("video_editing", "视频剪辑"),
    THREE_D_MODELING("3d_modeling", "3D建模"),
    ANIMATION("animation", "动画设计");

    private final String code;
    private final String name;

    public static SkillTag getByCode(String code) {
        for (SkillTag tag : values()) {
            if (tag.getCode().equals(code)) {
                return tag;
            }
        }
        return null;
    }
} 