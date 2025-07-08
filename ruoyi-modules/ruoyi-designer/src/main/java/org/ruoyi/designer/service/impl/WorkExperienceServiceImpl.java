package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.WorkExperience;
import org.ruoyi.designer.mapper.WorkExperienceMapper;
import org.ruoyi.designer.service.IWorkExperienceService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Date;

/**
 * 工作经历Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class WorkExperienceServiceImpl extends ServiceImpl<WorkExperienceMapper, WorkExperience> implements IWorkExperienceService {

    private final WorkExperienceMapper workExperienceMapper;

    /**
     * 查询工作经历列表
     */
    @Override
    public TableDataInfo<WorkExperience> selectWorkExperienceList(WorkExperience workExperience) {
        LambdaQueryWrapper<WorkExperience> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(workExperience.getCompany()), WorkExperience::getCompany, workExperience.getCompany())
                .like(StringUtils.isNotBlank(workExperience.getPosition()), WorkExperience::getPosition, workExperience.getPosition())
                .eq(workExperience.getDesignerId() != null, WorkExperience::getDesignerId, workExperience.getDesignerId())
                .eq(workExperience.getIsCurrent() != null, WorkExperience::getIsCurrent, workExperience.getIsCurrent())
                .eq(StringUtils.isNotBlank(workExperience.getStatus()), WorkExperience::getStatus, workExperience.getStatus())
                .orderByDesc(WorkExperience::getStartDate)
                .orderByDesc(WorkExperience::getCreateTime);
        
        PageQuery pageQuery = new PageQuery(20, 1);
        Page<WorkExperience> page = workExperienceMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    /**
     * 根据工作经历ID查询工作经历信息
     */
    @Override
    public WorkExperience selectWorkExperienceById(Long experienceId) {
        return workExperienceMapper.selectById(experienceId);
    }

    /**
     * 根据设计师ID查询工作经历列表
     */
    @Override
    public List<WorkExperience> selectWorkExperienceByDesignerId(Long designerId) {
        LambdaQueryWrapper<WorkExperience> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkExperience::getDesignerId, designerId)
                .eq(WorkExperience::getStatus, "0")
                .orderByDesc(WorkExperience::getStartDate);
        return workExperienceMapper.selectList(wrapper);
    }

    /**
     * 新增工作经历
     */
    @Override
    public Boolean insertWorkExperience(WorkExperience workExperience) {
        // 如果设置为当前工作，将该设计师的其他工作经历设置为非当前
        if (workExperience.getIsCurrent() != null && workExperience.getIsCurrent()) {
            updateCurrentWorkExperience(workExperience.getDesignerId(), null);
        }
        
        return save(workExperience);
    }

    /**
     * 修改工作经历
     */
    @Override
    public Boolean updateWorkExperience(WorkExperience workExperience) {
        // 如果设置为当前工作，将该设计师的其他工作经历设置为非当前
        if (workExperience.getIsCurrent() != null && workExperience.getIsCurrent()) {
            updateCurrentWorkExperience(workExperience.getDesignerId(), workExperience.getExperienceId());
        }
        
        return updateById(workExperience);
    }

    /**
     * 批量删除工作经历
     */
    @Override
    public Boolean deleteWorkExperienceByIds(List<Long> experienceIds) {
        return removeByIds(experienceIds);
    }

    /**
     * 删除设计师的所有工作经历
     */
    @Override
    public Boolean deleteWorkExperienceByDesignerId(Long designerId) {
        LambdaQueryWrapper<WorkExperience> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkExperience::getDesignerId, designerId);
        return remove(wrapper);
    }

    /**
     * 根据设计师ID批量逻辑删除工作经历
     */
    @Override
    public Boolean deleteByDesignerIds(List<Long> designerIds, Long currentUserId, Date currentTime) {
        if (designerIds == null || designerIds.isEmpty()) {
            return true;
        }
        
        LambdaUpdateWrapper<WorkExperience> wrapper = new LambdaUpdateWrapper<>();
        wrapper.in(WorkExperience::getDesignerId, designerIds)
                .set(WorkExperience::getDelFlag, "1")
                .set(WorkExperience::getDelTime, currentTime)
                .set(WorkExperience::getDelBy, currentUserId);
        
        return update(wrapper);
    }

    /**
     * 根据设计师ID批量恢复工作经历
     */
    @Override
    public Boolean restoreByDesignerIds(List<Long> designerIds) {
        if (designerIds == null || designerIds.isEmpty()) {
            return true;
        }
        
        LambdaUpdateWrapper<WorkExperience> wrapper = new LambdaUpdateWrapper<>();
        wrapper.in(WorkExperience::getDesignerId, designerIds)
                .set(WorkExperience::getDelFlag, "0")
                .set(WorkExperience::getDelTime, null)
                .set(WorkExperience::getDelBy, null);
        
        return update(wrapper);
    }

    /**
     * 更新当前工作经历状态
     * 将指定设计师的所有工作经历设置为非当前，除了指定的工作经历ID
     */
    private void updateCurrentWorkExperience(Long designerId, Long currentExperienceId) {
        LambdaQueryWrapper<WorkExperience> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(WorkExperience::getDesignerId, designerId)
                .eq(WorkExperience::getIsCurrent, true);
        
        if (currentExperienceId != null) {
            wrapper.ne(WorkExperience::getExperienceId, currentExperienceId);
        }
        
        List<WorkExperience> experiences = workExperienceMapper.selectList(wrapper);
        experiences.forEach(exp -> {
            exp.setIsCurrent(false);
            workExperienceMapper.updateById(exp);
        });
    }
} 