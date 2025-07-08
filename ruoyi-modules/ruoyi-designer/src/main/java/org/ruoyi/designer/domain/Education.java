package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import jakarta.validation.constraints.*;
import java.io.Serial;
import java.time.LocalDate;
import java.util.Date;

/**
 * 教育背景对象 des_education
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_education")
@Schema(description = "设计师教育背景信息")
public class Education extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 教育背景ID
     */
    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    @Schema(description = "教育背景ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "education_id")
    private Long educationId;

    /**
     * 设计师ID
     */
    @NotNull(message = "设计师ID不能为空")
    @Schema(description = "设计师ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long designerId;

    /**
     * 学校名称
     */
    @NotBlank(message = "学校名称不能为空")
    @Size(max = 100, message = "学校名称长度不能超过100个字符")
    @Schema(description = "学校名称", example = "中国美术学院", requiredMode = Schema.RequiredMode.REQUIRED)
    private String school;

    /**
     * 学位
     */
    @NotBlank(message = "学位不能为空")
    @Size(max = 50, message = "学位长度不能超过50个字符")
    @Schema(description = "学位", example = "硕士", requiredMode = Schema.RequiredMode.REQUIRED)
    private String degree;

    /**
     * 专业
     */
    @NotBlank(message = "专业不能为空")
    @Size(max = 100, message = "专业长度不能超过100个字符")
    @Schema(description = "专业", example = "设计学", requiredMode = Schema.RequiredMode.REQUIRED)
    private String major;

    /**
     * 开始日期
     */
    @NotNull(message = "开始日期不能为空")
    @Schema(description = "开始日期，格式：yyyy-MM-dd", example = "2015-09-01", type = "string", format = "date", requiredMode = Schema.RequiredMode.REQUIRED)
    private LocalDate startDate;

    /**
     * 结束日期
     */
    @Schema(description = "结束日期，格式：yyyy-MM-dd", example = "2018-06-30", type = "string", format = "date")
    private LocalDate endDate;

    /**
     * 是否在读
     */
    @Schema(description = "是否在读", example = "false")
    private Boolean isCurrent;

    /**
     * 描述
     */
    @Size(max = 500, message = "描述长度不能超过500个字符")
    @Schema(description = "描述", example = "专业方向：数字媒体艺术，研究方向：交互设计与用户体验")
    private String description;

    /**
     * GPA
     */
    @DecimalMin(value = "0.0", message = "GPA不能小于0")
    @DecimalMax(value = "5.0", message = "GPA不能大于5")
    @Schema(description = "GPA", example = "3.8")
    private Double gpa;

    /**
     * 排名（如第几名）
     */
    @Min(value = 1, message = "排名必须大于0")
    @Schema(description = "排名", example = "5")
    private Integer ranking;

    /**
     * 总人数
     */
    @Min(value = 1, message = "总人数必须大于0")
    @Schema(description = "总人数", example = "120")
    private Integer totalStudents;

    /**
     * 状态（0正常 1停用）
     */
    @Pattern(regexp = "^[01]$", message = "状态只能是0或1")
    @Schema(description = "状态", example = "0", allowableValues = {"0", "1"})
    private String status;

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
} 