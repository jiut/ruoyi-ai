package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.designer.domain.Work;

import java.util.List;
import java.util.Date;

/**
 * 作品Service接口
 *
 * @author ruoyi
 */
public interface IWorkService extends IService<Work> {

    /**
     * 查询作品列表
     *
     * @param work 作品
     * @return 作品集合
     */
    TableDataInfo<Work> selectWorkList(Work work);

    /**
     * 根据作品ID查询作品信息
     *
     * @param workId 作品ID
     * @return 作品信息
     */
    Work selectWorkById(Long workId);

    /**
     * 根据设计师ID查询作品列表
     *
     * @param designerId 设计师ID
     * @return 作品列表
     */
    List<Work> selectWorkByDesignerId(Long designerId);

    /**
     * 新增作品
     *
     * @param work 作品
     * @return 结果
     */
    Boolean insertWork(Work work);

    /**
     * 修改作品
     *
     * @param work 作品
     * @return 结果
     */
    Boolean updateWork(Work work);

    /**
     * 批量删除作品
     *
     * @param workIds 需要删除的作品ID
     * @return 结果
     */
    Boolean deleteWorkByIds(List<Long> workIds);

    /**
     * 删除设计师的所有作品
     *
     * @param designerId 设计师ID
     * @return 结果
     */
    Boolean deleteWorkByDesignerId(Long designerId);

    /**
     * 增加作品浏览数
     *
     * @param workId 作品ID
     * @return 结果
     */
    Boolean incrementViewCount(Long workId);

    /**
     * 增加作品点赞数
     *
     * @param workId 作品ID
     * @return 结果
     */
    Boolean incrementLikeCount(Long workId);

    /**
     * 根据设计师ID批量逻辑删除作品
     *
     * @param designerIds 设计师ID列表
     * @param currentUserId 当前用户ID
     * @param currentTime 当前时间
     * @return 结果
     */
    Boolean deleteByDesignerIds(List<Long> designerIds, Long currentUserId, Date currentTime);

    /**
     * 根据设计师ID批量恢复作品
     *
     * @param designerIds 设计师ID列表
     * @return 结果
     */
    Boolean restoreByDesignerIds(List<Long> designerIds);

    /**
     * 逻辑删除单个作品
     *
     * @param workId 作品ID
     * @param currentUserId 当前用户ID
     * @param currentTime 当前时间
     * @return 结果
     */
    Boolean logicDeleteWorkById(Long workId, Long currentUserId, Date currentTime);
} 