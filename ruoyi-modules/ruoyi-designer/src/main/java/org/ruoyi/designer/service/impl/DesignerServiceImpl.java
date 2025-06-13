package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.designer.domain.Designer;
import org.ruoyi.designer.domain.enums.GenderEnum;
import org.ruoyi.designer.mapper.DesignerMapper;
import org.ruoyi.designer.service.IDesignerService;
import org.springframework.stereotype.Service;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.core.JsonProcessingException;

import java.util.List;
import java.util.Arrays;
import java.util.stream.Collectors;

/**
 * 设计师Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class DesignerServiceImpl extends ServiceImpl<DesignerMapper, Designer> implements IDesignerService {

    private final DesignerMapper designerMapper;

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
     * 批量删除设计师
     */
    @Override
    public Boolean deleteDesignerByIds(List<Long> designerIds) {
        return removeByIds(designerIds);
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
        LambdaQueryWrapper<Designer> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Designer::getStatus, "0");
        
        // 使用JSON_CONTAINS函数查询包含指定技能标签的设计师
        for (String tag : skillTags) {
            wrapper.apply("JSON_CONTAINS(skill_tags, {0})", "\"" + tag + "\"");
        }
        
        wrapper.orderByDesc(Designer::getCreateTime);
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
} 