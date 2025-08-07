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
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.common.core.domain.R;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.log.annotation.Log;
import org.ruoyi.common.log.enums.BusinessType;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.common.web.core.BaseController;
import org.ruoyi.designer.domain.Task;
import org.ruoyi.designer.domain.dto.TaskQueryDto;
import org.ruoyi.designer.service.ITaskService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.util.List;

/**
 * 企业任务管理Controller
 * 企业管理员专用的任务管理接口
 *
 * @author ruoyi
 */
@Tag(name = "企业任务管理", description = "企业管理员专用任务管理接口")
@Validated
@RequiredArgsConstructor
@RestController
@RequestMapping("/designer/enterprise/tasks")
@Slf4j
public class EnterpriseTaskController extends BaseController {

    private final ITaskService taskService;
    private final DesignerPermissionUtils permissionUtils;

    /**
     * 获取当前企业的任务列表
     */
    @Operation(
        summary = "获取企业任务列表", 
        description = "获取当前登录企业发布的所有任务",
        parameters = {
            @Parameter(name = "status", description = "任务状态过滤"),
            @Parameter(name = "taskTitle", description = "任务标题（模糊查询）"),
            @Parameter(name = "taskType", description = "任务类型"),
            @Parameter(name = "urgent", description = "是否紧急"),
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10")
        }
    )
    @SaCheckRole("enterprise")  // 修复：直接检查企业管理员角色
    @SaCheckPermission("designer:enterprise:task:list")
    @GetMapping("/list")
    public TableDataInfo<Task> list(TaskQueryDto queryDto, PageQuery pageQuery) {
        // 设置企业ID过滤条件，只能查看自己企业的任务
        Long currentEnterpriseId = permissionUtils.getCurrentEnterpriseId();
        if (currentEnterpriseId == null) {
            // 返回空结果
            Page<Task> emptyPage = new Page<>(pageQuery.getPageNum(), pageQuery.getPageSize());
            emptyPage.setRecords(List.of());
            emptyPage.setTotal(0);
            return TableDataInfo.build(emptyPage);
        }
        
        // 将查询DTO转换为Task实体（只设置查询需要的字段）
        Task task = new Task();
        task.setEnterpriseId(currentEnterpriseId);
        task.setTaskTitle(queryDto.getTaskTitle());
        task.setTaskDescription(queryDto.getTaskDescription());
        task.setTaskType(queryDto.getTaskType());
        task.setStatus(queryDto.getStatus());
        task.setUrgent(queryDto.getUrgent());
        task.setBudgetMin(queryDto.getBudgetMin());
        task.setBudgetMax(queryDto.getBudgetMax());
        
        return taskService.selectTaskPage(task, pageQuery);
    }

    /**
     * 企业发布任务
     */
    @Operation(
        summary = "企业发布任务",
        description = "企业管理员发布新的设计任务",
        requestBody = @io.swagger.v3.oas.annotations.parameters.RequestBody(
            description = "任务信息",
            content = @Content(
                mediaType = "application/json",
                schema = @Schema(implementation = Task.class),
                examples = @ExampleObject(
                    name = "企业任务发布示例",
                    value = """
                        {
                            "taskTitle": "企业LOGO设计",
                            "taskDescription": "为科技公司设计现代简约风格的LOGO",
                            "taskType": "LOGO_DESIGN",
                            "skillTags": "[\\"illustrator\\", \\"brand_design\\", \\"creative_design\\"]",
                            "budgetMin": 2000,
                            "budgetMax": 5000,
                            "deadline": "2025-02-20 18:00:00",
                            "urgent": false,
                            "deliverables": "AI源文件+PNG/SVG导出+品牌规范",
                            "paymentTerms": "设计完成验收后5个工作日内付款"
                        }
                        """
                )
            )
        )
    )
    @SaCheckRole("enterprise")  // 修复：直接检查企业管理员角色
    @SaCheckPermission("designer:enterprise:task:add")
    @Log(title = "企业任务管理", businessType = BusinessType.INSERT)
    @PostMapping
    public R<Long> add(@Validated @RequestBody Task task) {
        // 设置企业ID，确保只能为自己的企业发布任务
        Long currentEnterpriseId = permissionUtils.getCurrentEnterpriseId();
        if (currentEnterpriseId == null) {
            return R.fail("无效的企业权限");
        }
        task.setEnterpriseId(currentEnterpriseId);
        // 新发布的任务默认为草稿状态
        task.setStatus(Task.TaskStatus.DRAFT.name());
        
        // 插入任务
        Boolean result = taskService.insertTask(task);
        if (result) {
            // 插入成功，返回任务ID
            return R.ok("任务创建成功", task.getTaskId());
        } else {
            return R.fail("任务创建失败");
        }
    }

