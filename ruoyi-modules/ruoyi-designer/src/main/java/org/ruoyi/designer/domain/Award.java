package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.core.validate.EditGroup;

import java.io.Serial;

/**
 * 获奖对象 des_award
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_award")
@Schema(description = "设计师获奖信息")
public class Award extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 获奖ID
     */
    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    @Schema(description = "获奖ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "award_id")
    private Long awardId;

    /**
     * 设计师ID
     */
    @NotNull(message = "设计师ID不能为空", groups = {AddGroup.class, EditGroup.class})
    @Schema(description = "设计师ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long designerId;

    /**
     * 奖项名称
     */
    @NotBlank(message = "奖项名称不能为空", groups = {AddGroup.class, EditGroup.class})
    @Schema(description = "奖项名称", example = "2023 iF 设计奖", requiredMode = Schema.RequiredMode.REQUIRED)
    private String title;

    /**
     * 颁发机构
     */
    @NotBlank(message = "颁发机构不能为空", groups = {AddGroup.class, EditGroup.class})
    @Schema(description = "颁发机构", example = "iF International Forum Design", requiredMode = Schema.RequiredMode.REQUIRED)
    private String organization;

    /**
     * 获奖年份
     */
    @NotBlank(message = "获奖年份不能为空", groups = {AddGroup.class, EditGroup.class})
    @Schema(description = "获奖年份", example = "2023", requiredMode = Schema.RequiredMode.REQUIRED)
    private String year;

    /**
     * 奖项等级
     */
    @Schema(description = "奖项等级", example = "金奖")
    private String level;

    /**
     * 奖项类别
     */
    @Schema(description = "奖项类别", example = "产品设计")
    private String category;

    /**
     * 获奖作品
     */
    @Schema(description = "获奖作品", example = "腾讯社交产品界面设计")
    private String workTitle;

    /**
     * 描述
     */
    @Schema(description = "描述", example = "该作品在用户体验和视觉设计方面表现出色")
    private String description;

    /**
     * 证书链接
     */
    @Schema(description = "证书链接", example = "https://example.com/certificate.pdf")
    private String certificateUrl;

    /**
     * 排序号
     */
    @Schema(description = "排序号", example = "1")
    private Integer sort;

    /**
     * 状态（0正常 1停用）
     */
    @Schema(description = "状态", example = "0", allowableValues = {"0", "1"})
    private String status;

    /**
     * 删除标志（0代表存在 1代表删除）
     */
    @TableLogic
    @Schema(description = "删除标志", example = "0", allowableValues = {"0", "1"})
    private String delFlag;
} 