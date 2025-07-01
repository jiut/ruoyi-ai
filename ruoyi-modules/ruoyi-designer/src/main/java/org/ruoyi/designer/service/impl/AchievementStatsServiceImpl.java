package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.AchievementStats;
import org.ruoyi.designer.mapper.AchievementStatsMapper;
import org.ruoyi.designer.service.IAchievementStatsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 学生成果统计Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class AchievementStatsServiceImpl extends ServiceImpl<AchievementStatsMapper, AchievementStats> implements IAchievementStatsService {

    private final AchievementStatsMapper baseMapper;

    /**
     * 根据院校ID获取成果统计
     */
    @Override
    public AchievementStats getBySchoolId(Long schoolId) {
        LambdaQueryWrapper<AchievementStats> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AchievementStats::getSchoolId, schoolId);
        return baseMapper.selectOne(queryWrapper);
    }

    /**
     * 保存或更新成果统计
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveOrUpdateAchievementStats(AchievementStats achievementStats) {
        if (achievementStats == null) {
            return false;
        }
        
        // 检查是否已存在
        AchievementStats existing = getBySchoolId(achievementStats.getSchoolId());
        if (existing != null) {
            achievementStats.setId(existing.getId());
        }
        
        return saveOrUpdate(achievementStats);
    }

    /**
     * 根据院校ID删除成果统计
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<AchievementStats> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AchievementStats::getSchoolId, schoolId);
        return remove(queryWrapper);
    }

    /**
     * 批量保存成果统计
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveBatchAchievementStats(java.util.List<AchievementStats> achievementStatsList) {
        return saveBatch(achievementStatsList);
    }
} 