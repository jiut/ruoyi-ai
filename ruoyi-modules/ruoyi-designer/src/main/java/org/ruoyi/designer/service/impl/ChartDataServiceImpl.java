package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.ChartData;
import org.ruoyi.designer.mapper.ChartDataMapper;
import org.ruoyi.designer.service.IChartDataService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 就业图表数据Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class ChartDataServiceImpl extends ServiceImpl<ChartDataMapper, ChartData> implements IChartDataService {

    private final ChartDataMapper baseMapper;

    /**
     * 根据院校ID获取图表数据
     */
    @Override
    public ChartData getBySchoolId(Long schoolId) {
        LambdaQueryWrapper<ChartData> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ChartData::getSchoolId, schoolId);
        return baseMapper.selectOne(queryWrapper);
    }

    /**
     * 保存或更新图表数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveOrUpdateChartData(ChartData chartData) {
        if (chartData == null) {
            return false;
        }
        
        // 检查是否已存在
        ChartData existing = getBySchoolId(chartData.getSchoolId());
        if (existing != null) {
            chartData.setId(existing.getId());
        }
        
        return saveOrUpdate(chartData);
    }

    /**
     * 根据院校ID删除图表数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<ChartData> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(ChartData::getSchoolId, schoolId);
        return remove(queryWrapper);
    }

    /**
     * 批量保存图表数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveBatchChartData(java.util.List<ChartData> chartDataList) {
        return saveBatch(chartDataList);
    }
} 