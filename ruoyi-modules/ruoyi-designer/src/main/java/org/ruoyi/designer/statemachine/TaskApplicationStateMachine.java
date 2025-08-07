package org.ruoyi.designer.statemachine;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.designer.domain.TaskApplication;
import org.ruoyi.designer.domain.Task;
import org.ruoyi.designer.domain.enums.ApplicationStatus;
import org.ruoyi.designer.domain.enums.ReviewMode;
import org.ruoyi.designer.domain.enums.TransitionAction;
import org.ruoyi.designer.service.ITaskApplicationService;
import org.ruoyi.designer.service.ApplicationStateLogService;
import org.ruoyi.designer.service.ITaskService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.core.exception.ServiceException;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 任务申请状态机
 * 负责管理状态转换规则和执行状态变更操作
 * 
 * @author ruoyi
 */
@Component
@Slf4j
@RequiredArgsConstructor
public class TaskApplicationStateMachine {
    
    private final ApplicationStateLogService stateLogService;
    private final ITaskApplicationService applicationService;
    private final DesignerPermissionUtils permissionUtils;
    private final ITaskService taskService;
    
    /**
     * 状态转换规则矩阵（线程安全）
     * 采用三级键值结构：当前状态 + 审核模式 + 操作类型 → 允许的目标状态集合
     */
    private final Map<StateTransitionKey, Set<ApplicationStatus>> transitionRules = initializeTransitionRules();
    
    /**
     * 初始化状态转换规则矩阵
     * 
     * 规则设计原则：
     * 1. 严格按照业务流程定义转换路径
     * 2. 不同审核模式有不同的转换规则
     * 3. 确保状态转换的单向性和原子性
     */
    private Map<StateTransitionKey, Set<ApplicationStatus>> initializeTransitionRules() {
        Map<StateTransitionKey, Set<ApplicationStatus>> rules = new ConcurrentHashMap<>();
        
        // ================== 双重审核模式 ==================
        
        // 规则1：待审核 → 系统管理员审核
        rules.put(
            new StateTransitionKey(ApplicationStatus.PENDING, ReviewMode.DUAL, TransitionAction.ADMIN_REVIEW),
            Set.of(ApplicationStatus.ADMIN_APPROVED, ApplicationStatus.ADMIN_REJECTED)
        );
        
        // 规则2：系统管理员通过 → 企业管理员审核
        rules.put(
            new StateTransitionKey(ApplicationStatus.ADMIN_APPROVED, ReviewMode.DUAL, TransitionAction.ENTERPRISE_REVIEW),
            Set.of(ApplicationStatus.ENTERPRISE_APPROVED, ApplicationStatus.ENTERPRISE_REJECTED)
        );
        
        // 规则3：系统管理员拒绝 → 流程结束（无后续转换）
        rules.put(
            new StateTransitionKey(ApplicationStatus.ADMIN_REJECTED, ReviewMode.DUAL, TransitionAction.SYSTEM_AUTO),
            Collections.emptySet() // 终态：无法继续转换
        );
        
        // ================== 企业自主审核模式 ==================
        
        // 规则4：待审核 → 企业管理员直接审核
        rules.put(
            new StateTransitionKey(ApplicationStatus.PENDING, ReviewMode.ENTERPRISE, TransitionAction.ENTERPRISE_REVIEW),
            Set.of(ApplicationStatus.ENTERPRISE_APPROVED, ApplicationStatus.ENTERPRISE_REJECTED)
        );
        
        // ================== 通用规则：用户撤回 ==================
        
        // 规则5：待审核状态下允许用户撤回（双重审核模式）
        rules.put(
            new StateTransitionKey(ApplicationStatus.PENDING, ReviewMode.DUAL, TransitionAction.WITHDRAW),
            Set.of(ApplicationStatus.WITHDRAWN)
        );
        
        // 规则6：待审核状态下允许用户撤回（企业自主审核模式）
        rules.put(
            new StateTransitionKey(ApplicationStatus.PENDING, ReviewMode.ENTERPRISE, TransitionAction.WITHDRAW),
            Set.of(ApplicationStatus.WITHDRAWN)
        );
        
        // 规则7：系统管理员审核通过后仍允许撤回（双重审核模式特有）
        rules.put(
            new StateTransitionKey(ApplicationStatus.ADMIN_APPROVED, ReviewMode.DUAL, TransitionAction.WITHDRAW),
            Set.of(ApplicationStatus.WITHDRAWN)
        );
        
        log.info("状态机转换规则初始化完成，共{}条规则", rules.size());
        return Collections.unmodifiableMap(rules);
    }
    
