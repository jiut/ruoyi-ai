package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.core.utils.ServletUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.designer.domain.ApplicationStateLog;
import org.ruoyi.designer.domain.enums.ApplicationStatus;
import org.ruoyi.designer.domain.enums.TransitionAction;
import org.ruoyi.designer.mapper.ApplicationStateLogMapper;
import org.ruoyi.system.service.ISysUserService;
import org.springframework.stereotype.Service;

import jakarta.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 应用状态日志服务
 * 记录状态变更的审计轨迹
 * 
 * @author ruoyi
 */
@Service
@Slf4j
@RequiredArgsConstructor
public class ApplicationStateLogService extends ServiceImpl<ApplicationStateLogMapper, ApplicationStateLog> {
    
    private final ISysUserService userService;
    
    /**
     * 记录状态转换日志
     * 
     * @param applicationId 申请ID
     * @param fromStatus 原状态
     * @param toStatus 目标状态
     * @param action 操作类型
     * @param operatorId 操作人ID
     * @param duration 操作耗时（毫秒）
     */
    public void logStateTransition(Long applicationId, ApplicationStatus fromStatus, 
                                  ApplicationStatus toStatus, TransitionAction action, 
                                  Long operatorId, long duration) {
        try {
            // 构建状态变更日志记录
            ApplicationStateLog stateLog = new ApplicationStateLog();
            stateLog.setApplicationId(applicationId);
            stateLog.setFromStatus(fromStatus.getCode());
            stateLog.setToStatus(toStatus.getCode());
            stateLog.setAction(action.name());
            stateLog.setOperatorId(operatorId);
            stateLog.setOperatorName(getOperatorName(operatorId));
            stateLog.setTransitionTime(new Date());
            stateLog.setDuration(duration);
            
            // 获取请求上下文信息
            HttpServletRequest request = ServletUtils.getRequest();
            if (request != null) {
                stateLog.setClientIp(ServletUtils.getClientIP());
                stateLog.setUserAgent(request.getHeader("User-Agent"));
            }
            
            // 保存到数据库
            save(stateLog);
            
            // 记录到系统日志
            log.info("状态变更日志已记录: applicationId={}, from={}, to={}, operator={}, duration={}ms", 
                    applicationId, fromStatus.getName(), toStatus.getName(), operatorId, duration);
            
        } catch (Exception e) {
            log.error("记录状态转换日志失败: applicationId={}, from={}, to={}", 
                     applicationId, fromStatus, toStatus, e);
        }
    }
    
    /**
     * 获取申请的完整状态变更历史
     * 
     * @param applicationId 申请ID
     * @return 状态变更历史列表
     */
    public List<ApplicationStateLog> getStateHistory(Long applicationId) {
        return baseMapper.selectStateHistoryByApplicationId(applicationId);
    }
    
    /**
     * 获取指定时间范围内的审核日志
     * 
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @param action 操作类型（可选）
     * @return 审核日志列表
     */
    public List<ApplicationStateLog> getLogsByDateRange(Date startDate, Date endDate, TransitionAction action) {
        return baseMapper.selectLogsByDateRange(startDate, endDate, action);
    }
    
    /**
     * 获取操作人的审核历史
     * 
     * @param operatorId 操作人ID
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @return 审核历史列表
     */
    public List<ApplicationStateLog> getLogsByOperator(Long operatorId, Date startDate, Date endDate) {
        return baseMapper.selectLogsByOperator(operatorId, startDate, endDate);
    }
    
