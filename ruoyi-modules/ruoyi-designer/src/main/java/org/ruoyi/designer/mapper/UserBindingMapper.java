package org.ruoyi.designer.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.ruoyi.designer.domain.UserBinding;

import java.util.List;

/**
 * 用户绑定Mapper接口
 *
 * @author ruoyi
 */
public interface UserBindingMapper extends BaseMapper<UserBinding> {

    /**
     * 根据用户ID和实体类型查询绑定关系
     *
     * @param userId 用户ID
     * @param entityType 实体类型
     * @return 绑定关系
     */
    @Select("SELECT * FROM des_user_binding WHERE user_id = #{userId} AND entity_type = #{entityType} AND binding_status = '1'")
    UserBinding selectByUserIdAndEntityType(@Param("userId") Long userId, @Param("entityType") String entityType);

    /**
     * 根据实体类型和实体ID查询绑定关系
     *
     * @param entityType 实体类型
     * @param entityId 实体ID
     * @return 绑定关系
     */
    @Select("SELECT * FROM des_user_binding WHERE entity_type = #{entityType} AND entity_id = #{entityId} AND binding_status = '1'")
    UserBinding selectByEntityTypeAndId(@Param("entityType") String entityType, @Param("entityId") Long entityId);

    /**
     * 根据用户ID查询所有绑定关系
     *
     * @param userId 用户ID
     * @return 绑定关系列表
     */
    @Select("SELECT * FROM des_user_binding WHERE user_id = #{userId} AND binding_status = '1'")
    List<UserBinding> selectByUserId(@Param("userId") Long userId);

    /**
     * 根据用户ID和实体类型查询绑定关系（包括所有状态）
     * 用于绑定操作时检查是否存在记录
     *
     * @param userId 用户ID
     * @param entityType 实体类型
     * @return 绑定关系
     */
    @Select("SELECT * FROM des_user_binding WHERE user_id = #{userId} AND entity_type = #{entityType}")
    UserBinding selectByUserIdAndEntityTypeAllStatus(@Param("userId") Long userId, @Param("entityType") String entityType);
} 