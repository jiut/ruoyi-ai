package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.designer.domain.Education;

import java.util.List;
import java.util.Date;

/**
 * 教育背景Service接口
 *
 * @author ruoyi
 */
public interface IEducationService extends IService<Education> {

    /**
     * 查询教育背景列表
     *
     * @param education 教育背景
     * @return 教育背景集合
     */
    TableDataInfo<Education> selectEducationList(Education education);

    /**
     * 根据教育背景ID查询教育背景信息
     *
     * @param educationId 教育背景ID
     * @return 教育背景信息
     */
    Education selectEducationById(Long educationId);

    /**
     * 根据设计师ID查询教育背景列表
     *
     * @param designerId 设计师ID
     * @return 教育背景列表
     */
    List<Education> selectEducationByDesignerId(Long designerId);

    /**
     * 新增教育背景
     *
     * @param education 教育背景
     * @return 结果
     */
    Boolean insertEducation(Education education);

    /**
     * 修改教育背景
     *
     * @param education 教育背景
     * @return 结果
     */
    Boolean updateEducation(Education education);

    /**
     * 批量删除教育背景
     *
     * @param educationIds 需要删除的教育背景ID
     * @return 结果
     */
    Boolean deleteEducationByIds(List<Long> educationIds);

    /**
     * 删除设计师的所有教育背景
     *
     * @param designerId 设计师ID
     * @return 结果
     */
    Boolean deleteEducationByDesignerId(Long designerId);

    /**
     * 根据设计师ID批量逻辑删除教育背景
     *
     * @param designerIds 设计师ID列表
     * @param currentUserId 当前用户ID
     * @param currentTime 当前时间
     * @return 结果
     */
    Boolean deleteByDesignerIds(List<Long> designerIds, Long currentUserId, Date currentTime);

    /**
     * 根据设计师ID批量恢复教育背景
     *
     * @param designerIds 设计师ID列表
     * @return 结果
     */
    Boolean restoreByDesignerIds(List<Long> designerIds);

    /**
     * 逻辑删除教育背景
     *
     * @param educationId 教育背景ID
     * @param currentUserId 当前用户ID
     * @param currentTime 当前时间
     * @return 结果
     */
    Boolean logicDeleteEducationById(Long educationId, Long currentUserId, Date currentTime);
} 