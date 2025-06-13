package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.School;

import java.util.List;
import java.util.Map;

/**
 * 院校Mapper接口
 *
 * @author ruoyi
 */
public interface SchoolMapper extends BaseMapper<School> {

    /**
     * 查询院校毕业生就业统计数据
     *
     * @param schoolId 院校ID
     * @return 就业统计数据
     */
    @Select("""
        SELECT 
            COUNT(d.designer_id) as totalGraduates,
            COUNT(CASE WHEN d.enterprise_id IS NOT NULL THEN 1 END) as employedCount,
            COUNT(CASE WHEN d.enterprise_id IS NULL THEN 1 END) as independentCount,
            AVG(CASE WHEN d.work_years IS NOT NULL THEN d.work_years ELSE 0 END) as avgWorkYears
        FROM des_designer d 
        WHERE d.school_id = #{schoolId} 
            AND d.graduation_date IS NOT NULL 
            AND d.status = '0'
    """)
    Map<String, Object> getEmploymentStatistics(@Param("schoolId") Long schoolId);

    /**
     * 查询院校毕业生就业企业分布
     *
     * @param schoolId 院校ID
     * @return 企业分布数据
     */
    @Select("""
        SELECT 
            e.enterprise_name,
            COUNT(d.designer_id) as designerCount
        FROM des_designer d
        INNER JOIN des_enterprise e ON d.enterprise_id = e.enterprise_id
        WHERE d.school_id = #{schoolId} 
            AND d.graduation_date IS NOT NULL 
            AND d.status = '0'
            AND e.status = '0'
        GROUP BY e.enterprise_id, e.enterprise_name
        ORDER BY designerCount DESC
    """)
    List<Map<String, Object>> getEmploymentDistribution(@Param("schoolId") Long schoolId);
} 