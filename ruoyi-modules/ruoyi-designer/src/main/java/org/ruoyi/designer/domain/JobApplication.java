package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableLogic;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;
import java.util.Date;

/**
 * 岗位申请对象 des_job_application
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_job_application")
@Schema(description = "岗位申请信息")
public class JobApplication extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 申请ID
     */
    @JsonIgnore
    @Schema(description = "申请ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "application_id")
    private Long applicationId;

    /**
     * 岗位ID
     */
    @Schema(description = "岗位ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long jobId;

    /**
     * 设计师ID
     */
    @Schema(description = "设计师ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long designerId;

    /**
     * 申请说明
     */
    @Schema(description = "申请说明", example = "我对这个岗位很感兴趣，希望能加入贵公司团队")
    private String coverLetter;

    /**
     * 简历文件URL
     */
    @Schema(description = "简历文件URL", example = "https://example.com/resume.pdf")
    private String resumeUrl;

    /**
     * 申请状态（0待审核 1通过 2拒绝 3撤回）
     */
    @Schema(description = "申请状态", example = "0", 
            allowableValues = {"0", "1", "2", "3"},
            accessMode = Schema.AccessMode.READ_ONLY,
            enumAsRef = true,
            implementation = String.class)
    private String status;

    /**
     * 企业反馈
     */
    @Schema(description = "企业反馈", example = "感谢您的申请，我们会尽快安排面试",
            accessMode = Schema.AccessMode.READ_ONLY)
    private String feedback;

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