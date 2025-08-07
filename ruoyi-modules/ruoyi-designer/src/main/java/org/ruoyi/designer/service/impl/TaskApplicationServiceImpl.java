package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.designer.domain.TaskApplication;
import org.ruoyi.designer.domain.enums.ApplicationStatus;
import org.ruoyi.designer.domain.enums.ReviewMode;
import org.ruoyi.designer.mapper.TaskApplicationMapper;
import org.ruoyi.designer.service.ITaskApplicationService;
import org.ruoyi.designer.util.TaskConfigService;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.Date;
import java.util.List;

/**
 * 任务申请Service业务层处理
 *
 * @author ruoyi
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class TaskApplicationServiceImpl implements ITaskApplicationService {

    private final TaskApplicationMapper baseMapper;
    private final TaskConfigService taskConfigService;

    /**
     * 查询任务申请
     *
     * @param applicationId 任务申请主键
     * @return 任务申请
     */
    @Override
    public TaskApplication selectTaskApplicationById(Long applicationId) {
        return baseMapper.selectById(applicationId);
    }

    /**
     * 查询任务申请列表
     *
     * @param taskApplication 任务申请
     * @return 任务申请
     */
    @Override
    public List<TaskApplication> selectTaskApplicationList(TaskApplication taskApplication) {
        LambdaQueryWrapper<TaskApplication> lqw = buildQueryWrapper(taskApplication);
        return baseMapper.selectList(lqw);
    }

    /**
     * 分页查询任务申请列表
     *
     * @param taskApplication 任务申请
     * @param pageQuery 分页参数
     * @return 任务申请分页数据
     */
    @Override
    public TableDataInfo<TaskApplication> selectTaskApplicationPage(TaskApplication taskApplication, PageQuery pageQuery) {
        LambdaQueryWrapper<TaskApplication> lqw = buildQueryWrapper(taskApplication);
        Page<TaskApplication> result = baseMapper.selectPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 新增任务申请
     *
     * @param taskApplication 任务申请
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertTaskApplication(TaskApplication taskApplication) {
        // 检查是否已申请过该任务
        if (hasApplied(taskApplication.getTaskId(), taskApplication.getDesignerId())) {
            throw new RuntimeException("该任务已申请过，不能重复申请");
        }

        // 设置初始状态和审核模式
        taskApplication.setStatus(ApplicationStatus.PENDING.getCode());
        taskApplication.setReviewMode(taskConfigService.getReviewMode().name());
        
        // 初始化审核状态
        taskApplication.setAdminReviewStatus("PENDING");
        taskApplication.setEnterpriseReviewStatus("PENDING");
        
        // 设置创建信息
        Long userId = LoginHelper.getUserId();
        taskApplication.setCreateBy(userId);
        taskApplication.setCreateTime(new Date());
        
        int result = baseMapper.insert(taskApplication);
        
        if (result > 0) {
            log.info("新增任务申请成功: applicationId={}, taskId={}, designerId={}", 
                    taskApplication.getApplicationId(), taskApplication.getTaskId(), taskApplication.getDesignerId());
        }
        
        return result > 0;
    }

    /**
     * 修改任务申请
     *
     * @param taskApplication 任务申请
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateTaskApplication(TaskApplication taskApplication) {
        taskApplication.setUpdateBy(LoginHelper.getUserId());
        taskApplication.setUpdateTime(new Date());
        
        int result = baseMapper.updateById(taskApplication);
        
        if (result > 0) {
            log.info("更新任务申请成功: applicationId={}", taskApplication.getApplicationId());
        }
        
        return result > 0;
    }

    /**
     * 批量删除任务申请
     *
     * @param applicationIds 需要删除的任务申请主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteTaskApplicationByIds(Collection<Long> applicationIds) {
        int result = baseMapper.deleteBatchIds(applicationIds);
        
        if (result > 0) {
            log.info("批量删除任务申请成功: applicationIds={}, count={}", applicationIds, result);
        }
        
        return result > 0;
    }

    /**
     * 删除任务申请信息
     *
     * @param applicationId 任务申请主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteTaskApplicationById(Long applicationId) {
        int result = baseMapper.deleteById(applicationId);
        
        if (result > 0) {
            log.info("删除任务申请成功: applicationId={}", applicationId);
        }
        
        return result > 0;
    }

    /**
     * 根据任务ID查询申请列表
     *
     * @param taskId 任务ID
     * @return 申请列表
     */
    @Override
    public List<TaskApplication> selectApplicationsByTaskId(Long taskId) {
        LambdaQueryWrapper<TaskApplication> lqw = Wrappers.<TaskApplication>lambdaQuery();
        lqw.eq(TaskApplication::getTaskId, taskId);
        lqw.eq(TaskApplication::getDelFlag, "0");
        lqw.orderByDesc(TaskApplication::getCreateTime);
        
        return baseMapper.selectList(lqw);
    }

    /**
     * 根据设计师ID查询申请列表
     *
     * @param designerId 设计师ID
     * @return 申请列表
     */
    @Override
    public List<TaskApplication> selectApplicationsByDesignerId(Long designerId) {
        LambdaQueryWrapper<TaskApplication> lqw = Wrappers.<TaskApplication>lambdaQuery();
        lqw.eq(TaskApplication::getDesignerId, designerId);
        lqw.eq(TaskApplication::getDelFlag, "0");
        lqw.orderByDesc(TaskApplication::getCreateTime);
        
        return baseMapper.selectList(lqw);
    }

    /**
     * 根据状态查询申请列表
     *
     * @param status 申请状态
     * @return 申请列表
     */
    @Override
    public List<TaskApplication> selectApplicationsByStatus(String status) {
        LambdaQueryWrapper<TaskApplication> lqw = Wrappers.<TaskApplication>lambdaQuery();
        lqw.eq(TaskApplication::getStatus, status);
        lqw.eq(TaskApplication::getDelFlag, "0");
        lqw.orderByDesc(TaskApplication::getCreateTime);
        
        return baseMapper.selectList(lqw);
    }

    /**
     * 检查是否已申请过该任务
     *
     * @param taskId 任务ID
     * @param designerId 设计师ID
     * @return 是否已申请
     */
    @Override
    public Boolean hasApplied(Long taskId, Long designerId) {
        LambdaQueryWrapper<TaskApplication> lqw = Wrappers.<TaskApplication>lambdaQuery();
        lqw.eq(TaskApplication::getTaskId, taskId);
        lqw.eq(TaskApplication::getDesignerId, designerId);
        lqw.eq(TaskApplication::getDelFlag, "0");
        
        return baseMapper.selectCount(lqw) > 0;
    }

    /**
     * 获取系统管理员待审核申请列表
     *
     * @return 待审核申请列表
     */
    public List<TaskApplication> selectAdminPendingApplications() {
        // 只在双重审核模式下返回数据
        if (!taskConfigService.isDualReviewMode()) {
            return List.of();
        }
        
        LambdaQueryWrapper<TaskApplication> lqw = Wrappers.<TaskApplication>lambdaQuery();
        lqw.eq(TaskApplication::getStatus, ApplicationStatus.PENDING.getCode());
        lqw.eq(TaskApplication::getReviewMode, ReviewMode.DUAL.name());
        lqw.eq(TaskApplication::getAdminReviewStatus, "PENDING");
        lqw.eq(TaskApplication::getDelFlag, "0");
        lqw.orderByAsc(TaskApplication::getCreateTime);
        
        return baseMapper.selectList(lqw);
    }

    /**
     * 获取企业管理员待审核申请列表
     *
     * @param enterpriseId 企业ID
     * @return 待审核申请列表
     */
    public List<TaskApplication> selectEnterprisePendingApplications(Long enterpriseId) {
        LambdaQueryWrapper<TaskApplication> lqw = Wrappers.<TaskApplication>lambdaQuery();
        
        if (taskConfigService.isDualReviewMode()) {
            // 双重审核模式：只显示系统管理员已审核通过的申请
            lqw.eq(TaskApplication::getStatus, ApplicationStatus.ADMIN_APPROVED.getCode());
        } else {
            // 企业自主审核模式：显示所有待审核的申请
            lqw.eq(TaskApplication::getStatus, ApplicationStatus.PENDING.getCode());
        }
        
        lqw.eq(TaskApplication::getEnterpriseReviewStatus, "PENDING");
        lqw.eq(TaskApplication::getDelFlag, "0");
        lqw.orderByAsc(TaskApplication::getCreateTime);
        
        // 需要关联查询任务表来过滤企业ID
        // 这里暂时返回所有，具体的关联查询在Mapper中实现
        return baseMapper.selectEnterprisePendingApplications(enterpriseId);
    }

    /**
     * 构建查询条件
     */
    private LambdaQueryWrapper<TaskApplication> buildQueryWrapper(TaskApplication taskApplication) {
        LambdaQueryWrapper<TaskApplication> lqw = Wrappers.<TaskApplication>lambdaQuery();
        lqw.eq(taskApplication.getTaskId() != null, TaskApplication::getTaskId, taskApplication.getTaskId());
        lqw.eq(taskApplication.getDesignerId() != null, TaskApplication::getDesignerId, taskApplication.getDesignerId());
        lqw.like(StringUtils.isNotBlank(taskApplication.getProposal()), TaskApplication::getProposal, taskApplication.getProposal());
        lqw.eq(taskApplication.getProposedPrice() != null, TaskApplication::getProposedPrice, taskApplication.getProposedPrice());
        lqw.eq(taskApplication.getEstimatedDays() != null, TaskApplication::getEstimatedDays, taskApplication.getEstimatedDays());
        lqw.eq(StringUtils.isNotBlank(taskApplication.getStatus()), TaskApplication::getStatus, taskApplication.getStatus());
        lqw.eq(StringUtils.isNotBlank(taskApplication.getReviewMode()), TaskApplication::getReviewMode, taskApplication.getReviewMode());
        lqw.eq(TaskApplication::getDelFlag, "0");
        lqw.orderByDesc(TaskApplication::getCreateTime);
        
        return lqw;
    }

    /**
     * 获取系统管理员审核基础统计
     *
     * @return 基础统计数据
     */
    public BasicReviewStats getBasicReviewStats() {
        try {
            // 查询统计数据
            java.util.Map<String, Object> statsMap = baseMapper.selectAdminReviewStats(null, null);
            
            BasicReviewStats stats = new BasicReviewStats();
            if (statsMap != null) {
                // 安全获取统计值
                Object pendingCountObj = statsMap.get("pending_count");
                Object reviewedTodayObj = statsMap.get("reviewed_today");
                
                stats.setPendingCount(pendingCountObj != null ? 
                    ((Number) pendingCountObj).longValue() : 0L);
                stats.setReviewedToday(reviewedTodayObj != null ? 
                    ((Number) reviewedTodayObj).longValue() : 0L);
            } else {
                stats.setPendingCount(0L);
                stats.setReviewedToday(0L);
            }
            
            return stats;
            
        } catch (Exception e) {
            log.error("获取系统管理员审核基础统计失败", e);
            // 返回默认值
            BasicReviewStats stats = new BasicReviewStats();
            stats.setPendingCount(0L);
            stats.setReviewedToday(0L);
            return stats;
        }
    }

    /**
     * 基础审核统计数据
     */
    public static class BasicReviewStats {
        /** 待审核申请数量 */
        private Long pendingCount;
        
        /** 今日已审核数量 */
        private Long reviewedToday;

        // Getters and setters
        public Long getPendingCount() { return pendingCount; }
        public void setPendingCount(Long pendingCount) { this.pendingCount = pendingCount; }
        public Long getReviewedToday() { return reviewedToday; }
        public void setReviewedToday(Long reviewedToday) { this.reviewedToday = reviewedToday; }
    }
} 