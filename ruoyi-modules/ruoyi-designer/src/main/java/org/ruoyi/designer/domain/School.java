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
 * 院校对象 des_school
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_school")
@Schema(description = "院校信息")
public class School extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 院校ID
     */
    @JsonIgnore
    @Schema(description = "院校ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "school_id")
    private Long schoolId;

    /**
     * 关联用户ID
     */
    @JsonIgnore
    @Schema(description = "关联用户ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    private Long userId;

    /**
     * 院校名称
     */
    @Schema(description = "院校名称", example = "北京设计学院", requiredMode = Schema.RequiredMode.REQUIRED)
    private String schoolName;

    /**
     * 院校简介
     */
    @Schema(description = "院校简介", example = "专业的设计教育机构，致力于培养优秀的设计人才")
    private String description;

    /**
     * 院校地址
     */
    @Schema(description = "院校地址", example = "北京市海淀区")
    private String address;

    /**
     * 联系电话
     */
    @Schema(description = "联系电话", example = "010-12345678")
    private String phone;

    /**
     * 联系邮箱
     */
    @Schema(description = "联系邮箱", example = "contact@school.edu.cn")
    private String email;

    /**
     * 院校网站
     */
    @Schema(description = "院校网站", example = "https://www.school.edu.cn")
    private String website;

    /**
     * 院校类型
     */
    @Schema(description = "院校类型", example = "UNIVERSITY",
            allowableValues = {"UNIVERSITY", "COLLEGE", "VOCATIONAL_SCHOOL", "TRAINING_INSTITUTION"})
    private String schoolType;

    /**
     * 院校等级
     */
    @Schema(description = "院校等级", example = "本科",
            allowableValues = {"专科", "本科", "硕士", "博士", "其他"})
    private String level;

    /**
     * 院校LOGO
     */
    @Schema(description = "院校LOGO链接", example = "https://www.school.edu.cn/logo.png")
    private String logo;

    /**
     * 状态（0正常 1停用）
     */
    @Schema(description = "状态", example = "0", allowableValues = {"0", "1"})
    private String status;
} 