package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.baomidou.mybatisplus.annotation.TableField;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 任务交付物对象 des_task_deliverable
 * 智图工厂的交付物管理
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_task_deliverable")
@Schema(description = "任务交付物信息")
public class TaskDeliverable extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 交付物ID
     */
    @Schema(description = "交付物ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "deliverable_id")
    private Long deliverableId;

    /**
     * 任务ID
     */
    @Schema(description = "任务ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long taskId;

    /**
     * 设计师ID
     */
    @Schema(description = "设计师ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long designerId;

    /**
     * 交付内容（可包含链接、提取码、说明等）
     */
    @Schema(description = "交付内容", example = "设计稿已完成，包含AI源文件和PNG导出文件\\n\\n百度网盘链接：https://pan.baidu.com/s/1abcdef123456\\n提取码：abc123")
    private String deliverableContent;

    /**
     * 版本号
     */
    @Schema(description = "版本号", example = "1")
    private Integer version;

    /**
     * 状态
     */
    @Schema(description = "状态", example = "SUBMITTED", 
            allowableValues = {"SUBMITTED", "APPROVED", "REVISION_REQUIRED", "REJECTED"})
    private String status;

    /**
     * 审核反馈
     */
    @Schema(description = "审核反馈", example = "设计质量很好，完全符合要求")
    private String reviewFeedback;

    /**
     * 删除标志（0代表存在 1代表删除）
     */
    @Schema(description = "删除标志", hidden = true)
    private String delFlag;

    // ===== 关联对象（查询时使用）=====
    
    /**
     * 任务信息（关联查询时使用）
     */
    @TableField(exist = false)
    @Schema(description = "任务信息", accessMode = Schema.AccessMode.READ_ONLY)
    private Task task;

    /**
     * 设计师信息（关联查询时使用）
     */
    @TableField(exist = false)
    @Schema(description = "设计师信息", accessMode = Schema.AccessMode.READ_ONLY)
    private Designer designer;

    /**
     * 交付物状态枚举
     */
    public enum DeliverableStatus {
        SUBMITTED("已提交"),
        APPROVED("已通过"),
        REVISION_REQUIRED("需要修改"),
        REJECTED("已拒绝");

        private final String description;

        DeliverableStatus(String description) {
            this.description = description;
        }

        public String getDescription() {
            return description;
        }

        /**
         * 根据状态值获取枚举
         */
        public static DeliverableStatus fromValue(String value) {
            for (DeliverableStatus status : values()) {
                if (status.name().equals(value)) {
                    return status;
                }
            }
            return SUBMITTED;
        }

        /**
         * 检查是否为终态
         */
        public boolean isFinalStatus() {
            return this == APPROVED || this == REJECTED;
        }

        /**
         * 检查是否可以修改
         */
        public boolean canModify() {
            return this == SUBMITTED || this == REVISION_REQUIRED;
        }
    }
} 