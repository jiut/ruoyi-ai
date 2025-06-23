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

    // ========== 设计工具/软件类 ==========
    FIGMA("figma", "Figma", SkillTagCategory.TOOL),
    SKETCH("sketch", "Sketch", SkillTagCategory.TOOL),
    AXURE_RP("axure_rp", "Axure RP", SkillTagCategory.TOOL),
    PHOTOSHOP("photoshop", "Photoshop", SkillTagCategory.TOOL),
    ILLUSTRATOR("illustrator", "Illustrator", SkillTagCategory.TOOL),
    AFTER_EFFECTS("after_effects", "After Effects", SkillTagCategory.TOOL),
    CINEMA_4D("cinema_4d", "Cinema 4D", SkillTagCategory.TOOL),
    BLENDER("blender", "Blender", SkillTagCategory.TOOL),
    THREE_D_MAX("3d_max", "3D Max", SkillTagCategory.TOOL),
    MAYA("maya", "Maya", SkillTagCategory.TOOL),
    ADOBE_XD("adobe_xd", "Adobe XD", SkillTagCategory.TOOL),
    INVISION("invision", "InVision", SkillTagCategory.TOOL),
    FRAMER("framer", "Framer", SkillTagCategory.TOOL),
    PRINCIPLE("principle", "Principle", SkillTagCategory.TOOL),
    ZEPLIN("zeplin", "Zeplin", SkillTagCategory.TOOL),
    ABSTRACT("abstract", "Abstract", SkillTagCategory.TOOL),
    LOTTIE("lottie", "Lottie", SkillTagCategory.TOOL),

    // ========== 设计专业领域类 ==========
    INTERACTION_DESIGN("interaction_design", "交互设计", SkillTagCategory.FIELD),
    UI_DESIGN("ui_design", "UI设计", SkillTagCategory.FIELD),
    BRAND_DESIGN("brand_design", "品牌设计", SkillTagCategory.FIELD),
    PRODUCT_DESIGN("product_design", "产品设计", SkillTagCategory.FIELD),
    MOTION_DESIGN("motion_design", "动效设计", SkillTagCategory.FIELD),
    GAME_ART("game_art", "游戏美术", SkillTagCategory.FIELD),
    WEB_DESIGN("web_design", "网页设计", SkillTagCategory.FIELD),
    MOBILE_DESIGN("mobile_design", "移动端设计", SkillTagCategory.FIELD),
    GRAPHIC_DESIGN("graphic_design", "平面设计", SkillTagCategory.FIELD),
    LOGO_DESIGN("logo_design", "LOGO设计", SkillTagCategory.FIELD),
    INTERFACE_DESIGN("interface_design", "界面设计", SkillTagCategory.FIELD),
    BRAND_IDENTITY("brand_identity", "品牌标识", SkillTagCategory.FIELD),
    ANIMATION_DESIGN("animation_design", "动画制作", SkillTagCategory.FIELD),

    // ========== 设计技能/方法类 ==========
    USER_EXPERIENCE("user_experience", "用户体验", SkillTagCategory.SKILL),
    USER_RESEARCH("user_research", "用户研究", SkillTagCategory.SKILL),
    PROTOTYPE_DESIGN("prototype_design", "原型设计", SkillTagCategory.SKILL),
    DESIGN_SYSTEM("design_system", "设计系统", SkillTagCategory.SKILL),
    INFORMATION_ARCHITECTURE("information_architecture", "信息架构", SkillTagCategory.SKILL),
    VISUAL_SYSTEM("visual_system", "视觉系统", SkillTagCategory.SKILL),
    WIREFRAMING("wireframing", "线框设计", SkillTagCategory.SKILL),
    USER_TESTING("user_testing", "用户测试", SkillTagCategory.SKILL),
    PERSONA_DESIGN("persona_design", "用户画像", SkillTagCategory.SKILL),
    JOURNEY_MAPPING("journey_mapping", "用户旅程", SkillTagCategory.SKILL),
    USABILITY_TESTING("usability_testing", "可用性测试", SkillTagCategory.SKILL),
    VISUAL_DESIGN("visual_design", "视觉设计", SkillTagCategory.SKILL),
    TYPOGRAPHY("typography", "字体设计", SkillTagCategory.SKILL),
    COLOR_THEORY("color_theory", "色彩理论", SkillTagCategory.SKILL),
    ILLUSTRATION("illustration", "插画", SkillTagCategory.SKILL),
    CHARACTER_DESIGN("character_design", "角色设计", SkillTagCategory.SKILL),
    SCENE_DESIGN("scene_design", "场景设计", SkillTagCategory.SKILL),
    VISUAL_IDENTITY("visual_identity", "视觉识别", SkillTagCategory.SKILL),
    ANIMATION("animation", "动画", SkillTagCategory.SKILL),
    EFFECTS("effects", "动效", SkillTagCategory.SKILL),
    THREE_D_MODELING("3d_modeling", "3D建模", SkillTagCategory.SKILL),

    // ========== 兼容性保留 ==========
    BRANDING("branding", "品牌设计", SkillTagCategory.FIELD),
    PHOTOGRAPHY("photography", "摄影", SkillTagCategory.SKILL),
    VIDEO_EDITING("video_editing", "视频剪辑", SkillTagCategory.SKILL);

    private final String code;
    private final String name;
    private final SkillTagCategory category;

    public static SkillTag getByCode(String code) {
        for (SkillTag tag : values()) {
            if (tag.getCode().equals(code)) {
                return tag;
            }
        }
        return null;
    }

    /**
     * 根据中文名称获取技能标签
     */
    public static SkillTag getByName(String name) {
        for (SkillTag tag : values()) {
            if (tag.getName().equals(name)) {
                return tag;
            }
        }
        return null;
    }

    /**
     * 获取所有技能代码列表
     */
    public static String[] getAllCodes() {
        return java.util.Arrays.stream(values())
                .map(SkillTag::getCode)
                .toArray(String[]::new);
    }

    /**
     * 获取所有技能名称列表
     */
    public static String[] getAllNames() {
        return java.util.Arrays.stream(values())
                .map(SkillTag::getName)
                .toArray(String[]::new);
    }

    /**
     * 根据分类获取标签列表
     */
    public static SkillTag[] getByCategory(SkillTagCategory category) {
        return java.util.Arrays.stream(values())
                .filter(tag -> tag.getCategory() == category)
                .toArray(SkillTag[]::new);
    }

    /**
     * 获取工具类标签
     */
    public static SkillTag[] getToolTags() {
        return getByCategory(SkillTagCategory.TOOL);
    }

    /**
     * 获取专业领域类标签
     */
    public static SkillTag[] getFieldTags() {
        return getByCategory(SkillTagCategory.FIELD);
    }

    /**
     * 获取技能方法类标签
     */
    public static SkillTag[] getSkillTags() {
        return getByCategory(SkillTagCategory.SKILL);
    }
} 