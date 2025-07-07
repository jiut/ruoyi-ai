package org.ruoyi.designer.domain.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

/**
 * 企业档案完整度VO
 *
 * @author ruoyi
 */
@Data
@Schema(description = "企业档案完整度信息")
public class EnterpriseCompletenessVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 基础信息完整度 (权重60%)
     */
    @Schema(description = "基础信息完整度分数", example = "80")
    private Integer basicInfo;

    /**
     * 联系信息完整度 (权重25%)
     */
    @Schema(description = "联系信息完整度分数", example = "70")
    private Integer contactInfo;

    /**
     * 招聘信息完整度 (权重15%)
     */
    @Schema(description = "招聘信息完整度分数", example = "40")
    private Integer recruitmentInfo;

    /**
     * 总体完整度
     */
    @Schema(description = "总体完整度分数", example = "72")
    private Integer overall;

    /**
     * 改进建议列表
     */
    @Schema(description = "改进建议列表")
    private List<String> suggestions;
} 