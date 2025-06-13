package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.common.core.exception.ServiceException;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.JobApplication;
import org.ruoyi.designer.mapper.JobApplicationMapper;
import org.ruoyi.designer.service.IJobApplicationService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 岗位申请Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class JobApplicationServiceImpl extends ServiceImpl<JobApplicationMapper, JobApplication> implements IJobApplicationService {

    private final JobApplicationMapper jobApplicationMapper;

    @Override
    public TableDataInfo<JobApplication> selectJobApplicationList(JobApplication jobApplication, PageQuery pageQuery) {
        LambdaQueryWrapper<JobApplication> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(jobApplication.getJobId() != null, JobApplication::getJobId, jobApplication.getJobId())
                .eq(jobApplication.getDesignerId() != null, JobApplication::getDesignerId, jobApplication.getDesignerId())
                .eq(StringUtils.isNotBlank(jobApplication.getStatus()), JobApplication::getStatus, jobApplication.getStatus())
                .orderByDesc(JobApplication::getCreateTime);
        
        Page<JobApplication> page = jobApplicationMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    @Override
    public JobApplication selectJobApplicationById(Long applicationId) {
        return jobApplicationMapper.selectById(applicationId);
    }

    @Override
    public Boolean insertJobApplication(JobApplication jobApplication) {
        return save(jobApplication);
    }

    @Override
    public Boolean updateJobApplication(JobApplication jobApplication) {
        return updateById(jobApplication);
    }

    @Override
    public Boolean deleteJobApplicationByIds(List<Long> applicationIds) {
        return removeByIds(applicationIds);
    }

    @Override
    public List<JobApplication> selectJobApplicationByJob(Long jobId) {
        LambdaQueryWrapper<JobApplication> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JobApplication::getJobId, jobId)
                .orderByDesc(JobApplication::getCreateTime);
        return jobApplicationMapper.selectList(wrapper);
    }

    @Override
    public List<JobApplication> selectJobApplicationByDesigner(Long designerId) {
        LambdaQueryWrapper<JobApplication> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JobApplication::getDesignerId, designerId)
                .orderByDesc(JobApplication::getCreateTime);
        return jobApplicationMapper.selectList(wrapper);
    }

    @Override
    public Boolean applyForJob(Long jobId, Long designerId, String coverLetter, String resumeUrl) {
        LambdaQueryWrapper<JobApplication> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(JobApplication::getJobId, jobId)
                .eq(JobApplication::getDesignerId, designerId);
        
        JobApplication existingApplication = jobApplicationMapper.selectOne(wrapper);
        if (existingApplication != null) {
            throw new ServiceException("您已经申请过该岗位");
        }
        
        JobApplication jobApplication = new JobApplication();
        jobApplication.setJobId(jobId);
        jobApplication.setDesignerId(designerId);
        jobApplication.setCoverLetter(coverLetter);
        jobApplication.setResumeUrl(resumeUrl);
        jobApplication.setStatus("0");
        
        return save(jobApplication);
    }

    @Override
    public Boolean processApplication(Long applicationId, String status, String feedback) {
        JobApplication jobApplication = jobApplicationMapper.selectById(applicationId);
        if (jobApplication == null) {
            throw new ServiceException("申请不存在");
        }
        
        if (!"0".equals(jobApplication.getStatus())) {
            throw new ServiceException("该申请已经被处理过");
        }
        
        jobApplication.setStatus(status);
        jobApplication.setFeedback(feedback);
        
        return updateById(jobApplication);
    }

    @Override
    public Boolean withdrawApplication(Long applicationId, Long designerId) {
        JobApplication jobApplication = jobApplicationMapper.selectById(applicationId);
        if (jobApplication == null) {
            throw new ServiceException("申请不存在");
        }
        
        if (!jobApplication.getDesignerId().equals(designerId)) {
            throw new ServiceException("无权限撤回该申请");
        }
        
        if (!"0".equals(jobApplication.getStatus())) {
            throw new ServiceException("该申请已经被处理，无法撤回");
        }
        
        jobApplication.setStatus("3");
        
        return updateById(jobApplication);
    }
} 