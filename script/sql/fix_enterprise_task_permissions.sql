-- ====================================================================
-- 智图工厂企业任务权限修复脚本
-- 修复企业管理员缺失的任务编辑和删除权限
-- 日期：2025-01-27
-- ====================================================================

SET FOREIGN_KEY_CHECKS = 0;

-- 1. 添加缺失的企业专用权限码
INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES 
-- 企业任务编辑权限
(9002, '企业任务编辑权限', 0, 98, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:enterprise:task:edit', '#', NULL, 1, NOW(), 1, NOW(), '企业管理员编辑任务权限'),

-- 企业任务删除权限  
(9003, '企业任务删除权限', 0, 99, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:enterprise:task:delete', '#', NULL, 1, NOW(), 1, NOW(), '企业管理员删除任务权限'),

-- 企业任务发布权限
(9004, '企业任务发布权限', 0, 100, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:enterprise:task:publish', '#', NULL, 1, NOW(), 1, NOW(), '企业管理员发布任务权限'),

-- 企业任务取消权限
(9005, '企业任务取消权限', 0, 101, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:enterprise:task:cancel', '#', NULL, 1, NOW(), 1, NOW(), '企业管理员取消任务权限');

-- 2. 为超级管理员角色(ID=1)分配新权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES 
(1, 9002),  -- 企业任务编辑权限
(1, 9003),  -- 企业任务删除权限
(1, 9004),  -- 企业任务发布权限
(1, 9005);  -- 企业任务取消权限

-- 3. 为企业管理员角色(ID=1932319128081666051)分配新权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES 
(1932319128081666051, 9002),  -- 企业任务编辑权限
(1932319128081666051, 9003),  -- 企业任务删除权限
(1932319128081666051, 9004),  -- 企业任务发布权限
(1932319128081666051, 9005);  -- 企业任务取消权限

-- 4. 验证权限配置
SELECT '=== 企业专用权限码检查 ===' AS status;
SELECT menu_id, menu_name, perms 
FROM sys_menu 
WHERE perms LIKE '%designer:enterprise:task%' 
ORDER BY perms;

SELECT '=== 企业管理员权限分配检查 ===' AS status;
SELECT r.role_name, m.menu_name, m.perms 
FROM sys_role r
JOIN sys_role_menu rm ON r.role_id = rm.role_id
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE r.role_key = 'enterprise' 
  AND m.perms LIKE '%designer:enterprise:task%'
ORDER BY m.perms;

SET FOREIGN_KEY_CHECKS = 1;

-- ====================================================================
-- 修复完成提示
-- ====================================================================
SELECT '智图工厂企业任务权限修复完成！' AS status,
       '新增权限：designer:enterprise:task:edit, designer:enterprise:task:delete, designer:enterprise:task:publish, designer:enterprise:task:cancel' AS new_permissions,
       '已为企业管理员角色分配相应权限' AS role_assignment; 