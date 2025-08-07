package org.ruoyi.designer.util;

import lombok.extern.slf4j.Slf4j;
import org.ruoyi.designer.domain.enums.ReviewMode;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import jakarta.annotation.PostConstruct;

/**
 * 任务配置服务
 * 提供环境变量配置管理和审核模式控制
 *
 * @author ruoyi
 */
@Component
@Slf4j
public class TaskConfigService {

    /**
     * 任务审核模式配置
     * 可配置值：DUAL（双重审核）、ENTERPRISE（企业自主审核）
     * 默认：DUAL
     */
    @Value("${task.review.mode:DUAL}")
    private String taskReviewMode;

    /**
     * 系统管理员审核超时时间（小时）
     * 默认：24小时
     */
    @Value("${task.review.admin.timeout:24}")
    private int adminReviewTimeoutHours;

    /**
     * 企业管理员审核超时时间（小时）
     * 默认：72小时
     */
    @Value("${task.review.enterprise.timeout:72}")
    private int enterpriseReviewTimeoutHours;

    /**
     * 是否启用自动撤回超时申请
     * 默认：false
     */
    @Value("${task.review.auto-withdraw.enabled:false}")
    private boolean autoWithdrawEnabled;

    /**
     * 是否启用审核通知
     * 默认：true
     */
    @Value("${task.review.notification.enabled:true}")
    private boolean notificationEnabled;

    /**
     * 审核日志保留天数
     * 默认：365天
     */
    @Value("${task.review.log.retention-days:365}")
    private int logRetentionDays;

    /**
     * 当前配置的审核模式
     */
    private ReviewMode currentReviewMode;

    /**
     * 初始化配置
     */
    @PostConstruct
    public void initConfig() {
        try {
            this.currentReviewMode = ReviewMode.valueOf(taskReviewMode.toUpperCase());
            log.info("任务审核模式初始化完成: {}", currentReviewMode.getName());
            log.info("系统管理员审核超时时间: {}小时", adminReviewTimeoutHours);
            log.info("企业管理员审核超时时间: {}小时", enterpriseReviewTimeoutHours);
            log.info("自动撤回功能: {}", autoWithdrawEnabled ? "启用" : "禁用");
            log.info("审核通知功能: {}", notificationEnabled ? "启用" : "禁用");
            log.info("审核日志保留天数: {}天", logRetentionDays);
        } catch (IllegalArgumentException e) {
            log.warn("无效的审核模式配置: {}，使用默认值: DUAL", taskReviewMode);
            this.currentReviewMode = ReviewMode.DUAL;
        }
    }

    /**
     * 获取当前审核模式
     *
     * @return 审核模式
     */
    public ReviewMode getReviewMode() {
        return currentReviewMode;
    }

    /**
     * 是否为双重审核模式
     *
     * @return true-双重审核模式，false-企业自主审核模式
     */
    public boolean isDualReviewMode() {
        return ReviewMode.DUAL.equals(currentReviewMode);
    }

    /**
     * 是否为企业自主审核模式
     *
     * @return true-企业自主审核模式，false-双重审核模式
     */
    public boolean isEnterpriseReviewMode() {
        return ReviewMode.ENTERPRISE.equals(currentReviewMode);
    }

    /**
     * 获取系统管理员审核超时时间（小时）
     *
     * @return 超时时间
     */
    public int getAdminReviewTimeoutHours() {
        return adminReviewTimeoutHours;
    }

    /**
     * 获取企业管理员审核超时时间（小时）
     *
     * @return 超时时间
     */
    public int getEnterpriseReviewTimeoutHours() {
        return enterpriseReviewTimeoutHours;
    }

    /**
     * 是否启用自动撤回超时申请
     *
     * @return true-启用，false-禁用
     */
    public boolean isAutoWithdrawEnabled() {
        return autoWithdrawEnabled;
    }

    /**
     * 是否启用审核通知
     *
     * @return true-启用，false-禁用
     */
    public boolean isNotificationEnabled() {
        return notificationEnabled;
    }

    /**
     * 获取审核日志保留天数
     *
     * @return 保留天数
     */
    public int getLogRetentionDays() {
        return logRetentionDays;
    }

    /**
     * 获取配置信息摘要
     *
     * @return 配置摘要
     */
    public String getConfigSummary() {
        return String.format(
            "审核模式: %s, 系统管理员超时: %d小时, 企业管理员超时: %d小时, 自动撤回: %s, 通知: %s, 日志保留: %d天",
            currentReviewMode.getName(),
            adminReviewTimeoutHours,
            enterpriseReviewTimeoutHours,
            autoWithdrawEnabled ? "启用" : "禁用",
            notificationEnabled ? "启用" : "禁用",
            logRetentionDays
        );
    }

    /**
     * 检查配置是否有效
     *
     * @return true-有效，false-无效
     */
    public boolean isConfigValid() {
        return currentReviewMode != null
            && adminReviewTimeoutHours > 0
            && enterpriseReviewTimeoutHours > 0
            && logRetentionDays > 0;
    }

    /**
     * 动态更新审核模式（仅用于开发和测试环境）
     * 
     * @param reviewMode 新的审核模式
     * @return 是否更新成功
     */
    public boolean updateReviewMode(ReviewMode reviewMode) {
        if (reviewMode == null) {
            log.warn("尝试设置空的审核模式，操作被忽略");
            return false;
        }

        ReviewMode oldMode = this.currentReviewMode;
        this.currentReviewMode = reviewMode;
        
        log.info("审核模式已更新: {} -> {}", oldMode.getName(), reviewMode.getName());
        return true;
    }

    /**
     * 重置为默认配置
     */
    public void resetToDefault() {
        this.currentReviewMode = ReviewMode.DUAL;
        log.info("配置已重置为默认值: {}", currentReviewMode.getName());
    }
} 