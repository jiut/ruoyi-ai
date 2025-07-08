package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.designer.domain.WorkExperience;

import java.util.List;
import java.util.Date;

/**
 * 工作经历Service接口
 *
 * @author ruoyi
 */
public interface IWorkExperienceService extends IService<WorkExperience> {

    /**
     * 查询工作经历列表
     *
     * @param workExperience 工作经历
     * @return 工作经历集合
     */
    TableDataInfo<WorkExperience> selectWorkExperienceList(WorkExperience workExperience);

    /**
     * 根据工作经历ID查询工作经历信息
     *
     * @param experienceId 工作经历ID
     * @return 工作经历信息
     */
    WorkExperience selectWorkExperienceById(Long experienceId);

    /**
     * 根据设计师ID查询工作经历列表
     *
     * @param designerId 设计师ID
     * @return 工作经历列表
     */
    List<WorkExperience> selectWorkExperienceByDesignerId(Long designerId);

    /**
     * 新增工作经历
     *
     * @param workExperience 工作经历
     * @return 结果
     */
    Boolean insertWorkExperience(WorkExperience workExperience);

    /**
     * 修改工作经历
     *
     * @param workExperience 工作经历
     * @return 结果
     */
    Boolean updateWorkExperience(WorkExperience workExperience);

    /**
     * 批量删除工作经历
     *
     * @param experienceIds 需要删除的工作经历ID
     * @return 结果
     */
    Boolean deleteWorkExperienceByIds(List<Long> experienceIds);

    /**
     * 删除设计师的所有工作经历
     *
     * @param designerId 设计师ID
     * @return 结果
     */
    Boolean deleteWorkExperienceByDesignerId(Long designerId);

    /**
     * 根据设计师ID批量逻辑删除工作经历
     *
     * @param designerIds 设计师ID列表
     * @param currentUserId 当前用户ID
     * @param currentTime 当前时间
     * @return 结果
     */
    Boolean deleteByDesignerIds(List<Long> designerIds, Long currentUserId, Date currentTime);

    /**
     * 根据设计师ID批量恢复工作经历
     *
     * @param designerIds 设计师ID列表
     * @return 结果
     */
    Boolean restoreByDesignerIds(List<Long> designerIds);
} 