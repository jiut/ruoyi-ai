package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.EmploymentStats;

/**
 * 就业统计Service接口
 *
 * @author ruoyi
 * @date 2024-12-28
 */
public interface IEmploymentStatsService extends IService<EmploymentStats> {

    /**
     * 根据院校ID获取就业统计
     *
     * @param schoolId 院校ID
     * @return 就业统计信息
     */
    EmploymentStats getBySchoolId(Long schoolId);

    /**
     * 保存或更新就业统计
     *
     * @param employmentStats 就业统计信息
     * @return 是否成功
     */
    Boolean saveOrUpdateEmploymentStats(EmploymentStats employmentStats);

    /**
     * 根据院校ID删除就业统计
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);

    /**
     * 批量保存就业统计
     *
     * @param employmentStatsList 就业统计列表
     * @return 是否成功
     */
    Boolean saveBatchEmploymentStats(java.util.List<EmploymentStats> employmentStatsList);
} 