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


} 