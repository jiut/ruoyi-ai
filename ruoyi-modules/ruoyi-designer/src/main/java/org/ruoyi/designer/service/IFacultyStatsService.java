package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.FacultyStats;

/**
 * 师资统计Service接口
 *
 * @author ruoyi
 */
public interface IFacultyStatsService extends IService<FacultyStats> {

    /**
     * 根据院校ID获取师资统计
     *
     * @param schoolId 院校ID
     * @return 师资统计
     */
    FacultyStats getFacultyStatsBySchoolId(Long schoolId);

    /**
     * 保存或更新师资统计
     *
     * @param facultyStats 师资统计
     * @return 是否成功
     */
    Boolean saveOrUpdateFacultyStats(FacultyStats facultyStats);

    /**
     * 根据院校ID删除师资统计
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);
} 