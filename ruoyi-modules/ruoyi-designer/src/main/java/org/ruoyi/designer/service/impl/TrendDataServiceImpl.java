package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.TrendData;
import org.ruoyi.designer.mapper.TrendDataMapper;
import org.ruoyi.designer.service.ITrendDataService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 获奖趋势数据Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class TrendDataServiceImpl extends ServiceImpl<TrendDataMapper, TrendData> implements ITrendDataService {

    private final TrendDataMapper baseMapper;

    /**
     * 根据院校ID获取获奖趋势数据
     */
    @Override
    public TrendData getBySchoolId(Long schoolId) {
        LambdaQueryWrapper<TrendData> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(TrendData::getSchoolId, schoolId);
        return baseMapper.selectOne(queryWrapper);
    }

    /**
     * 保存或更新获奖趋势数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveOrUpdateTrendData(TrendData trendData) {
        if (trendData == null) {
            return false;
        }
        
        // 检查是否已存在
        TrendData existing = getBySchoolId(trendData.getSchoolId());
        if (existing != null) {
            trendData.setId(existing.getId());
        }
        
        return saveOrUpdate(trendData);
    }

    /**
     * 根据院校ID删除获奖趋势数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<TrendData> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(TrendData::getSchoolId, schoolId);
        return remove(queryWrapper);
    }

    /**
     * 批量保存获奖趋势数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveBatchTrendData(java.util.List<TrendData> trendDataList) {
        return saveBatch(trendDataList);
    }
} 