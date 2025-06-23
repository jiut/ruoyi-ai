package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;
import java.time.LocalDate;

/**
 * 工作经历对象 des_work_experience
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_work_experience")
@Schema(description = "设计师工作经历信息")
public class WorkExperience extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 工作经历ID
     */
    @JsonIgnore
    @Schema(description = "工作经历ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "experience_id")
    private Long experienceId;

    /**
     * 设计师ID
     */
    @Schema(description = "设计师ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long designerId;

    /**
     * 公司名称
     */
    @Schema(description = "公司名称", example = "腾讯科技有限公司", requiredMode = Schema.RequiredMode.REQUIRED)
    private String company;

    /**
     * 职位名称
     */
    @Schema(description = "职位名称", example = "高级UI设计师", requiredMode = Schema.RequiredMode.REQUIRED)
    private String position;

    /**
     * 开始日期
     */
    @Schema(description = "开始日期，格式：yyyy-MM-dd", example = "2020-03-01", type = "string", format = "date", requiredMode = Schema.RequiredMode.REQUIRED)
    private LocalDate startDate;

    /**
     * 结束日期
     */
    @Schema(description = "结束日期，格式：yyyy-MM-dd", example = "2023-02-28", type = "string", format = "date")
    private LocalDate endDate;

    /**
     * 是否为当前工作
     */
    @Schema(description = "是否为当前工作", example = "true")
    private Boolean isCurrent;

    /**
     * 工作描述
     */
    @Schema(description = "工作描述", example = "负责移动应用UI设计，参与用户体验优化")
    private String description;

    /**
     * 工作地点
     */
    @Schema(description = "工作地点", example = "深圳市南山区")
    private String location;

    /**
     * 行业类型
     */
    @Schema(description = "行业类型", example = "互联网")
    private String industry;

    /**
     * 状态（0正常 1停用）
     */
    @Schema(description = "状态", example = "0", allowableValues = {"0", "1"})
    private String status;
} 