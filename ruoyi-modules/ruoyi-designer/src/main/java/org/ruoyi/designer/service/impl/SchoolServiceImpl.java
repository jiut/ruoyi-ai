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
} 