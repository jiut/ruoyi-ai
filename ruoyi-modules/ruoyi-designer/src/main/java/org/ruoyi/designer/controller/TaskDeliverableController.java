package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.annotation.SaCheckRole;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.designer.domain.TaskDeliverable;
import org.ruoyi.designer.service.ITaskDeliverableService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;

/**
 * 任务交付物Controller
 * 智图工厂交付物管理接口
 *
 * @author ruoyi
 */
@Tag(name = "交付物管理", description = "智图工厂交付物提交和管理")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/task-deliverable")
public class TaskDeliverableController extends BaseController {

    private final ITaskDeliverableService deliverableService;
    private final DesignerPermissionUtils permissionUtils;

    /**
     * 查询交付物列表
     */
    @Operation(
        summary = "查询交付物列表", 
        description = "分页查询交付物信息",
        parameters = {
            @Parameter(name = "taskId", description = "任务ID"),
            @Parameter(name = "designerId", description = "设计师ID"),
            @Parameter(name = "status", description = "交付物状态"),
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10")
        }
    )
    @SaCheckPermission("designer:task-deliverable:list")
    @GetMapping("/list")
    public TableDataInfo<TaskDeliverable> list(TaskDeliverable deliverable, PageQuery pageQuery) {
        return deliverableService.selectDeliverablePage(deliverable, pageQuery);
    }

    /**
     * 获取交付物详细信息
     */
    @Operation(
        summary = "获取交付物详情",
        description = "根据交付物ID获取详细信息",
        parameters = @Parameter(name = "id", description = "交付物ID", required = true, example = "1")
    )
    @SaCheckPermission("designer:task-deliverable:query")
    @GetMapping("/{id}")
    public R<TaskDeliverable> getInfo(@PathVariable Long id) {
        return R.ok(deliverableService.selectDeliverableById(id));
    }

