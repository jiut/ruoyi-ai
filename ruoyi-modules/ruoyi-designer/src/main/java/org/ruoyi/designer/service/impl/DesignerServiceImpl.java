package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.designer.domain.Designer;
import org.ruoyi.designer.domain.enums.GenderEnum;
import org.ruoyi.designer.mapper.DesignerMapper;
import org.ruoyi.designer.service.IDesignerService;
import org.ruoyi.designer.service.IWorkExperienceService;
import org.ruoyi.designer.service.IEducationService;
import org.ruoyi.designer.service.IWorkService;
import org.ruoyi.designer.service.IAwardService;
import org.ruoyi.designer.service.IJobApplicationService;
import org.ruoyi.designer.util.DesignerPermissionUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;
import org.ruoyi.common.core.exception.ServiceException;

import java.util.List;
import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.Date;
import org.ruoyi.designer.service.IUserBindingService;
import org.ruoyi.designer.domain.enums.UserEntityType;

/**
 * 设计师Service业务层处理
 *
 * @author ruoyi
 */
@Slf4j
@RequiredArgsConstructor
@Service
public class DesignerServiceImpl extends ServiceImpl<DesignerMapper, Designer> implements IDesignerService {

    private final DesignerMapper designerMapper;
    private final IWorkExperienceService workExperienceService;
    private final IEducationService educationService;
    private final IWorkService workService;
    private final IAwardService awardService;
    private final IJobApplicationService jobApplicationService;
    private final DesignerPermissionUtils permissionUtils;
    private final IUserBindingService userBindingService;

    /**
     * 查询设计师列表
     */
    @Override
    public TableDataInfo<Designer> selectDesignerList(Designer designer) {
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(designer.getDesignerName()), Designer::getDesignerName, designer.getDesignerName())
                .eq(StringUtils.isNotBlank(designer.getProfession()), Designer::getProfession, designer.getProfession())
                .eq(designer.getSchoolId() != null, Designer::getSchoolId, designer.getSchoolId())
                .eq(designer.getEnterpriseId() != null, Designer::getEnterpriseId, designer.getEnterpriseId())
                .eq(StringUtils.isNotBlank(designer.getStatus()), Designer::getStatus, designer.getStatus())
                .orderByDesc(Designer::getCreateTime);
        
        PageQuery pageQuery = new PageQuery(20, 1);  // 使用默认分页参数
        Page<Designer> page = designerMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    /**
     * 根据设计师ID查询设计师信息
     */
    @Override
    public Designer selectDesignerById(Long designerId) {
        return designerMapper.selectById(designerId);
    }

    /**
     * 新增设计师
     */
    @Override
    public Boolean insertDesigner(Designer designer) {
        // 设置当前用户ID
        designer.setUserId(LoginHelper.getUserId());
        
        // 转换性别字段：如果传入的是中文，转换为数字代码
        convertGenderField(designer);
        
        // 转换技能标签格式
        convertSkillTagsField(designer);
        
        // 转换社交链接格式
        convertSocialLinksField(designer);
        
        return save(designer);
    }

    /**
     * 修改设计师
     */
    @Override
    public Boolean updateDesigner(Designer designer) {
        // 如果没有提供设计师ID，则根据当前用户ID查找设计师
        if (designer.getDesignerId() == null) {
            Long userId = LoginHelper.getUserId();
            Designer existingDesigner = selectDesignerByUserId(userId);
            if (existingDesigner == null) {
                throw new RuntimeException("当前用户未绑定设计师信息");
            }
            designer.setDesignerId(existingDesigner.getDesignerId());
            designer.setUserId(userId);
        }
        
        // 转换性别字段：如果传入的是中文，转换为数字代码
        convertGenderField(designer);
        
        // 转换技能标签格式
        convertSkillTagsField(designer);
        
        // 转换社交链接格式
        convertSocialLinksField(designer);
        
        return updateById(designer);
    }

    /**
     * 转换性别字段
     * 如果传入的是中文（男、女、未知），转换为数字代码（0、1、2）
     * 
     * @param designer 设计师对象
     */
    private void convertGenderField(Designer designer) {
        if (StringUtils.isNotBlank(designer.getGender())) {
            String gender = designer.getGender();
            // 如果是中文，转换为数字代码
            if ("男".equals(gender) || "女".equals(gender) || "未知".equals(gender)) {
                designer.setGender(GenderEnum.convertNameToCode(gender));
            }
            // 如果已经是数字代码，保持不变
            // 如果是其他值，设置为未知
            else if (!"0".equals(gender) && !"1".equals(gender) && !"2".equals(gender)) {
                designer.setGender(GenderEnum.UNKNOWN.getCode());
            }
        }
    }

