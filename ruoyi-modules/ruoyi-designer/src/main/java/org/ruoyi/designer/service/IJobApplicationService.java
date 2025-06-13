package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.JobApplication;

import java.util.List;

/**
 * 岗位申请Service接口
 *
 * @author ruoyi
 */
public interface IJobApplicationService extends IService<JobApplication> {

    /**
     * 查询岗位申请列表
     *
     * @param jobApplication 岗位申请
     * @param pageQuery 分页参数
     * @return 岗位申请集合
     */
    TableDataInfo<JobApplication> selectJobApplicationList(JobApplication jobApplication, PageQuery pageQuery);

    /**
     * 根据申请ID查询岗位申请信息
     *
     * @param applicationId 申请ID
     * @return 岗位申请信息
     */
    JobApplication selectJobApplicationById(Long applicationId);

    /**
     * 新增岗位申请
     *
     * @param jobApplication 岗位申请
     * @return 结果
     */
    Boolean insertJobApplication(JobApplication jobApplication);

    /**
     * 修改岗位申请
     *
     * @param jobApplication 岗位申请
     * @return 结果
     */
    Boolean updateJobApplication(JobApplication jobApplication);

    /**
     * 批量删除岗位申请
     *
     * @param applicationIds 需要删除的申请ID
     * @return 结果
     */
    Boolean deleteJobApplicationByIds(List<Long> applicationIds);

    /**
     * 根据岗位查询申请
     *
     * @param jobId 岗位ID
     * @return 申请列表
     */
    List<JobApplication> selectJobApplicationByJob(Long jobId);

    /**
     * 根据设计师查询申请
     *
     * @param designerId 设计师ID
     * @return 申请列表
     */
    List<JobApplication> selectJobApplicationByDesigner(Long designerId);

    /**
     * 设计师申请岗位
     *
     * @param jobId 岗位ID
     * @param designerId 设计师ID
     * @param coverLetter 申请说明
     * @param resumeUrl 简历文件URL
     * @return 结果
     */
    Boolean applyForJob(Long jobId, Long designerId, String coverLetter, String resumeUrl);

    /**
     * 企业处理申请（通过或拒绝）
     *
     * @param applicationId 申请ID
     * @param status 处理结果（1通过 2拒绝）
     * @param feedback 企业反馈
     * @return 结果
     */
    Boolean processApplication(Long applicationId, String status, String feedback);

    /**
     * 设计师撤回申请
     *
     * @param applicationId 申请ID
     * @param designerId 设计师ID
     * @return 结果
     */
    Boolean withdrawApplication(Long applicationId, Long designerId);
} 