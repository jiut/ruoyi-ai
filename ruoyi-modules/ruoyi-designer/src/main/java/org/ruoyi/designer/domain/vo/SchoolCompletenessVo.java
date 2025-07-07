package org.ruoyi.designer.domain.vo;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

/**
 * 院校档案完整度VO
 *
 * @author ruoyi
 */
@Data
@Schema(description = "院校档案完整度信息")
public class SchoolCompletenessVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 基础信息完整度 (权重40%)
     */
    @Schema(description = "基础信息完整度分数", example = "85")
    private Integer basicInfo;

    /**
     * 课程体系完整度 (权重30%)
     */
    @Schema(description = "课程体系完整度分数", example = "60")
    private Integer courseSystem;

    /**
     * 获奖作品完整度 (权重20%)
     */
    @Schema(description = "获奖作品完整度分数", example = "40")
    private Integer awardWorks;

    /**
     * 统计数据完整度 (权重10%)
     */
    @Schema(description = "统计数据完整度分数", example = "90")
    private Integer statisticsData;

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