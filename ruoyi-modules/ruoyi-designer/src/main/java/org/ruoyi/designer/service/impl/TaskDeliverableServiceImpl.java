package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.designer.domain.TaskDeliverable;
import org.ruoyi.designer.mapper.TaskDeliverableMapper;
import org.ruoyi.designer.service.ITaskDeliverableService;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.regex.Pattern;

/**
 * 任务交付物Service业务层处理
 *
 * @author ruoyi
 */
@Service
@RequiredArgsConstructor
@Slf4j
public class TaskDeliverableServiceImpl implements ITaskDeliverableService {

    private final TaskDeliverableMapper baseMapper;

    /**
     * 查询交付物
     *
     * @param deliverableId 交付物主键
     * @return 交付物
     */
    @Override
    public TaskDeliverable selectDeliverableById(Long deliverableId) {
        return baseMapper.selectById(deliverableId);
    }

    /**
     * 查询交付物列表
     *
     * @param deliverable 交付物
     * @return 交付物
     */
    @Override
    public List<TaskDeliverable> selectDeliverableList(TaskDeliverable deliverable) {
        LambdaQueryWrapper<TaskDeliverable> lqw = buildQueryWrapper(deliverable);
        return baseMapper.selectList(lqw);
    }

    /**
     * 分页查询交付物列表
     *
     * @param deliverable 交付物
     * @param pageQuery 分页参数
     * @return 交付物分页数据
     */
    @Override
    public TableDataInfo<TaskDeliverable> selectDeliverablePage(TaskDeliverable deliverable, PageQuery pageQuery) {
        LambdaQueryWrapper<TaskDeliverable> lqw = buildQueryWrapper(deliverable);
        Page<TaskDeliverable> result = baseMapper.selectPage(pageQuery.build(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 新增交付物
     *
     * @param deliverable 交付物
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean insertDeliverable(TaskDeliverable deliverable) {
        // 设置默认值
        if (deliverable.getVersion() == null) {
            deliverable.setVersion(1);
        }
        if (StringUtils.isBlank(deliverable.getStatus())) {
            deliverable.setStatus(TaskDeliverable.DeliverableStatus.SUBMITTED.name());
        }

        // 验证交付物内容安全性
        if (!validateDeliverableContent(deliverable.getDeliverableContent())) {
            log.warn("交付物内容包含不安全元素: deliverableId={}", deliverable.getDeliverableId());
            return false;
        }

        // 设置创建信息
        Long userId = LoginHelper.getUserId();
        deliverable.setCreateBy(userId);
        deliverable.setCreateTime(new Date());
        
        int result = baseMapper.insert(deliverable);
        
        if (result > 0) {
            log.info("新增交付物成功: deliverableId={}, taskId={}, designerId={}", 
                    deliverable.getDeliverableId(), deliverable.getTaskId(), deliverable.getDesignerId());
        }
        
        return result > 0;
    }

    /**
     * 修改交付物
     *
     * @param deliverable 交付物
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateDeliverable(TaskDeliverable deliverable) {
        // 验证交付物内容安全性
        if (StringUtils.isNotBlank(deliverable.getDeliverableContent()) &&
            !validateDeliverableContent(deliverable.getDeliverableContent())) {
            log.warn("交付物内容包含不安全元素: deliverableId={}", deliverable.getDeliverableId());
            return false;
        }

        deliverable.setUpdateBy(LoginHelper.getUserId());
        deliverable.setUpdateTime(new Date());
        
        int result = baseMapper.updateById(deliverable);
        
        if (result > 0) {
            log.info("更新交付物成功: deliverableId={}", deliverable.getDeliverableId());
        }
        
        return result > 0;
    }

    /**
     * 批量删除交付物
     *
     * @param deliverableIds 需要删除的交付物主键集合
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteDeliverableByIds(Collection<Long> deliverableIds) {
        int result = baseMapper.deleteBatchIds(deliverableIds);
        
        if (result > 0) {
            log.info("批量删除交付物成功: deliverableIds={}, count={}", deliverableIds, result);
        }
        
        return result > 0;
    }

    /**
     * 删除交付物信息
     *
     * @param deliverableId 交付物主键
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteDeliverableById(Long deliverableId) {
        int result = baseMapper.deleteById(deliverableId);
        
        if (result > 0) {
            log.info("删除交付物成功: deliverableId={}", deliverableId);
        }
        
        return result > 0;
    }

    /**
     * 审核交付物
     *
     * @param deliverableId 交付物ID
     * @param status 审核状态
     * @param feedback 审核反馈
     * @return 结果
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean reviewDeliverable(Long deliverableId, String status, String feedback) {
        TaskDeliverable deliverable = new TaskDeliverable();
        deliverable.setDeliverableId(deliverableId);
        deliverable.setStatus(status);
        deliverable.setReviewFeedback(feedback);
        deliverable.setUpdateBy(LoginHelper.getUserId());
        deliverable.setUpdateTime(new Date());
        
        int result = baseMapper.updateById(deliverable);
        
        if (result > 0) {
            log.info("审核交付物成功: deliverableId={}, status={}", deliverableId, status);
        }
        
        return result > 0;
    }

    /**
     * 根据任务ID查询交付物列表
     *
     * @param taskId 任务ID
     * @return 交付物列表
     */
    @Override
    public List<TaskDeliverable> selectDeliverablesByTaskId(Long taskId) {
        LambdaQueryWrapper<TaskDeliverable> lqw = Wrappers.<TaskDeliverable>lambdaQuery();
        lqw.eq(TaskDeliverable::getTaskId, taskId);
        lqw.eq(TaskDeliverable::getDelFlag, "0");
        lqw.orderByDesc(TaskDeliverable::getCreateTime);
        
        return baseMapper.selectList(lqw);
    }

    /**
     * 根据设计师ID查询交付物列表
     *
     * @param designerId 设计师ID
     * @return 交付物列表
     */
    @Override
    public List<TaskDeliverable> selectDeliverablesByDesignerId(Long designerId) {
        LambdaQueryWrapper<TaskDeliverable> lqw = Wrappers.<TaskDeliverable>lambdaQuery();
        lqw.eq(TaskDeliverable::getDesignerId, designerId);
        lqw.eq(TaskDeliverable::getDelFlag, "0");
        lqw.orderByDesc(TaskDeliverable::getCreateTime);
        
        return baseMapper.selectList(lqw);
    }

    /**
     * 根据状态查询交付物列表
     *
     * @param status 交付物状态
     * @return 交付物列表
     */
    @Override
    public List<TaskDeliverable> selectDeliverablesByStatus(String status) {
        LambdaQueryWrapper<TaskDeliverable> lqw = Wrappers.<TaskDeliverable>lambdaQuery();
        lqw.eq(TaskDeliverable::getStatus, status);
        lqw.eq(TaskDeliverable::getDelFlag, "0");
        lqw.orderByDesc(TaskDeliverable::getCreateTime);
        
        return baseMapper.selectList(lqw);
    }

    /**
     * 验证交付物内容安全性
     *
     * @param content 交付物内容
     * @return 是否安全
     */
    @Override
    public Boolean validateDeliverableContent(String content) {
        if (StringUtils.isBlank(content)) {
            return false;
        }
        
        // 检查基本长度
        String trimmed = content.trim();
        if (trimmed.length() < 10 || trimmed.length() > 10000) {
            return false;
        }
        
        // 检查恶意链接模式
        Pattern[] maliciousPatterns = {
            Pattern.compile("javascript:", Pattern.CASE_INSENSITIVE),
            Pattern.compile("data:text/html", Pattern.CASE_INSENSITIVE),
            Pattern.compile("vbscript:", Pattern.CASE_INSENSITIVE),
            Pattern.compile("file://", Pattern.CASE_INSENSITIVE)
        };
        
        for (Pattern pattern : maliciousPatterns) {
            if (pattern.matcher(content).find()) {
                return false;
            }
        }
        
        return true;
    }

    /**
     * 构建查询条件
     *
     * @param deliverable 交付物查询对象
     * @return 查询条件
     */
    private LambdaQueryWrapper<TaskDeliverable> buildQueryWrapper(TaskDeliverable deliverable) {
        LambdaQueryWrapper<TaskDeliverable> lqw = Wrappers.<TaskDeliverable>lambdaQuery();
        lqw.eq(deliverable.getTaskId() != null, TaskDeliverable::getTaskId, deliverable.getTaskId());
        lqw.eq(deliverable.getDesignerId() != null, TaskDeliverable::getDesignerId, deliverable.getDesignerId());
        lqw.eq(StringUtils.isNotBlank(deliverable.getStatus()), TaskDeliverable::getStatus, deliverable.getStatus());
        lqw.eq(deliverable.getVersion() != null, TaskDeliverable::getVersion, deliverable.getVersion());
        lqw.eq(TaskDeliverable::getDelFlag, "0");
        lqw.orderByDesc(TaskDeliverable::getCreateTime);
        return lqw;
    }
} 