package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.JobPosting;
import org.ruoyi.designer.mapper.JobPostingMapper;
import org.ruoyi.designer.service.IJobPostingService;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;

/**
 * 岗位招聘Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class JobPostingServiceImpl extends ServiceImpl<JobPostingMapper, JobPosting> implements IJobPostingService {

    private final JobPostingMapper jobPostingMapper;

    /**
     * 查询岗位招聘列表
     */
    @Override
    public TableDataInfo<JobPosting> selectJobPostingList(JobPosting jobPosting, PageQuery pageQuery) {
        LambdaQueryWrapper<JobPosting> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(jobPosting.getJobTitle()), JobPosting::getJobTitle, jobPosting.getJobTitle())
                .eq(jobPosting.getEnterpriseId() != null, JobPosting::getEnterpriseId, jobPosting.getEnterpriseId())
                .eq(StringUtils.isNotBlank(jobPosting.getRequiredProfession()), JobPosting::getRequiredProfession, jobPosting.getRequiredProfession())
                .eq(StringUtils.isNotBlank(jobPosting.getLocation()), JobPosting::getLocation, jobPosting.getLocation())
                .eq(StringUtils.isNotBlank(jobPosting.getJobType()), JobPosting::getJobType, jobPosting.getJobType())
                .eq(StringUtils.isNotBlank(jobPosting.getStatus()), JobPosting::getStatus, jobPosting.getStatus())
                .ge(jobPosting.getDeadline() != null, JobPosting::getDeadline, LocalDate.now()) // 只显示未过期的岗位
                .orderByDesc(JobPosting::getCreateTime);
        
        Page<JobPosting> page = jobPostingMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    /**
     * 根据岗位ID查询岗位招聘信息
     */
    @Override
    public JobPosting selectJobPostingById(Long jobId) {
        return jobPostingMapper.selectById(jobId);
    }

    /**
     * 新增岗位招聘
     */
    @Override
    public Boolean insertJobPosting(JobPosting jobPosting) {
        return save(jobPosting);
    }

    /**
     * 修改岗位招聘
     */
    @Override
    public Boolean updateJobPosting(JobPosting jobPosting) {
        return updateById(jobPosting);
    }

    /**
     * 批量删除岗位招聘
     */
    @Override
    public Boolean deleteJobPostingByIds(List<Long> jobIds) {
        return removeByIds(jobIds);
    }

    /**
     * 根据企业查询岗位
     */
    @Override
    public List<JobPosting> selectJobPostingByEnterprise(Long enterpriseId) {
        LambdaQueryWrapper<JobPosting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JobPosting::getEnterpriseId, enterpriseId)
                .eq(JobPosting::getStatus, "0")
                .ge(JobPosting::getDeadline, LocalDate.now())
                .orderByDesc(JobPosting::getCreateTime);
        return jobPostingMapper.selectList(wrapper);
    }

    /**
     * 根据职业要求查询岗位
     */
    @Override
    public List<JobPosting> selectJobPostingByProfession(String profession) {
        LambdaQueryWrapper<JobPosting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JobPosting::getRequiredProfession, profession)
                .eq(JobPosting::getStatus, "0")
                .ge(JobPosting::getDeadline, LocalDate.now())
                .orderByDesc(JobPosting::getCreateTime);
        return jobPostingMapper.selectList(wrapper);
    }

    /**
     * 根据技能要求查询岗位
     */
    @Override
    public List<JobPosting> selectJobPostingBySkills(List<String> skillTags) {
        LambdaQueryWrapper<JobPosting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JobPosting::getStatus, "0")
                .ge(JobPosting::getDeadline, LocalDate.now());
        
        // 使用JSON_CONTAINS函数查询包含指定技能要求的岗位
        for (String tag : skillTags) {
            wrapper.apply("JSON_CONTAINS(required_skills, {0})", "\"" + tag + "\"");
        }
        
        wrapper.orderByDesc(JobPosting::getCreateTime);
        return jobPostingMapper.selectList(wrapper);
    }
} 