package org.ruoyi.designer.service;

import org.ruoyi.designer.domain.Task;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 任务Service接口
 *
 * @author ruoyi
 */
public interface ITaskService {

    /**
     * 查询任务
     *
     * @param taskId 任务主键
     * @return 任务
     */
    Task selectTaskById(Long taskId);

    /**
     * 查询任务列表
     *
     * @param task 任务
     * @return 任务集合
     */
    List<Task> selectTaskList(Task task);

    /**
     * 分页查询任务列表
     *
     * @param task 任务
     * @param pageQuery 分页参数
     * @return 任务分页数据
     */
    TableDataInfo<Task> selectTaskPage(Task task, PageQuery pageQuery);

    /**
     * 新增任务
     *
     * @param task 任务
     * @return 结果
     */
    Boolean insertTask(Task task);

    /**
     * 修改任务
     *
     * @param task 任务
     * @return 结果
     */
    Boolean updateTask(Task task);

    /**
     * 批量删除任务
     *
     * @param taskIds 需要删除的任务主键集合
     * @return 结果
     */
    Boolean deleteTaskByIds(Collection<Long> taskIds);

    /**
     * 删除任务信息
     *
     * @param taskId 任务主键
     * @return 结果
     */
    Boolean deleteTaskById(Long taskId);

    /**
     * 逻辑删除任务（标准实现）
     *
     * @param taskId 任务主键
     * @return 结果
     */
    Boolean logicalDeleteTaskById(Long taskId);

    /**
     * 批量逻辑删除任务
     *
     * @param taskIds 需要删除的任务主键集合
     * @return 结果
     */
    Boolean logicalDeleteTaskByIds(Collection<Long> taskIds);

    /**
     * 恢复已删除的任务（管理员专用）
     *
     * @param taskId 任务主键
     * @return 结果
     */
    Boolean restoreTaskById(Long taskId);

    /**
     * 批量恢复已删除的任务
     *
     * @param taskIds 需要恢复的任务主键集合
     * @return 结果
     */
    Boolean restoreTaskByIds(Collection<Long> taskIds);

    /**
     * 查询包含已删除数据的任务列表（管理员专用）
     *
     * @param task 任务
     * @return 任务集合
     */
    List<Task> selectTaskListIncludeDeleted(Task task);

    /**
     * 根据企业ID查询任务列表
     *
     * @param enterpriseId 企业ID
     * @return 任务列表
     */
    List<Task> selectTasksByEnterpriseId(Long enterpriseId);

    /**
     * 根据状态查询任务列表
     *
     * @param status 任务状态
     * @return 任务列表
     */
    List<Task> selectTasksByStatus(String status);

    /**
     * 增加任务浏览次数
     *
     * @param taskId 任务ID
     * @return 结果
     */
    Boolean incrementViews(Long taskId);

    /**
     * 增加任务申请数量
     *
     * @param taskId 任务ID
     * @return 结果
     */
    Boolean incrementApplications(Long taskId);

    /**
     * 减少任务申请数量
     *
     * @param taskId 任务ID
     * @return 结果
     */
    Boolean decrementApplications(Long taskId);
} 