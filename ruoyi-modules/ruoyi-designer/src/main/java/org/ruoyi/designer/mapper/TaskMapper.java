package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.ruoyi.designer.domain.Task;
import org.apache.ibatis.annotations.Param;

import java.util.Collection;
import java.util.List;

/**
 * 任务Mapper接口
 *
 * @author ruoyi
 */
public interface TaskMapper extends BaseMapper<Task> {

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
     * 新增任务
     *
     * @param task 任务
     * @return 结果
     */
    int insertTask(Task task);

    /**
     * 修改任务
     *
     * @param task 任务
     * @return 结果
     */
    int updateTask(Task task);

    /**
     * 删除任务
     *
     * @param taskId 任务主键
     * @return 结果
     */
    int deleteTaskById(Long taskId);

    /**
     * 批量删除任务
     *
     * @param taskIds 需要删除的数据主键集合
     * @return 结果
     */
    int deleteTaskByIds(@Param("taskIds") Collection<Long> taskIds);

    /**
     * 根据企业ID查询任务列表
     *
     * @param enterpriseId 企业ID
     * @return 任务列表
     */
    List<Task> selectTasksByEnterpriseId(@Param("enterpriseId") Long enterpriseId);

    /**
     * 根据状态查询任务列表
     *
     * @param status 任务状态
     * @return 任务列表
     */
    List<Task> selectTasksByStatus(@Param("status") String status);

    /**
     * 增加任务浏览次数
     *
     * @param taskId 任务ID
     * @return 结果
     */
    int incrementViews(@Param("taskId") Long taskId);

    /**
     * 增加任务申请数量
     *
     * @param taskId 任务ID
     * @return 结果
     */
    int incrementApplications(@Param("taskId") Long taskId);

    /**
     * 减少任务申请数量
     *
     * @param taskId 任务ID
     * @return 结果
     */
    int decrementApplications(@Param("taskId") Long taskId);
} 