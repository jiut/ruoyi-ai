package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.designer.domain.Award;

import java.util.List;
import java.util.Date;

/**
 * 获奖Service接口
 *
 * @author ruoyi
 */
public interface IAwardService extends IService<Award> {

    /**
     * 查询获奖列表
     *
     * @param award 获奖
     * @return 获奖集合
     */
    TableDataInfo<Award> selectAwardList(Award award);

    /**
     * 根据获奖ID查询获奖信息
     *
     * @param awardId 获奖ID
     * @return 获奖信息
     */
    Award selectAwardById(Long awardId);

    /**
     * 根据设计师ID查询获奖列表
     *
     * @param designerId 设计师ID
     * @return 获奖列表
     */
    List<Award> selectAwardByDesignerId(Long designerId);

    /**
     * 新增获奖
     *
     * @param award 获奖
     * @return 结果
     */
    Boolean insertAward(Award award);

    /**
     * 修改获奖
     *
     * @param award 获奖
     * @return 结果
     */
    Boolean updateAward(Award award);

    /**
     * 批量删除获奖
     *
     * @param awardIds 需要删除的获奖ID
     * @return 结果
     */
    Boolean deleteAwardByIds(List<Long> awardIds);

    /**
     * 删除设计师的所有获奖记录
     *
     * @param designerId 设计师ID
     * @return 结果
     */
    Boolean deleteAwardByDesignerId(Long designerId);

    /**
     * 根据设计师ID批量逻辑删除获奖记录
     *
     * @param designerIds 设计师ID列表
     * @param currentUserId 当前用户ID
     * @param currentTime 当前时间
     * @return 结果
     */
    Boolean deleteByDesignerIds(List<Long> designerIds, Long currentUserId, Date currentTime);

    /**
     * 根据设计师ID批量恢复获奖记录
     *
     * @param designerIds 设计师ID列表
     * @return 结果
     */
    Boolean restoreByDesignerIds(List<Long> designerIds);

    /**
     * 逻辑删除单个获奖记录
     *
     * @param awardId 获奖ID
     * @param currentUserId 当前用户ID
     * @param currentTime 当前时间
     * @return 结果
     */
    Boolean logicDeleteAwardById(Long awardId, Long currentUserId, Date currentTime);
} 