package org.ruoyi.designer.service;

import org.ruoyi.designer.domain.TaskDeliverable;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;

import java.util.Collection;
import java.util.List;

/**
 * 任务交付物Service接口
 *
 * @author ruoyi
 */
public interface ITaskDeliverableService {

    /**
     * 查询交付物
     *
     * @param deliverableId 交付物主键
     * @return 交付物
     */
    TaskDeliverable selectDeliverableById(Long deliverableId);

    /**
     * 查询交付物列表
     *
     * @param deliverable 交付物
     * @return 交付物集合
     */
    List<TaskDeliverable> selectDeliverableList(TaskDeliverable deliverable);

    /**
     * 分页查询交付物列表
     *
     * @param deliverable 交付物
     * @param pageQuery 分页参数
     * @return 交付物分页数据
     */
    TableDataInfo<TaskDeliverable> selectDeliverablePage(TaskDeliverable deliverable, PageQuery pageQuery);

    /**
     * 新增交付物
     *
     * @param deliverable 交付物
     * @return 结果
     */
    Boolean insertDeliverable(TaskDeliverable deliverable);

    /**
     * 修改交付物
     *
     * @param deliverable 交付物
     * @return 结果
     */
    Boolean updateDeliverable(TaskDeliverable deliverable);

    /**
     * 批量删除交付物
     *
     * @param deliverableIds 需要删除的交付物主键集合
     * @return 结果
     */
    Boolean deleteDeliverableByIds(Collection<Long> deliverableIds);

    /**
     * 删除交付物信息
     *
     * @param deliverableId 交付物主键
     * @return 结果
     */
    Boolean deleteDeliverableById(Long deliverableId);

    /**
     * 审核交付物
     *
     * @param deliverableId 交付物ID
     * @param status 审核状态
     * @param feedback 审核反馈
     * @return 结果
     */
    Boolean reviewDeliverable(Long deliverableId, String status, String feedback);

    /**
     * 根据任务ID查询交付物列表
     *
     * @param taskId 任务ID
     * @return 交付物列表
     */
    List<TaskDeliverable> selectDeliverablesByTaskId(Long taskId);

    /**
     * 根据设计师ID查询交付物列表
     *
     * @param designerId 设计师ID
     * @return 交付物列表
     */
    List<TaskDeliverable> selectDeliverablesByDesignerId(Long designerId);

    /**
     * 根据状态查询交付物列表
     *
     * @param status 交付物状态
     * @return 交付物列表
     */
    List<TaskDeliverable> selectDeliverablesByStatus(String status);

    /**
     * 验证交付物内容安全性
     *
     * @param content 交付物内容
     * @return 是否安全
     */
    Boolean validateDeliverableContent(String content);
} 