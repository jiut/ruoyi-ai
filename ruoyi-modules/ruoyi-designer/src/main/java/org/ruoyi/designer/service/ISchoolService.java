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
} 