package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.SchoolCardStats;

/**
 * 卡片统计数据Service接口
 *
 * @author ruoyi
 * @date 2024-12-28
 */
public interface ISchoolCardStatsService extends IService<SchoolCardStats> {

    /**
     * 根据院校ID获取卡片统计数据
     *
     * @param schoolId 院校ID
     * @return 卡片统计数据
     */
    SchoolCardStats getBySchoolId(Long schoolId);

    /**
     * 保存或更新卡片统计数据
     *
     * @param cardStats 卡片统计数据
     * @return 是否成功
     */
    Boolean saveOrUpdateCardStats(SchoolCardStats cardStats);

    /**
     * 根据院校ID删除卡片统计数据
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);

    /**
     * 批量保存卡片统计数据
     *
     * @param cardStatsList 卡片统计数据列表
     * @return 是否成功
     */
    Boolean saveBatchCardStats(java.util.List<SchoolCardStats> cardStatsList);
} 