    /**
     * 转换技能标签字段
     * 如果传入的是逗号分隔的字符串，转换为JSON数组格式
     * 
     * @param designer 设计师对象
     */
    private void convertSkillTagsField(Designer designer) {
        if (StringUtils.isNotBlank(designer.getSkillTags())) {
            String skillTags = designer.getSkillTags().trim();
            
            // 如果不是JSON格式（不以[开头且不以]结尾），则认为是逗号分隔的字符串
            if (!skillTags.startsWith("[") || !skillTags.endsWith("]")) {
                // 将逗号分隔的字符串转换为JSON数组格式
                String[] tags = skillTags.split(",");
                String jsonArray = Arrays.stream(tags)
                        .map(String::trim)
                        .filter(tag -> !tag.isEmpty())
                        .map(tag -> "\"" + tag + "\"")
                        .collect(Collectors.joining(",", "[", "]"));
                designer.setSkillTags(jsonArray);
            }
            // 如果已经是JSON格式，保持不变
        }
    }

    /**
     * 转换社交链接字段
     * 验证并确保socialLinks字段是有效的JSON格式
     * 
     * @param designer 设计师对象
     */
    private void convertSocialLinksField(Designer designer) {
        if (StringUtils.isNotBlank(designer.getSocialLinks())) {
            String socialLinks = designer.getSocialLinks().trim();
            
            // 验证是否为有效的JSON格式
            try {
                ObjectMapper objectMapper = new ObjectMapper();
                // 尝试解析JSON，如果失败会抛出异常
                objectMapper.readTree(socialLinks);
                // 如果解析成功，直接使用原值
                designer.setSocialLinks(socialLinks);
            } catch (JsonProcessingException e) {
                // 如果不是有效的JSON，设置为空或默认值
                designer.setSocialLinks("{}");
            }
        }
    }

    /**
     * 批量逻辑删除设计师
     * 实现逻辑删除，并级联删除关联数据
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteDesignerByIds(List<Long> designerIds) {
        if (designerIds == null || designerIds.isEmpty()) {
            return false;
        }

        try {
            // 获取当前用户ID
            Long currentUserId = LoginHelper.getUserId();
            Date currentTime = new Date();

            // 批量更新设计师记录（逻辑删除）
            LambdaUpdateWrapper<Designer> designerWrapper = new LambdaUpdateWrapper<>();
            designerWrapper.in(Designer::getDesignerId, designerIds)
                    .set(Designer::getDelFlag, "1")  // 设置为软删除状态
                    .set(Designer::getDelTime, currentTime)
                    .set(Designer::getDelBy, currentUserId);
            
            boolean result = this.update(designerWrapper);
            
            if (result) {
                // 级联逻辑删除关联数据
                cascadeDeleteRelatedData(designerIds, currentUserId, currentTime);
            }
            
            return result;
        } catch (Exception e) {
            throw new ServiceException("删除设计师失败：" + e.getMessage());
        }
    }

    /**
     * 级联删除关联数据
     * @param designerIds 设计师ID列表
     * @param currentUserId 当前用户ID
     * @param currentTime 当前时间
     */
    private void cascadeDeleteRelatedData(List<Long> designerIds, Long currentUserId, Date currentTime) {
        // 删除工作经历
        workExperienceService.deleteByDesignerIds(designerIds, currentUserId, currentTime);
        
        // 删除教育背景
        educationService.deleteByDesignerIds(designerIds, currentUserId, currentTime);
        
        // 删除作品
        workService.deleteByDesignerIds(designerIds, currentUserId, currentTime);
        
        // 删除获奖记录
        awardService.deleteByDesignerIds(designerIds, currentUserId, currentTime);
        
        // 删除岗位申请
        jobApplicationService.deleteByDesignerIds(designerIds, currentUserId, currentTime);

        // 解除用户绑定关系（设置为解绑状态）
        userBindingService.batchUnbindByEntityTypeAndIds(UserEntityType.DESIGNER, designerIds);
    }

