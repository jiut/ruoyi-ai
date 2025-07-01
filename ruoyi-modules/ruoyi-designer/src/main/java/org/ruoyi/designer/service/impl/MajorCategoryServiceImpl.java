package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.MajorCategory;
import org.ruoyi.designer.mapper.MajorCategoryMapper;
import org.ruoyi.designer.service.IMajorCategoryService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 专业分类Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class MajorCategoryServiceImpl extends ServiceImpl<MajorCategoryMapper, MajorCategory> implements IMajorCategoryService {

    private final MajorCategoryMapper baseMapper;

    /**
     * 根据院校ID获取专业分类列表
     */
    @Override
    public List<MajorCategory> getMajorCategoriesBySchoolId(Long schoolId) {
        return baseMapper.selectBySchoolId(schoolId);
    }

    /**
     * 批量保存专业分类
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveMajorCategories(Long schoolId, List<MajorCategory> categories) {
        if (categories == null || categories.isEmpty()) {
            return true;
        }
        
        // 删除原有数据
        LambdaQueryWrapper<MajorCategory> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MajorCategory::getSchoolId, schoolId);
        baseMapper.delete(queryWrapper);
        
        // 设置院校ID并批量插入
        categories.forEach(category -> category.setSchoolId(schoolId));
        return saveBatch(categories);
    }

    /**
     * 根据院校ID删除专业分类
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<MajorCategory> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(MajorCategory::getSchoolId, schoolId);
        return remove(queryWrapper);
    }
} 