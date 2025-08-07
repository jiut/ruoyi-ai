-- ====================================================================
-- 智图工厂任务逻辑删除功能权限配置脚本
-- 为系统管理员添加任务恢复和回收站功能权限
-- 日期：2025-01-27
-- 修改：将权限从企业级改为系统级，仅系统管理员可访问
-- ====================================================================

USE ruoyi;

-- 1. 删除旧的企业级权限（如果存在）
DELETE FROM sys_role_menu WHERE menu_id IN (
    SELECT menu_id FROM sys_menu WHERE perms IN (
        'designer:enterprise:task:restore',
        'designer:enterprise:task:recycle'
    )
);

DELETE FROM sys_menu WHERE perms IN (
    'designer:enterprise:task:restore',
    'designer:enterprise:task:recycle'
);

-- 2. 添加新的系统级权限码
INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
VALUES 
-- 系统任务恢复权限
(9006, '系统任务恢复权限', 0, 102, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task:restore', '#', NULL, 1, NOW(), 1, NOW(), '系统管理员恢复任务权限'),

-- 系统任务回收站权限
(9007, '系统任务回收站权限', 0, 103, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task:recycle', '#', NULL, 1, NOW(), 1, NOW(), '系统管理员查看回收站权限');

-- 3. 仅为超级管理员角色(ID=1)分配新权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES 
(1, 9006),  -- 系统任务恢复权限
(1, 9007);  -- 系统任务回收站权限

-- 注意：不再为企业管理员角色分配这些权限

-- 4. 验证权限配置
SELECT 
    m.menu_id,
    m.menu_name,
    m.perms,
    m.remark
FROM sys_menu m
WHERE m.perms IN (
    'designer:task:restore',
    'designer:task:recycle'
)
ORDER BY m.menu_id;

-- 5. 验证角色权限分配（应该只有系统管理员有这些权限）
SELECT 
    r.role_name,
    r.role_key,
    m.menu_name,
    m.perms
FROM sys_role r
JOIN sys_role_menu rm ON r.role_id = rm.role_id
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE m.perms IN (
    'designer:task:restore',
    'designer:task:recycle'
)
ORDER BY r.role_name, m.perms;

-- 6. 验证企业管理员不再拥有这些权限
SELECT 
    '企业管理员权限检查' AS check_type,
    COUNT(*) AS permission_count,
    CASE 
        WHEN COUNT(*) = 0 THEN '✅ 正确：企业管理员已移除任务恢复和回收站权限'
        ELSE '❌ 错误：企业管理员仍有这些权限，需要手动清理'
    END AS result
FROM sys_role r
JOIN sys_role_menu rm ON r.role_id = rm.role_id
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE r.role_key = 'enterprise'
  AND m.perms IN ('designer:task:restore', 'designer:task:recycle');

SELECT '任务逻辑删除权限配置完成 - 仅系统管理员可访问' AS status; 