    /**
     * 恢复已删除的设计师及其关联数据
     * @param designerIds 设计师ID列表
     * @return 恢复结果
     */
    @Transactional(rollbackFor = Exception.class)
    public Boolean restoreDesignerByIds(List<Long> designerIds) {
        if (designerIds == null || designerIds.isEmpty()) {
            return false;
        }

        try {
            // 获取当前用户ID（仅管理员可恢复）
            if (!LoginHelper.isSuperAdmin()) {
                throw new ServiceException("无权限恢复设计师数据");
            }

            // 批量恢复设计师记录
            LambdaUpdateWrapper<Designer> designerWrapper = new LambdaUpdateWrapper<>();
            designerWrapper.in(Designer::getDesignerId, designerIds)
                    .set(Designer::getDelFlag, "0")  // 恢复为正常状态
                    .set(Designer::getDelTime, null)
                    .set(Designer::getDelBy, null);
            
            boolean result = this.update(designerWrapper);
            
            if (result) {
                // 级联恢复关联数据
                cascadeRestoreRelatedData(designerIds);
            }
            
            return result;
        } catch (Exception e) {
            throw new ServiceException("恢复设计师失败：" + e.getMessage());
        }
    }

    /**
     * 级联恢复关联数据
     * @param designerIds 设计师ID列表
     */
    private void cascadeRestoreRelatedData(List<Long> designerIds) {
        // 恢复工作经历
        workExperienceService.restoreByDesignerIds(designerIds);
        
        // 恢复教育背景
        educationService.restoreByDesignerIds(designerIds);
        
        // 恢复作品
        workService.restoreByDesignerIds(designerIds);
        
        // 恢复获奖记录
        awardService.restoreByDesignerIds(designerIds);
        
        // 恢复岗位申请
        jobApplicationService.restoreByDesignerIds(designerIds);
        
        // 恢复用户绑定关系（重新激活绑定）
        userBindingService.batchRestoreByEntityTypeAndIds(UserEntityType.DESIGNER, designerIds);
    }

