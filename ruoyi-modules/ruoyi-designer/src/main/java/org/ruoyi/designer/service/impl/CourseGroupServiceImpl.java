package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.CourseGroup;
import org.ruoyi.designer.mapper.CourseGroupMapper;
import org.ruoyi.designer.service.ICourseGroupService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 课程体系Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class CourseGroupServiceImpl extends ServiceImpl<CourseGroupMapper, CourseGroup> implements ICourseGroupService {

    private final CourseGroupMapper baseMapper;

    /**
     * 根据院校ID获取课程体系列表
     */
    @Override
    public List<CourseGroup> getCourseGroupsBySchoolId(Long schoolId) {
        return baseMapper.selectBySchoolId(schoolId);
    }

    /**
     * 批量保存课程体系
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveCourseGroups(Long schoolId, List<CourseGroup> courseGroups) {
        if (courseGroups == null || courseGroups.isEmpty()) {
            return true;
        }
        
        // 删除原有数据
        LambdaQueryWrapper<CourseGroup> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(CourseGroup::getSchoolId, schoolId);
        baseMapper.delete(queryWrapper);
        
        // 设置院校ID并批量插入
        courseGroups.forEach(group -> group.setSchoolId(schoolId));
        return saveBatch(courseGroups);
    }

    /**
     * 根据院校ID删除课程体系
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<CourseGroup> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(CourseGroup::getSchoolId, schoolId);
        return remove(queryWrapper);
    }
} 