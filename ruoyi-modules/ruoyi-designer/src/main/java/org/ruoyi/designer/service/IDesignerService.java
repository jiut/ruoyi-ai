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
     * 恢复已删除的设计师
     *
     * @param designerIds 需要恢复的设计师ID
     * @return 结果
     */
    Boolean restoreDesignerByIds(List<Long> designerIds);

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

    /**
     * 查询设计师公开信息列表（企业招聘使用）
     * 只返回公开的设计师信息，隐藏敏感信息
     *
     * @param designer 设计师查询条件
     * @return 设计师公开信息集合
     */
    TableDataInfo<Designer> selectPublicDesignerList(Designer designer);

    /**
     * 根据院校查询设计师列表
     * 院校管理员查看本校设计师使用
     *
     * @param designer 设计师查询条件
     * @param schoolId 院校ID
     * @return 设计师集合
     */
    TableDataInfo<Designer> selectDesignerListBySchool(Designer designer, Long schoolId);

    // ==================== 新增状态控制方法 ====================

    /**
     * 更新设计师状态（启用/停用）
     *
     * @param designerId 设计师ID
     * @param status 状态（0正常 1停用）
     * @return 更新结果
     */
    Boolean updateDesignerStatus(Long designerId, String status);

    /**
     * 批量更新设计师状态
     *
     * @param designerIds 设计师ID列表
     * @param status 状态（0正常 1停用）
     * @return 更新结果
     */
    Boolean batchUpdateDesignerStatus(List<Long> designerIds, String status);

    // ==================== 新增回收站查询方法 ====================

    /**
     * 查询包含已删除数据的设计师列表（管理员专用）
     *
     * @param designer 设计师查询条件
     * @return 设计师集合（包含已删除数据）
     */
    TableDataInfo<Designer> selectDesignerListIncludeDeleted(Designer designer);

    /**
     * 查询包含停用数据的设计师列表（管理员专用）
     *
     * @param designer 设计师查询条件
     * @return 设计师集合（包含停用数据）
     */
    TableDataInfo<Designer> selectDesignerListIncludeDisabled(Designer designer);

    /**
     * 查询回收站中的设计师列表（仅已删除数据）
     *
     * @return 已删除的设计师集合
     */
    TableDataInfo<Designer> selectRecycleDesignerList();

    /**
     * 查询停用的设计师列表
     *
     * @return 停用的设计师集合
     */
    TableDataInfo<Designer> selectDisabledDesignerList();
} 