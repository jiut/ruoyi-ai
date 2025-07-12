package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.Education;
import org.ruoyi.designer.mapper.EducationMapper;
import org.ruoyi.designer.service.IEducationService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Date;

/**
 * 教育背景Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class EducationServiceImpl extends ServiceImpl<EducationMapper, Education> implements IEducationService {

    private final EducationMapper educationMapper;

    /**
     * 查询教育背景列表
     */
    @Override
    public TableDataInfo<Education> selectEducationList(Education education) {
        LambdaQueryWrapper<Education> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(education.getSchool()), Education::getSchool, education.getSchool())
                .like(StringUtils.isNotBlank(education.getDegree()), Education::getDegree, education.getDegree())
                .like(StringUtils.isNotBlank(education.getMajor()), Education::getMajor, education.getMajor())
                .eq(education.getDesignerId() != null, Education::getDesignerId, education.getDesignerId())
                .eq(education.getIsCurrent() != null, Education::getIsCurrent, education.getIsCurrent())
                .eq(StringUtils.isNotBlank(education.getStatus()), Education::getStatus, education.getStatus())
                .orderByDesc(Education::getStartDate)
                .orderByDesc(Education::getCreateTime);
        
        PageQuery pageQuery = new PageQuery(20, 1);
        Page<Education> page = educationMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    /**
     * 根据教育背景ID查询教育背景信息
     */
    @Override
    public Education selectEducationById(Long educationId) {
        return educationMapper.selectById(educationId);
    }

    /**
     * 根据设计师ID查询教育背景列表
     */
    @Override
    public List<Education> selectEducationByDesignerId(Long designerId) {
        LambdaQueryWrapper<Education> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Education::getDesignerId, designerId)
                .eq(Education::getStatus, "0")
                .orderByDesc(Education::getStartDate);
        return educationMapper.selectList(wrapper);
    }

    /**
     * 新增教育背景
     */
    @Override
    public Boolean insertEducation(Education education) {
        return save(education);
    }

    /**
     * 修改教育背景
     */
    @Override
    public Boolean updateEducation(Education education) {
        return updateById(education);
    }

    /**
     * 批量删除教育背景
     */
    @Override
    public Boolean deleteEducationByIds(List<Long> educationIds) {
        return removeByIds(educationIds);
    }

    /**
     * 删除设计师的所有教育背景
     */
    @Override
    public Boolean deleteEducationByDesignerId(Long designerId) {
        LambdaQueryWrapper<Education> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Education::getDesignerId, designerId);
        return remove(wrapper);
    }

    /**
     * 根据设计师ID批量逻辑删除教育背景
     */
    @Override
    public Boolean deleteByDesignerIds(List<Long> designerIds, Long currentUserId, Date currentTime) {
        if (designerIds == null || designerIds.isEmpty()) {
            return true;
        }
        
        LambdaUpdateWrapper<Education> wrapper = new LambdaUpdateWrapper<>();
        wrapper.in(Education::getDesignerId, designerIds)
                .set(Education::getDelFlag, "1")
                .set(Education::getDelTime, currentTime)
                .set(Education::getDelBy, currentUserId);
        
        return update(wrapper);
    }

    /**
     * 根据设计师ID批量恢复教育背景
     */
    @Override
    public Boolean restoreByDesignerIds(List<Long> designerIds) {
        if (designerIds == null || designerIds.isEmpty()) {
            return true;
        }
        
        LambdaUpdateWrapper<Education> wrapper = new LambdaUpdateWrapper<>();
        wrapper.in(Education::getDesignerId, designerIds)
                .set(Education::getDelFlag, "0")
                .set(Education::getDelTime, null)
                .set(Education::getDelBy, null);
        
        return update(wrapper);
    }

    /**
     * 逻辑删除教育背景
     */
    @Override
    public Boolean logicDeleteEducationById(Long educationId, Long currentUserId, Date currentTime) {
        if (educationId == null) {
            return false;
        }
        
        LambdaUpdateWrapper<Education> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(Education::getEducationId, educationId)
                .set(Education::getDelFlag, "1")
                .set(Education::getDelTime, currentTime)
                .set(Education::getDelBy, currentUserId);
        
        return update(wrapper);
    }
} 