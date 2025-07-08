package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.Award;
import org.ruoyi.designer.mapper.AwardMapper;
import org.ruoyi.designer.service.IAwardService;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Date;

/**
 * 获奖Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class AwardServiceImpl extends ServiceImpl<AwardMapper, Award> implements IAwardService {

    private final AwardMapper awardMapper;

    /**
     * 查询获奖列表
     */
    @Override
    public TableDataInfo<Award> selectAwardList(Award award) {
        LambdaQueryWrapper<Award> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(award.getTitle()), Award::getTitle, award.getTitle())
                .like(StringUtils.isNotBlank(award.getOrganization()), Award::getOrganization, award.getOrganization())
                .eq(StringUtils.isNotBlank(award.getYear()), Award::getYear, award.getYear())
                .eq(award.getDesignerId() != null, Award::getDesignerId, award.getDesignerId())
                .eq(StringUtils.isNotBlank(award.getLevel()), Award::getLevel, award.getLevel())
                .eq(StringUtils.isNotBlank(award.getCategory()), Award::getCategory, award.getCategory())
                .eq(StringUtils.isNotBlank(award.getStatus()), Award::getStatus, award.getStatus())
                .orderByAsc(Award::getSort)
                .orderByDesc(Award::getYear)
                .orderByDesc(Award::getCreateTime);
        
        PageQuery pageQuery = new PageQuery(20, 1);
        Page<Award> page = awardMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    /**
     * 根据获奖ID查询获奖信息
     */
    @Override
    public Award selectAwardById(Long awardId) {
        return awardMapper.selectById(awardId);
    }

    /**
     * 根据设计师ID查询获奖列表
     */
    @Override
    public List<Award> selectAwardByDesignerId(Long designerId) {
        LambdaQueryWrapper<Award> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Award::getDesignerId, designerId)
                .eq(Award::getStatus, "0")
                .orderByAsc(Award::getSort)
                .orderByDesc(Award::getYear);
        return awardMapper.selectList(wrapper);
    }

    /**
     * 新增获奖
     */
    @Override
    public Boolean insertAward(Award award) {
        // 如果没有设置排序号，自动设置为最大值+1
        if (award.getSort() == null || award.getSort() == 0) {
            award.setSort(getNextSortNumber(award.getDesignerId()));
        }
        
        return save(award);
    }

    /**
     * 修改获奖
     */
    @Override
    public Boolean updateAward(Award award) {
        return updateById(award);
    }

    /**
     * 批量删除获奖
     */
    @Override
    public Boolean deleteAwardByIds(List<Long> awardIds) {
        return removeByIds(awardIds);
    }

    /**
     * 删除设计师的所有获奖记录
     */
    @Override
    public Boolean deleteAwardByDesignerId(Long designerId) {
        LambdaQueryWrapper<Award> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Award::getDesignerId, designerId);
        return remove(wrapper);
    }

    /**
     * 根据设计师ID批量逻辑删除获奖记录
     */
    @Override
    public Boolean deleteByDesignerIds(List<Long> designerIds, Long currentUserId, Date currentTime) {
        if (designerIds == null || designerIds.isEmpty()) {
            return true;
        }
        
        LambdaUpdateWrapper<Award> wrapper = new LambdaUpdateWrapper<>();
        wrapper.in(Award::getDesignerId, designerIds)
                .set(Award::getDelFlag, "1")
                .set(Award::getDelTime, currentTime)
                .set(Award::getDelBy, currentUserId);
        
        return update(wrapper);
    }

    /**
     * 根据设计师ID批量恢复获奖记录
     */
    @Override
    public Boolean restoreByDesignerIds(List<Long> designerIds) {
        if (designerIds == null || designerIds.isEmpty()) {
            return true;
        }
        
        LambdaUpdateWrapper<Award> wrapper = new LambdaUpdateWrapper<>();
        wrapper.in(Award::getDesignerId, designerIds)
                .set(Award::getDelFlag, "0")
                .set(Award::getDelTime, null)
                .set(Award::getDelBy, null);
        
        return update(wrapper);
    }

    /**
     * 获取下一个排序号
     */
    private Integer getNextSortNumber(Long designerId) {
        LambdaQueryWrapper<Award> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Award::getDesignerId, designerId)
                .orderByDesc(Award::getSort)
                .last("LIMIT 1");
        
        Award lastAward = awardMapper.selectOne(wrapper);
        return lastAward != null && lastAward.getSort() != null ? lastAward.getSort() + 1 : 1;
    }
} 