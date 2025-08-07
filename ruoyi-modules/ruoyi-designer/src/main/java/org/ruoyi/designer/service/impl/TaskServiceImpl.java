package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.designer.domain.Enterprise;
import org.ruoyi.designer.domain.Task;
import org.ruoyi.designer.mapper.TaskMapper;
import org.ruoyi.designer.service.IEnterpriseService;
import org.ruoyi.designer.service.ITaskService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;
import java.util.Arrays;
import java.util.ArrayList;

/**
 * 任务Service业务层处理
 *
 * @author ruoyi
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class TaskServiceImpl implements ITaskService {

    private final TaskMapper baseMapper;
    private final IEnterpriseService enterpriseService;

    /**
     * 查询任务
     *
     * @param taskId 任务主键
     * @return 任务
     */
    @Override
    public Task selectTaskById(Long taskId) {
        Task task = baseMapper.selectById(taskId);
        if (task != null) {
            // 关联查询企业信息
            Enterprise enterprise = enterpriseService.getById(task.getEnterpriseId());
            task.setEnterprise(enterprise);
        }
        return task;
    }

    /**
     * 查询任务列表
     *
     * @param task 任务
     * @return 任务
     */
    @Override
    public List<Task> selectTaskList(Task task) {
        LambdaQueryWrapper<Task> lqw = buildQueryWrapper(task);
        List<Task> tasks = baseMapper.selectList(lqw);
        
        // 关联查询企业信息
        fillEnterpriseInfo(tasks);
        
        return tasks;
    }

    /**
     * 分页查询任务列表
     *
     * @param task 任务
     * @param pageQuery 分页参数
     * @return 任务分页数据
     */
    @Override
    public TableDataInfo<Task> selectTaskPage(Task task, PageQuery pageQuery) {
        LambdaQueryWrapper<Task> lqw = buildQueryWrapper(task);
        Page<Task> result = baseMapper.selectPage(pageQuery.build(), lqw);
        
        // 关联查询企业信息
        List<Task> tasks = result.getRecords();
        fillEnterpriseInfo(tasks);
        
        return TableDataInfo.build(result);
    }

    /**
     * 新增任务
     *
     * @param task 任务
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertTask(Task task) {
        // 设置默认值
        if (task.getViews() == null) {
            task.setViews(0);
        }
        if (task.getApplications() == null) {
            task.setApplications(0);
        }
        if (task.getUrgent() == null) {
            task.setUrgent(false);
        }
        if (StringUtils.isBlank(task.getStatus())) {
            task.setStatus(Task.TaskStatus.DRAFT.name());
        }

        // 设置创建信息
        Long userId = LoginHelper.getUserId();
        task.setCreateBy(userId);
        task.setCreateTime(new Date());
        
        // 转换技能标签字段
        task.setSkillTags(convertSkillTagsField(task.getSkillTags()));

        int result = baseMapper.insert(task);
        
        if (result > 0) {
            log.info("新增任务成功: taskId={}, title={}, enterpriseId={}", 
                    task.getTaskId(), task.getTaskTitle(), task.getEnterpriseId());
        }
        
        return result > 0;
    }

    /**
     * 修改任务
     *
     * @param task 任务
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateTask(Task task) {
        task.setUpdateBy(LoginHelper.getUserId());
        task.setUpdateTime(new Date());
        
        // 转换技能标签字段
        task.setSkillTags(convertSkillTagsField(task.getSkillTags()));

        int result = baseMapper.updateById(task);
        
        if (result > 0) {
            log.info("更新任务成功: taskId={}", task.getTaskId());
        }
        
        return result > 0;
    }

    /**
     * 批量删除任务
     *
     * @param taskIds 需要删除的任务主键集合
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteTaskByIds(Collection<Long> taskIds) {
        int result = baseMapper.deleteBatchIds(taskIds);
        
        if (result > 0) {
            log.info("批量删除任务成功: taskIds={}, count={}", taskIds, result);
        }
        
        return result > 0;
    }

    /**
     * 删除任务信息
     *
     * @param taskId 任务主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteTaskById(Long taskId) {
        int result = baseMapper.deleteById(taskId);
        
        if (result > 0) {
            log.info("删除任务成功: taskId={}", taskId);
        }
        
        return result > 0;
    }

    /**
     * 逻辑删除任务（标准实现）
     *
     * @param taskId 任务主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean logicalDeleteTaskById(Long taskId) {
        // 1. 验证任务是否存在
        Task task = baseMapper.selectById(taskId);
        if (task == null) {
            log.warn("尝试删除不存在的任务: taskId={}", taskId);
            return false;
        }
        
        // 2. 检查任务状态是否允许删除
        if (Task.TaskStatus.IN_PROGRESS.name().equals(task.getStatus()) ||
            Task.TaskStatus.COMPLETED.name().equals(task.getStatus())) {
            log.warn("进行中或已完成的任务不允许删除: taskId={}, status={}", taskId, task.getStatus());
            return false;
        }
        
        // 3. 设置删除标志和删除信息
        LambdaUpdateWrapper<Task> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(Task::getTaskId, taskId)
               .set(Task::getDelFlag, "1")  // 设置为软删除
               .set(Task::getDelTime, new Date())
               .set(Task::getDelBy, LoginHelper.getUserId());
        
        int result = baseMapper.update(null, wrapper);
        
        if (result > 0) {
            log.info("逻辑删除任务成功: taskId={}, delBy={}", taskId, LoginHelper.getUserId());
            
            // 4. 处理关联数据的逻辑删除（如果需要）
            cascadeLogicalDeleteRelatedData(taskId);
        }
        
        return result > 0;
    }

    /**
     * 批量逻辑删除任务
     *
     * @param taskIds 需要删除的任务主键集合
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean logicalDeleteTaskByIds(Collection<Long> taskIds) {
        if (taskIds == null || taskIds.isEmpty()) {
            return false;
        }
        
        boolean allSuccess = true;
        for (Long taskId : taskIds) {
            if (!logicalDeleteTaskById(taskId)) {
                allSuccess = false;
                log.error("批量删除任务失败: taskId={}", taskId);
            }
        }
        
        return allSuccess;
    }

    /**
     * 恢复已删除的任务（管理员专用）
     *
     * @param taskId 任务主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean restoreTaskById(Long taskId) {
        // 权限检查已在Controller层通过@SaCheckRole("admin")处理，这里无需重复检查
        
        // 1. 查询已删除的任务（需要忽略逻辑删除过滤）
        LambdaQueryWrapper<Task> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Task::getTaskId, taskId)
                   .eq(Task::getDelFlag, "1");
        
        Task deletedTask = baseMapper.selectOne(queryWrapper);
        if (deletedTask == null) {
            log.warn("尝试恢复不存在或未删除的任务: taskId={}", taskId);
            return false;
        }
        
        // 2. 恢复任务
        LambdaUpdateWrapper<Task> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(Task::getTaskId, taskId)
               .set(Task::getDelFlag, "0")  // 恢复为正常状态
               .set(Task::getDelTime, null)
               .set(Task::getDelBy, null);
        
        int result = baseMapper.update(null, wrapper);
        
        if (result > 0) {
            log.info("恢复任务成功: taskId={}, restoreBy={}", taskId, LoginHelper.getUserId());
            
            // 3. 恢复关联数据（如果需要）
            cascadeRestoreRelatedData(taskId);
        }
        
        return result > 0;
    }

    /**
     * 批量恢复已删除的任务
     *
     * @param taskIds 需要恢复的任务主键集合
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean restoreTaskByIds(Collection<Long> taskIds) {
        if (taskIds == null || taskIds.isEmpty()) {
            return false;
        }
        
        boolean allSuccess = true;
        for (Long taskId : taskIds) {
            if (!restoreTaskById(taskId)) {
                allSuccess = false;
                log.error("批量恢复任务失败: taskId={}", taskId);
            }
        }
        
        return allSuccess;
    }

    /**
     * 查询包含已删除数据的任务列表（管理员专用）
     *
     * @param task 任务
     * @return 任务集合
     */
    @Override
    public List<Task> selectTaskListIncludeDeleted(Task task) {
        // 权限检查已在Controller层通过@SaCheckRole("admin")处理，这里无需重复检查
        
        LambdaQueryWrapper<Task> lqw = buildQueryWrapper(task, true); // 传递true表示包含所有状态
        // 显式查询已删除的数据
        lqw.in(Task::getDelFlag, "1", "2");
        lqw.orderByDesc(Task::getDelTime);
        
        List<Task> tasks = baseMapper.selectList(lqw);
        
        // 关联查询企业信息
        fillEnterpriseInfo(tasks);
        
        return tasks;
    }

    /**
     * 根据企业ID查询任务列表
     *
     * @param enterpriseId 企业ID
     * @return 任务列表
     */
    @Override
    public List<Task> selectTasksByEnterpriseId(Long enterpriseId) {
        LambdaQueryWrapper<Task> lqw = Wrappers.<Task>lambdaQuery();
        lqw.eq(Task::getEnterpriseId, enterpriseId);
        lqw.eq(Task::getDelFlag, "0");
        lqw.orderByDesc(Task::getCreateTime);
        
        List<Task> tasks = baseMapper.selectList(lqw);
        
        // 关联查询企业信息
        fillEnterpriseInfo(tasks);
        
        return tasks;
    }

    /**
     * 根据状态查询任务列表
     *
     * @param status 任务状态
     * @return 任务列表
     */
    @Override
    public List<Task> selectTasksByStatus(String status) {
        LambdaQueryWrapper<Task> lqw = Wrappers.<Task>lambdaQuery();
        lqw.eq(Task::getStatus, status);
        lqw.eq(Task::getDelFlag, "0");
        lqw.orderByDesc(Task::getCreateTime);
        
        List<Task> tasks = baseMapper.selectList(lqw);
        
        // 关联查询企业信息
        fillEnterpriseInfo(tasks);
        
        return tasks;
    }

    /**
     * 增加任务浏览次数
     *
     * @param taskId 任务ID
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean incrementViews(Long taskId) {
        Task task = baseMapper.selectById(taskId);
        if (task != null) {
            task.setViews(task.getViews() == null ? 1 : task.getViews() + 1);
            return baseMapper.updateById(task) > 0;
        }
        return false;
    }

    /**
     * 增加任务申请数量
     *
     * @param taskId 任务ID
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean incrementApplications(Long taskId) {
        Task task = baseMapper.selectById(taskId);
        if (task != null) {
            task.setApplications(task.getApplications() == null ? 1 : task.getApplications() + 1);
            return baseMapper.updateById(task) > 0;
        }
        return false;
    }

    /**
     * 减少任务申请数量
     *
     * @param taskId 任务ID
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean decrementApplications(Long taskId) {
        Task task = baseMapper.selectById(taskId);
        if (task != null && task.getApplications() != null && task.getApplications() > 0) {
            task.setApplications(task.getApplications() - 1);
            return baseMapper.updateById(task) > 0;
        }
        return false;
    }

    /**
     * 构建查询条件
     */
    private LambdaQueryWrapper<Task> buildQueryWrapper(Task task) {
        return buildQueryWrapper(task, false);
    }
    
    /**
     * 构建查询条件（重载方法）
     * 
     * @param task 查询条件
     * @param includeAllStatus 是否包含所有状态（true=包含草稿，false=排除草稿）
     * @return 查询条件
     */
    private LambdaQueryWrapper<Task> buildQueryWrapper(Task task, boolean includeAllStatus) {
        LambdaQueryWrapper<Task> lqw = Wrappers.<Task>lambdaQuery();
        lqw.eq(task.getEnterpriseId() != null, Task::getEnterpriseId, task.getEnterpriseId());
        lqw.like(StringUtils.isNotBlank(task.getTaskTitle()), Task::getTaskTitle, task.getTaskTitle());
        lqw.like(StringUtils.isNotBlank(task.getTaskDescription()), Task::getTaskDescription, task.getTaskDescription());
        lqw.eq(StringUtils.isNotBlank(task.getTaskType()), Task::getTaskType, task.getTaskType());
        lqw.eq(StringUtils.isNotBlank(task.getStatus()), Task::getStatus, task.getStatus());
        lqw.eq(task.getUrgent() != null, Task::getUrgent, task.getUrgent());
        lqw.eq(Task::getDelFlag, "0");
        
        // 任务广场权限控制：
        // 1. 如果指定了企业ID，说明是企业管理员查询自己的任务，应包含草稿状态
        // 2. 如果未指定企业ID且未指定状态，说明是公共任务广场查询，应排除草稿状态
        if (!includeAllStatus && task.getEnterpriseId() == null && StringUtils.isBlank(task.getStatus())) {
            lqw.ne(Task::getStatus, Task.TaskStatus.DRAFT.name());
        }
        
        lqw.orderByDesc(Task::getCreateTime);
        
        return lqw;
    }

    /**
     * 为任务列表填充企业信息
     */
    private void fillEnterpriseInfo(List<Task> tasks) {
        if (tasks.isEmpty()) {
            return;
        }
        
        // 收集所有企业ID
        List<Long> enterpriseIds = tasks.stream()
                .map(Task::getEnterpriseId)
                .distinct()
                .toList();
        
        // 批量查询企业信息
        List<Enterprise> enterprises = enterpriseService.listByIds(enterpriseIds);
        Map<Long, Enterprise> enterpriseMap = enterprises.stream()
                .collect(Collectors.toMap(Enterprise::getEnterpriseId, e -> e));
        
        // 设置企业信息
        tasks.forEach(task -> {
            Enterprise enterprise = enterpriseMap.get(task.getEnterpriseId());
            task.setEnterprise(enterprise);
        });
    }

    /**
     * 转换技能标签字段
     * 如果传入的是逗号分隔的字符串，转换为JSON数组格式
     * 
     * @param skillTags 技能标签字符串
     * @return JSON格式的技能标签字符串
     */
    private String convertSkillTagsField(String skillTags) {
        if (StringUtils.isBlank(skillTags)) {
            return "[]";
        }
        
        String trimmedSkillTags = skillTags.trim();
        
        // 如果不是JSON格式（不以[开头且不以]结尾），则认为是逗号分隔的字符串
        if (!trimmedSkillTags.startsWith("[") || !trimmedSkillTags.endsWith("]")) {
            // 将逗号分隔的字符串转换为JSON数组格式
            String[] tags = trimmedSkillTags.split(",");
            String jsonArray = Arrays.stream(tags)
                    .map(String::trim)
                    .filter(tag -> !tag.isEmpty())
                    .map(tag -> "\"" + tag + "\"")
                    .collect(Collectors.joining(",", "[", "]"));
            return jsonArray;
        }
        
        // 如果已经是JSON格式，保持不变
        return trimmedSkillTags;
    }

    /**
     * 级联逻辑删除关联数据
     *
     * @param taskId 任务ID
     */
    private void cascadeLogicalDeleteRelatedData(Long taskId) {
        // 这里可以添加删除任务申请、交付物等关联数据的逻辑
        // 例如：
        // taskApplicationService.logicalDeleteByTaskId(taskId);
        // taskDeliverableService.logicalDeleteByTaskId(taskId);
        log.info("处理任务关联数据的逻辑删除: taskId={}", taskId);
    }

    /**
     * 级联恢复关联数据
     *
     * @param taskId 任务ID
     */
    private void cascadeRestoreRelatedData(Long taskId) {
        // 这里可以添加恢复任务申请、交付物等关联数据的逻辑
        // 例如：
        // taskApplicationService.restoreByTaskId(taskId);
        // taskDeliverableService.restoreByTaskId(taskId);
        log.info("处理任务关联数据的恢复: taskId={}", taskId);
    }
} 