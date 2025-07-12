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

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.Max;
import java.io.Serial;
import java.time.LocalDate;
import java.util.Date;

/**
 * 设计师对象 des_designer
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_designer")
@Schema(description = "设计师信息")
public class Designer extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 设计师ID
     */
    @JsonProperty("id")
    @Schema(description = "设计师ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "designer_id")
    private Long designerId;

    /**
     * 关联用户ID
     */
    @Schema(description = "关联用户ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    private Long userId;

    /**
     * 设计师姓名
     */
    @NotBlank(message = "设计师姓名不能为空")
    @Schema(description = "设计师姓名", example = "张三", requiredMode = Schema.RequiredMode.REQUIRED)
    private String designerName;

    /**
     * 头像
     */
    @Schema(description = "头像URL", example = "https://avatars.githubusercontent.com/u/27265998")
    private String avatar;

    /**
     * 性别（0男 1女 2未知）
     */
    @Pattern(regexp = "^[012]$", message = "性别值必须为0、1或2")
    @Schema(description = "性别", example = "0", allowableValues = {"0", "1", "2"})
    private String gender;

    /**
     * 出生日期
     */
    @Schema(description = "出生日期，格式：yyyy-MM-dd", example = "1995-06-15", type = "string", format = "date")
    private LocalDate birthDate;

    /**
     * 联系电话
     */
    @Pattern(regexp = "^$|^1[3-9]\\d{9}$", message = "手机号格式不正确")
    @Schema(description = "联系电话", example = "13800138000")
    private String phone;

    /**
     * 联系邮箱
     */
    @Email(message = "邮箱格式不正确")
    @Schema(description = "联系邮箱", example = "zhangsan@example.com")
    private String email;

    /**
     * 个人简介
     */
    @Schema(description = "个人简介", example = "专业UI设计师，擅长原型设计和视觉设计")
    private String description;

    /**
     * 职业（插画师、交互设计师等）
     */
    @Pattern(regexp = "^(ILLUSTRATOR|INTERACTION_DESIGNER|BRAND_DESIGNER|UI_DESIGNER|UX_DESIGNER|UI_UX_DESIGNER|GRAPHIC_DESIGNER|PRODUCT_DESIGNER|MOTION_DESIGNER|VISUAL_DESIGNER|THREE_D_DESIGNER)$", 
             message = "职业类型不在允许的范围内")
    @Schema(description = "职业类型", example = "UI_UX_DESIGNER", 
            allowableValues = {"ILLUSTRATOR", "INTERACTION_DESIGNER", "BRAND_DESIGNER", "UI_DESIGNER", 
                             "UX_DESIGNER", "UI_UX_DESIGNER", "GRAPHIC_DESIGNER", "PRODUCT_DESIGNER", 
                             "MOTION_DESIGNER", "VISUAL_DESIGNER", "THREE_D_DESIGNER"})
    private String profession;

    /**
     * 技能标签（JSON数组格式）
     */
    @Schema(description = "技能标签，JSON数组格式", 
            example = "[\"prototype_design\", \"visual_design\"]")
    private String skillTags;

    /**
     * 工作年限
     */
    @Min(value = 0, message = "工作年限不能小于0")
    @Max(value = 50, message = "工作年限不能大于50")
    @Schema(description = "工作年限（年）", example = "3", minimum = "0", maximum = "50")
    private Integer workYears;

    /**
     * 所属院校ID（可为空）
     */
    @Schema(description = "所属院校ID", example = "1")
    private Long schoolId;

    /**
     * 所属企业ID（可为空）
     */
    @Schema(description = "所属企业ID", example = "1")
    private Long enterpriseId;

    /**
     * 毕业时间（如果是学生）
     */
    @Schema(description = "毕业时间，格式：yyyy-MM-dd", example = "2022-06-30", type = "string", format = "date")
    private LocalDate graduationDate;

    /**
     * 入职时间（如果有企业）
     */
    @Schema(description = "入职时间，格式：yyyy-MM-dd", example = "2022-07-15", type = "string", format = "date")
    private LocalDate joinDate;

    /**
     * 作品集链接
     */
    @Schema(description = "作品集链接", example = "https://portfolio.example.com")
    private String portfolioUrl;

    /**
     * 社交媒体链接
     */
    @Schema(description = "社交媒体链接，JSON字符串格式", 
            type = "string",
            example = "\"{\\\"github\\\":\\\"https://github.com/testuser\\\",\\\"behance\\\":\\\"https://behance.net/testuser\\\"}\"")
    private String socialLinks;

    /**
     * 工作状态（EMPLOYED在职、FREELANCER自由职业者、SEEKING求职中等）
     */
    @Pattern(regexp = "^(EMPLOYED|FREELANCER|SEEKING|STUDENT)$", message = "工作状态不在允许的范围内")
    @Schema(description = "工作状态", example = "EMPLOYED", 
            allowableValues = {"EMPLOYED", "FREELANCER", "SEEKING", "STUDENT"})
    private String workStatus;

    /**
     * 工作地点
     */
    @Schema(description = "工作地点", example = "深圳市南山区")
    private String location;

    /**
     * 状态（0正常 1停用）
     */
    @Pattern(regexp = "^[01]$", message = "状态值必须为0或1")
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