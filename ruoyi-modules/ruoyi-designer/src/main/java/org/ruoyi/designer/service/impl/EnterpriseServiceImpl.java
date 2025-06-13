package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.core.page.TableDataInfo;
import org.ruoyi.common.core.utils.StringUtils;
import org.ruoyi.core.page.PageQuery;
import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.designer.domain.Enterprise;
import org.ruoyi.designer.mapper.EnterpriseMapper;
import org.ruoyi.designer.service.IEnterpriseService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 企业Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class EnterpriseServiceImpl extends ServiceImpl<EnterpriseMapper, Enterprise> implements IEnterpriseService {

    private final EnterpriseMapper enterpriseMapper;

    @Override
    public TableDataInfo<Enterprise> selectEnterpriseList(Enterprise enterprise, PageQuery pageQuery) {
        LambdaQueryWrapper<Enterprise> wrapper = new LambdaQueryWrapper<>();
        wrapper.like(StringUtils.isNotBlank(enterprise.getEnterpriseName()), Enterprise::getEnterpriseName, enterprise.getEnterpriseName())
                .eq(StringUtils.isNotBlank(enterprise.getIndustry()), Enterprise::getIndustry, enterprise.getIndustry())
                .eq(StringUtils.isNotBlank(enterprise.getScale()), Enterprise::getScale, enterprise.getScale())
                .eq(StringUtils.isNotBlank(enterprise.getStatus()), Enterprise::getStatus, enterprise.getStatus())
                .orderByDesc(Enterprise::getCreateTime);
        
        Page<Enterprise> page = enterpriseMapper.selectPage(pageQuery.build(), wrapper);
        return TableDataInfo.build(page);
    }

    @Override
    public Enterprise selectEnterpriseById(Long enterpriseId) {
        return enterpriseMapper.selectById(enterpriseId);
    }

    @Override
    public Boolean insertEnterprise(Enterprise enterprise) {
        // 设置当前用户ID
        enterprise.setUserId(LoginHelper.getUserId());
        return save(enterprise);
    }

    @Override
    public Boolean updateEnterprise(Enterprise enterprise) {
        // 如果没有提供企业ID，则根据当前用户ID查找企业
        if (enterprise.getEnterpriseId() == null) {
            Long userId = LoginHelper.getUserId();
            Enterprise existingEnterprise = selectEnterpriseByUserId(userId);
            if (existingEnterprise == null) {
                throw new RuntimeException("当前用户未绑定企业信息");
            }
            enterprise.setEnterpriseId(existingEnterprise.getEnterpriseId());
            enterprise.setUserId(userId);
        }
        return updateById(enterprise);
    }

    @Override
    public Boolean deleteEnterpriseByIds(List<Long> enterpriseIds) {
        return removeByIds(enterpriseIds);
    }

    @Override
    public Enterprise selectEnterpriseByUserId(Long userId) {
        LambdaQueryWrapper<Enterprise> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Enterprise::getUserId, userId)
                .eq(Enterprise::getStatus, "0");
        return enterpriseMapper.selectOne(wrapper);
    }
} 