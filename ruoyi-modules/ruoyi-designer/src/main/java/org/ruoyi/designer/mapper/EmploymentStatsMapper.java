package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.EmploymentStats;

/**
 * 就业统计Mapper接口
 *
 * @author ruoyi
 */
public interface EmploymentStatsMapper extends BaseMapper<EmploymentStats> {

    /**
     * 根据院校ID查询就业统计
     *
     * @param schoolId 院校ID
     * @return 就业统计
     */
    @Select("""
        SELECT id, school_id, employment_rate, average_salary, 
               further_study_rate, overseas_employment_rate, description,
               create_by, create_time, update_by, update_time
        FROM des_school_employment_stats 
        WHERE school_id = #{schoolId}
    """)
    EmploymentStats selectBySchoolId(@Param("schoolId") Long schoolId);
} 