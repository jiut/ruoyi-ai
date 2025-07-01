package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.Employer;
import org.ruoyi.designer.mapper.EmployerMapper;
import org.ruoyi.designer.service.IEmployerService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * 代表性雇主Service业务层处理
 *
 * @author ruoyi
 * @date 2024-12-28
 */
@RequiredArgsConstructor
@Service
public class EmployerServiceImpl extends ServiceImpl<EmployerMapper, Employer> implements IEmployerService {

    private final EmployerMapper baseMapper;

    /**
     * 根据院校ID获取代表性雇主列表
     */
    @Override
    public List<Employer> getBySchoolId(Long schoolId) {
        return baseMapper.selectBySchoolId(schoolId);
    }

    /**
     * 批量保存雇主信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean saveEmployers(Long schoolId, List<Employer> employers) {
        if (employers == null || employers.isEmpty()) {
            return true;
        }
        
        // 删除原有数据
        LambdaQueryWrapper<Employer> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Employer::getSchoolId, schoolId);
        baseMapper.delete(queryWrapper);
        
        // 设置院校ID并批量插入
        employers.forEach(employer -> employer.setSchoolId(schoolId));
        return saveBatch(employers);
    }

    /**
     * 根据院校ID删除雇主信息
     */
    @Override
    @Transactional(rollbackFor = Exception.class)
    public Boolean deleteBySchoolId(Long schoolId) {
        LambdaQueryWrapper<Employer> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Employer::getSchoolId, schoolId);
        return remove(queryWrapper);
    }

    /**
     * 根据行业类型查询雇主
     */
    @Override
    public List<Employer> getByIndustry(String industry) {
        LambdaQueryWrapper<Employer> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(Employer::getIndustry, industry);
        return baseMapper.selectList(queryWrapper);
    }
} 