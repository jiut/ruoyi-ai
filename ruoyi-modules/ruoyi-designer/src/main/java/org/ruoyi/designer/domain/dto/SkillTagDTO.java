package org.ruoyi.designer.domain.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 技能标签数据传输对象
 *
 * @author ruoyi
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "技能标签信息")
public class SkillTagDTO {

    @Schema(description = "技能代码", example = "figma")
    private String code;

    @Schema(description = "技能名称", example = "Figma")
    private String name;

    @Schema(description = "技能分类", example = "tool", allowableValues = {"tool", "field", "skill"})
    private String category;
} 