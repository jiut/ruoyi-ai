package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.annotation.SaCheckRole;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.common.core.validate.AddGroup;
import org.ruoyi.common.core.validate.EditGroup;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.designer.domain.TaskApplication;
import org.ruoyi.designer.domain.vo.EnterpriseApplicationView;
import org.ruoyi.designer.domain.enums.ApplicationStatus;
import org.ruoyi.designer.domain.enums.TransitionAction;
import org.ruoyi.designer.service.ITaskApplicationService;
import org.ruoyi.designer.service.impl.TaskApplicationServiceImpl;
import org.ruoyi.designer.mapper.TaskApplicationMapper;
import org.ruoyi.designer.statemachine.AllowedAction;
import org.ruoyi.designer.statemachine.StateTransitionResult;
import org.ruoyi.designer.statemachine.TaskApplicationStateMachine;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.ruoyi.designer.util.TaskConfigService;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import jakarta.validation.constraints.Size;
import java.util.List;

/**
 * 任务申请审核控制器
 * 基于状态机的审核流程控制
 *
 * @author ruoyi
 */
@RestController
@RequestMapping("/designer/task-application")
@RequiredArgsConstructor
@Tag(name = "任务申请审核", description = "基于状态机的任务申请审核管理")
@Slf4j
@Validated
public class TaskApplicationReviewController {

    private final TaskApplicationStateMachine stateMachine;
    private final ITaskApplicationService applicationService;
    private final TaskApplicationServiceImpl applicationServiceImpl;
    private final TaskApplicationMapper taskApplicationMapper;
    private final DesignerPermissionUtils permissionUtils;
    private final TaskConfigService taskConfigService;

    /**
     * 系统管理员审核申请
     */
    @Operation(summary = "系统管理员审核", description = "系统管理员对任务申请进行一级审核")
    @PostMapping("/{id}/admin-review")
    @SaCheckRole("admin")  // 修复：直接检查系统管理员角色
    @SaCheckPermission("designer:task-application:admin-review")
    public R<StateTransitionResult> adminReview(
            @Parameter(description = "申请ID") @PathVariable Long id,
            @RequestBody @Valid AdminReviewRequest request) {

        // 检查是否为双重审核模式
        if (!taskConfigService.isDualReviewMode()) {
            return R.fail("当前为企业自主审核模式，系统管理员无需审核");
        }

        // 检查权限
        if (!LoginHelper.isSuperAdmin()) {
            return R.fail("只有系统管理员可以进行一级审核");
        }

        // 根据审核决定确定目标状态
        ApplicationStatus targetStatus = "APPROVED".equals(request.getDecision()) 
            ? ApplicationStatus.ADMIN_APPROVED 
            : ApplicationStatus.ADMIN_REJECTED;

        // 执行状态转换
        StateTransitionResult result = stateMachine.executeTransition(
            id, targetStatus, TransitionAction.ADMIN_REVIEW, 
            request.getFeedback(), LoginHelper.getUserId()
        );

        if (result.isSuccess()) {
            log.info("系统管理员审核完成: applicationId={}, decision={}, operator={}", 
                    id, request.getDecision(), LoginHelper.getUserId());
            return R.ok(result);
        } else {
            log.warn("系统管理员审核失败: applicationId={}, reason={}", id, result.getMessage());
            return R.fail(result.getMessage());
        }
    }

    /**
     * 企业管理员审核申请
     */
    @Operation(summary = "企业管理员审核", description = "企业管理员对任务申请进行最终审核")
    @PostMapping("/{id}/enterprise-review")
    @SaCheckRole("enterprise")  // 修复：直接检查企业管理员角色
    @SaCheckPermission("designer:task-application:enterprise-review")
    public R<StateTransitionResult> enterpriseReview(
            @Parameter(description = "申请ID") @PathVariable Long id,
            @RequestBody @Valid EnterpriseReviewRequest request) {

        // 获取申请信息进行权限检查
        TaskApplication application = applicationService.selectTaskApplicationById(id);
        if (application == null) {
            return R.fail("申请不存在");
        }

        // 权限检查：确保只能审核自己企业的申请
        if (!permissionUtils.hasEnterprisePermission(application.getTask().getEnterpriseId())) {
            return R.fail("无权限审核此申请");
        }

        // 根据审核决定确定目标状态
        ApplicationStatus targetStatus = "APPROVED".equals(request.getDecision())
            ? ApplicationStatus.ENTERPRISE_APPROVED
            : ApplicationStatus.ENTERPRISE_REJECTED;

        // 执行状态转换
        StateTransitionResult result = stateMachine.executeTransition(
            id, targetStatus, TransitionAction.ENTERPRISE_REVIEW,
            request.getFeedback(), LoginHelper.getUserId()
        );

        if (result.isSuccess()) {
            log.info("企业管理员审核完成: applicationId={}, decision={}, operator={}", 
                    id, request.getDecision(), LoginHelper.getUserId());
            return R.ok(result);
        } else {
            log.warn("企业管理员审核失败: applicationId={}, reason={}", id, result.getMessage());
            return R.fail(result.getMessage());
        }
    }

