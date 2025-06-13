package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;
import org.ruoyi.common.core.utils.StringUtils;

import java.io.Serial;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

/**
 * 岗位招聘对象 des_job_posting
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_job_posting")
@Schema(description = "岗位招聘信息")
public class JobPosting extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 岗位ID
     */
    @JsonIgnore
    @Schema(description = "岗位ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "job_id")
    private Long jobId;

    /**
     * 企业ID
     */
    @Schema(description = "企业ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long enterpriseId;

    /**
     * 岗位名称
     */
    @Schema(description = "岗位名称", example = "高级UI设计师", requiredMode = Schema.RequiredMode.REQUIRED)
    private String jobTitle;

    /**
     * 岗位描述
     */
    @Schema(description = "岗位描述", example = "负责移动端产品UI设计，与产品经理和开发团队紧密合作")
    private String description;

    /**
     * 职业要求（对应设计师职业）
     */
    @Schema(description = "职业要求", example = "UI_DESIGNER",
            allowableValues = {"ILLUSTRATOR", "INTERACTION_DESIGNER", "BRAND_DESIGNER", "UI_DESIGNER", 
                             "UX_DESIGNER", "GRAPHIC_DESIGNER", "PRODUCT_DESIGNER", "MOTION_DESIGNER"},
            requiredMode = Schema.RequiredMode.REQUIRED)
    private String requiredProfession;

    /**
     * 技能要求（JSON数组格式）
     */
    @Schema(description = "技能要求，JSON数组格式", 
            example = "[\"PROTOTYPE_DESIGN\", \"VISUAL_DESIGN\", \"USER_INTERFACE_DESIGN\"]")
    private String requiredSkills;

    /**
     * 工作年限要求
     */
    @Schema(description = "工作年限要求", example = "3-5年")
    private String workYearsRequired;

    /**
     * 薪资范围最低值
     */
    @Schema(description = "薪资范围最低值（元）", example = "15000")
    private BigDecimal salaryMin;

    /**
     * 薪资范围最高值
     */
    @Schema(description = "薪资范围最高值（元）", example = "25000")
    private BigDecimal salaryMax;

    /**
     * 工作地点
     */
    @Schema(description = "工作地点", example = "北京市朝阳区")
    private String location;

    /**
     * 工作类型（全职/兼职/实习）
     */
    @Schema(description = "工作类型", example = "全职", allowableValues = {"全职", "兼职", "实习"})
    private String jobType;

    /**
     * 学历要求
     */
    @Schema(description = "学历要求", example = "本科及以上")
    private String educationRequired;

    /**
     * 招聘人数
     */
    @Schema(description = "招聘人数", example = "2", minimum = "1")
    private Integer recruitmentCount;

    /**
     * 截止日期
     */
    @Schema(description = "截止日期，格式：yyyy-MM-dd", example = "2024-12-31", type = "string", format = "date")
    private LocalDate deadline;

    /**
     * 联系人
     */
    @Schema(description = "联系人", example = "王经理")
    private String contactPerson;

    /**
     * 联系电话
     */
    @Schema(description = "联系电话", example = "010-12345678")
    private String contactPhone;

    /**
     * 联系邮箱
     */
    @Schema(description = "联系邮箱", example = "hr@company.com")
    private String contactEmail;

    /**
     * 状态（0正常 1停用 2已结束）
     */
    @Schema(description = "状态", example = "0", allowableValues = {"0", "1", "2"})
    private String status;

    /**
     * 设置技能要求
     * 如果传入的是逗号分隔的字符串，自动转换为JSON数组格式
     */
    public void setRequiredSkills(String requiredSkills) {
        if (StringUtils.isBlank(requiredSkills)) {
            this.requiredSkills = null;
            return;
        }
        
        // 如果已经是JSON格式（以[开头），直接使用
        if (requiredSkills.trim().startsWith("[")) {
            this.requiredSkills = requiredSkills;
            return;
        }
        
        // 如果是逗号分隔的字符串，转换为JSON数组
        try {
            String[] skillArray = requiredSkills.split(",");
            List<String> skillList = Arrays.stream(skillArray)
                    .map(String::trim)
                    .filter(StringUtils::isNotBlank)
                    .toList();
            
            ObjectMapper objectMapper = new ObjectMapper();
            this.requiredSkills = objectMapper.writeValueAsString(skillList);
        } catch (JsonProcessingException e) {
            // 如果转换失败，记录错误并设置为空
            throw new RuntimeException("技能要求格式转换失败: " + e.getMessage(), e);
        }
    }
} 