    /**
     * 验证状态转换的合法性
     * 
     * @param fromStatus 当前状态
     * @param toStatus 目标状态
     * @param reviewMode 审核模式
     * @param action 操作类型
     * @return 是否允许转换
     */
    public boolean canTransition(ApplicationStatus fromStatus, ApplicationStatus toStatus, 
                                ReviewMode reviewMode, TransitionAction action) {
        StateTransitionKey key = new StateTransitionKey(fromStatus, reviewMode, action);
        Set<ApplicationStatus> allowedStates = transitionRules.get(key);
        
        if (allowedStates == null) {
            log.warn("状态转换规则不存在: from={}, to={}, mode={}, action={}", 
                    fromStatus, toStatus, reviewMode, action);
            return false;
        }
        
        boolean canTransition = allowedStates.contains(toStatus);
        
        if (!canTransition) {
            log.warn("非法状态转换: from={}, to={}, mode={}, action={}, allowed={}", 
                    fromStatus, toStatus, reviewMode, action, allowedStates);
        } else {
            log.debug("状态转换验证通过: from={}, to={}, mode={}, action={}", 
                     fromStatus, toStatus, reviewMode, action);
        }
        
        return canTransition;
    }
    
    /**
     * 执行状态转换
     * 
     * 原子操作包括：
     * 1. 状态转换合法性验证
     * 2. 数据库状态更新
     * 3. 状态变更日志记录
     * 4. 后续业务逻辑触发
     * 
     * @param applicationId 申请ID
     * @param toStatus 目标状态
     * @param action 操作类型
     * @param feedback 审核反馈
     * @param operatorId 操作人ID
     * @return 状态转换结果
     */
    @Transactional(rollbackFor = Exception.class)
    public StateTransitionResult executeTransition(Long applicationId, ApplicationStatus toStatus, 
                                                  TransitionAction action, String feedback, Long operatorId) {
        long startTime = System.currentTimeMillis();
        
        try {
            // 步骤1：获取当前申请信息
            TaskApplication application = applicationService.selectTaskApplicationById(applicationId);
            if (application == null) {
                return StateTransitionResult.failure("申请不存在: " + applicationId);
            }
            
            ApplicationStatus fromStatus = ApplicationStatus.fromCode(application.getStatus());
            ReviewMode reviewMode = ReviewMode.valueOf(application.getReviewMode());
            
            log.info("开始执行状态转换: applicationId={}, from={}, to={}, action={}, operator={}", 
                    applicationId, fromStatus, toStatus, action, operatorId);
            
            // 步骤2：验证转换合法性
            if (!canTransition(fromStatus, toStatus, reviewMode, action)) {
                return StateTransitionResult.failure(
                    String.format("状态转换不被允许: %s → %s (模式: %s, 操作: %s)", 
                                 fromStatus.getName(), toStatus.getName(), reviewMode.getName(), action.getDescription())
                );
            }
            
            // 步骤3：执行状态更新
            updateApplicationStatus(application, toStatus, action, feedback, operatorId);
            
            // 步骤4：记录状态变更日志
            long duration = System.currentTimeMillis() - startTime;
            stateLogService.logStateTransition(applicationId, fromStatus, toStatus, action, operatorId, duration);
            
            // 步骤5：触发后续业务逻辑
            triggerPostTransitionActions(application, fromStatus, toStatus, action);
            
            log.info("状态转换执行成功: applicationId={}, from={}, to={}, duration={}ms", 
                    applicationId, fromStatus, toStatus, duration);
            
            return StateTransitionResult.success("状态更新成功", toStatus);
            
        } catch (Exception e) {
            log.error("状态转换执行失败: applicationId={}, toStatus={}, action={}", 
                     applicationId, toStatus, action, e);
            return StateTransitionResult.failure("状态转换失败: " + e.getMessage());
        }
    }
    
