package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.School;

import java.util.List;
import java.util.Map;

/**
 * 院校Service接口
 *
 * @author ruoyi
 */
public interface ISchoolService extends IService<School> {

    /**
     * 查询院校列表
     *
     * @param school 院校
     * @param pageQuery 分页参数
     * @return 院校集合
     */
    TableDataInfo<School> selectSchoolList(School school, PageQuery pageQuery);

    /**
     * 根据院校ID查询特定院校列表（用于院校管理员权限控制）
     *
     * @param schoolId 院校ID
     * @param school 院校查询条件
     * @param pageQuery 分页参数
     * @return 院校集合
     */
    TableDataInfo<School> selectSchoolListBySchoolId(Long schoolId, School school, PageQuery pageQuery);

    /**
     * 根据院校ID查询院校信息
     *
     * @param schoolId 院校ID
     * @return 院校信息
     */
    School selectSchoolById(Long schoolId);

    /**
     * 根据用户ID查询院校
     *
     * @param userId 用户ID
     * @return 院校信息
     */
    School selectSchoolByUserId(Long userId);

    /**
     * 新增院校
     *
     * @param school 院校
     * @return 结果
     */
    Boolean insertSchool(School school);

    /**
     * 修改院校
     *
     * @param school 院校
     * @return 结果
     */
    Boolean updateSchool(School school);

    /**
     * 批量删除院校
     *
     * @param schoolIds 需要删除的院校ID
     * @return 结果
     */
    Boolean deleteSchoolByIds(List<Long> schoolIds);

    /**
     * 获取院校毕业生就业统计数据
     *
     * @param schoolId 院校ID
     * @return 就业统计数据
     */
    Map<String, Object> getEmploymentStatistics(Long schoolId);

    /**
     * 获取院校毕业生就业企业分布
     *
     * @param schoolId 院校ID
     * @return 企业分布数据
     */
    List<Map<String, Object>> getEmploymentDistribution(Long schoolId);

    /**
     * 根据院校名称查询院校是否存在
     *
     * @param schoolName 院校名称
     * @return 是否存在
     */
    boolean existsBySchoolName(String schoolName);

    /**
     * 查询院校学生列表
     *
     * @param schoolId 院校ID
     * @param status 学生状态（current-在校, graduate-毕业）
     * @param profession 专业
     * @param graduationYear 毕业年份
     * @param pageQuery 分页参数
     * @return 学生列表
     */
    TableDataInfo<Map<String, Object>> getSchoolStudents(Long schoolId, String status, String profession, Integer graduationYear, PageQuery pageQuery);

    /**
     * 查询院校专业列表
     *
     * @param schoolId 院校ID
     * @return 专业列表
     */
    List<Map<String, Object>> getSchoolMajors(Long schoolId);

    /**
     * 查询院校获奖成果
     *
     * @param schoolId 院校ID
     * @return 获奖成果列表
     */
    List<Map<String, Object>> getSchoolAchievements(Long schoolId);

    /**
     * 收藏院校
     *
     * @param schoolId 院校ID
     * @param userId 用户ID
     * @return 结果
     */
    Boolean favoriteSchool(Long schoolId, Long userId);

    /**
     * 取消收藏院校
     *
     * @param schoolId 院校ID
     * @param userId 用户ID
     * @return 结果
     */
    Boolean unfavoriteSchool(Long schoolId, Long userId);

    /**
     * 获取用户收藏的院校列表
     *
     * @param userId 用户ID
     * @return 收藏院校列表
     */
    List<School> getFavoriteSchools(Long userId);

    // =================== Mock数据API扩展方法 ===================

    /**
     * 获取院校专业分类
     *
     * @param schoolId 院校ID
     * @return 专业分类列表
     */
    List<org.ruoyi.designer.domain.MajorCategory> getMajorCategories(Long schoolId);