    /**
     * 企业修改任务
     */
    @Operation(
        summary = "企业修改任务",
        description = "企业管理员修改自己发布的任务信息",
        parameters = @Parameter(name = "id", description = "任务ID", required = true, example = "1")
    )
    @SaCheckRole("enterprise")  // 修复：直接检查企业管理员角色
    @SaCheckPermission("designer:enterprise:task:edit")
    @Log(title = "企业任务管理", businessType = BusinessType.UPDATE)
    @PutMapping("/{id}")
    public R<Void> edit(@PathVariable Long id, @Validated @RequestBody Task task) {
        // 验证任务是否属于当前企业
        Task existingTask = taskService.selectTaskById(id);
        if (existingTask == null) {
            return R.fail("任务不存在");
        }
        Long currentEnterpriseId = permissionUtils.getCurrentEnterpriseId();
        if (currentEnterpriseId == null || !currentEnterpriseId.equals(existingTask.getEnterpriseId())) {
            return R.fail("无权限修改此任务");
        }
        
        task.setTaskId(id);
        task.setEnterpriseId(currentEnterpriseId); // 确保不能修改企业ID
        return toAjax(taskService.updateTask(task));
    }

    /**
     * 企业删除任务
     */
    @Operation(
        summary = "企业删除任务",
        description = "企业管理员逻辑删除自己发布的任务",
        parameters = @Parameter(name = "id", description = "任务ID", required = true, example = "1")
    )
    @SaCheckRole("enterprise")  // 修复：直接检查企业管理员角色
    @SaCheckPermission("designer:enterprise:task:remove")
    @Log(title = "企业任务管理", businessType = BusinessType.DELETE)
    @DeleteMapping("/{id}")
    public R<Void> remove(@PathVariable Long id) {
        try {
            // 1. 验证任务是否存在
            Task existingTask = taskService.selectTaskById(id);
            if (existingTask == null) {
                return R.fail("任务不存在");
            }
            
            // 2. 验证权限：任务是否属于当前企业
            Long currentEnterpriseId = permissionUtils.getCurrentEnterpriseId();
            if (currentEnterpriseId == null) {
                return R.fail("无效的企业权限");
            }
            if (!currentEnterpriseId.equals(existingTask.getEnterpriseId())) {
                return R.fail("无权限删除此任务");
            }
            
            // 3. 检查任务状态是否允许删除
            if (Task.TaskStatus.IN_PROGRESS.name().equals(existingTask.getStatus()) ||
                Task.TaskStatus.COMPLETED.name().equals(existingTask.getStatus())) {
                return R.fail("进行中或已完成的任务不允许删除");
            }
            
            // 4. 执行逻辑删除
            boolean result = taskService.logicalDeleteTaskById(id);
            if (result) {
                log.info("企业任务删除成功 - 任务ID: {}, 企业ID: {}, 操作人: {}", 
                        id, currentEnterpriseId, LoginHelper.getUserId());
                return R.ok();
            } else {
                log.error("企业任务删除失败 - 任务ID: {}", id);
                return R.fail("删除失败");
            }
        } catch (Exception e) {
            log.error("企业任务删除异常 - 任务ID: {}", id, e);
            return R.fail("删除失败：" + e.getMessage());
        }
    }

