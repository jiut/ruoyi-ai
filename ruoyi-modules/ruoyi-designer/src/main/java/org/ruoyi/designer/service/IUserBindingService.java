package org.ruoyi.designer.service;

import com.baomidou.mybatisplus.extension.service.IService;
import org.ruoyi.designer.domain.UserBinding;
import org.ruoyi.designer.domain.enums.UnbindResult;
import org.ruoyi.designer.domain.enums.UserEntityType;

import java.util.List;

/**
 * 用户绑定Service接口
 *
 * @author ruoyi
 */
public interface IUserBindingService extends IService<UserBinding> {

    /**
     * 绑定用户与实体
     *
     * @param userId 用户ID
     * @param entityType 实体类型
     * @param entityId 实体ID
     * @return 结果
     */
    Boolean bindUserToEntity(Long userId, UserEntityType entityType, Long entityId);

    /**
     * 解绑用户与实体
     *
     * @param userId 用户ID
     * @param entityType 实体类型
     * @return 结果
     */
    Boolean unbindUserFromEntity(Long userId, UserEntityType entityType);

    /**
     * 解绑用户与实体（返回详细状态）
     *
     * @param userId 用户ID
     * @param entityType 实体类型
     * @return 解绑结果状态
     */
    UnbindResult unbindUserFromEntityWithResult(Long userId, UserEntityType entityType);

    /**
     * 根据用户ID和实体类型查询绑定关系
     *
     * @param userId 用户ID
     * @param entityType 实体类型
     * @return 绑定关系
     */
    UserBinding getBindingByUserIdAndEntityType(Long userId, UserEntityType entityType);

    /**
     * 根据实体类型和实体ID查询绑定关系
     *
     * @param entityType 实体类型
     * @param entityId 实体ID
     * @return 绑定关系
     */
    UserBinding getBindingByEntityTypeAndId(UserEntityType entityType, Long entityId);

    /**
     * 根据用户ID查询所有绑定关系
     *
     * @param userId 用户ID
     * @return 绑定关系列表
     */
    List<UserBinding> getBindingsByUserId(Long userId);

    /**
     * 检查用户是否有指定类型的绑定
     *
     * @param userId 用户ID
     * @param entityType 实体类型
     * @return 是否已绑定
     */
    Boolean isUserBoundToEntityType(Long userId, UserEntityType entityType);

    /**
     * 获取用户绑定的设计师ID
     *
     * @param userId 用户ID
     * @return 设计师ID
     */
    Long getDesignerIdByUserId(Long userId);

    /**
     * 获取用户绑定的企业ID
     *
     * @param userId 用户ID
     * @return 企业ID
     */
    Long getEnterpriseIdByUserId(Long userId);

    /**
     * 获取用户绑定的院校ID
     *
     * @param userId 用户ID
     * @return 院校ID
     */
    Long getSchoolIdByUserId(Long userId);

    /**
     * 根据用户ID和实体类型查询绑定关系（包括所有状态）
     * 用于检查用户是否曾经有过绑定记录
     *
     * @param userId 用户ID
     * @param entityType 实体类型
     * @return 绑定关系
     */
    UserBinding getBindingByUserIdAndEntityTypeAllStatus(Long userId, UserEntityType entityType);
} 