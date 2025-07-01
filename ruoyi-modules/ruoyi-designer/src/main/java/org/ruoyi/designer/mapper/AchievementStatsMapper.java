package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.AchievementStats;

/**
 * 成果统计Mapper接口
 *
 * @author ruoyi
 */
public interface AchievementStatsMapper extends BaseMapper<AchievementStats> {

    /**
     * 根据院校ID查询成果统计
     *
     * @param schoolId 院校ID
     * @return 成果统计
     */
    @Select("""
        SELECT id, school_id, international_awards, national_awards, 
               provincial_awards, patents, description,
               create_by, create_time, update_by, update_time
        FROM des_school_achievement_stats 
        WHERE school_id = #{schoolId}
    """)
    AchievementStats selectBySchoolId(@Param("schoolId") Long schoolId);
} 