    /**
     * 提交交付物链接（设计师）
     */
    @Operation(
        summary = "提交交付物",
        description = "设计师提交交付物内容（支持自然文本格式）",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "交付物信息",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = TaskDeliverable.class),
                examples = @ExampleObject(
                    name = "交付物提交示例",
                    value = """
                        {
                            "taskId": 1,
                            "deliverableContent": "设计稿已完成，包含AI源文件和PNG导出文件\\n\\n百度网盘链接：https://pan.baidu.com/s/1abcdef123456\\n提取码：abc123\\n\\nGitHub发布包：https://github.com/user/project/releases/tag/v1.0\\n\\n注意事项：\\n1. AI源文件在design文件夹中\\n2. PNG导出文件在assets文件夹中\\n3. 建议使用最新版本的AI软件打开源文件",
                            "version": 1
                        }
                        """
                )
            )
        )
    )
    @SaCheckRole("designer")  // 修复：直接检查设计师角色
    @SaCheckPermission("designer:task-deliverable:add")
    @Log(title = "交付物管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody TaskDeliverable deliverable) {
        // 设置设计师ID，确保只能为自己提交交付物
        Long currentDesignerId = permissionUtils.getCurrentDesignerId();
        if (currentDesignerId == null) {
            return R.fail("无效的设计师权限");
        }
        deliverable.setDesignerId(currentDesignerId);
        return toAjax(deliverableService.insertDeliverable(deliverable));
    }

    /**
     * 更新交付物链接
     */
    @Operation(
        summary = "更新交付物",
        description = "设计师更新交付物内容",
        parameters = @Parameter(name = "id", description = "交付物ID", required = true, example = "1")
    )
    @SaCheckRole("designer")  // 修复：直接检查设计师角色
    @SaCheckPermission("designer:task-deliverable:edit")
    @Log(title = "交付物管理", businessType = BusinessType.UPDATE)
    @PutMapping("/{id}")
    public R<Void> edit(@PathVariable Long id, @Validated @RequestBody TaskDeliverable deliverable) {
        // 验证交付物是否属于当前设计师
        TaskDeliverable existingDeliverable = deliverableService.selectDeliverableById(id);
        if (existingDeliverable == null) {
            return R.fail("交付物不存在");
        }
        Long currentDesignerId = permissionUtils.getCurrentDesignerId();
        if (currentDesignerId == null || !currentDesignerId.equals(existingDeliverable.getDesignerId())) {
            return R.fail("无权限修改此交付物");
        }
        
        // 检查交付物状态是否允许修改
        TaskDeliverable.DeliverableStatus status = TaskDeliverable.DeliverableStatus.fromValue(existingDeliverable.getStatus());
        if (!status.canModify()) {
            return R.fail("当前状态不允许修改交付物");
        }
        
        deliverable.setDeliverableId(id);
        deliverable.setDesignerId(currentDesignerId); // 确保不能修改设计师ID
        return toAjax(deliverableService.updateDeliverable(deliverable));
    }

    /**
     * 删除交付物
     */
    @Operation(
        summary = "删除交付物",
        description = "设计师删除自己的交付物",
        parameters = @Parameter(name = "id", description = "交付物ID", required = true, example = "1")
    )
    @SaCheckPermission("designer:task-deliverable:remove")
    @Log(title = "交付物管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    public R<Void> remove(@PathVariable Long id) {
        // 验证交付物是否属于当前设计师
        TaskDeliverable existingDeliverable = deliverableService.selectDeliverableById(id);
        if (existingDeliverable == null) {
            return R.fail("交付物不存在");
        }
        Long currentDesignerId = permissionUtils.getCurrentDesignerId();
        if (currentDesignerId == null || !currentDesignerId.equals(existingDeliverable.getDesignerId())) {
            return R.fail("无权限删除此交付物");
        }
        
        // 检查交付物状态是否允许删除
        TaskDeliverable.DeliverableStatus status = TaskDeliverable.DeliverableStatus.fromValue(existingDeliverable.getStatus());
        if (status.isFinalStatus()) {
            return R.fail("已完成审核的交付物不允许删除");
        }
        
        return toAjax(deliverableService.deleteDeliverableById(id));
    }

    /**
     * 审核交付物（企业管理员）
     */
    @Operation(
        summary = "审核交付物",
        description = "企业管理员审核交付物",
        parameters = @Parameter(name = "id", description = "交付物ID", required = true, example = "1"),
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "审核信息",
            content = @Content(
                mediaType = "application/json",
                examples = @ExampleObject(
                    name = "审核示例",
                    value = """
                        {
                            "status": "APPROVED",
                            "feedback": "设计质量很好，完全符合要求"
                        }
                        """
                )
            )
        )
    )
    @SaCheckPermission("designer:task-deliverable:review")
    @Log(title = "交付物管理", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/review")
    public R<Void> review(
            @PathVariable Long id,
            @RequestBody @Valid ReviewRequest request) {
        
        // 验证交付物是否存在
        TaskDeliverable existingDeliverable = deliverableService.selectDeliverableById(id);
        if (existingDeliverable == null) {
            return R.fail("交付物不存在");
        }
        
        // 验证企业权限（需要验证任务是否属于当前企业）
        Long currentEnterpriseId = permissionUtils.getCurrentEnterpriseId();
        if (currentEnterpriseId == null) {
            return R.fail("无效的企业权限");
        }
        
        // 这里需要查询任务信息验证企业权限，简化处理暂时允许所有企业管理员审核
        
        return toAjax(deliverableService.reviewDeliverable(id, request.getStatus(), request.getFeedback()));
    }

    /**
     * 审核请求对象
     */
    @Schema(description = "审核请求")
    public static class ReviewRequest {
        @Schema(description = "审核状态", allowableValues = {"APPROVED", "REVISION_REQUIRED", "REJECTED"})
        @NotBlank(message = "审核状态不能为空")
        private String status;

        @Schema(description = "审核反馈")
        private String feedback;

        public String getStatus() {
            return status;
        }

        public void setStatus(String status) {
            this.status = status;
        }

        public String getFeedback() {
            return feedback;
        }

        public void setFeedback(String feedback) {
            this.feedback = feedback;
        }
    }
} 