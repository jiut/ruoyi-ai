package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;
import java.util.Date;

/**
 * 申请状态变更日志对象 des_application_state_log
 * 用于记录任务申请的状态转换历史，提供完整的审计轨迹
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_application_state_log")
@Schema(description = "申请状态变更日志")
public class ApplicationStateLog extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 日志ID
     */
    @Schema(description = "日志ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
    @TableId(value = "log_id")
    private Long logId;

    /**
     * 申请ID
     */
    @Schema(description = "申请ID", example = "1", requiredMode = Schema.RequiredMode.REQUIRED)
    private Long applicationId;

    /**
     * 原状态
     */
    @Schema(description = "原状态", example = "0")
    private String fromStatus;

    /**
     * 目标状态
     */
    @Schema(description = "目标状态", example = "1")
    private String toStatus;

    /**
     * 操作类型
     */
    @Schema(description = "操作类型", example = "ADMIN_REVIEW")
    private String action;

    /**
     * 审核反馈
     */
    @Schema(description = "审核反馈")
    private String feedback;

    /**
     * 操作人ID
     */
    @Schema(description = "操作人ID", example = "1")
    private Long operatorId;

    /**
     * 操作人姓名
     */
    @Schema(description = "操作人姓名", example = "张管理员")
    private String operatorName;

    /**
     * 转换时间
     */
    @Schema(description = "转换时间")
    private Date transitionTime;

    /**
     * 审核模式
     */
    @Schema(description = "审核模式", example = "DUAL")
    private String reviewMode;

    /**
     * 操作耗时（毫秒）
     */
    @Schema(description = "操作耗时（毫秒）", example = "1500")
    private Long duration;

    /**
     * 客户端IP
     */
    @Schema(description = "客户端IP", example = "192.168.1.100")
    private String clientIp;

    /**
     * 用户代理
     */
    @Schema(description = "用户代理")
    private String userAgent;

    /**
     * 附加信息（JSON格式）
     */
    @Schema(description = "附加信息")
    private String metadata;
} 