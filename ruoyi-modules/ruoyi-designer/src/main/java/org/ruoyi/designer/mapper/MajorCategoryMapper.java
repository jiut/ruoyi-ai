package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.MajorCategory;

import java.util.List;

/**
 * 专业分类Mapper接口
 *
 * @author ruoyi
 */
public interface MajorCategoryMapper extends BaseMapper<MajorCategory> {

    /**
     * 根据院校ID查询专业分类列表
     *
     * @param schoolId 院校ID
     * @return 专业分类列表
     */
    default List<MajorCategory> selectBySchoolId(Long schoolId) {
        return selectList(new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<MajorCategory>()
                .eq(MajorCategory::getSchoolId, schoolId)
                .orderByAsc(MajorCategory::getCreateTime));
    }

    /**
     * 批量插入专业分类
     *
     * @param categories 专业分类列表
     * @return 影响行数
     */
    int insertBatch(@Param("categories") List<MajorCategory> categories);
} 