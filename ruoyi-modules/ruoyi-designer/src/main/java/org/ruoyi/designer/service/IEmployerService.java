package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.Employer;

import java.util.List;

/**
 * 代表性雇主Service接口
 *
 * @author ruoyi
 * @date 2024-12-28
 */
public interface IEmployerService extends IService<Employer> {

    /**
     * 根据院校ID获取代表性雇主列表
     *
     * @param schoolId 院校ID
     * @return 雇主列表
     */
    List<Employer> getBySchoolId(Long schoolId);

    /**
     * 批量保存雇主信息
     *
     * @param schoolId 院校ID
     * @param employers 雇主列表
     * @return 是否成功
     */
    Boolean saveEmployers(Long schoolId, List<Employer> employers);

    /**
     * 根据院校ID删除雇主信息
     *
     * @param schoolId 院校ID
     * @return 是否成功
     */
    Boolean deleteBySchoolId(Long schoolId);

    /**
     * 根据行业类型查询雇主
     *
     * @param industry 行业类型
     * @return 雇主列表
     */
    List<Employer> getByIndustry(String industry);
} 