    /**
     * 获取当前状态下允许的操作列表
     * 根据用户角色和申请状态动态计算可执行的操作
     * 
     * @param applicationId 申请ID
     * @param userId 用户ID
     * @return 允许的操作列表
     */
    public List<AllowedAction> getAllowedActions(Long applicationId, Long userId) {
        TaskApplication application = applicationService.selectTaskApplicationById(applicationId);
        if (application == null) {
            return Collections.emptyList();
        }
        
        ApplicationStatus currentStatus = ApplicationStatus.fromCode(application.getStatus());
        ReviewMode reviewMode = ReviewMode.valueOf(application.getReviewMode());
        
        List<AllowedAction> allowedActions = new ArrayList<>();
        
        // 根据状态和用户角色确定允许的操作
        switch (currentStatus) {
            case PENDING:
                // 待审核状态下的可能操作
                if (isDesigner(userId, application.getDesignerId())) {
                    allowedActions.add(new AllowedAction(TransitionAction.WITHDRAW, "撤回申请", "取消本次申请"));
                }
                
                if (reviewMode == ReviewMode.DUAL && isSystemAdmin(userId)) {
                    allowedActions.add(new AllowedAction(TransitionAction.ADMIN_REVIEW, "系统审核", "系统管理员审核"));
                }
                
                if (reviewMode == ReviewMode.ENTERPRISE) {
                    Task task = taskService.selectTaskById(application.getTaskId());
                    if (task != null && isEnterpriseManager(userId, task.getEnterpriseId())) {
                        allowedActions.add(new AllowedAction(TransitionAction.ENTERPRISE_REVIEW, "企业审核", "企业管理员审核"));
                    }
                }
                break;
                
            case ADMIN_APPROVED:
                // 系统管理员审核通过状态下的可能操作
                if (isDesigner(userId, application.getDesignerId())) {
                    allowedActions.add(new AllowedAction(TransitionAction.WITHDRAW, "撤回申请", "在企业审核前撤回"));
                }
                
                Task task = taskService.selectTaskById(application.getTaskId());
                if (task != null && isEnterpriseManager(userId, task.getEnterpriseId())) {
                    allowedActions.add(new AllowedAction(TransitionAction.ENTERPRISE_REVIEW, "企业审核", "企业管理员最终审核"));
                }
                break;
                
            case ADMIN_REJECTED:
            case ENTERPRISE_APPROVED:
            case ENTERPRISE_REJECTED:
            case WITHDRAWN:
                // 终态：无可执行操作
                break;
        }
        
        return allowedActions;
    }
    
