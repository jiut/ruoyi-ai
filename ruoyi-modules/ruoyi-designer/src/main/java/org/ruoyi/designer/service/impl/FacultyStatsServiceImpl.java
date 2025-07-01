package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.FacultyStats;
import org.ruoyi.designer.mapper.FacultyStatsMapper;
import org.ruoyi.designer.service.IFacultyStatsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 师资统计Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class FacultyStatsServiceImpl extends ServiceImpl<FacultyStatsMapper, FacultyStats> implements IFacultyStatsService {

    private final FacultyStatsMapper baseMapper;

    /**
     * 根据院校ID获取师资统计
     */
    @Override
    public FacultyStats getFacultyStatsBySchoolId(Long schoolId) {
        LambdaQueryWrapper<FacultyStats> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(FacultyStats::getSchoolId, schoolId);
        return baseMapper.selectOne(queryWrapper);
    }

    /**
     * 根据院校ID获取师资统计（内部方法）
     */
    public FacultyStats getBySchoolId(Long schoolId) {
        return getFacultyStatsBySchoolId(schoolId);
    }

    /**
     * 保存或更新师资统计
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveOrUpdateFacultyStats(FacultyStats facultyStats) {
        if (facultyStats == null) {
            return false;
        }
        
        // 检查是否已存在
        FacultyStats existing = getBySchoolId(facultyStats.getSchoolId());
        if (existing != null) {
            facultyStats.setId(existing.getId());
        }
        
        return saveOrUpdate(facultyStats);
    }

    /**
     * 根据院校ID删除师资统计
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<FacultyStats> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(FacultyStats::getSchoolId, schoolId);
        return remove(queryWrapper);
    }

    /**
     * 批量保存师资统计（内部方法）
     */
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveBatchFacultyStats(java.util.List<FacultyStats> facultyStatsList) {
        return saveBatch(facultyStatsList);
    }
} 