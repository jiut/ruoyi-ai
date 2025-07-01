package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.MajorCategory;

import java.util.List;

/**
 * 专业分类Service接口
 *
 * @author ruoyi
 */
public interface IMajorCategoryService extends IService<MajorCategory> {

    /**
     * 根据院校ID获取专业分类列表
     *
     * @param schoolId 院校ID
     * @return 专业分类列表
     */
    List<MajorCategory> getMajorCategoriesBySchoolId(Long schoolId);

    /**
     * 批量保存专业分类
     *
     * @param schoolId 院校ID
     * @param categories 专业分类列表
     * @return 是否成功
     */
    Boolean saveMajorCategories(Long schoolId, List<MajorCategory> categories);

    /**
     * 根据院校ID删除专业分类
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);
} 