    /**
     * 获取状态转换路径
     * 显示从当前状态到目标状态的完整转换路径
     * 
     * @param currentStatus 当前状态
     * @param targetStatus 目标状态
     * @param reviewMode 审核模式
     * @return 转换路径
     */
    public List<StateTransitionPath> getTransitionPath(ApplicationStatus currentStatus, 
                                                      ApplicationStatus targetStatus, 
                                                      ReviewMode reviewMode) {
        List<StateTransitionPath> path = new ArrayList<>();
        
        if (currentStatus == targetStatus) {
            return path; // 已经是目标状态
        }
        
        // 根据审核模式计算转换路径
        if (reviewMode == ReviewMode.DUAL) {
            switch (currentStatus) {
                case PENDING:
                    if (targetStatus == ApplicationStatus.ENTERPRISE_APPROVED) {
                        path.add(new StateTransitionPath(ApplicationStatus.PENDING, ApplicationStatus.ADMIN_APPROVED, TransitionAction.ADMIN_REVIEW));
                        path.add(new StateTransitionPath(ApplicationStatus.ADMIN_APPROVED, ApplicationStatus.ENTERPRISE_APPROVED, TransitionAction.ENTERPRISE_REVIEW));
                    } else if (targetStatus == ApplicationStatus.ADMIN_REJECTED || targetStatus == ApplicationStatus.WITHDRAWN) {
                        path.add(new StateTransitionPath(ApplicationStatus.PENDING, targetStatus, 
                                targetStatus == ApplicationStatus.WITHDRAWN ? TransitionAction.WITHDRAW : TransitionAction.ADMIN_REVIEW));
                    }
                    break;
                    
                case ADMIN_APPROVED:
                    if (targetStatus == ApplicationStatus.ENTERPRISE_APPROVED || targetStatus == ApplicationStatus.ENTERPRISE_REJECTED) {
                        path.add(new StateTransitionPath(ApplicationStatus.ADMIN_APPROVED, targetStatus, TransitionAction.ENTERPRISE_REVIEW));
                    } else if (targetStatus == ApplicationStatus.WITHDRAWN) {
                        path.add(new StateTransitionPath(ApplicationStatus.ADMIN_APPROVED, ApplicationStatus.WITHDRAWN, TransitionAction.WITHDRAW));
                    }
                    break;
            }
        } else if (reviewMode == ReviewMode.ENTERPRISE) {
            if (currentStatus == ApplicationStatus.PENDING) {
                if (targetStatus == ApplicationStatus.ENTERPRISE_APPROVED || targetStatus == ApplicationStatus.ENTERPRISE_REJECTED) {
                    path.add(new StateTransitionPath(ApplicationStatus.PENDING, targetStatus, TransitionAction.ENTERPRISE_REVIEW));
                } else if (targetStatus == ApplicationStatus.WITHDRAWN) {
                    path.add(new StateTransitionPath(ApplicationStatus.PENDING, ApplicationStatus.WITHDRAWN, TransitionAction.WITHDRAW));
                }
            }
        }
        
        return path;
    }
    
    /**
     * 更新申请状态
     */
    private void updateApplicationStatus(TaskApplication application, ApplicationStatus toStatus, 
                                       TransitionAction action, String feedback, Long operatorId) {
        // 更新主状态
        application.setStatus(toStatus.getCode());
        
        // 根据操作类型更新相应的审核字段
        Date now = new Date();
        switch (action) {
            case ADMIN_REVIEW:
                application.setAdminReviewStatus(toStatus == ApplicationStatus.ADMIN_APPROVED ? "APPROVED" : "REJECTED");
                application.setAdminReviewFeedback(feedback);
                application.setAdminReviewTime(now);
                application.setAdminReviewBy(operatorId);
                break;
                
            case ENTERPRISE_REVIEW:
                application.setEnterpriseReviewStatus(toStatus == ApplicationStatus.ENTERPRISE_APPROVED ? "APPROVED" : "REJECTED");
                application.setEnterpriseReviewFeedback(feedback);
                application.setEnterpriseReviewTime(now);
                // 统一反馈字段（用户可见）
                application.setFeedback(feedback);
                break;
                
            case WITHDRAW:
                application.setFeedback("用户主动撤回申请");
                break;
        }
        
        application.setUpdateBy(operatorId);
        application.setUpdateTime(now);
        
        applicationService.updateTaskApplication(application);
    }
    
    /**
     * 触发后续业务逻辑
     */
    private void triggerPostTransitionActions(TaskApplication application, ApplicationStatus fromStatus, 
                                            ApplicationStatus toStatus, TransitionAction action) {
        // 发送通知
        sendNotification(application, fromStatus, toStatus, action);
        
        // 更新任务状态
        updateTaskStatus(application, toStatus);
        
        // 触发工作流
        triggerWorkflow(application, toStatus);
        
        // 记录业务事件
        recordBusinessEvent(application, fromStatus, toStatus, action);
    }
    
