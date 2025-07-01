package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.TrendData;

/**
 * 获奖趋势数据Service接口
 *
 * @author ruoyi
 * @date 2024-12-28
 */
public interface ITrendDataService extends IService<TrendData> {

    /**
     * 根据院校ID获取获奖趋势数据
     *
     * @param schoolId 院校ID
     * @return 获奖趋势数据
     */
    TrendData getBySchoolId(Long schoolId);

    /**
     * 保存或更新获奖趋势数据
     *
     * @param trendData 获奖趋势数据
     * @return 是否成功
     */
    Boolean saveOrUpdateTrendData(TrendData trendData);

    /**
     * 根据院校ID删除获奖趋势数据
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);

    /**
     * 批量保存获奖趋势数据
     *
     * @param trendDataList 获奖趋势数据列表
     * @return 是否成功
     */
    Boolean saveBatchTrendData(java.util.List<TrendData> trendDataList);
} 