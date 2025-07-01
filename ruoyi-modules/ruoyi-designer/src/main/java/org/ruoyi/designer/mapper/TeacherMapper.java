package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.Teacher;

import java.util.List;

/**
 * 代表性教师Mapper接口
 *
 * @author ruoyi
 */
public interface TeacherMapper extends BaseMapper<Teacher> {

    /**
     * 根据院校ID查询代表性教师列表
     *
     * @param schoolId 院校ID
     * @return 代表性教师列表
     */
    default List<Teacher> selectBySchoolId(Long schoolId) {
        return selectList(new com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper<Teacher>()
                .eq(Teacher::getSchoolId, schoolId)
                .orderByAsc(Teacher::getCreateTime));
    }

    /**
     * 批量插入代表性教师
     *
     * @param teachers 代表性教师列表
     * @return 影响行数
     */
    int insertBatch(@Param("teachers") List<Teacher> teachers);
} 