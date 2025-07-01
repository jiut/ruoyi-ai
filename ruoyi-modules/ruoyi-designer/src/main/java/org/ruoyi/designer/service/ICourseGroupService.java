package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.CourseGroup;

import java.util.List;

/**
 * 课程体系Service接口
 *
 * @author ruoyi
 */
public interface ICourseGroupService extends IService<CourseGroup> {

    /**
     * 根据院校ID获取课程体系列表
     *
     * @param schoolId 院校ID
     * @return 课程体系列表
     */
    List<CourseGroup> getCourseGroupsBySchoolId(Long schoolId);

    /**
     * 批量保存课程体系
     *
     * @param schoolId 院校ID
     * @param courseGroups 课程体系列表
     * @return 是否成功
     */
    Boolean saveCourseGroups(Long schoolId, List<CourseGroup> courseGroups);

    /**
     * 根据院校ID删除课程体系
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);
} 