package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.School;
import org.ruoyi.designer.domain.*;
import org.ruoyi.designer.domain.vo.SchoolFullInfoVo;
import org.ruoyi.designer.mapper.SchoolMapper;
import org.ruoyi.designer.mapper.*;
import org.ruoyi.designer.service.ISchoolService;
import org.springframework.stereotype.Service;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Collections;
import java.util.List;
import java.util.Map;
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
    private final MajorCategoryMapper majorCategoryMapper;
    private final CourseGroupMapper courseGroupMapper;
    private final FacultyStatsMapper facultyStatsMapper;
    private final TeacherMapper teacherMapper;
    private final EmploymentStatsMapper employmentStatsMapper;
    private final EmployerMapper employerMapper;
    private final ChartDataMapper chartDataMapper;
    private final AchievementStatsMapper achievementStatsMapper;
    private final TrendDataMapper trendDataMapper;
    private final AwardWorkMapper awardWorkMapper;
    private final SchoolCardStatsMapper schoolCardStatsMapper;
    private static final Logger log = LoggerFactory.getLogger(SchoolServiceImpl.class);

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
        
        // 填充卡片统计数据
        fillCardStatsData(page.getRecords());
        
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
        
        // 填充卡片统计数据
        fillCardStatsData(page.getRecords());
        
        return TableDataInfo.build(page);
    }

    /**
     * 根据院校ID查询院校信息
     */
    @Override
    public School selectSchoolById(Long schoolId) {
        School school = schoolMapper.selectById(schoolId);
        return school;
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
        School school = schoolMapper.selectOne(wrapper);
        return school;
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
        List<School> schools = schoolMapper.getFavoriteSchools(userId);
        return schools;
    }

    // =================== Mock数据API扩展方法实现 ===================

    @Override
    public List<MajorCategory> getMajorCategories(Long schoolId) {
        return majorCategoryMapper.selectBySchoolId(schoolId);
    }

    @Override
    public List<CourseGroup> getCourseSystem(Long schoolId) {
        return courseGroupMapper.selectBySchoolId(schoolId);
    }

    @Override
    public FacultyStats getFacultyStats(Long schoolId) {
        return facultyStatsMapper.selectBySchoolId(schoolId);
    }

    @Override
    public List<Teacher> getFacultyMembers(Long schoolId) {
        return teacherMapper.selectBySchoolId(schoolId);
    }

    @Override
    public EmploymentStats getSchoolEmploymentStats(Long schoolId) {
        return employmentStatsMapper.selectBySchoolId(schoolId);
    }

    @Override
    public List<Employer> getEmployers(Long schoolId) {
        return employerMapper.selectBySchoolId(schoolId);
    }

    @Override
    public ChartData getEmploymentCharts(Long schoolId) {
        return chartDataMapper.selectBySchoolId(schoolId);
    }

    @Override
    public AchievementStats getAchievementStats(Long schoolId) {
        return achievementStatsMapper.selectBySchoolId(schoolId);
    }

    @Override
    public TrendData getAwardTrends(Long schoolId) {
        return trendDataMapper.selectBySchoolId(schoolId);
    }

    @Override
    public List<AwardWork> getAwardWorks(Long schoolId) {
        return awardWorkMapper.selectBySchoolId(schoolId);
    }

    @Override
    public SchoolCardStats getCardStats(Long schoolId) {
        try {
            SchoolCardStats result = schoolCardStatsMapper.selectBySchoolId(schoolId);
            
            if (result == null) {
                log.warn("未查询到院校[{}]的卡片统计数据", schoolId);
            }
            
            return result;
        } catch (Exception e) {
            log.error("查询院校[{}]卡片统计数据时发生异常", schoolId, e);
            throw e;
        }
    }

    @Override
    public SchoolFullInfoVo getSchoolFullInfo(Long schoolId) {
        SchoolFullInfoVo fullInfo = new SchoolFullInfoVo();
        
        // 基础信息
        fullInfo.setBasicInfo(selectSchoolById(schoolId));
        
        // 专业分类
        fullInfo.setMajorCategories(getMajorCategories(schoolId));
        
        // 课程体系
        fullInfo.setCourseSystem(getCourseSystem(schoolId));
        
        // 师资信息
        fullInfo.setFacultyStats(getFacultyStats(schoolId));
        fullInfo.setFacultyMembers(getFacultyMembers(schoolId));
        
        // 就业信息
        fullInfo.setEmploymentStats(getSchoolEmploymentStats(schoolId));
        fullInfo.setEmployers(getEmployers(schoolId));
        fullInfo.setEmploymentCharts(getEmploymentCharts(schoolId));
        
        // 成果信息
        fullInfo.setAchievementStats(getAchievementStats(schoolId));
        fullInfo.setAwardTrends(getAwardTrends(schoolId));
        fullInfo.setAwardWorks(getAwardWorks(schoolId));
        
        // 卡片统计
        fullInfo.setCardStats(getCardStats(schoolId));
        
        return fullInfo;
    }

    // =================== 格式化数据方法实现 ===================

    @Override
    public String getFormattedEmploymentRate(Long schoolId) {
        try {
            SchoolCardStats cardStats = getCardStats(schoolId);
            
            if (cardStats != null) {
                if (cardStats.getEmploymentRates() != null && !cardStats.getEmploymentRates().isEmpty()) {
                    String result = cardStats.getEmploymentRates().get(0);
                    return result;
                } else {
                    log.warn("院校[{}]就业率数据为空或列表为空", schoolId);
                }
            } else {
                log.warn("院校[{}]未找到卡片统计数据", schoolId);
            }
        } catch (Exception e) {
            log.error("获取院校[{}]就业率时发生异常", schoolId, e);
        }
        return "--";
    }

    @Override
    public String getFormattedFacultyStrength(Long schoolId) {
        try {
            SchoolCardStats cardStats = getCardStats(schoolId);
            
            if (cardStats != null) {
                if (cardStats.getFacultyStrengths() != null && !cardStats.getFacultyStrengths().isEmpty()) {
                    String result = cardStats.getFacultyStrengths().get(0);
                    return result;
                } else {
                    log.warn("院校[{}]师资力量数据为空或列表为空", schoolId);
                }
            } else {
                log.warn("院校[{}]未找到卡片统计数据", schoolId);
            }
        } catch (Exception e) {
            log.error("获取院校[{}]师资力量时发生异常", schoolId, e);
        }
        return "--";
    }

    @Override
    public String getFormattedStudentScore(Long schoolId) {
        try {
            SchoolCardStats cardStats = getCardStats(schoolId);
            
            if (cardStats != null) {
                if (cardStats.getStudentScores() != null && !cardStats.getStudentScores().isEmpty()) {
                    String result = cardStats.getStudentScores().get(0);
                    return result;
                } else {
                    log.warn("院校[{}]学生评分数据为空或列表为空", schoolId);
                }
            } else {
                log.warn("院校[{}]未找到卡片统计数据", schoolId);
            }
        } catch (Exception e) {
            log.error("获取院校[{}]学生评分时发生异常", schoolId, e);
        }
        return "--";
    }

    @Override
    public String getFormattedAdvantagePrograms(School school) {
        try {
            if (school == null) {
                log.warn("院校信息为空");
                return "待完善";
            }
            
            SchoolCardStats cardStats = getCardStats(school.getSchoolId());
            
            if (cardStats != null && cardStats.getAdvantagePrograms() != null && !cardStats.getAdvantagePrograms().isEmpty()) {
                String result = String.join("、", cardStats.getAdvantagePrograms());
                return result;
            } else {
                log.warn("院校[{}]未找到卡片统计数据或优势专业数据为空", school.getSchoolName());
            }
        } catch (Exception e) {
            log.error("获取院校[{}]优势专业时发生异常", school != null ? school.getSchoolName() : "未知", e);
        }
        return "待完善";
    }

    // =================== 扩展查询方法实现 ===================

    @Override
    public TableDataInfo<School> selectSchoolListWithFilters(
            School school,
            String province,
            String city,
            String schoolType,
            String level,
            Boolean isKey,
            Boolean is985,
            Boolean is211,
            Boolean isDoubleFirst,
            PageQuery pageQuery) {
        
        LambdaQueryWrapper<School> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(school.getSchoolName()), School::getSchoolName, school.getSchoolName())
                .eq(StringUtils.isNotBlank(province), School::getProvince, province)
                .eq(StringUtils.isNotBlank(city), School::getCity, city)
                .eq(StringUtils.isNotBlank(schoolType), School::getSchoolType, schoolType)
                .eq(StringUtils.isNotBlank(level), School::getLevel, level)
                .eq(isKey != null, School::getIsKey, isKey)
                .eq(is985 != null, School::getIs985, is985)
                .eq(is211 != null, School::getIs211, is211)
                .eq(isDoubleFirst != null, School::getIsDoubleFirst, isDoubleFirst)
                .eq(StringUtils.isNotBlank(school.getStatus()), School::getStatus, school.getStatus())
                .orderByDesc(School::getCreateTime);
        
        Page<School> page = schoolMapper.selectPage(pageQuery.build(), wrapper);
        
        // 填充卡片统计数据
        fillCardStatsData(page.getRecords());
        
        return TableDataInfo.build(page);
    }

    // =================== 私有辅助方法 ===================

    /**
     * 填充院校卡片统计数据
     * 根据院校卡片统计数据后端适配指南的要求，在list接口中直接返回统计字段
     *
     * @param schools 院校列表
     */
    private void fillCardStatsData(List<School> schools) {
        if (schools == null || schools.isEmpty()) {
            return;
        }
        
        for (School school : schools) {
            try {
                // 获取卡片统计数据
                SchoolCardStats cardStats = getCardStats(school.getSchoolId());
                
                if (cardStats != null) {
                    // 设置就业率
                    school.setEmploymentRate(getFormattedEmploymentRate(school.getSchoolId()));
                    
                    // 设置师资力量
                    school.setFacultyStrength(getFormattedFacultyStrength(school.getSchoolId()));
                    
                    // 设置学生评分
                    school.setStudentScore(getFormattedStudentScore(school.getSchoolId()));
                    
                    // 设置优势专业
                    school.setAdvantagePrograms(getFormattedAdvantagePrograms(school));
                } else {
                    // 如果没有卡片统计数据，设置默认值
                    school.setEmploymentRate("--");
                    school.setFacultyStrength("--");
                    school.setStudentScore("--");
                    school.setAdvantagePrograms("待完善");
                }
            } catch (Exception e) {
                log.error("为院校[{}]填充卡片统计数据时发生异常", school.getSchoolName(), e);
                // 设置默认值
                school.setEmploymentRate("--");
                school.setFacultyStrength("--");
                school.setStudentScore("--");
                school.setAdvantagePrograms("待完善");
            }
        }
    }

} 