    @Override
    public Designer selectDesignerByUserId(Long userId) {
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Designer::getUserId, userId)
                .eq(Designer::getStatus, "0");
        return designerMapper.selectOne(wrapper);
    }

    /**
     * 根据职业查询设计师
     */
    @Override
    public List<Designer> selectDesignerByProfession(String profession) {
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Designer::getProfession, profession)
                .eq(Designer::getStatus, "0")
                .orderByDesc(Designer::getCreateTime);
        return designerMapper.selectList(wrapper);
    }

    /**
     * 根据技能标签查询设计师
     */
    @Override
    public List<Designer> selectDesignerBySkillTags(List<String> skillTags) {
        if (skillTags == null || skillTags.isEmpty()) {
            return List.of();
        }
        
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        // 使用 JSON_CONTAINS 查询技能标签
        for (String tag : skillTags) {
            wrapper.apply("JSON_CONTAINS(skill_tags, JSON_QUOTE({0}))", tag);
        }
        wrapper.eq(Designer::getStatus, "0")
                .orderByDesc(Designer::getCreateTime);
        
        return designerMapper.selectList(wrapper);
    }

    /**
     * 根据院校查询设计师
     */
    @Override
    public List<Designer> selectDesignerBySchool(Long schoolId) {
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Designer::getSchoolId, schoolId)
                .eq(Designer::getStatus, "0")
                .orderByDesc(Designer::getCreateTime);
        return designerMapper.selectList(wrapper);
    }

    /**
     * 根据企业查询设计师
     */
    @Override
    public List<Designer> selectDesignerByEnterprise(Long enterpriseId) {
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Designer::getEnterpriseId, enterpriseId)
                .eq(Designer::getStatus, "0")
                .orderByDesc(Designer::getCreateTime);
        return designerMapper.selectList(wrapper);
    }

    /**
     * 查询公开的设计师列表（用于展示）
     */
    @Override
    public TableDataInfo<Designer> selectPublicDesignerList(Designer designer) {
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(designer.getDesignerName()), Designer::getDesignerName, designer.getDesignerName())
                .eq(StringUtils.isNotBlank(designer.getProfession()), Designer::getProfession, designer.getProfession())
                .eq(designer.getSchoolId() != null, Designer::getSchoolId, designer.getSchoolId())
                .eq(designer.getEnterpriseId() != null, Designer::getEnterpriseId, designer.getEnterpriseId())
                .eq(Designer::getStatus, "0")  // 只查询正常状态的设计师
                .orderByDesc(Designer::getCreateTime);
        
        PageQuery pageQuery = new PageQuery(20, 1);
        Page<Designer> page = designerMapper.selectPage(pageQuery.build(), wrapper);
        
        // 过滤敏感信息
        List<Designer> publicDesigners = page.getRecords().stream()
                .map(this::convertToPublicDesigner)
                .collect(Collectors.toList());
        
        page.setRecords(publicDesigners);
        return TableDataInfo.build(page);
    }

    /**
     * 根据院校查询设计师列表（院校管理员使用）
     */
    @Override
    public TableDataInfo<Designer> selectDesignerListBySchool(Designer designer, Long schoolId) {
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(designer.getDesignerName()), Designer::getDesignerName, designer.getDesignerName())
                .eq(StringUtils.isNotBlank(designer.getProfession()), Designer::getProfession, designer.getProfession())
                .eq(Designer::getSchoolId, schoolId)  // 限制为特定院校
                .eq(StringUtils.isNotBlank(designer.getStatus()), Designer::getStatus, designer.getStatus())
                .orderByDesc(Designer::getCreateTime);
        
        PageQuery pageQuery = new PageQuery(20, 1);
        Page<Designer> page = designerMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    /**
     * 转换为公开的设计师信息（过滤敏感信息）
     */
    private Designer convertToPublicDesigner(Designer designer) {
        Designer publicDesigner = new Designer();
        publicDesigner.setDesignerId(designer.getDesignerId());
        publicDesigner.setDesignerName(designer.getDesignerName());
        publicDesigner.setAvatar(designer.getAvatar());
        publicDesigner.setDescription(designer.getDescription());
        publicDesigner.setProfession(designer.getProfession());
        publicDesigner.setSkillTags(designer.getSkillTags());
        publicDesigner.setWorkYears(designer.getWorkYears());
        publicDesigner.setWorkStatus(designer.getWorkStatus());
        publicDesigner.setLocation(designer.getLocation());
        publicDesigner.setPortfolioUrl(designer.getPortfolioUrl());
        publicDesigner.setSocialLinks(designer.getSocialLinks());
        publicDesigner.setSchoolId(designer.getSchoolId());
        publicDesigner.setEnterpriseId(designer.getEnterpriseId());
        // 不包含联系方式等敏感信息
        return publicDesigner;
    }

    // ==================== 新增状态控制方法实现 ====================

    /**
     * 更新设计师状态（启用/停用）
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean updateDesignerStatus(Long designerId, String status) {
        // 1. 验证设计师是否存在
        Designer designer = this.getById(designerId);
        if (designer == null) {
            throw new ServiceException("设计师不存在");
        }

        // 2. 检查权限
        if (!hasPermissionToUpdateStatus(designerId)) {
            throw new ServiceException("无权限修改此设计师状态");
        }

        // 3. 验证状态值
        if (!"0".equals(status) && !"1".equals(status)) {
            throw new ServiceException("状态值无效");
        }

        // 4. 更新状态
        LambdaUpdateWrapper<Designer> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(Designer::getDesignerId, designerId)
                .set(Designer::getStatus, status);

        boolean result = this.update(wrapper);

        // 5. 记录状态变更日志
        if (result) {
            String operation = "0".equals(status) ? "启用" : "停用";
            log.info("设计师状态更新成功 - 设计师ID: {}, 操作: {}, 操作人: {}", 
                    designerId, operation, LoginHelper.getUserId());
        }

        return result;
    }

    /**
     * 批量更新设计师状态
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean batchUpdateDesignerStatus(List<Long> designerIds, String status) {
        if (designerIds == null || designerIds.isEmpty()) {
            return false;
        }

        // 验证权限
        for (Long designerId : designerIds) {
            if (!hasPermissionToUpdateStatus(designerId)) {
                throw new ServiceException("无权限修改设计师ID " + designerId + " 的状态");
            }
        }

        // 验证状态值
        if (!"0".equals(status) && !"1".equals(status)) {
            throw new ServiceException("状态值无效");
        }

        // 批量更新状态
        LambdaUpdateWrapper<Designer> wrapper = new LambdaUpdateWrapper<>();
        wrapper.in(Designer::getDesignerId, designerIds)
                .set(Designer::getStatus, status);

        boolean result = this.update(wrapper);

        if (result) {
            String operation = "0".equals(status) ? "启用" : "停用";
            log.info("设计师状态批量更新成功 - 设计师IDs: {}, 操作: {}, 操作人: {}", 
                    designerIds, operation, LoginHelper.getUserId());
        }

        return result;
    }

    /**
     * 检查状态更新权限
     */
    private boolean hasPermissionToUpdateStatus(Long designerId) {
        // 超级管理员无限制
        if (LoginHelper.isSuperAdmin()) {
            return true;
        }

        // 获取当前用户信息
        Long userId = LoginHelper.getUserId();
        
        // 院校管理员只能修改本校设计师状态
        if (permissionUtils.isSchool()) {
            Designer designer = this.getById(designerId);
            if (designer == null) return false;

            Long schoolId = permissionUtils.getCurrentSchoolId();
            return designer.getSchoolId() != null && designer.getSchoolId().equals(schoolId);
        }

        // 企业管理员只能修改本企业设计师状态
        if (permissionUtils.isEnterprise()) {
            Designer designer = this.getById(designerId);
            if (designer == null) return false;

            Long enterpriseId = permissionUtils.getCurrentEnterpriseId();
            return designer.getEnterpriseId() != null && designer.getEnterpriseId().equals(enterpriseId);
        }

        // 设计师不能修改状态
        return false;
    }

    // ==================== 新增回收站查询方法实现 ====================

    /**
     * 查询包含已删除数据的设计师列表（管理员专用）
     */
    @Override
    public TableDataInfo<Designer> selectDesignerListIncludeDeleted(Designer designer) {
        // 只有超级管理员可以查看已删除数据
        if (!LoginHelper.isSuperAdmin()) {
            throw new ServiceException("无权限查看已删除的设计师数据");
        }

        // 注意：由于@TableLogic的限制，这里需要特殊处理
        // 暂时返回空列表，等待后续Mapper方法扩展
        PageQuery pageQuery = new PageQuery(20, 1);
        Page<Designer> emptyPage = new Page<>(pageQuery.getPageNum(), pageQuery.getPageSize());
        emptyPage.setRecords(List.of());
        emptyPage.setTotal(0);
        
        log.warn("查询已删除数据功能需要扩展Mapper方法支持");
        return TableDataInfo.build(emptyPage);
    }

    /**
     * 查询包含停用数据的设计师列表（管理员专用）
     */
    @Override
    public TableDataInfo<Designer> selectDesignerListIncludeDisabled(Designer designer) {
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(designer.getDesignerName()), Designer::getDesignerName, designer.getDesignerName())
                .eq(StringUtils.isNotBlank(designer.getProfession()), Designer::getProfession, designer.getProfession())
                .eq(designer.getSchoolId() != null, Designer::getSchoolId, designer.getSchoolId())
                .eq(designer.getEnterpriseId() != null, Designer::getEnterpriseId, designer.getEnterpriseId())
                // 查询所有状态的数据（包括停用）
                .in(Designer::getStatus, "0", "1")
                .orderByDesc(Designer::getCreateTime);

        PageQuery pageQuery = new PageQuery(20, 1);
        Page<Designer> page = designerMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    /**
     * 查询回收站中的设计师列表（仅已删除数据）
     */
    @Override
    public TableDataInfo<Designer> selectRecycleDesignerList() {
        // 只有超级管理员可以查看回收站
        if (!LoginHelper.isSuperAdmin()) {
            throw new ServiceException("无权限查看回收站数据");
        }

        // 注意：由于@TableLogic的限制，这里需要特殊处理
        // 暂时返回空列表，等待后续Mapper方法扩展
        PageQuery pageQuery = new PageQuery(20, 1);
        Page<Designer> emptyPage = new Page<>(pageQuery.getPageNum(), pageQuery.getPageSize());
        emptyPage.setRecords(List.of());
        emptyPage.setTotal(0);
        
        log.warn("回收站查询功能需要扩展Mapper方法支持");
        return TableDataInfo.build(emptyPage);
    }

    /**
     * 查询停用的设计师列表
     */
    @Override
    public TableDataInfo<Designer> selectDisabledDesignerList() {
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Designer::getStatus, "1")  // 仅查询停用状态
                .orderByDesc(Designer::getCreateTime);

        PageQuery pageQuery = new PageQuery(20, 1);
        Page<Designer> page = designerMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }
} 