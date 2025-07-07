package org.ruoyi.common.core.constant;

/**
 * 用户常量信息
 *
 * @author ruoyi
 */
public interface UserConstants {

    /**
     * 平台内系统用户的唯一标志
     */
    String SYS_USER = "SYS_USER";

    /**
     * 正常状态
     */
    String NORMAL = "0";

    /**
     * 异常状态
     */
    String EXCEPTION = "1";

    /**
     * 用户正常状态
     */
    String USER_NORMAL = "0";

    /**
     * 用户封禁状态
     */
    String USER_DISABLE = "1";

    /**
     * 角色正常状态
     */
    String ROLE_NORMAL = "0";

    /**
     * 角色封禁状态
     */
    String ROLE_DISABLE = "1";

    /**
     * 部门正常状态
     */
    String DEPT_NORMAL = "0";

    /**
     * 部门停用状态
     */
    String DEPT_DISABLE = "1";

    /**
     * 字典正常状态
     */
    String DICT_NORMAL = "0";

    /**
     * 是否为系统默认（是）
     */
    String YES = "Y";

    /**
     * 是否菜单外链（是）
     */
    String YES_FRAME = "0";

    /**
     * 是否菜单外链（否）
     */
    String NO_FRAME = "1";

    /**
     * 菜单正常状态
     */
    String MENU_NORMAL = "0";

    /**
     * 菜单停用状态
     */
    String MENU_DISABLE = "1";

    /**
     * 菜单类型（目录）
     */
    String TYPE_DIR = "M";

    /**
     * 菜单类型（菜单）
     */
    String TYPE_MENU = "C";

    /**
     * 菜单类型（按钮）
     */
    String TYPE_BUTTON = "F";

    /**
     * Layout组件标识
     */
    String LAYOUT = "Layout";

    /**
     * ParentView组件标识
     */
    String PARENT_VIEW = "ParentView";

    /**
     * InnerLink组件标识
     */
    String INNER_LINK = "InnerLink";

    /**
     * 用户名长度限制
     */
    int USERNAME_MIN_LENGTH = 2;
    int USERNAME_MAX_LENGTH = 100;

    /**
     * 密码长度限制
     */
    int PASSWORD_MIN_LENGTH = 5;
    int PASSWORD_MAX_LENGTH = 20;

    /**
     * 超级管理员ID
     */
    Long SUPER_ADMIN_ID = 1L;

    /**
     * 角色标识常量
     */
    interface RoleKeys {
        /**
         * 设计师角色标识
         */
        String DESIGNER = "designer";
        
        /**
         * 企业管理员角色标识
         */
        String ENTERPRISE = "enterprise";
        
        /**
         * 院校管理员角色标识
         */
        String SCHOOL = "school";
        
        /**
         * 超级管理员角色标识
         */
        String ADMIN = "admin";
        
        /**
         * 普通用户角色标识
         */
        String COMMON = "common";
    }

    /**
     * 角色ID常量（用于系统内部引用）
     */
    interface RoleIds {
        /**
         * 普通角色ID
         */
        Long COMMON_ROLE_ID = 2L;
        
        /**
         * 设计师角色ID
         */
        Long DESIGNER_ROLE_ID = 1932319128081666050L;
        
        /**
         * 企业管理员角色ID
         */
        Long ENTERPRISE_ROLE_ID = 1932319128081666051L;
        
        /**
         * 院校管理员角色ID
         */
        Long SCHOOL_ROLE_ID = 1932319128081666052L;
    }

    /**
     * 获取角色显示名称
     */
    static String getRoleDisplayName(String roleKey) {
        switch (roleKey) {
            case RoleKeys.DESIGNER:
                return "设计师";
            case RoleKeys.ENTERPRISE:
                return "企业管理员";
            case RoleKeys.SCHOOL:
                return "院校管理员";
            case RoleKeys.ADMIN:
                return "系统管理员";
            case RoleKeys.COMMON:
                return "普通用户";
            default:
                return roleKey;
        }
    }

}
