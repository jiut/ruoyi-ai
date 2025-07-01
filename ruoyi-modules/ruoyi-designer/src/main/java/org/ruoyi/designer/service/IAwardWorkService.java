package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.AwardWork;

import java.util.List;

/**
 * 获奖作品Service接口
 *
 * @author ruoyi
 * @date 2024-12-28
 */
public interface IAwardWorkService extends IService<AwardWork> {

    /**
     * 根据院校ID获取获奖作品列表
     *
     * @param schoolId 院校ID
     * @return 获奖作品列表
     */
    List<AwardWork> getBySchoolId(Long schoolId);

    /**
     * 批量保存获奖作品
     *
     * @param schoolId 院校ID
     * @param awardWorks 获奖作品列表
     * @return 是否成功
     */
    Boolean saveAwardWorks(Long schoolId, List<AwardWork> awardWorks);

    /**
     * 根据院校ID删除获奖作品
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);

    /**
     * 根据奖项名称查询获奖作品
     *
     * @param award 奖项名称
     * @return 获奖作品列表
     */
    List<AwardWork> getByAward(String award);
} 