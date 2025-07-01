package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.AwardWork;
import org.ruoyi.designer.mapper.AwardWorkMapper;
import org.ruoyi.designer.service.IAwardWorkService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 获奖作品Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class AwardWorkServiceImpl extends ServiceImpl<AwardWorkMapper, AwardWork> implements IAwardWorkService {

    private final AwardWorkMapper baseMapper;

    /**
     * 根据院校ID获取获奖作品列表
     */
    @Override
    public List<AwardWork> getBySchoolId(Long schoolId) {
        return baseMapper.selectBySchoolId(schoolId);
    }

    /**
     * 批量保存获奖作品
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveAwardWorks(Long schoolId, List<AwardWork> awardWorks) {
        if (awardWorks == null || awardWorks.isEmpty()) {
            return true;
        }
        
        // 删除原有数据
        LambdaQueryWrapper<AwardWork> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AwardWork::getSchoolId, schoolId);
        baseMapper.delete(queryWrapper);
        
        // 设置院校ID并批量插入
        awardWorks.forEach(work -> work.setSchoolId(schoolId));
        return saveBatch(awardWorks);
    }

    /**
     * 根据院校ID删除获奖作品
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<AwardWork> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AwardWork::getSchoolId, schoolId);
        return remove(queryWrapper);
    }

    /**
     * 根据奖项名称查询获奖作品
     */
    @Override
    public List<AwardWork> getByAward(String award) {
        LambdaQueryWrapper<AwardWork> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(AwardWork::getAward, award);
        return baseMapper.selectList(queryWrapper);
    }
} 