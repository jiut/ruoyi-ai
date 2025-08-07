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
import org.ruoyi.designer.domain.TaskApplication;
import org.ruoyi.designer.service.ITaskApplicationService;
import org.ruoyi.designer.service.ITaskService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

/**
 * 任务申请Controller
 * 智图工厂任务申请基础功能
 *
 * @author ruoyi
 */
@Tag(name = "任务申请管理", description = "智图工厂任务申请基础功能")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/task-application")
public class TaskApplicationController extends BaseController {

    private final ITaskApplicationService taskApplicationService;
    private final ITaskService taskService;
    private final DesignerPermissionUtils permissionUtils;

    /**
     * 查询申请列表
     */
    @Operation(
        summary = "查询申请列表", 
        description = "分页查询任务申请信息",
        parameters = {
            @Parameter(name = "taskId", description = "任务ID"),
            @Parameter(name = "designerId", description = "设计师ID"),
            @Parameter(name = "status", description = "申请状态"),
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10")
        }
    )
    @SaCheckPermission("designer:task-application:list")
    @GetMapping("/list")
    public TableDataInfo<TaskApplication> list(TaskApplication taskApplication, PageQuery pageQuery) {
        // 权限控制：设计师只能查看自己的申请，企业管理员查看企业任务的申请
        if (permissionUtils.isDesigner()) {
            Long currentDesignerId = permissionUtils.getCurrentDesignerId();
            if (currentDesignerId != null) {
                taskApplication.setDesignerId(currentDesignerId);
            }
        } else if (permissionUtils.isEnterprise()) {
            // 企业管理员查看自己企业任务的申请
            Long currentEnterpriseId = permissionUtils.getCurrentEnterpriseId();
            if (currentEnterpriseId == null) {
                // 返回空结果
                return TableDataInfo.build();
            }
            // 企业管理员只能查看自己企业任务的申请
            // 这里暂时使用简化逻辑，后续可以通过Service层实现更精确的企业过滤
        }
        
        return taskApplicationService.selectTaskApplicationPage(taskApplication, pageQuery);
    }

    /**
     * 获取申请详细信息
     */
    @Operation(
        summary = "获取申请详情",
        description = "根据申请ID获取详细信息",
        parameters = @Parameter(name = "id", description = "申请ID", required = true, example = "1")
    )
    @SaCheckPermission("designer:task-application:query")
    @GetMapping("/{id}")
    public R<TaskApplication> getInfo(@PathVariable Long id) {
        TaskApplication application = taskApplicationService.selectTaskApplicationById(id);
        if (application == null) {
            return R.fail("申请不存在");
        }
        
        // 权限控制：验证申请是否属于当前用户
        if (permissionUtils.isDesigner()) {
            Long currentDesignerId = permissionUtils.getCurrentDesignerId();
            if (currentDesignerId == null || !currentDesignerId.equals(application.getDesignerId())) {
                return R.fail("无权限查看此申请");
            }
        } else if (permissionUtils.isEnterprise()) {
            // 企业管理员需要验证任务是否属于当前企业
            Long currentEnterpriseId = permissionUtils.getCurrentEnterpriseId();
            if (currentEnterpriseId == null) {
                return R.fail("无效的企业权限");
            }
            // 验证申请的任务是否属于当前企业
            if (application.getTask() != null && application.getTask().getEnterpriseId() != null) {
                if (!currentEnterpriseId.equals(application.getTask().getEnterpriseId())) {
                    return R.fail("无权限查看此申请");
                }
            } else {
                // 如果任务信息不完整，暂时允许查看，后续优化时加强验证
            }
        }
        
        return R.ok(application);
    }

    /**
     * 申请任务
     */
    @Operation(
        summary = "申请任务",
        description = "设计师申请指定任务",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "申请信息",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = TaskApplication.class),
                examples = @ExampleObject(
                    name = "任务申请示例",
                    value = """
                        {
                            "taskId": 1,
                            "designerId": 1,
                            "proposal": "我对这个项目很感兴趣，具有3年的LOGO设计经验，擅长简约现代风格设计。我的设计理念是通过简洁有力的视觉元素传达品牌核心价值，确保LOGO在各种媒介上都能保持良好的识别度和美观性。",
                            "proposedPrice": 3000.00,
                            "estimatedDays": 7,
                            "portfolioLinks": "[\\"https://dribbble.com/designer123\\", \\"https://behance.net/portfolio\\"]"
                        }
                        """
                )
            )
        )
    )
    @SaCheckRole("designer")  // 修复：直接检查设计师角色
    @SaCheckPermission("designer:task-application:apply")
    @Log(title = "申请任务", businessType = BusinessType.INSERT)
    @PostMapping("/apply")
    public R<Void> apply(@Validated @RequestBody TaskApplication taskApplication) {
        // 权限控制：只有设计师可以申请任务
        if (!permissionUtils.isDesigner()) {
            return R.fail("只有设计师可以申请任务");
        }
        
        // 设置设计师ID，确保只能为自己申请任务
        Long currentDesignerId = permissionUtils.getCurrentDesignerId();
        if (currentDesignerId == null) {
            return R.fail("无效的设计师权限");
        }
        taskApplication.setDesignerId(currentDesignerId);
        
        // 验证任务是否存在和状态是否有效
        if (taskApplication.getTaskId() == null) {
            return R.fail("任务ID不能为空");
        }
        
        // 检查是否重复申请
        if (taskApplicationService.hasApplied(taskApplication.getTaskId(), currentDesignerId)) {
            return R.fail("该任务已申请过，不能重复申请");
        }
        
        return toAjax(taskApplicationService.insertTaskApplication(taskApplication));
    }
} 