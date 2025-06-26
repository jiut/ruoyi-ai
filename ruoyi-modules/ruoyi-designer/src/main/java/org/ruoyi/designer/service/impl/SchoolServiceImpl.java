package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.School;
import org.ruoyi.designer.mapper.SchoolMapper;
import org.ruoyi.designer.service.ISchoolService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.ArrayList;
import java.time.LocalDate;

/**
 * 院校Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class SchoolServiceImpl extends ServiceImpl<SchoolMapper, School> implements ISchoolService {

    private final SchoolMapper schoolMapper;

    /**
     * 查询院校列表
     */
    @Override
    public TableDataInfo<School> selectSchoolList(School school, PageQuery pageQuery) {
        LambdaQueryWrapper<School> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(school.getSchoolName()), School::getSchoolName, school.getSchoolName())
                .eq(StringUtils.isNotBlank(school.getSchoolType()), School::getSchoolType, school.getSchoolType())
                .eq(StringUtils.isNotBlank(school.getLevel()), School::getLevel, school.getLevel())
                .eq(StringUtils.isNotBlank(school.getStatus()), School::getStatus, school.getStatus())
                .orderByDesc(School::getCreateTime);
        
        Page<School> page = schoolMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    /**
     * 根据院校ID查询特定院校列表（用于院校管理员权限控制）
     */
    @Override
    public TableDataInfo<School> selectSchoolListBySchoolId(Long schoolId, School school, PageQuery pageQuery) {
        LambdaQueryWrapper<School> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(School::getSchoolId, schoolId)
                .like(StringUtils.isNotBlank(school.getSchoolName()), School::getSchoolName, school.getSchoolName())
                .eq(StringUtils.isNotBlank(school.getSchoolType()), School::getSchoolType, school.getSchoolType())
                .eq(StringUtils.isNotBlank(school.getLevel()), School::getLevel, school.getLevel())
                .eq(StringUtils.isNotBlank(school.getStatus()), School::getStatus, school.getStatus())
                .orderByDesc(School::getCreateTime);
        
        Page<School> page = schoolMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    /**
     * 根据院校ID查询院校信息
     */
    @Override
    public School selectSchoolById(Long schoolId) {
        return schoolMapper.selectById(schoolId);
    }

    /**
     * 新增院校
     */
    @Override
    public Boolean insertSchool(School school) {
        return save(school);
    }

    /**
     * 修改院校
     */
    @Override
    public Boolean updateSchool(School school) {
        return updateById(school);
    }

    /**
     * 批量删除院校
     */
    @Override
    public Boolean deleteSchoolByIds(List<Long> schoolIds) {
        return removeByIds(schoolIds);
    }

    @Override
    public School selectSchoolByUserId(Long userId) {
        LambdaQueryWrapper<School> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(School::getUserId, userId)
                .eq(School::getStatus, "0");
        return schoolMapper.selectOne(wrapper);
    }

    /**
     * 获取院校毕业生就业统计数据
     */
    @Override
    public Map<String, Object> getEmploymentStatistics(Long schoolId) {
        return schoolMapper.getEmploymentStatistics(schoolId);
    }

    /**
     * 获取院校毕业生就业企业分布
     */
    @Override
    public List<Map<String, Object>> getEmploymentDistribution(Long schoolId) {
        return schoolMapper.getEmploymentDistribution(schoolId);
    }

    @Override
    public boolean existsBySchoolName(String schoolName) {
        LambdaQueryWrapper<School> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(School::getSchoolName, schoolName)
                .eq(School::getStatus, "0");
        return schoolMapper.selectCount(wrapper) > 0;
    }

    /**
     * 查询院校学生列表
     */
    @Override
    public TableDataInfo<Map<String, Object>> getSchoolStudents(Long schoolId, String status, String profession, Integer graduationYear, PageQuery pageQuery) {
        // 由于 Mapper 方法使用动态 SQL，我们需要手动处理分页
        List<Map<String, Object>> allData = schoolMapper.getSchoolStudents(schoolId, status, profession, graduationYear);
        
        // 手动创建分页结果
        // 注意：这种方式不是最优的，因为它会查询所有数据然后在内存中分页
        // 更好的方式是在 Mapper 中使用 MyBatis-Plus 的分页插件
        int total = allData.size();
        int pageNum = pageQuery.getPageNum();
        int pageSize = pageQuery.getPageSize();
        int startIndex = (pageNum - 1) * pageSize;
        int endIndex = Math.min(startIndex + pageSize, total);
        
        List<Map<String, Object>> pageData = allData.subList(startIndex, endIndex);
        
        TableDataInfo<Map<String, Object>> result = new TableDataInfo<>();
        result.setRows(pageData);
        result.setTotal(total);
        result.setCode(200);
        result.setMsg("查询成功");
        
        return result;
    }

    /**
     * 查询院校专业列表
     */
    @Override
    public List<Map<String, Object>> getSchoolMajors(Long schoolId) {
        return schoolMapper.getSchoolMajors(schoolId);
    }

    /**
     * 查询院校获奖成果
     */
    @Override
    public List<Map<String, Object>> getSchoolAchievements(Long schoolId) {
        return schoolMapper.getSchoolAchievements(schoolId);
    }

    /**
     * 收藏院校
     */
    @Override
    public Boolean favoriteSchool(Long schoolId, Long userId) {
        return schoolMapper.favoriteSchool(schoolId, userId);
    }

    /**
     * 取消收藏院校
     */
    @Override
    public Boolean unfavoriteSchool(Long schoolId, Long userId) {
        return schoolMapper.unfavoriteSchool(schoolId, userId);
    }

    /**
     * 获取用户收藏的院校列表
     */
    @Override
    public List<School> getFavoriteSchools(Long userId) {
        return schoolMapper.getFavoriteSchools(userId);
    }


} 