    // 辅助方法...
    private boolean isDesigner(Long userId, Long designerId) {
        return designerId.equals(userId);
    }
    
    private boolean isSystemAdmin(Long userId) {
        return LoginHelper.isSuperAdmin();
    }
    
    private boolean isEnterpriseManager(Long userId, Long enterpriseId) {
        // 检查用户是否为指定企业的管理员
        return permissionUtils.hasEnterprisePermission(enterpriseId);
    }
    
    private void sendNotification(TaskApplication application, ApplicationStatus fromStatus, ApplicationStatus toStatus, TransitionAction action) {
        try {
            // 发送给设计师的通知
            sendDesignerNotification(application, fromStatus, toStatus, action);
            
            // 发送给企业管理员的通知
            if (toStatus == ApplicationStatus.ADMIN_APPROVED && action == TransitionAction.ADMIN_REVIEW) {
                sendEnterpriseNotification(application, toStatus);
            }
            
            log.info("状态变更通知发送完成: applicationId={}, from={}, to={}, action={}", 
                    application.getApplicationId(), fromStatus, toStatus, action);
        } catch (Exception e) {
            log.error("发送状态变更通知失败: applicationId={}", application.getApplicationId(), e);
        }
    }
    
    private void sendDesignerNotification(TaskApplication application, ApplicationStatus fromStatus, ApplicationStatus toStatus, TransitionAction action) {
        String title;
        String content;
        
        switch (toStatus) {
            case ADMIN_APPROVED:
                title = "申请已通过初审";
                content = "您的任务申请已通过系统审核，正在等待企业管理员最终审核。";
                break;
            case ADMIN_REJECTED:
                title = "申请未通过审核";
                content = "您的任务申请未通过审核，请查看反馈信息并考虑重新申请。";
                break;
            case ENTERPRISE_APPROVED:
                title = "申请审核通过";
                content = "恭喜！您的任务申请已审核通过，可以开始任务执行。";
                break;
            case ENTERPRISE_REJECTED:
                title = "申请未通过审核";
                content = "您的任务申请未通过企业审核，请查看反馈信息。";
                break;
            default:
                return;
        }
        
        // 实际的通知发送逻辑
        log.info("发送设计师通知: designerId={}, title={}, content={}", 
                application.getDesignerId(), title, content);
    }
    
    private void sendEnterpriseNotification(TaskApplication application, ApplicationStatus toStatus) {
        String title = "新的申请待审核";
        String content = "有新的任务申请需要您审核，请及时处理。";
        
        // 实际的通知发送逻辑
        log.info("发送企业管理员通知: taskId={}, title={}, content={}", 
                application.getTaskId(), title, content);
    }
    
    private void updateTaskStatus(TaskApplication application, ApplicationStatus toStatus) {
        try {
            // 根据申请状态更新任务的相关统计信息
            if (toStatus == ApplicationStatus.ENTERPRISE_APPROVED) {
                // 任务申请通过，更新任务状态为进行中
                Task task = taskService.selectTaskById(application.getTaskId());
                if (task != null && "PUBLISHED".equals(task.getStatus())) {
                    task.setStatus("IN_PROGRESS");
                    taskService.updateTask(task);
                    log.info("任务状态已更新为进行中: taskId={}", task.getTaskId());
                }
            }
            
            log.debug("任务状态更新完成: taskId={}, applicationStatus={}", 
                    application.getTaskId(), toStatus);
        } catch (Exception e) {
            log.error("更新任务状态失败: taskId={}", application.getTaskId(), e);
        }
    }
    
