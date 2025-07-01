package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.FacultyStats;

/**
 * 师资统计Mapper接口
 *
 * @author ruoyi
 */
public interface FacultyStatsMapper extends BaseMapper<FacultyStats> {

    /**
     * 根据院校ID查询师资统计
     *
     * @param schoolId 院校ID
     * @return 师资统计
     */
    @Select("""
        SELECT id, school_id, total_faculty, professors, doctor_degree, 
               overseas_background, description,
               create_by, create_time, update_by, update_time
        FROM des_school_faculty_stats 
        WHERE school_id = #{schoolId}
    """)
    FacultyStats selectBySchoolId(@Param("schoolId") Long schoolId);
} 