    /**
     * 获取审核效率统计
     * 
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @return 效率统计数据
     */
    public ReviewEfficiencyStats getReviewEfficiencyStats(Date startDate, Date endDate) {
        try {
            ReviewEfficiencyStats stats = new ReviewEfficiencyStats();
            
            // 系统管理员审核统计
            Map<String, Object> adminStats = baseMapper.selectReviewEfficiencyStats(startDate, endDate, TransitionAction.ADMIN_REVIEW);
            if (adminStats != null) {
                stats.setAdminReviewCount(getMapValue(adminStats, "review_count", 0L));
                stats.setAdminApprovalRate(getMapValue(adminStats, "approval_rate", 0.0));
                
                Long avgDuration = baseMapper.selectAverageReviewDuration(TransitionAction.ADMIN_REVIEW, startDate, endDate);
                stats.setAdminAvgDuration(avgDuration != null ? avgDuration : 0L);
            }
            
            // 企业管理员审核统计
            Map<String, Object> enterpriseStats = baseMapper.selectReviewEfficiencyStats(startDate, endDate, TransitionAction.ENTERPRISE_REVIEW);
            if (enterpriseStats != null) {
                stats.setEnterpriseReviewCount(getMapValue(enterpriseStats, "review_count", 0L));
                stats.setEnterpriseApprovalRate(getMapValue(enterpriseStats, "approval_rate", 0.0));
                
                Long avgDuration = baseMapper.selectAverageReviewDuration(TransitionAction.ENTERPRISE_REVIEW, startDate, endDate);
                stats.setEnterpriseAvgDuration(avgDuration != null ? avgDuration : 0L);
            }
            
            // 总体通过率统计
            Map<String, Object> overallStats = baseMapper.selectApprovalRateStats(startDate, endDate);
            if (overallStats != null) {
                stats.setOverallApprovalRate(getMapValue(overallStats, "overall_approval_rate", 0.0));
            }
            
            return stats;
            
        } catch (Exception e) {
            log.error("获取审核效率统计失败: startDate={}, endDate={}", startDate, endDate, e);
            return new ReviewEfficiencyStats();
        }
    }
    
    /**
     * 获取最新的状态变更记录
     * 
     * @param applicationId 申请ID
     * @return 最新的状态变更记录
     */
    public ApplicationStateLog getLatestStateLog(Long applicationId) {
        return baseMapper.selectLatestStateLog(applicationId);
    }
    
    /**
     * 统计指定操作类型的日志数量
     * 
     * @param action 操作类型
     * @param startDate 开始时间
     * @param endDate 结束时间
     * @return 日志数量
     */
    public Long countLogsByAction(TransitionAction action, Date startDate, Date endDate) {
        return baseMapper.countLogsByAction(action, startDate, endDate);
    }
    
    /**
     * 获取操作人姓名
     */
    private String getOperatorName(Long operatorId) {
        try {
            if (operatorId == null) {
                return "系统自动";
            }
            
            // 根据操作人ID获取姓名
            var user = userService.selectUserById(operatorId);
            return user != null ? user.getNickName() : "未知用户";
        } catch (Exception e) {
            log.warn("获取操作人姓名失败: operatorId={}", operatorId, e);
            return "未知用户";
        }
    }
    
    /**
     * 安全获取Map中的值
     */
    @SuppressWarnings("unchecked")
    private <T> T getMapValue(Map<String, Object> map, String key, T defaultValue) {
        try {
            Object value = map.get(key);
            return value != null ? (T) value : defaultValue;
        } catch (Exception e) {
            return defaultValue;
        }
    }
    
    /**
     * 审核效率统计数据类
     */
    public static class ReviewEfficiencyStats {
        private Long adminReviewCount = 0L;
        private Double adminApprovalRate = 0.0;
        private Long adminAvgDuration = 0L;
        private Long enterpriseReviewCount = 0L;
        private Double enterpriseApprovalRate = 0.0;
        private Long enterpriseAvgDuration = 0L;
        private Double overallApprovalRate = 0.0;
        
        // Getters and setters
        public Long getAdminReviewCount() { return adminReviewCount; }
        public void setAdminReviewCount(Long adminReviewCount) { this.adminReviewCount = adminReviewCount; }
        public Double getAdminApprovalRate() { return adminApprovalRate; }
        public void setAdminApprovalRate(Double adminApprovalRate) { this.adminApprovalRate = adminApprovalRate; }
        public Long getAdminAvgDuration() { return adminAvgDuration; }
        public void setAdminAvgDuration(Long adminAvgDuration) { this.adminAvgDuration = adminAvgDuration; }
        public Long getEnterpriseReviewCount() { return enterpriseReviewCount; }
        public void setEnterpriseReviewCount(Long enterpriseReviewCount) { this.enterpriseReviewCount = enterpriseReviewCount; }
        public Double getEnterpriseApprovalRate() { return enterpriseApprovalRate; }
        public void setEnterpriseApprovalRate(Double enterpriseApprovalRate) { this.enterpriseApprovalRate = enterpriseApprovalRate; }
        public Long getEnterpriseAvgDuration() { return enterpriseAvgDuration; }
        public void setEnterpriseAvgDuration(Long enterpriseAvgDuration) { this.enterpriseAvgDuration = enterpriseAvgDuration; }
        public Double getOverallApprovalRate() { return overallApprovalRate; }
        public void setOverallApprovalRate(Double overallApprovalRate) { this.overallApprovalRate = overallApprovalRate; }
    }
} 