    /**
     * 设计师撤回申请
     */
    @Operation(summary = "撤回申请", description = "设计师主动撤回任务申请")
    @PostMapping("/{id}/withdraw")
    @SaCheckRole("designer")  // 修复：直接检查设计师角色
    @SaCheckPermission("designer:task-application:withdraw")
    public R<StateTransitionResult> withdrawApplication(
            @Parameter(description = "申请ID") @PathVariable Long id,
            @RequestBody(required = false) WithdrawRequest request) {

        // 获取申请信息进行权限检查
        TaskApplication application = applicationService.selectTaskApplicationById(id);
        if (application == null) {
            return R.fail("申请不存在");
        }

        // 权限检查：确保只能撤回自己的申请（保留业务逻辑检查）
        if (!permissionUtils.hasDesignerPermission(application.getDesignerId())) {
            return R.fail("只能撤回自己的申请");
        }

        String reason = request != null && request.getReason() != null ? request.getReason() : "用户主动撤回";

        // 执行状态转换
        StateTransitionResult result = stateMachine.executeTransition(
            id, ApplicationStatus.WITHDRAWN, TransitionAction.WITHDRAW,
            reason, LoginHelper.getUserId()
        );

        if (result.isSuccess()) {
            log.info("申请撤回成功: applicationId={}, operator={}", id, LoginHelper.getUserId());
            return R.ok(result);
        } else {
            log.warn("申请撤回失败: applicationId={}, reason={}", id, result.getMessage());
            return R.fail(result.getMessage());
        }
    }

    /**
     * 获取申请的可执行操作
     */
    @Operation(summary = "获取可执行操作", description = "获取当前用户对指定申请的可执行操作列表")
    @GetMapping("/{id}/allowed-actions")
    public R<List<AllowedAction>> getAllowedActions(@Parameter(description = "申请ID") @PathVariable Long id) {
        List<AllowedAction> actions = stateMachine.getAllowedActions(id, LoginHelper.getUserId());
        return R.ok(actions);
    }

    /**
     * 获取系统管理员待审核申请列表
     */
    @Operation(summary = "获取系统管理员待审核申请", description = "获取系统管理员需要审核的申请列表")
    @GetMapping("/admin/pending")
    @SaCheckRole("admin")  // 修复：直接检查系统管理员角色
    @SaCheckPermission("designer:task-application:admin-review")
    public R<List<TaskApplication>> getAdminPendingApplications() {
        // 检查是否为双重审核模式
        if (!taskConfigService.isDualReviewMode()) {
            return R.ok(List.of());
        }

        // 检查权限
        if (!LoginHelper.isSuperAdmin()) {
            return R.fail("只有系统管理员可以查看待审核申请");
        }

        List<TaskApplication> applications = applicationServiceImpl.selectAdminPendingApplications();
        return R.ok(applications);
    }

    /**
     * 获取企业管理员待审核申请列表
     */
    @Operation(summary = "获取企业管理员待审核申请", description = "获取企业管理员需要审核的申请列表")
    @GetMapping("/enterprise/pending")
    @SaCheckRole("enterprise")  // 修复：直接检查企业管理员角色
    @SaCheckPermission("designer:task-application:enterprise-review")
    public R<List<TaskApplication>> getEnterprisePendingApplications() {
        // 获取当前企业ID
        Long enterpriseId = permissionUtils.getCurrentEnterpriseId();
        if (enterpriseId == null) {
            return R.fail("当前用户未绑定企业");
        }

        List<TaskApplication> applications = applicationServiceImpl.selectEnterprisePendingApplications(enterpriseId);
        return R.ok(applications);
    }

    /**
     * 企业管理员获取待审核申请列表（分页版本，严格隐藏系统管理员信息）
     */
    @Operation(summary = "企业管理员待审核申请列表", description = "获取企业管理员待审核申请的分页列表，严格隐藏系统管理员审核信息")
    @GetMapping("/enterprise/pending/list")
    @SaCheckRole("enterprise")
    @SaCheckPermission("designer:task-application:enterprise-review")
    public R<TableDataInfo<EnterpriseApplicationView>> getEnterprisePendingApplicationsList(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        
        // 获取当前企业ID
        Long enterpriseId = permissionUtils.getCurrentEnterpriseId();
        if (enterpriseId == null) {
            return R.fail("当前用户未绑定企业");
        }
        
        // 调用Mapper方法获取数据
        List<EnterpriseApplicationView> list = taskApplicationMapper
            .selectEnterprisePendingApplicationsView(enterpriseId, (pageNum - 1) * pageSize, pageSize);
        
        // 获取总数
        Long totalCount = taskApplicationMapper
            .countEnterprisePendingApplications(enterpriseId);
        
        // 构建分页响应
        TableDataInfo<EnterpriseApplicationView> dataInfo = new TableDataInfo<>();
        dataInfo.setRows(list);
        dataInfo.setTotal(totalCount);
        dataInfo.setCode(200);
        dataInfo.setMsg("查询成功");
        
        return R.ok(dataInfo);
    }

