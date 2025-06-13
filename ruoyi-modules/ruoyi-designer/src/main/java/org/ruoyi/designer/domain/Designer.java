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
    @JsonIgnore
    @Schema(description = "设计师ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "designer_id")
    private Long designerId;

    /**
     * 关联用户ID
     */
    @JsonIgnore
    @Schema(description = "关联用户ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    private Long userId;

    /**
     * 设计师姓名
     */
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
    @Schema(description = "联系电话", example = "13800138000", requiredMode = Schema.RequiredMode.REQUIRED)
    private String phone;

    /**
     * 联系邮箱
     */
    @Schema(description = "联系邮箱", example = "zhangsan@example.com", requiredMode = Schema.RequiredMode.REQUIRED)
    private String email;

    /**
     * 个人简介
     */
    @Schema(description = "个人简介", example = "专业UI设计师，擅长原型设计和视觉设计")
    private String description;

    /**
     * 职业（插画师、交互设计师等）
     */
    @Schema(description = "职业类型", example = "UI_DESIGNER", 
            allowableValues = {"ILLUSTRATOR", "INTERACTION_DESIGNER", "BRAND_DESIGNER", "UI_DESIGNER", 
                             "UX_DESIGNER", "GRAPHIC_DESIGNER", "PRODUCT_DESIGNER", "MOTION_DESIGNER"},
            requiredMode = Schema.RequiredMode.REQUIRED)
    private String profession;

    /**
     * 技能标签（JSON数组格式）
     */
    @Schema(description = "技能标签，JSON数组格式", 
            example = "[\"PROTOTYPE_DESIGN\", \"VISUAL_DESIGN\"]")
    private String skillTags;

    /**
     * 工作年限
     */
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
     * 状态（0正常 1停用）
     */
    @Schema(description = "状态", example = "0", allowableValues = {"0", "1"})
    private String status;
} 