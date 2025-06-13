package org.ruoyi.designer.domain;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.EqualsAndHashCode;
import org.ruoyi.core.domain.BaseEntity;

import java.io.Serial;

/**
 * 用户绑定关系对象 des_user_binding
 *
 * @author ruoyi
 */
@Data
@EqualsAndHashCode(callSuper = true)
@TableName("des_user_binding")
public class UserBinding extends BaseEntity {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 绑定ID
     */
    @TableId(value = "binding_id")
    private Long bindingId;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 实体类型（designer/enterprise/school）
     */
    private String entityType;

    /**
     * 实体ID
     */
    private Long entityId;

    /**
     * 绑定状态（0解绑 1绑定）
     */
    private String bindingStatus;
} 