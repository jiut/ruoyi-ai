package org.ruoyi.designer.domain.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 技能标签分类枚举
 *
 * @author ruoyi
 */
@Getter
@AllArgsConstructor
public enum SkillTagCategory {
    
    TOOL("tool", "工具"),
    FIELD("field", "专业领域"),
    SKILL("skill", "技能方法");

    private final String code;
    private final String name;

    public static SkillTagCategory getByCode(String code) {
        for (SkillTagCategory category : values()) {
            if (category.getCode().equals(code)) {
                return category;
            }
        }
        return null;
    }
} 