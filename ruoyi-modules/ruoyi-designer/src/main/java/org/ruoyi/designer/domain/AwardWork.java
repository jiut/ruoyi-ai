package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 院校获奖作品对象 des_school_award_work
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_school_award_work")
@Schema(description = "院校获奖作品")
public class AwardWork extends BaseEntity {

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
     * 作品标题
     */
    @Schema(description = "作品标题", example = "「循迹」智能导盲系统", requiredMode = Schema.RequiredMode.REQUIRED)
    private String title;

    /**
     * 奖项名称
     */
    @Schema(description = "奖项名称", example = "2024 红点设计奖 · 最佳设计奖")
    private String award;

    /**
     * 作品描述
     */
    @Schema(description = "作品描述", example = "基于计算机视觉和触觉反馈的创新型导盲设备，为视障人士提供更安全、便捷的出行体验。")
    private String description;
} 