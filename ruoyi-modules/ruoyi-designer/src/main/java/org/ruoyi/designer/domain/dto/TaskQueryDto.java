package org.ruoyi.designer.domain.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;

import java.math.BigDecimal;

/**
 * 任务查询参数DTO
 * 避免实体类直接用作查询参数引起的类型转换问题
 *
 * @author ruoyi
 */
@Data
@Schema(description = "任务查询参数")
public class TaskQueryDto {

    /**
     * 企业ID（用于后端设置或系统管理员过滤）
     */
    @Schema(description = "企业ID（系统管理员查询回收站时可用于过滤特定企业）", example = "1")
    private Long enterpriseId;

    /**
     * 任务标题（模糊查询）
     */
    @Schema(description = "任务标题", example = "LOGO设计")
    private String taskTitle;

    /**
     * 任务描述（模糊查询）
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
     * 技能标签（前端可传递字符串进行模糊搜索）
     */
    @Schema(description = "技能标签", example = "photoshop")
    private String skillTag;
} 