package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.ChartData;

/**
 * 就业图表数据Service接口
 *
 * @author ruoyi
 * @date 2024-12-28
 */
public interface IChartDataService extends IService<ChartData> {

    /**
     * 根据院校ID获取图表数据
     *
     * @param schoolId 院校ID
     * @return 图表数据
     */
    ChartData getBySchoolId(Long schoolId);

    /**
     * 保存或更新图表数据
     *
     * @param chartData 图表数据
     * @return 是否成功
     */
    Boolean saveOrUpdateChartData(ChartData chartData);

    /**
     * 根据院校ID删除图表数据
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);

    /**
     * 批量保存图表数据
     *
     * @param chartDataList 图表数据列表
     * @return 是否成功
     */
    Boolean saveBatchChartData(java.util.List<ChartData> chartDataList);
} 