    /**
     * 获取院校课程体系
     *
     * @param schoolId 院校ID
     * @return 课程体系列表
     */
    List<org.ruoyi.designer.domain.CourseGroup> getCourseSystem(Long schoolId);

    /**
     * 获取院校师资统计
     *
     * @param schoolId 院校ID
     * @return 师资统计
     */
    org.ruoyi.designer.domain.FacultyStats getFacultyStats(Long schoolId);

    /**
     * 获取院校代表性教师
     *
     * @param schoolId 院校ID
     * @return 代表性教师列表
     */
    List<org.ruoyi.designer.domain.Teacher> getFacultyMembers(Long schoolId);

    /**
     * 获取院校就业统计
     *
     * @param schoolId 院校ID
     * @return 就业统计
     */
    org.ruoyi.designer.domain.EmploymentStats getSchoolEmploymentStats(Long schoolId);

    /**
     * 获取院校代表性雇主
     *
     * @param schoolId 院校ID
     * @return 代表性雇主列表
     */
    List<org.ruoyi.designer.domain.Employer> getEmployers(Long schoolId);

    /**
     * 获取院校就业图表数据
     *
     * @param schoolId 院校ID
     * @return 就业图表数据
     */
    org.ruoyi.designer.domain.ChartData getEmploymentCharts(Long schoolId);

    /**
     * 获取院校学生成果统计
     *
     * @param schoolId 院校ID
     * @return 学生成果统计
     */
    org.ruoyi.designer.domain.AchievementStats getAchievementStats(Long schoolId);

    /**
     * 获取院校获奖趋势数据
     *
     * @param schoolId 院校ID
     * @return 获奖趋势数据
     */
    org.ruoyi.designer.domain.TrendData getAwardTrends(Long schoolId);

    /**
     * 获取院校获奖作品
     *
     * @param schoolId 院校ID
     * @return 获奖作品列表
     */
    List<org.ruoyi.designer.domain.AwardWork> getAwardWorks(Long schoolId);

    /**
     * 获取院校卡片统计数据
     *
     * @param schoolId 院校ID
     * @return 卡片统计数据
     */
    org.ruoyi.designer.domain.SchoolCardStats getCardStats(Long schoolId);

    /**
     * 获取院校完整信息
     *
     * @param schoolId 院校ID
     * @return 院校完整信息
     */
    org.ruoyi.designer.domain.vo.SchoolFullInfoVo getSchoolFullInfo(Long schoolId);

    // =================== 格式化数据方法 ===================

    /**
     * 获取格式化的就业率
     *
     * @param schoolId 院校ID
     * @return 格式化的就业率
     */
    String getFormattedEmploymentRate(Long schoolId);

    /**
     * 获取格式化的师资力量评分
     *
     * @param schoolId 院校ID
     * @return 格式化的师资力量评分
     */
    String getFormattedFacultyStrength(Long schoolId);

    /**
     * 获取格式化的学生评分
     *
     * @param schoolId 院校ID
     * @return 格式化的学生评分
     */
    String getFormattedStudentScore(Long schoolId);

    /**
     * 获取格式化的优势专业
     *
     * @param school 院校信息
     * @return 格式化的优势专业
     */
    String getFormattedAdvantagePrograms(School school);

    // =================== 扩展查询方法 ===================

    /**
     * 根据筛选条件查询院校列表（支持新字段筛选）
     *
     * @param school 院校基础条件
     * @param province 省份
     * @param city 城市
     * @param schoolType 院校类型
     * @param level 办学层次
     * @param isKey 是否重点院校
     * @param is985 是否985院校
     * @param is211 是否211院校
     * @param isDoubleFirst 是否双一流院校
     * @param pageQuery 分页参数
     * @return 院校列表
     */
    TableDataInfo<School> selectSchoolListWithFilters(
        School school,
        String province,
        String city,
        String schoolType,
        String level,
        Boolean isKey,
        Boolean is985,
        Boolean is211,
        Boolean isDoubleFirst,
        PageQuery pageQuery
    );

} 