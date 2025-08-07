package org.ruoyi.designer.service;

import org.ruoyi.designer.domain.TaskApplication;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 任务申请Service接口
 *
 * @author ruoyi
 */
public interface ITaskApplicationService {

    /**
     * 查询任务申请
     *
     * @param applicationId 任务申请主键
     * @return 任务申请
     */
    TaskApplication selectTaskApplicationById(Long applicationId);

    /**
     * 查询任务申请列表
     *
     * @param taskApplication 任务申请
     * @return 任务申请集合
     */
    List<TaskApplication> selectTaskApplicationList(TaskApplication taskApplication);

    /**
     * 分页查询任务申请列表
     *
     * @param taskApplication 任务申请
     * @param pageQuery 分页参数
     * @return 任务申请分页数据
     */
    TableDataInfo<TaskApplication> selectTaskApplicationPage(TaskApplication taskApplication, PageQuery pageQuery);

    /**
     * 新增任务申请
     *
     * @param taskApplication 任务申请
     * @return 结果
     */
    Boolean insertTaskApplication(TaskApplication taskApplication);

    /**
     * 修改任务申请
     *
     * @param taskApplication 任务申请
     * @return 结果
     */
    Boolean updateTaskApplication(TaskApplication taskApplication);

    /**
     * 批量删除任务申请
     *
     * @param applicationIds 需要删除的任务申请主键集合
     * @return 结果
     */
    Boolean deleteTaskApplicationByIds(Collection<Long> applicationIds);

    /**
     * 删除任务申请信息
     *
     * @param applicationId 任务申请主键
     * @return 结果
     */
    Boolean deleteTaskApplicationById(Long applicationId);

    /**
     * 根据任务ID查询申请列表
     *
     * @param taskId 任务ID
     * @return 申请列表
     */
    List<TaskApplication> selectApplicationsByTaskId(Long taskId);

    /**
     * 根据设计师ID查询申请列表
     *
     * @param designerId 设计师ID
     * @return 申请列表
     */
    List<TaskApplication> selectApplicationsByDesignerId(Long designerId);

    /**
     * 根据状态查询申请列表
     *
     * @param status 申请状态
     * @return 申请列表
     */
    List<TaskApplication> selectApplicationsByStatus(String status);

    /**
     * 检查是否已申请过该任务
     *
     * @param taskId 任务ID
     * @param designerId 设计师ID
     * @return 是否已申请
     */
    Boolean hasApplied(Long taskId, Long designerId);
} 