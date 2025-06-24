package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.Work;
import org.ruoyi.designer.mapper.WorkMapper;
import org.ruoyi.designer.service.IWorkService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 作品Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class WorkServiceImpl extends ServiceImpl<WorkMapper, Work> implements IWorkService {

    private final WorkMapper workMapper;

    /**
     * 查询作品列表
     *
     * @param work 作品
     * @return 作品集合
     */
    @Override
    public TableDataInfo<Work> selectWorkList(Work work) {
        LambdaQueryWrapper<Work> lqw = new LambdaQueryWrapper<Work>()
            .eq(work.getDesignerId() != null, Work::getDesignerId, work.getDesignerId())
            .like(StringUtils.isNotBlank(work.getTitle()), Work::getTitle, work.getTitle())
            .eq(StringUtils.isNotBlank(work.getWorkType()), Work::getWorkType, work.getWorkType())
            .eq(StringUtils.isNotBlank(work.getIsFeatured()), Work::getIsFeatured, work.getIsFeatured())
            .eq(StringUtils.isNotBlank(work.getStatus()), Work::getStatus, work.getStatus())
            .orderByDesc(Work::getCreateTime);
        
        Page<Work> result = workMapper.selectPage(new Page<>(), lqw);
        return TableDataInfo.build(result);
    }

    /**
     * 根据作品ID查询作品信息
     *
     * @param workId 作品ID
     * @return 作品信息
     */
    @Override
    public Work selectWorkById(Long workId) {
        return workMapper.selectById(workId);
    }

    /**
     * 根据设计师ID查询作品列表
     *
     * @param designerId 设计师ID
     * @return 作品列表
     */
    @Override
    public List<Work> selectWorkByDesignerId(Long designerId) {
        LambdaQueryWrapper<Work> lqw = new LambdaQueryWrapper<Work>()
            .eq(Work::getDesignerId, designerId)
            .eq(Work::getStatus, "0")
            .orderByDesc(Work::getCreateTime);
        return workMapper.selectList(lqw);
    }

    /**
     * 新增作品
     *
     * @param work 作品
     * @return 结果
     */
    @Override
    public Boolean insertWork(Work work) {
        if (work.getLikeCount() == null) {
            work.setLikeCount(0);
        }
        if (work.getViewCount() == null) {
            work.setViewCount(0);
        }
        if (StringUtils.isBlank(work.getStatus())) {
            work.setStatus("0");
        }
        if (StringUtils.isBlank(work.getIsFeatured())) {
            work.setIsFeatured("0");
        }
        return workMapper.insert(work) > 0;
    }

    /**
     * 修改作品
     *
     * @param work 作品
     * @return 结果
     */
    @Override
    public Boolean updateWork(Work work) {
        return workMapper.updateById(work) > 0;
    }

    /**
     * 批量删除作品
     *
     * @param workIds 需要删除的作品ID
     * @return 结果
     */
    @Override
    public Boolean deleteWorkByIds(List<Long> workIds) {
        return workMapper.deleteBatchIds(workIds) > 0;
    }

    /**
     * 删除设计师的所有作品
     *
     * @param designerId 设计师ID
     * @return 结果
     */
    @Override
    public Boolean deleteWorkByDesignerId(Long designerId) {
        LambdaQueryWrapper<Work> lqw = new LambdaQueryWrapper<Work>()
            .eq(Work::getDesignerId, designerId);
        return workMapper.delete(lqw) > 0;
    }

    /**
     * 增加作品浏览数
     *
     * @param workId 作品ID
     * @return 结果
     */
    @Override
    public Boolean incrementViewCount(Long workId) {
        Work work = workMapper.selectById(workId);
        if (work != null) {
            work.setViewCount(work.getViewCount() == null ? 1 : work.getViewCount() + 1);
            return workMapper.updateById(work) > 0;
        }
        return false;
    }

    /**
     * 增加作品点赞数
     *
     * @param workId 作品ID
     * @return 结果
     */
    @Override
    public Boolean incrementLikeCount(Long workId) {
        Work work = workMapper.selectById(workId);
        if (work != null) {
            work.setLikeCount(work.getLikeCount() == null ? 1 : work.getLikeCount() + 1);
            return workMapper.updateById(work) > 0;
        }
        return false;
    }
} 