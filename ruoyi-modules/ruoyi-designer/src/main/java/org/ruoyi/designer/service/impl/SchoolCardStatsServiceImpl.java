package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.SchoolCardStats;
import org.ruoyi.designer.mapper.SchoolCardStatsMapper;
import org.ruoyi.designer.service.ISchoolCardStatsService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 卡片统计数据Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class SchoolCardStatsServiceImpl extends ServiceImpl<SchoolCardStatsMapper, SchoolCardStats> implements ISchoolCardStatsService {

    private final SchoolCardStatsMapper baseMapper;

    /**
     * 根据院校ID获取卡片统计数据
     */
    @Override
    public SchoolCardStats getBySchoolId(Long schoolId) {
        LambdaQueryWrapper<SchoolCardStats> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(SchoolCardStats::getSchoolId, schoolId);
        return baseMapper.selectOne(queryWrapper);
    }

    /**
     * 保存或更新卡片统计数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveOrUpdateCardStats(SchoolCardStats cardStats) {
        if (cardStats == null) {
            return false;
        }
        
        // 检查是否已存在
        SchoolCardStats existing = getBySchoolId(cardStats.getSchoolId());
        if (existing != null) {
            cardStats.setId(existing.getId());
        }
        
        return saveOrUpdate(cardStats);
    }

    /**
     * 根据院校ID删除卡片统计数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<SchoolCardStats> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(SchoolCardStats::getSchoolId, schoolId);
        return remove(queryWrapper);
    }

    /**
     * 批量保存卡片统计数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveBatchCardStats(java.util.List<SchoolCardStats> cardStatsList) {
        return saveBatch(cardStatsList);
    }
} 