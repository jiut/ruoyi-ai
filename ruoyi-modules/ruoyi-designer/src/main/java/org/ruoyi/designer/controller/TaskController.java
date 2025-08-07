package org.ruoyi.designer.controller;

import cn.dev33.satoken.annotation.SaCheckPermission;
import cn.dev33.satoken.annotation.SaCheckRole;
import cn.dev33.satoken.annotation.SaMode;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.tags.Tag;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.designer.domain.Task;
import org.ruoyi.designer.domain.dto.TaskQueryDto;
import org.ruoyi.designer.service.ITaskService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.Arrays;
import org.apache.commons.lang3.StringUtils;

/**
 * 任务Controller
 * 智图工厂任务管理接口
 *
 * @author ruoyi
 */
@Tag(name = "任务管理", description = "智图工厂任务发布和管理")
@Validated
@RequiredArgsConstructor
@RestController("designerTaskController")
@RequestMapping("/designer/task")
public class TaskController extends BaseController {

    private final ITaskService taskService;
    private final DesignerPermissionUtils permissionUtils;

    /**
     * 查询任务列表
     */
    @Operation(
        summary = "查询任务列表", 
        description = "分页查询任务信息",
        parameters = {
            @Parameter(name = "taskTitle", description = "任务标题"),
            @Parameter(name = "taskType", description = "任务类型"),
            @Parameter(name = "status", description = "任务状态"),
            @Parameter(name = "urgent", description = "是否紧急"),
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10")
        }
    )
    @SaCheckPermission("designer:task:list")
    @GetMapping("/list")
    public TableDataInfo<Task> list(TaskQueryDto queryDto, PageQuery pageQuery) {
        // 将查询DTO转换为Task实体（只设置查询需要的字段）
        Task task = new Task();
        task.setTaskTitle(queryDto.getTaskTitle());
        task.setTaskDescription(queryDto.getTaskDescription());
        task.setTaskType(queryDto.getTaskType());
        task.setStatus(queryDto.getStatus());
        task.setUrgent(queryDto.getUrgent());
        task.setBudgetMin(queryDto.getBudgetMin());
        task.setBudgetMax(queryDto.getBudgetMax());
        task.setEnterpriseId(queryDto.getEnterpriseId());
        
        // 任务广场权限控制：设计师只能看到已发布的任务
        if (permissionUtils.isDesigner() && StringUtils.isBlank(task.getStatus())) {
            // 设计师访问任务广场时，默认只显示已发布状态的任务
            task.setStatus(Task.TaskStatus.PUBLISHED.name());
        }
        
        return taskService.selectTaskPage(task, pageQuery);
    }

    /**
     * 获取任务详细信息
     */
    @Operation(
        summary = "获取任务详情",
        description = "根据任务ID获取详细信息",
        parameters = @Parameter(name = "id", description = "任务ID", required = true, example = "1")
    )
    @SaCheckPermission("designer:task:query")
    @GetMapping("/{id}")
    public R<Task> getInfo(@PathVariable Long id) {
        return R.ok(taskService.selectTaskById(id));
    }

    /**
     * 新增任务
     */
    @Operation(
        summary = "创建任务",
        description = "企业管理员创建新任务",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "任务信息",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = Task.class),
                examples = @ExampleObject(
                    name = "任务创建示例",
                    value = """
                        {
                            "taskTitle": "LOGO设计项目",
                            "taskDescription": "为新创公司设计简洁现代的LOGO",
                            "taskType": "LOGO_DESIGN",
                            "skillTags": "[\\"illustrator\\", \\"creative_design\\", \\"brand_design\\"]",
                            "budgetMin": 1000,
                            "budgetMax": 3000,
                            "deadline": "2025-02-15 18:00:00",
                            "urgent": false,
                            "deliverables": "AI源文件+PNG高清导出+使用规范",
                            "paymentTerms": "设计完成后3个工作日内付款"
                        }
                        """
                )
            )
        )
    )
    @SaCheckRole(value = {"enterprise", "admin"}, mode = SaMode.OR)  // 修复：只允许企业管理员和系统管理员
    @SaCheckPermission("designer:task:add")
    @Log(title = "任务管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Void> add(@Validated @RequestBody Task task) {
        return toAjax(taskService.insertTask(task));
    }

    /**
     * 修改任务
     */
    @Operation(
        summary = "修改任务",
        description = "企业管理员修改任务信息（仅限自己发布的任务）",
        parameters = @Parameter(name = "id", description = "任务ID", required = true, example = "1")
    )
    @SaCheckRole(value = {"enterprise", "admin"}, mode = SaMode.OR)  // 修复：只允许企业管理员和系统管理员
    @SaCheckPermission("designer:task:edit")
    @Log(title = "任务管理", businessType = BusinessType.UPDATE)
    @PutMapping("/{id}")
    public R<Void> edit(@PathVariable Long id, @Validated @RequestBody Task task) {
        task.setTaskId(id);
        return toAjax(taskService.updateTask(task));
    }

    /**
     * 删除任务
     */
    @Operation(
        summary = "删除任务",
        description = "企业管理员删除任务（仅限自己发布的任务）",
        parameters = @Parameter(name = "ids", description = "任务ID数组", required = true, example = "1,2,3")
    )
    @SaCheckRole(value = {"enterprise", "admin"}, mode = SaMode.OR)  // 修复：只允许企业管理员和系统管理员
    @SaCheckPermission("designer:task:remove")
    @Log(title = "任务管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{ids}")
    public R<Void> remove(@PathVariable Long[] ids) {
        return toAjax(taskService.deleteTaskByIds(Arrays.asList(ids)));
    }
} 