    private void triggerWorkflow(TaskApplication application, ApplicationStatus toStatus) {
        try {
            // 根据不同的状态触发不同的工作流
            switch (toStatus) {
                case ENTERPRISE_APPROVED:
                    // 申请通过，触发任务开始工作流
                    triggerTaskStartWorkflow(application);
                    break;
                case ADMIN_REJECTED:
                case ENTERPRISE_REJECTED:
                    // 申请拒绝，触发清理工作流
                    triggerApplicationCleanupWorkflow(application);
                    break;
                case WITHDRAWN:
                    // 申请撤回，触发撤回工作流
                    triggerWithdrawWorkflow(application);
                    break;
            }
            
            log.debug("工作流触发完成: applicationId={}, status={}", 
                    application.getApplicationId(), toStatus);
        } catch (Exception e) {
            log.error("触发工作流失败: applicationId={}", application.getApplicationId(), e);
        }
    }
    
    private void triggerTaskStartWorkflow(TaskApplication application) {
        // 任务开始工作流：创建项目空间、分配资源等
        log.info("触发任务开始工作流: applicationId={}, taskId={}", 
                application.getApplicationId(), application.getTaskId());
    }
    
    private void triggerApplicationCleanupWorkflow(TaskApplication application) {
        // 申请清理工作流：清理临时数据、发送统计信息等
        log.info("触发申请清理工作流: applicationId={}", application.getApplicationId());
    }
    
    private void triggerWithdrawWorkflow(TaskApplication application) {
        // 撤回工作流：更新统计数据、发送通知等
        log.info("触发撤回工作流: applicationId={}", application.getApplicationId());
        
        // 减少任务的申请数量
        try {
            taskService.decrementApplications(application.getTaskId());
        } catch (Exception e) {
            log.error("减少任务申请数量失败: taskId={}", application.getTaskId(), e);
        }
    }
    
    private void recordBusinessEvent(TaskApplication application, ApplicationStatus fromStatus, ApplicationStatus toStatus, TransitionAction action) {
        try {
            // 记录业务事件到事件日志系统
            BusinessEvent event = new BusinessEvent();
            event.setEventType("APPLICATION_STATUS_CHANGE");
            event.setEntityType("TaskApplication");
            event.setEntityId(application.getApplicationId());
            event.setFromStatus(fromStatus.getCode());
            event.setToStatus(toStatus.getCode());
            event.setAction(action.name());
            event.setOperatorId(LoginHelper.getUserId());
            event.setEventTime(new Date());
            
            // 这里可以发送到消息队列或事件总线
            log.debug("业务事件已记录: applicationId={}, from={}, to={}, action={}", 
                    application.getApplicationId(), fromStatus, toStatus, action);
        } catch (Exception e) {
            log.error("记录业务事件失败: applicationId={}", application.getApplicationId(), e);
        }
    }
    
    // 业务事件内部类
    private static class BusinessEvent {
        private String eventType;
        private String entityType;
        private Long entityId;
        private String fromStatus;
        private String toStatus;
        private String action;
        private Long operatorId;
        private Date eventTime;
        
        // Getters and setters
        public String getEventType() { return eventType; }
        public void setEventType(String eventType) { this.eventType = eventType; }
        public String getEntityType() { return entityType; }
        public void setEntityType(String entityType) { this.entityType = entityType; }
        public Long getEntityId() { return entityId; }
        public void setEntityId(Long entityId) { this.entityId = entityId; }
        public String getFromStatus() { return fromStatus; }
        public void setFromStatus(String fromStatus) { this.fromStatus = fromStatus; }
        public String getToStatus() { return toStatus; }
        public void setToStatus(String toStatus) { this.toStatus = toStatus; }
        public String getAction() { return action; }
        public void setAction(String action) { this.action = action; }
        public Long getOperatorId() { return operatorId; }
        public void setOperatorId(Long operatorId) { this.operatorId = operatorId; }
        public Date getEventTime() { return eventTime; }
        public void setEventTime(Date eventTime) { this.eventTime = eventTime; }
    }
} 