    /**
     * 恢复已删除的任务（系统管理员专用）
     */
    @Operation(
        summary = "恢复任务",
        description = "系统管理员恢复已删除的任务（可恢复所有企业的任务）",
        parameters = @Parameter(name = "id", description = "任务ID", required = true, example = "1")
    )
    @SaCheckRole("admin")  // 修改：仅系统管理员可访问
    @SaCheckPermission("designer:task:restore")  // 修改：使用系统级权限
    @Log(title = "任务管理", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/restore")
    public R<Void> restore(@PathVariable Long id) {
        try {
            // 系统管理员恢复任务，无需企业权限验证
            boolean result = taskService.restoreTaskById(id);
            if (result) {
                log.info("系统管理员恢复任务成功 - 任务ID: {}, 操作人: {}", 
                        id, LoginHelper.getUserId());
                return R.ok();
            } else {
                log.error("任务恢复失败 - 任务ID: {}", id);
                return R.fail("恢复失败：任务不存在或未被删除");
            }
        } catch (Exception e) {
            log.error("任务恢复异常 - 任务ID: {}", id, e);
            return R.fail("恢复失败：" + e.getMessage());
        }
    }

    /**
     * 查询系统回收站任务（系统管理员专用）
     */
    @Operation(
        summary = "查询系统回收站",
        description = "系统管理员查看所有企业的已删除任务列表",
        parameters = {
            @Parameter(name = "enterpriseId", description = "企业ID（可选，用于过滤特定企业）", example = "1"),
            @Parameter(name = "taskTitle", description = "任务标题（模糊查询）"),
            @Parameter(name = "taskType", description = "任务类型"),
            @Parameter(name = "pageNum", description = "页码", example = "1"),
            @Parameter(name = "pageSize", description = "每页大小", example = "10")
        }
    )
    @SaCheckRole("admin")  // 修改：仅系统管理员可访问
    @SaCheckPermission("designer:task:recycle")  // 修改：使用系统级权限
    @GetMapping("/recycle")
    public TableDataInfo<Task> getRecycleList(TaskQueryDto queryDto, PageQuery pageQuery) {
        try {
            // 系统管理员可以查看所有企业的已删除任务
            Task task = new Task();
            task.setTaskTitle(queryDto.getTaskTitle());
            task.setTaskType(queryDto.getTaskType());
            
            // 如果指定了企业ID，则只查询该企业的删除任务
            if (queryDto.getEnterpriseId() != null) {
                task.setEnterpriseId(queryDto.getEnterpriseId());
            }
            
            List<Task> deletedTasks = taskService.selectTaskListIncludeDeleted(task);
            
            // 手动实现分页
            int start = (int) ((pageQuery.getPageNum() - 1) * pageQuery.getPageSize());
            int end = Math.min(start + (int) pageQuery.getPageSize(), deletedTasks.size());
            
            List<Task> pagedTasks = deletedTasks.subList(Math.max(0, start), end);
            
            TableDataInfo<Task> dataInfo = new TableDataInfo<>();
            dataInfo.setCode(200);
            dataInfo.setRows(pagedTasks);
            dataInfo.setTotal(deletedTasks.size());
            
            log.info("系统管理员查询回收站 - 总数: {}, 当前页: {}, 操作人: {}", 
                    deletedTasks.size(), pagedTasks.size(), LoginHelper.getUserId());
            
            return dataInfo;
        } catch (Exception e) {
            log.error("查询回收站异常", e);
            return TableDataInfo.build();
        }
    }

    /**
     * 发布任务
     */
    @Operation(
        summary = "发布任务",
        description = "将草稿状态的任务发布到任务广场",
        parameters = @Parameter(name = "id", description = "任务ID", required = true, example = "1")
    )
    @SaCheckRole("enterprise")  // 修复：直接检查企业管理员角色
    @SaCheckPermission("designer:enterprise:task:publish")
    @Log(title = "企业任务管理", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/publish")
    public R<Void> publish(@PathVariable Long id) {
        // 验证任务是否属于当前企业
        Task existingTask = taskService.selectTaskById(id);
        if (existingTask == null) {
            return R.fail("任务不存在");
        }
        Long currentEnterpriseId = permissionUtils.getCurrentEnterpriseId();
        if (currentEnterpriseId == null || !currentEnterpriseId.equals(existingTask.getEnterpriseId())) {
            return R.fail("无权限操作此任务");
        }
        
        // 只有草稿状态的任务才能发布
        if (!Task.TaskStatus.DRAFT.name().equals(existingTask.getStatus())) {
            return R.fail("只有草稿状态的任务才能发布");
        }
        
        // 更新状态为已发布
        Task updateTask = new Task();
        updateTask.setTaskId(id);
        updateTask.setStatus(Task.TaskStatus.PUBLISHED.name());
        
        return toAjax(taskService.updateTask(updateTask));
    }

    /**
     * 取消任务
     */
    @Operation(
        summary = "取消任务",
        description = "取消已发布的任务",
        parameters = @Parameter(name = "id", description = "任务ID", required = true, example = "1")
    )
    @SaCheckRole("enterprise")  // 修复：直接检查企业管理员角色
    @SaCheckPermission("designer:enterprise:task:cancel")
    @Log(title = "企业任务管理", businessType = BusinessType.UPDATE)
    @PostMapping("/{id}/cancel")
    public R<Void> cancel(@PathVariable Long id) {
        // 验证任务是否属于当前企业
        Task existingTask = taskService.selectTaskById(id);
        if (existingTask == null) {
            return R.fail("任务不存在");
        }
        Long currentEnterpriseId = permissionUtils.getCurrentEnterpriseId();
        if (currentEnterpriseId == null || !currentEnterpriseId.equals(existingTask.getEnterpriseId())) {
            return R.fail("无权限操作此任务");
        }
        
        // 只有已发布或进行中的任务才能取消
        String currentStatus = existingTask.getStatus();
        if (!Task.TaskStatus.PUBLISHED.name().equals(currentStatus) && 
            !Task.TaskStatus.IN_PROGRESS.name().equals(currentStatus)) {
            return R.fail("只有已发布或进行中的任务才能取消");
        }
        
        // 更新状态为已取消
        Task updateTask = new Task();
        updateTask.setTaskId(id);
        updateTask.setStatus(Task.TaskStatus.CANCELLED.name());
        
        return toAjax(taskService.updateTask(updateTask));
    }
} 