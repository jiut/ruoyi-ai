package org.ruoyi.designer.domain.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

/**
 * 设计师档案完整度VO
 *
 * @author ruoyi
 */
@Data
@Schema(description = "设计师档案完整度信息")
public class DesignerCompletenessVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 基础信息完整度 (权重40%)
     */
    @Schema(description = "基础信息完整度分数", example = "80")
    private Integer basicInfo;

    /**
     * 作品集完整度 (权重25%)
     */
    @Schema(description = "作品集完整度分数", example = "60")
    private Integer portfolio;

    /**
     * 工作经历完整度 (权重20%)
     */
    @Schema(description = "工作经历完整度分数", example = "50")
    private Integer experience;

    /**
     * 教育背景完整度 (权重15%)
     */
    @Schema(description = "教育背景完整度分数", example = "100")
    private Integer education;

    /**
     * 总体完整度
     */
    @Schema(description = "总体完整度分数", example = "70")
    private Integer overall;

    /**
     * 改进建议列表
     */
    @Schema(description = "改进建议列表")
    private List<String> suggestions;
} 