package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.designer.domain.Designer;

import java.util.List;

/**
 * 设计师Service接口
 *
 * @author ruoyi
 */
public interface IDesignerService extends IService<Designer> {

    /**
     * 查询设计师列表
     *
     * @param designer 设计师
     * @return 设计师集合
     */
    TableDataInfo<Designer> selectDesignerList(Designer designer);

    /**
     * 根据设计师ID查询设计师信息
     *
     * @param designerId 设计师ID
     * @return 设计师信息
     */
    Designer selectDesignerById(Long designerId);

    /**
     * 根据用户ID查询设计师
     *
     * @param userId 用户ID
     * @return 设计师信息
     */
    Designer selectDesignerByUserId(Long userId);

    /**
     * 新增设计师
     *
     * @param designer 设计师
     * @return 结果
     */
    Boolean insertDesigner(Designer designer);

    /**
     * 修改设计师
     *
     * @param designer 设计师
     * @return 结果
     */
    Boolean updateDesigner(Designer designer);

    /**
     * 批量删除设计师
     *
     * @param designerIds 需要删除的设计师ID
     * @return 结果
     */
    Boolean deleteDesignerByIds(List<Long> designerIds);

    /**
     * 根据职业查询设计师
     *
     * @param profession 职业
     * @return 设计师列表
     */
    List<Designer> selectDesignerByProfession(String profession);

    /**
     * 根据技能标签查询设计师
     *
     * @param skillTags 技能标签
     * @return 设计师列表
     */
    List<Designer> selectDesignerBySkillTags(List<String> skillTags);

    /**
     * 根据院校查询设计师
     *
     * @param schoolId 院校ID
     * @return 设计师列表
     */
    List<Designer> selectDesignerBySchool(Long schoolId);

    /**
     * 根据企业查询设计师
     *
     * @param enterpriseId 企业ID
     * @return 设计师列表
     */
    List<Designer> selectDesignerByEnterprise(Long enterpriseId);
} 