    /**
     * 系统管理员获取待审核申请列表（分页版本）
     */
    @Operation(summary = "系统管理员待审核申请列表", description = "获取系统管理员待审核申请的分页列表")
    @GetMapping("/admin/pending/list")
    @SaCheckRole("admin")
    @SaCheckPermission("designer:task-application:admin-pending")
    public R<TableDataInfo<TaskApplication>> getAdminPendingApplicationsList(
            @RequestParam(defaultValue = "1") Integer pageNum,
            @RequestParam(defaultValue = "10") Integer pageSize) {
        
        // 检查系统管理员权限
        if (!LoginHelper.isSuperAdmin()) {
            return R.fail("只有系统管理员可以查看待审核申请");
        }
        
        // 调用Mapper方法获取数据
        List<TaskApplication> list = taskApplicationMapper
            .selectAdminPendingApplications((pageNum - 1) * pageSize, pageSize);
        
        // 获取总数
        Long totalCount = taskApplicationMapper
            .countAdminPendingApplications();
        
        // 构建分页响应
        TableDataInfo<TaskApplication> dataInfo = new TableDataInfo<>();
        dataInfo.setRows(list);
        dataInfo.setTotal(totalCount);
        dataInfo.setCode(200);
        dataInfo.setMsg("查询成功");
        
        return R.ok(dataInfo);
    }

    /**
     * 获取当前审核模式
     */
    @Operation(summary = "获取审核模式", description = "获取当前系统的审核模式配置")
    @GetMapping("/review-mode")
    public R<ReviewModeInfo> getReviewMode() {
        ReviewModeInfo info = new ReviewModeInfo();
        info.setReviewMode(taskConfigService.getReviewMode().name());
        info.setDescription(taskConfigService.getReviewMode().getDescription());
        info.setIsDualMode(taskConfigService.isDualReviewMode());
        return R.ok(info);
    }

    /**
     * 获取系统管理员审核基础统计
     */
    @Operation(summary = "获取系统管理员审核基础统计", description = "获取待审核数量、今日审核数量等基础统计信息")
    @GetMapping("/admin/review/basic-stats")
    @SaCheckPermission("designer:task-application:admin-review")
    public R<BasicReviewStats> getBasicStats() {
        // 检查权限
        if (!LoginHelper.isSuperAdmin()) {
            return R.fail("只有系统管理员可以查看审核统计");
        }

        // 检查是否为双重审核模式
        if (!taskConfigService.isDualReviewMode()) {
            BasicReviewStats stats = new BasicReviewStats();
            stats.setPendingCount(0L);
            stats.setReviewedToday(0L);
            return R.ok(stats);
        }

        TaskApplicationServiceImpl.BasicReviewStats serviceStats = applicationServiceImpl.getBasicReviewStats();
        
        // 转换为控制器的DTO
        BasicReviewStats stats = new BasicReviewStats();
        stats.setPendingCount(serviceStats.getPendingCount());
        stats.setReviewedToday(serviceStats.getReviewedToday());
        
        return R.ok(stats);
    }

    // ===== 内部类：请求和响应DTO =====

    /**
     * 系统管理员审核请求
     */
    public static class AdminReviewRequest {
        
        @NotBlank(message = "审核决定不能为空")
        @Pattern(regexp = "^(APPROVED|REJECTED)$", message = "审核决定必须是APPROVED或REJECTED")
        private String decision;
        
        @Size(max = 1000, message = "审核反馈不能超过1000字符")
        private String feedback;

        // Getters and setters
        public String getDecision() { return decision; }
        public void setDecision(String decision) { this.decision = decision; }
        public String getFeedback() { return feedback; }
        public void setFeedback(String feedback) { this.feedback = feedback; }
    }

    /**
     * 企业管理员审核请求
     */
    public static class EnterpriseReviewRequest {
        
        @NotBlank(message = "审核决定不能为空")
        @Pattern(regexp = "^(APPROVED|REJECTED)$", message = "审核决定必须是APPROVED或REJECTED")
        private String decision;
        
        @Size(max = 1000, message = "审核反馈不能超过1000字符")
        private String feedback;

        // Getters and setters
        public String getDecision() { return decision; }
        public void setDecision(String decision) { this.decision = decision; }
        public String getFeedback() { return feedback; }
        public void setFeedback(String feedback) { this.feedback = feedback; }
    }

    /**
     * 撤回申请请求
     */
    public static class WithdrawRequest {
        
        @Size(max = 500, message = "撤回原因不能超过500字符")
        private String reason;

        // Getters and setters
        public String getReason() { return reason; }
        public void setReason(String reason) { this.reason = reason; }
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

    /**
     * 审核模式信息
     */
    public static class ReviewModeInfo {
        private String reviewMode;
        private String description;
        private Boolean isDualMode;

        // Getters and setters
        public String getReviewMode() { return reviewMode; }
        public void setReviewMode(String reviewMode) { this.reviewMode = reviewMode; }
        public String getDescription() { return description; }
        public void setDescription(String description) { this.description = description; }
        public Boolean getIsDualMode() { return isDualMode; }
        public void setIsDualMode(Boolean isDualMode) { this.isDualMode = isDualMode; }
    }
} 