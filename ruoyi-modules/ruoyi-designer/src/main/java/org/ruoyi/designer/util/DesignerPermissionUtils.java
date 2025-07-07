package org.ruoyi.designer.util;

import org.ruoyi.common.satoken.utils.LoginHelper;
import org.ruoyi.designer.domain.UserBinding;
import org.ruoyi.designer.domain.enums.UserEntityType;
import org.ruoyi.designer.service.IUserBindingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;

/**
 * 设计师权限控制工具类
 *
 * @author ruoyi
 */
@Component
public class DesignerPermissionUtils {

    @Autowired
    private IUserBindingService userBindingService;

    /**
     * 检查当前用户是否为设计师
     *
     * @return 是否为设计师
     */
    public boolean isDesigner() {
        Long userId = LoginHelper.getUserId();
        return userBindingService.isUserBoundToEntityType(userId, UserEntityType.DESIGNER);
    }

    /**
     * 检查当前用户是否为企业用户
     *
     * @return 是否为企业用户
     */
    public boolean isEnterprise() {
        Long userId = LoginHelper.getUserId();
        return userBindingService.isUserBoundToEntityType(userId, UserEntityType.ENTERPRISE);
    }

    /**
     * 检查当前用户是否为院校用户
     *
     * @return 是否为院校用户
     */
    public boolean isSchool() {
        Long userId = LoginHelper.getUserId();
        return userBindingService.isUserBoundToEntityType(userId, UserEntityType.SCHOOL);
    }

    /**
     * 获取当前用户绑定的设计师ID
     *
     * @return 设计师ID
     */
    public Long getCurrentDesignerId() {
        Long userId = LoginHelper.getUserId();
        return userBindingService.getDesignerIdByUserId(userId);
    }

    /**
     * 获取当前用户绑定的企业ID
     *
     * @return 企业ID
     */
    public Long getCurrentEnterpriseId() {
        Long userId = LoginHelper.getUserId();
        return userBindingService.getEnterpriseIdByUserId(userId);
    }

    /**
     * 获取当前用户绑定的院校ID
     *
     * @return 院校ID
     */
    public Long getCurrentSchoolId() {
        Long userId = LoginHelper.getUserId();
        return userBindingService.getSchoolIdByUserId(userId);
    }

    /**
     * 检查当前用户是否拥有指定设计师的权限
     *
     * @param designerId 设计师ID
     * @return 是否拥有权限
     */
    public boolean hasDesignerPermission(Long designerId) {
        if (LoginHelper.isSuperAdmin()) {
            return true;
        }
        Long currentDesignerId = getCurrentDesignerId();
        return currentDesignerId != null && currentDesignerId.equals(designerId);
    }

    /**
     * 检查当前用户是否拥有指定企业的权限
     *
     * @param enterpriseId 企业ID
     * @return 是否拥有权限
     */
    public boolean hasEnterprisePermission(Long enterpriseId) {
        if (LoginHelper.isSuperAdmin()) {
            return true;
        }
        Long currentEnterpriseId = getCurrentEnterpriseId();
        return currentEnterpriseId != null && currentEnterpriseId.equals(enterpriseId);
    }

    /**
     * 检查当前用户是否拥有指定院校的权限
     *
     * @param schoolId 院校ID
     * @return 是否拥有权限
     */
    public boolean hasSchoolPermission(Long schoolId) {
        if (LoginHelper.isSuperAdmin()) {
            return true;
        }
        Long currentSchoolId = getCurrentSchoolId();
        return currentSchoolId != null && currentSchoolId.equals(schoolId);
    }

    /**
     * 检查当前用户是否可以查看指定设计师的详细信息
     *
     * @param designerId 设计师ID
     * @return 是否可以查看
     */
    public boolean canViewDesignerDetail(Long designerId) {
        // 管理员可以查看所有
        if (LoginHelper.isSuperAdmin()) {
            return true;
        }
        
        // 设计师可以查看自己的信息
        if (hasDesignerPermission(designerId)) {
            return true;
        }
        
        // 企业用户可以查看设计师的公开信息
        if (isEnterprise()) {
            return true;
        }
        
        // 院校用户可以查看本校设计师的信息
        if (isSchool()) {
            // 这里需要额外的逻辑来判断设计师是否属于该院校
            return true;
        }
        
        return false;
    }

    /**
     * 检查用户是否有权限编辑指定设计师的数据
     * 
     * @param designerId 设计师ID
     * @return 是否有权限
     */
    public boolean hasPermissionToEdit(Long designerId) {
        // 管理员有所有权限
        if (LoginHelper.isSuperAdmin()) {
            return true;
        }
        
        // 检查是否为当前用户的设计师ID
        Long currentDesignerId = getCurrentDesignerIdSafely();
        return currentDesignerId != null && currentDesignerId.equals(designerId);
    }

    /**
     * 获取当前用户的设计师ID（安全版本）
     * 
     * @return 设计师ID，如果未绑定则返回null
     */
    public Long getCurrentDesignerIdSafely() {
        try {
            Long userId = LoginHelper.getUserId();
            if (userId == null) {
                return null;
            }
            
            List<UserBinding> bindings = userBindingService.getBindingsByUserId(userId);
            return extractDesignerId(bindings);
        } catch (Exception e) {
            return null;
        }
    }

    /**
     * 从用户绑定信息中提取设计师ID
     * 
     * @param bindings 绑定信息列表
     * @return 设计师ID
     */
    public Long extractDesignerId(List<UserBinding> bindings) {
        if (bindings == null || bindings.isEmpty()) {
            return null;
        }
        
        return bindings.stream()
            .filter(binding -> UserEntityType.DESIGNER.getCode().equals(binding.getEntityType()) 
                            && "1".equals(binding.getBindingStatus()))
            .map(UserBinding::getEntityId)
            .findFirst()
            .orElse(null);
    }

    /**
     * 验证设计师ID是否有效
     * 
     * @param designerId 设计师ID
     * @return 是否有效
     */
    public boolean isValidDesignerId(Long designerId) {
        return designerId != null && designerId > 0;
    }
} 