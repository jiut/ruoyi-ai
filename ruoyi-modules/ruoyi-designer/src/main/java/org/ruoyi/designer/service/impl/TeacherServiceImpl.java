package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.Teacher;
import org.ruoyi.designer.mapper.TeacherMapper;
import org.ruoyi.designer.service.ITeacherService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 代表性教师Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class TeacherServiceImpl extends ServiceImpl<TeacherMapper, Teacher> implements ITeacherService {

    private final TeacherMapper baseMapper;

    /**
     * 根据院校ID获取代表性教师列表
     */
    @Override
    public List<Teacher> getTeachersBySchoolId(Long schoolId) {
        return baseMapper.selectBySchoolId(schoolId);
    }

    /**
     * 批量保存教师信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveTeachers(Long schoolId, List<Teacher> teachers) {
        if (teachers == null || teachers.isEmpty()) {
            return true;
        }
        
        // 删除原有数据
        LambdaQueryWrapper<Teacher> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Teacher::getSchoolId, schoolId);
        baseMapper.delete(queryWrapper);
        
        // 设置院校ID并批量插入
        teachers.forEach(teacher -> teacher.setSchoolId(schoolId));
        return saveBatch(teachers);
    }

    /**
     * 根据院校ID删除教师信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<Teacher> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Teacher::getSchoolId, schoolId);
        return remove(queryWrapper);
    }

    /**
     * 根据职称查询教师（内部方法）
     */
    public List<Teacher> getByTitle(String title) {
        LambdaQueryWrapper<Teacher> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Teacher::getTitle, title);
        return baseMapper.selectList(queryWrapper);
    }
} 