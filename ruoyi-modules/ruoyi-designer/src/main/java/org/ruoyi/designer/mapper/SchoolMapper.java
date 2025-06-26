package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Delete;
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

    /**
     * 查询院校学生列表
     *
     * @param schoolId 院校ID
     * @param status 学生状态
     * @param profession 专业
     * @param graduationYear 毕业年份
     * @return 学生列表
     */
    @Select("<script>" +
        "SELECT " +
            "d.designer_id, " +
            "d.designer_name, " +
            "d.profession, " +
            "d.work_status, " +
            "d.graduation_date, " +
            "d.join_date, " +
            "e.enterprise_name " +
        "FROM des_designer d " +
        "LEFT JOIN des_enterprise e ON d.enterprise_id = e.enterprise_id " +
        "WHERE d.school_id = #{schoolId} " +
            "AND d.status = '0' " +
            "<if test=\"status == &quot;current&quot;\"> " +
                "AND (d.graduation_date IS NULL OR d.graduation_date &gt; CURDATE()) " +
            "</if> " +
            "<if test=\"status == &quot;graduate&quot;\"> " +
                "AND d.graduation_date IS NOT NULL AND d.graduation_date &lt;= CURDATE() " +
            "</if> " +
            "<if test=\"profession != null and profession != &quot;&quot;\"> " +
                "AND d.profession LIKE CONCAT('%', #{profession}, '%') " +
            "</if> " +
            "<if test=\"graduationYear != null\"> " +
                "AND YEAR(d.graduation_date) = #{graduationYear} " +
            "</if> " +
        "ORDER BY d.create_time DESC " +
        "</script>")
    List<Map<String, Object>> getSchoolStudents(@Param("schoolId") Long schoolId, 
                                               @Param("status") String status, 
                                               @Param("profession") String profession, 
                                               @Param("graduationYear") Integer graduationYear);

    /**
     * 查询院校专业列表
     *
     * @param schoolId 院校ID
     * @return 专业列表
     */
    @Select("""
        SELECT 
            d.profession as majorName,
            COUNT(d.designer_id) as studentCount,
            COUNT(CASE WHEN d.graduation_date IS NOT NULL AND d.enterprise_id IS NOT NULL THEN 1 END) as employedCount,
            CASE 
                WHEN COUNT(CASE WHEN d.graduation_date IS NOT NULL THEN 1 END) = 0 THEN 0
                ELSE ROUND(COUNT(CASE WHEN d.graduation_date IS NOT NULL AND d.enterprise_id IS NOT NULL THEN 1 END) * 100.0 / COUNT(CASE WHEN d.graduation_date IS NOT NULL THEN 1 END), 2)
            END as employmentRate
        FROM des_designer d
        WHERE d.school_id = #{schoolId} 
            AND d.status = '0' 
            AND d.profession IS NOT NULL
        GROUP BY d.profession
        ORDER BY studentCount DESC
    """)
    List<Map<String, Object>> getSchoolMajors(@Param("schoolId") Long schoolId);

    /**
     * 查询院校获奖成果
     *
     * @param schoolId 院校ID
     * @return 获奖成果列表
     */
    @Select("""
        SELECT 
            a.title,
            a.organization,
            a.year,
            a.level,
            a.category,
            a.work_title,
            d.designer_name
        FROM des_award a
        INNER JOIN des_designer d ON a.designer_id = d.designer_id
        WHERE d.school_id = #{schoolId} 
            AND a.status = '0'
            AND d.status = '0'
        ORDER BY a.year DESC, a.level
    """)
    List<Map<String, Object>> getSchoolAchievements(@Param("schoolId") Long schoolId);

    /**
     * 收藏院校
     *
     * @param schoolId 院校ID
     * @param userId 用户ID
     * @return 结果
     */
    @Insert("""
        INSERT IGNORE INTO des_user_favorite (user_id, entity_id, entity_type, create_time)
        VALUES (#{userId}, #{schoolId}, 'SCHOOL', NOW())
    """)
    Boolean favoriteSchool(@Param("schoolId") Long schoolId, @Param("userId") Long userId);

    /**
     * 取消收藏院校
     *
     * @param schoolId 院校ID
     * @param userId 用户ID
     * @return 结果
     */
    @Delete("""
        DELETE FROM des_user_favorite 
        WHERE user_id = #{userId} AND entity_id = #{schoolId} AND entity_type = 'SCHOOL'
    """)
    Boolean unfavoriteSchool(@Param("schoolId") Long schoolId, @Param("userId") Long userId);

    /**
     * 获取用户收藏的院校列表
     *
     * @param userId 用户ID
     * @return 收藏院校列表
     */
    @Select("""
        SELECT s.*
        FROM des_school s
        INNER JOIN des_user_favorite f ON s.school_id = f.entity_id
        WHERE f.user_id = #{userId} 
            AND f.entity_type = 'SCHOOL'
            AND s.status = '0'
        ORDER BY f.create_time DESC
    """)
    List<School> getFavoriteSchools(@Param("userId") Long userId);
} 