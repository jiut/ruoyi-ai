package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 企业对象 des_enterprise
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_enterprise")
@Schema(description = "企业信息")
public class Enterprise extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 企业ID
     */
    @JsonIgnore
    @Schema(description = "企业ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "enterprise_id")
    private Long enterpriseId;

    /**
     * 关联用户ID
     */
    @JsonIgnore
    @Schema(description = "关联用户ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    private Long userId;

    /**
     * 企业名称
     */
    @Schema(description = "企业名称", example = "创新科技有限公司", requiredMode = Schema.RequiredMode.REQUIRED)
    private String enterpriseName;

    /**
     * 企业简介
     */
    @Schema(description = "企业简介", example = "专注于互联网产品设计与开发的创新型企业")
    private String description;

    /**
     * 企业地址
     */
    @Schema(description = "企业地址", example = "北京市朝阳区")
    private String address;

    /**
     * 联系电话
     */
    @Schema(description = "联系电话", example = "010-12345678")
    private String phone;

    /**
     * 联系邮箱
     */
    @Schema(description = "联系邮箱", example = "contact@company.com")
    private String email;

    /**
     * 企业网站
     */
    @Schema(description = "企业网站", example = "https://www.company.com")
    private String website;

    /**
     * 企业规模
     */
    @Schema(description = "企业规模", example = "100-500人", 
            allowableValues = {"1-50人", "50-100人", "100-500人", "500-1000人", "1000人以上"})
    private String scale;

    /**
     * 行业类型
     */
    @Schema(description = "行业类型", example = "互联网",
            allowableValues = {"互联网", "软件开发", "游戏", "电商", "金融", "教育", "医疗", "制造业", "其他"})
    private String industry;

    /**
     * 企业LOGO
     */
    @Schema(description = "企业LOGO链接", example = "https://www.company.com/logo.png")
    private String logo;

    /**
     * 状态（0正常 1停用）
     */
    @Schema(description = "状态", example = "0", allowableValues = {"0", "1"})
    private String status;
} 