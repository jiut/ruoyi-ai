package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableField;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;
import java.util.Date;

/**
 * 任务申请对象 des_task_application
 * 支持双重审核的任务申请系统
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_task_application")
@Schema(description = "任务申请信息")
public class TaskApplication extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 申请ID
     */
    @Schema(description = "申请ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "application_id")
    private Long applicationId;

    /**
     * 任务ID
     */
    @Schema(description = "任务ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long taskId;

    /**
     * 设计师ID
     */
    @Schema(description = "设计师ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long designerId;

    /**
     * 申请提案
     */
    @Schema(description = "申请提案", example = "我对这个项目很感兴趣...")
    private String proposal;

    /**
     * 报价金额
     */
    @Schema(description = "报价金额", example = "3000.00")
    private java.math.BigDecimal proposedPrice;

    /**
     * 预计完成天数
     */
    @Schema(description = "预计完成天数", example = "7")
    private Integer estimatedDays;

    /**
     * 作品链接（JSON数组）
     */
    @Schema(description = "作品链接", example = "[\"https://portfolio1.com\", \"https://portfolio2.com\"]")
    private String portfolioLinks;

    // ===== 最终申请状态 =====
    
    /**
     * 最终申请状态
     */
    @Schema(description = "申请状态", example = "0", 
            allowableValues = {"0", "1", "2", "3", "4", "5"})
    private String status;

    /**
     * 统一的审核反馈
     */
    @Schema(description = "审核反馈")
    private String feedback;

    // ===== 双重审核扩展字段（对用户完全隐藏）=====
    
    /**
     * 系统管理员审核状态
     */
    @JsonIgnore
    @Schema(hidden = true)
    private String adminReviewStatus;

    /**
     * 系统管理员审核反馈
     */
    @JsonIgnore
    @Schema(hidden = true)
    private String adminReviewFeedback;

    /**
     * 系统管理员审核时间
     */
    @JsonIgnore
    @Schema(hidden = true)
    private Date adminReviewTime;

    /**
     * 系统管理员审核人ID
     */
    @JsonIgnore
    @Schema(hidden = true)
    private Long adminReviewBy;

    /**
     * 企业管理员审核状态
     */
    @JsonIgnore
    @Schema(hidden = true)
    private String enterpriseReviewStatus;

    /**
     * 企业管理员审核反馈
     */
    @JsonIgnore
    @Schema(hidden = true)
    private String enterpriseReviewFeedback;

    /**
     * 企业管理员审核时间
     */
    @JsonIgnore
    @Schema(hidden = true)
    private Date enterpriseReviewTime;

    /**
     * 审核模式
     */
    @JsonIgnore
    @Schema(hidden = true)
    private String reviewMode;

    /**
     * 删除标志（0代表存在 1代表删除）
     */
    @Schema(description = "删除标志", hidden = true)
    private String delFlag;

    // ===== 关联对象（查询时使用）=====
    
    /**
     * 任务信息（关联查询时使用）
     */
    @TableField(exist = false)
    @Schema(description = "任务信息", accessMode = Schema.AccessMode.READ_ONLY)
    private Task task;

    /**
     * 设计师信息（关联查询时使用）
     */
    @TableField(exist = false)
    @Schema(description = "设计师信息", accessMode = Schema.AccessMode.READ_ONLY)
    private Designer designer;
} 