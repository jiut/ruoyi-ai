package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 院校学生成果统计对象 des_school_achievement_stats
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_school_achievement_stats")
@Schema(description = "院校学生成果统计")
public class AchievementStats extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 主键ID
     */
    @Schema(description = "主键ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "id")
    private Long id;

    /**
     * 院校ID
     */
    @Schema(description = "院校ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long schoolId;

    /**
     * 国际奖项数量
     */
    @Schema(description = "国际奖项数量", example = "126")
    private Integer internationalAwards;

    /**
     * 国家级奖项数量
     */
    @Schema(description = "国家级奖项数量", example = "287")
    private Integer nationalAwards;

    /**
     * 省级奖项数量
     */
    @Schema(description = "省级奖项数量", example = "453")
    private Integer provincialAwards;

    /**
     * 专利数量
     */
    @Schema(description = "专利数量", example = "192")
    private Integer patents;

    /**
     * 成果描述
     */
    @Schema(description = "成果描述")
    private String description;
} 