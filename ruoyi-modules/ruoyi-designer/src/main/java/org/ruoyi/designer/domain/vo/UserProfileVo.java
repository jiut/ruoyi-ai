package org.ruoyi.designer.domain.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;
import org.ruoyi.designer.domain.Designer;
import org.ruoyi.designer.domain.Enterprise;
import org.ruoyi.designer.domain.School;
import org.ruoyi.designer.domain.UserBinding;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

/**
 * 用户档案视图对象
 *
 * @author ruoyi
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class UserProfileVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 用户ID
     */
    private Long userId;

    /**
     * 用户名
     */
    private String userName;

    /**
     * 昵称
     */
    private String nickName;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 手机号
     */
    private String phonenumber;

    /**
     * 头像
     */
    private String avatar;

    /**
     * 绑定关系列表
     */
    private List<UserBinding> bindings;

    /**
     * 设计师信息
     */
    private Designer designer;

    /**
     * 企业信息
     */
    private Enterprise enterprise;

    /**
     * 院校信息
     */
    private School school;

    /**
     * 用户角色列表
     */
    private List<String> roles;

    /**
     * 权限列表
     */
    private List<String> permissions;
} 