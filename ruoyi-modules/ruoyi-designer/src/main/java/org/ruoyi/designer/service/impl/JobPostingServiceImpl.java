package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.JobPosting;
import org.ruoyi.designer.domain.Enterprise;
import org.ruoyi.designer.mapper.JobPostingMapper;
import org.ruoyi.designer.service.IJobPostingService;
import org.ruoyi.designer.service.IEnterpriseService;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * 岗位招聘Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class JobPostingServiceImpl extends ServiceImpl<JobPostingMapper, JobPosting> implements IJobPostingService {

    private final JobPostingMapper jobPostingMapper;
    private final IEnterpriseService enterpriseService;

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
        
        // 关联查询企业信息
        List<JobPosting> jobPostings = page.getRecords();
        fillEnterpriseInfo(jobPostings);
        
        return TableDataInfo.build(page);
    }

    /**
     * 根据岗位ID查询岗位招聘信息
     */
    @Override
    public JobPosting selectJobPostingById(Long jobId) {
        JobPosting jobPosting = jobPostingMapper.selectById(jobId);
        if (jobPosting != null) {
            // 关联查询企业信息
            Enterprise enterprise = enterpriseService.selectEnterpriseById(jobPosting.getEnterpriseId());
            jobPosting.setEnterprise(enterprise);
        }
        return jobPosting;
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
        List<JobPosting> jobPostings = jobPostingMapper.selectList(wrapper);
        
        // 关联查询企业信息
        fillEnterpriseInfo(jobPostings);
        
        return jobPostings;
    }

    /**
     * 根据职业要求查询岗位
     */
    @Override
    public List<JobPosting> selectJobPostingByProfession(String profession) {
        LambdaQueryWrapper<JobPosting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JobPosting::getRequiredProfession, profession)
                .eq(JobPosting::getStatus, "0")
                .orderByDesc(JobPosting::getCreateTime);
        List<JobPosting> jobPostings = jobPostingMapper.selectList(wrapper);
        
        // 关联查询企业信息
        fillEnterpriseInfo(jobPostings);
        
        return jobPostings;
    }

    /**
     * 根据技能要求查询岗位
     */
    @Override
    public List<JobPosting> selectJobPostingBySkills(List<String> skillTags) {
        LambdaQueryWrapper<JobPosting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JobPosting::getStatus, "0");
        
        // 使用JSON_CONTAINS函数查询包含指定技能要求的岗位
        for (String tag : skillTags) {
            wrapper.apply("JSON_CONTAINS(required_skills, {0})", "\"" + tag + "\"");
        }
        
        wrapper.orderByDesc(JobPosting::getCreateTime);
        List<JobPosting> jobPostings = jobPostingMapper.selectList(wrapper);
        
        // 关联查询企业信息
        fillEnterpriseInfo(jobPostings);
        
        return jobPostings;
    }

    /**
     * 根据技能要求查询岗位（任意匹配）
     */
    public List<JobPosting> selectJobPostingBySkillsAny(List<String> skillTags) {
        LambdaQueryWrapper<JobPosting> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JobPosting::getStatus, "0");
        
        // 使用OR条件查询包含任意一个技能的岗位
        wrapper.and(w -> {
            for (int i = 0; i < skillTags.size(); i++) {
                if (i == 0) {
                    w.apply("JSON_CONTAINS(required_skills, {0})", "\"" + skillTags.get(i) + "\"");
                } else {
                    w.or().apply("JSON_CONTAINS(required_skills, {0})", "\"" + skillTags.get(i) + "\"");
                }
            }
        });
        
        wrapper.orderByDesc(JobPosting::getCreateTime);
        List<JobPosting> jobPostings = jobPostingMapper.selectList(wrapper);
        
        // 关联查询企业信息
        fillEnterpriseInfo(jobPostings);
        
        return jobPostings;
    }
    
    /**
     * 为岗位列表填充企业信息
     */
    private void fillEnterpriseInfo(List<JobPosting> jobPostings) {
        if (jobPostings.isEmpty()) {
            return;
        }
        
        // 收集所有企业ID
        List<Long> enterpriseIds = jobPostings.stream()
                .map(JobPosting::getEnterpriseId)
                .distinct()
                .toList();
        
        // 批量查询企业信息
        List<Enterprise> enterprises = enterpriseService.listByIds(enterpriseIds);
        Map<Long, Enterprise> enterpriseMap = enterprises.stream()
                .collect(Collectors.toMap(Enterprise::getEnterpriseId, e -> e));
        
        // 设置企业信息
        jobPostings.forEach(jobPosting -> {
            Enterprise enterprise = enterpriseMap.get(jobPosting.getEnterpriseId());
            jobPosting.setEnterprise(enterprise);
        });
    }
} 