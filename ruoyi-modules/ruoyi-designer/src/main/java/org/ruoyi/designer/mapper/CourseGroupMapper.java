package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.CourseGroup;

import java.util.List;

/**
 * 课程体系Mapper接口
 *
 * @author ruoyi
 */
public interface CourseGroupMapper extends BaseMapper<CourseGroup> {

    /**
     * 根据院校ID查询课程体系列表
     *
     * @param schoolId 院校ID
     * @return 课程体系列表
     */
    default List<CourseGroup> selectBySchoolId(Long schoolId) {
        return selectList(new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<CourseGroup>()
                .eq(CourseGroup::getSchoolId, schoolId)
                .orderByAsc(CourseGroup::getCreateTime));
    }

    /**
     * 批量插入课程体系
     *
     * @param courseGroups 课程体系列表
     * @return 影响行数
     */
    int insertBatch(@Param("courseGroups") List<CourseGroup> courseGroups);
} 