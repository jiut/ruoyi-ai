package org.ruoyi.designer.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.RequiredArgsConstructor;
import org.ruoyi.designer.domain.UserBinding;
import org.ruoyi.designer.domain.enums.UnbindResult;
import org.ruoyi.designer.domain.enums.UserEntityType;
import org.ruoyi.designer.mapper.UserBindingMapper;
import org.ruoyi.designer.service.IUserBindingService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 用户绑定Service业务层处理
 *
 * @author ruoyi
 */
@RequiredArgsConstructor
@Service
public class UserBindingServiceImpl extends ServiceImpl<UserBindingMapper, UserBinding> implements IUserBindingService {

    private final UserBindingMapper userBindingMapper;

    @Override
    public Boolean bindUserToEntity(Long userId, UserEntityType entityType, Long entityId) {
        // 先检查是否已经存在绑定关系（包括所有状态）
        UserBinding existing = userBindingMapper.selectByUserIdAndEntityTypeAllStatus(userId, entityType.getCode());
        if (existing != null) {
            // 如果已存在记录，更新绑定状态和实体ID（重新激活绑定）
            existing.setEntityId(entityId);
            existing.setBindingStatus("1");
            return updateById(existing);
        }
        
        // 创建新的绑定关系
        UserBinding binding = new UserBinding();
        binding.setUserId(userId);
        binding.setEntityType(entityType.getCode());
        binding.setEntityId(entityId);
        binding.setBindingStatus("1");
        
        return save(binding);
    }

    @Override
    public Boolean unbindUserFromEntity(Long userId, UserEntityType entityType) {
        // 查询包括所有状态的绑定记录
        UserBinding binding = userBindingMapper.selectByUserIdAndEntityTypeAllStatus(userId, entityType.getCode());
        if (binding != null && "1".equals(binding.getBindingStatus())) {
            // 只有当前状态为绑定时才执行解绑操作
            binding.setBindingStatus("0");
            return updateById(binding);
        }
        return true;
    }

    @Override
    public UnbindResult unbindUserFromEntityWithResult(Long userId, UserEntityType entityType) {
        // 查询包括所有状态的绑定记录
        UserBinding binding = userBindingMapper.selectByUserIdAndEntityTypeAllStatus(userId, entityType.getCode());
        
        if (binding == null) {
            // 用户从未绑定过该身份
            return UnbindResult.NOT_BOUND;
        }
        
        if ("0".equals(binding.getBindingStatus())) {
            // 用户已经处于解绑状态
            return UnbindResult.ALREADY_UNBOUND;
        }
        
        if ("1".equals(binding.getBindingStatus())) {
            // 执行解绑操作
            binding.setBindingStatus("0");
            if (updateById(binding)) {
                return UnbindResult.SUCCESS;
            } else {
                return UnbindResult.FAILED;
            }
        }
        
        // 未知状态，返回失败
        return UnbindResult.FAILED;
    }

    @Override
    public UserBinding getBindingByUserIdAndEntityType(Long userId, UserEntityType entityType) {
        return userBindingMapper.selectByUserIdAndEntityType(userId, entityType.getCode());
    }

    @Override
    public UserBinding getBindingByEntityTypeAndId(UserEntityType entityType, Long entityId) {
        return userBindingMapper.selectByEntityTypeAndId(entityType.getCode(), entityId);
    }

    @Override
    public List<UserBinding> getBindingsByUserId(Long userId) {
        return userBindingMapper.selectByUserId(userId);
    }

    @Override
    public Boolean isUserBoundToEntityType(Long userId, UserEntityType entityType) {
        UserBinding binding = getBindingByUserIdAndEntityType(userId, entityType);
        return binding != null;
    }

    @Override
    public Long getDesignerIdByUserId(Long userId) {
        UserBinding binding = getBindingByUserIdAndEntityType(userId, UserEntityType.DESIGNER);
        return binding != null ? binding.getEntityId() : null;
    }

    @Override
    public Long getEnterpriseIdByUserId(Long userId) {
        UserBinding binding = getBindingByUserIdAndEntityType(userId, UserEntityType.ENTERPRISE);
        return binding != null ? binding.getEntityId() : null;
    }

    @Override
    public Long getSchoolIdByUserId(Long userId) {
        UserBinding binding = getBindingByUserIdAndEntityType(userId, UserEntityType.SCHOOL);
        return binding != null ? binding.getEntityId() : null;
    }

    @Override
    public UserBinding getBindingByUserIdAndEntityTypeAllStatus(Long userId, UserEntityType entityType) {
        return userBindingMapper.selectByUserIdAndEntityTypeAllStatus(userId, entityType.getCode());
    }

    @Override
    public Boolean unbindByEntityTypeAndId(UserEntityType entityType, Long entityId) {
        // 查询指定实体的绑定关系
        UserBinding binding = userBindingMapper.selectByEntityTypeAndId(entityType.getCode(), entityId);
        if (binding != null && "1".equals(binding.getBindingStatus())) {
            // 将绑定状态设置为解绑
            binding.setBindingStatus("0");
            return updateById(binding);
        }
        return true; // 如果没有绑定关系或已经是解绑状态，返回成功
    }

    @Override
    public Boolean batchUnbindByEntityTypeAndIds(UserEntityType entityType, List<Long> entityIds) {
        if (entityIds == null || entityIds.isEmpty()) {
            return true;
        }
        
        // 批量更新绑定状态为解绑
        LambdaUpdateWrapper<UserBinding> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(UserBinding::getEntityType, entityType.getCode())
                .in(UserBinding::getEntityId, entityIds)
                .eq(UserBinding::getBindingStatus, "1")  // 只更新当前为绑定状态的记录
                .set(UserBinding::getBindingStatus, "0"); // 设置为解绑状态
        
        return update(wrapper);
    }

    @Override
    public Boolean batchRestoreByEntityTypeAndIds(UserEntityType entityType, List<Long> entityIds) {
        if (entityIds == null || entityIds.isEmpty()) {
            return true;
        }
        
        // 批量恢复绑定状态
        LambdaUpdateWrapper<UserBinding> wrapper = new LambdaUpdateWrapper<>();
        wrapper.eq(UserBinding::getEntityType, entityType.getCode())
                .in(UserBinding::getEntityId, entityIds)
                .eq(UserBinding::getBindingStatus, "0")  // 只恢复当前为解绑状态的记录
                .set(UserBinding::getBindingStatus, "1"); // 设置为绑定状态
        
        return update(wrapper);
    }
} 