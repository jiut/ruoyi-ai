package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.EmploymentStats;
import org.ruoyi.designer.mapper.EmploymentStatsMapper;
import org.ruoyi.designer.service.IEmploymentStatsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 就业统计Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class EmploymentStatsServiceImpl extends ServiceImpl<EmploymentStatsMapper, EmploymentStats> implements IEmploymentStatsService {

    private final EmploymentStatsMapper baseMapper;

    /**
     * 根据院校ID获取就业统计
     */
    @Override
    public EmploymentStats getBySchoolId(Long schoolId) {
        LambdaQueryWrapper<EmploymentStats> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(EmploymentStats::getSchoolId, schoolId);
        return baseMapper.selectOne(queryWrapper);
    }

    /**
     * 保存或更新就业统计
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveOrUpdateEmploymentStats(EmploymentStats employmentStats) {
        if (employmentStats == null) {
            return false;
        }
        
        // 检查是否已存在
        EmploymentStats existing = getBySchoolId(employmentStats.getSchoolId());
        if (existing != null) {
            employmentStats.setId(existing.getId());
        }
        
        return saveOrUpdate(employmentStats);
    }

    /**
     * 根据院校ID删除就业统计
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<EmploymentStats> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(EmploymentStats::getSchoolId, schoolId);
        return remove(queryWrapper);
    }

    /**
     * 批量保存就业统计
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveBatchEmploymentStats(java.util.List<EmploymentStats> employmentStatsList) {
        return saveBatch(employmentStatsList);
    }
} 