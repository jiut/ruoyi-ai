package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.AchievementStats;

/**
 * 学生成果统计Service接口
 *
 * @author ruoyi
 * @date 2024-12-28
 */
public interface IAchievementStatsService extends IService<AchievementStats> {

    /**
     * 根据院校ID获取成果统计
     *
     * @param schoolId 院校ID
     * @return 成果统计信息
     */
    AchievementStats getBySchoolId(Long schoolId);

    /**
     * 保存或更新成果统计
     *
     * @param achievementStats 成果统计信息
     * @return 是否成功
     */
    Boolean saveOrUpdateAchievementStats(AchievementStats achievementStats);

    /**
     * 根据院校ID删除成果统计
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);

    /**
     * 批量保存成果统计
     *
     * @param achievementStatsList 成果统计列表
     * @return 是否成功
     */
    Boolean saveBatchAchievementStats(java.util.List<AchievementStats> achievementStatsList);
} 