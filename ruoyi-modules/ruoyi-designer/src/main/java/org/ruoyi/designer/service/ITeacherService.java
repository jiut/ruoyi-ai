package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.Teacher;

import java.util.List;

/**
 * 代表性教师Service接口
 *
 * @author ruoyi
 */
public interface ITeacherService extends IService<Teacher> {

    /**
     * 根据院校ID获取代表性教师列表
     *
     * @param schoolId 院校ID
     * @return 代表性教师列表
     */
    List<Teacher> getTeachersBySchoolId(Long schoolId);

    /**
     * 批量保存代表性教师
     *
     * @param schoolId 院校ID
     * @param teachers 代表性教师列表
     * @return 是否成功
     */
    Boolean saveTeachers(Long schoolId, List<Teacher> teachers);

    /**
     * 根据院校ID删除代表性教师
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);
} 