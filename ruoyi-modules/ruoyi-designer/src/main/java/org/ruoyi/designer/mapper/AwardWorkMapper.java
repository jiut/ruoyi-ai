package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.AwardWork;

import java.util.List;

/**
 * 获奖作品Mapper接口
 *
 * @author ruoyi
 */
public interface AwardWorkMapper extends BaseMapper<AwardWork> {

    /**
     * 根据院校ID查询获奖作品列表
     *
     * @param schoolId 院校ID
     * @return 获奖作品列表
     */
    @Select("""
        SELECT id, school_id, title, award, description,
               create_by, create_time, update_by, update_time
        FROM des_school_award_work 
        WHERE school_id = #{schoolId}
        ORDER BY create_time ASC
    """)
    List<AwardWork> selectBySchoolId(@Param("schoolId") Long schoolId);

    /**
     * 批量插入获奖作品
     *
     * @param awardWorks 获奖作品列表
     * @return 影响行数
     */
    int insertBatch(@Param("awardWorks") List<AwardWork> awardWorks);
} 