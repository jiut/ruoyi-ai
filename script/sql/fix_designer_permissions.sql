-- ====================================================================
-- 智图工厂设计师权限修复脚本
-- 修复设计师角色缺失的关键权限
-- 日期：2025-01-27
-- ====================================================================

SET FOREIGN_KEY_CHECKS = 0;

-- 1. 为设计师角色分配申请任务权限（权限码已存在）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) 
SELECT 1932319128081666050, menu_id FROM sys_menu WHERE perms = 'designer:task-application:apply';

-- 2. 添加并分配撤回申请权限码（如果不存在）
INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES (9010, '撤回申请权限', 0, 102, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task-application:withdraw', '#', NULL, 1, NOW(), 1, NOW(), '设计师撤回申请权限');

-- 为设计师角色分配撤回权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666050, 9010);

-- 3. 为设计师角色分配支付中心查看权限（权限码已存在）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) 
SELECT 1932319128081666050, menu_id FROM sys_menu WHERE perms = 'designer:task-payment:list';

-- 4. 添加支付确认权限码（如果不存在）
INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES (9012, '确认支付权限', 0, 103, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task-payment:confirm', '#', NULL, 1, NOW(), 1, NOW(), '确认支付权限');

-- 为设计师角色分配支付确认权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666050, 9012);

-- 5. 为企业管理员角色分配支付确认权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 9012);

-- 6. 为系统管理员角色分配新权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 9010);  -- 撤回申请权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 9012);  -- 支付确认权限

-- 7. 添加系统管理员审核统计权限
INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES (9011, '系统管理员审核统计权限', 0, 104, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task-application:admin-statistics', '#', NULL, 1, NOW(), 1, NOW(), '系统管理员审核统计功能');

-- 为系统管理员角色分配审核统计权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 9011);

-- 8. 验证权限配置
SELECT '=== 设计师权限修复验证 ===' AS status;
SELECT '设计师核心权限' AS category, m.perms, m.menu_name 
FROM sys_role_menu rm 
JOIN sys_menu m ON rm.menu_id = m.menu_id 
WHERE rm.role_id = 1932319128081666050 
  AND m.perms IN (
    'designer:task-application:apply',
    'designer:task-application:withdraw', 
    'designer:task-payment:list',
    'designer:task-payment:confirm'
  )
ORDER BY m.perms;

SELECT '=== 新增权限码验证 ===' AS status;
SELECT menu_id, menu_name, perms 
FROM sys_menu 
WHERE menu_id IN (9010, 9011, 9012);

SET FOREIGN_KEY_CHECKS = 1;

-- ====================================================================
-- 修复完成提示
-- ====================================================================
SELECT '智图工厂设计师权限修复完成！' AS status,
       '设计师现在可以：申请任务、撤回申请、查看支付记录、确认支付' AS designer_capabilities,
       '新增权限码：withdraw、admin-statistics、confirm' AS new_permissions; 