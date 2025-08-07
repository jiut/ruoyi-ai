package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.IdType;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;
import java.math.BigDecimal;
import java.util.Date;

/**
 * 任务对象 des_task
 * 智图工厂的项目任务平台
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_task")
@Schema(description = "任务信息")
public class Task extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 任务ID
     */
    @Schema(description = "任务ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "task_id", type = IdType.AUTO)
    private Long taskId;

    /**
     * 企业ID（关联现有企业表）
     */
    @Schema(description = "企业ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long enterpriseId;

    /**
     * 任务标题
     */
    @Schema(description = "任务标题", example = "LOGO设计项目")
    private String taskTitle;

    /**
     * 任务描述
     */
    @Schema(description = "任务描述")
    private String taskDescription;

    /**
     * 任务类型
     */
    @Schema(description = "任务类型", example = "LOGO_DESIGN", 
            allowableValues = {"LOGO_DESIGN", "UI_UX_DESIGN", "GRAPHIC_DESIGN", "ILLUSTRATION", "BRAND_DESIGN"})
    private String taskType;

    /**
     * 技能标签（JSON数组）
     */
    @Schema(description = "技能标签", example = "[\"photoshop\", \"illustrator\", \"creative_design\"]")
    private String skillTags;

    /**
     * 预算最低值
     */
    @Schema(description = "预算最低值", example = "1000.00")
    private BigDecimal budgetMin;

    /**
     * 预算最高值
     */
    @Schema(description = "预算最高值", example = "5000.00")
    private BigDecimal budgetMax;

    /**
     * 截止时间
     */
    @Schema(description = "截止时间", example = "2025-02-15 18:00:00")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date deadline;

    /**
     * 是否紧急
     */
    @Schema(description = "是否紧急", example = "false")
    private Boolean urgent;

    /**
     * 任务状态
     */
    @Schema(description = "任务状态", example = "PUBLISHED", 
            allowableValues = {"DRAFT", "PUBLISHED", "IN_PROGRESS", "COMPLETED", "CANCELLED"})
    private String status;

    /**
     * 交付物要求
     */
    @Schema(description = "交付物要求")
    private String deliverables;

    /**
     * 付款条款
     */
    @Schema(description = "付款条款")
    private String paymentTerms;

    /**
     * 浏览次数
     */
    @Schema(description = "浏览次数", example = "0", accessMode = Schema.AccessMode.READ_ONLY)
    private Integer views;

    /**
     * 申请数量
     */
    @Schema(description = "申请数量", example = "0", accessMode = Schema.AccessMode.READ_ONLY)
    private Integer applications;

    /**
     * 删除标志（0正常 1软删除 2硬删除）
     */
    @TableLogic(value = "0", delval = "1")
    @JsonIgnore
    @Schema(description = "删除标志", hidden = true)
    private String delFlag;
    
    /**
     * 删除时间
     */
    @JsonIgnore
    @Schema(description = "删除时间", hidden = true)
    private Date delTime;
    
    /**
     * 删除人ID
     */
    @JsonIgnore
    @Schema(description = "删除人ID", hidden = true)
    private Long delBy;

    // ===== 关联对象（查询时使用）=====
    
    /**
     * 企业信息（关联查询时使用）
     */
    @TableField(exist = false)
    @Schema(description = "企业信息", accessMode = Schema.AccessMode.READ_ONLY)
    private Enterprise enterprise;

    /**
     * 任务类型枚举
     */
    public enum TaskType {
        LOGO_DESIGN("LOGO设计"),
        UI_UX_DESIGN("UI/UX设计"),
        GRAPHIC_DESIGN("平面设计"),
        ILLUSTRATION("插画设计"),
        BRAND_DESIGN("品牌设计");

        private final String description;

        TaskType(String description) {
            this.description = description;
        }

        public String getDescription() {
            return description;
        }
    }

    /**
     * 任务状态枚举
     */
    public enum TaskStatus {
        DRAFT("草稿"),
        PUBLISHED("已发布"),
        IN_PROGRESS("进行中"),
        COMPLETED("已完成"),
        CANCELLED("已取消");

        private final String description;

        TaskStatus(String description) {
            this.description = description;
        }

        public String getDescription() {
            return description;
        }
    }
} 