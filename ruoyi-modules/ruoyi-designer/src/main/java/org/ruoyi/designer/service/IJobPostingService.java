package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.JobPosting;

import java.util.List;

/**
 * 岗位招聘Service接口
 *
 * @author ruoyi
 */
public interface IJobPostingService extends IService<JobPosting> {

    /**
     * 查询岗位招聘列表
     *
     * @param jobPosting 岗位招聘
     * @param pageQuery 分页参数
     * @return 岗位招聘集合
     */
    TableDataInfo<JobPosting> selectJobPostingList(JobPosting jobPosting, PageQuery pageQuery);

    /**
     * 根据岗位ID查询岗位招聘信息
     *
     * @param jobId 岗位ID
     * @return 岗位招聘信息
     */
    JobPosting selectJobPostingById(Long jobId);

    /**
     * 新增岗位招聘
     *
     * @param jobPosting 岗位招聘
     * @return 结果
     */
    Boolean insertJobPosting(JobPosting jobPosting);

    /**
     * 修改岗位招聘
     *
     * @param jobPosting 岗位招聘
     * @return 结果
     */
    Boolean updateJobPosting(JobPosting jobPosting);

    /**
     * 批量删除岗位招聘
     *
     * @param jobIds 需要删除的岗位ID
     * @return 结果
     */
    Boolean deleteJobPostingByIds(List<Long> jobIds);

    /**
     * 根据企业查询岗位
     *
     * @param enterpriseId 企业ID
     * @return 岗位列表
     */
    List<JobPosting> selectJobPostingByEnterprise(Long enterpriseId);

    /**
     * 根据职业要求查询岗位
     *
     * @param profession 职业
     * @return 岗位列表
     */
    List<JobPosting> selectJobPostingByProfession(String profession);

    /**
     * 根据技能要求查询岗位
     *
     * @param skillTags 技能标签
     * @return 岗位列表
     */
    List<JobPosting> selectJobPostingBySkills(List<String> skillTags);
} 