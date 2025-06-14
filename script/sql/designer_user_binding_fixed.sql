-- 设计师管理模块权限修复脚本
-- 目标：确保设计师管理接口只能被系统管理员访问

-- 1. 重新定义角色权限分配
-- 注意：以下示例假设角色ID，实际部署时需要根据实际ID调整

-- 设计师角色权限（只能管理自己的信息，不能访问设计师管理接口）
-- 移除所有 designer:designer:* 权限，只保留个人相关权限
-- INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) 
-- SELECT (SELECT role_id FROM sys_role WHERE role_key = 'designer'), `menu_id` 
-- FROM `sys_menu` WHERE `perms` IN (
--     'designer:application:apply',     -- 申请岗位
--     'designer:application:withdraw',  -- 撤回申请
--     'designer:application:query',     -- 查询自己的申请
--     'designer:user:profile'           -- 个人档案管理
-- );

-- 企业管理员角色权限（只能管理岗位和申请）
-- INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) 
-- SELECT (SELECT role_id FROM sys_role WHERE role_key = 'enterprise'), `menu_id` 
-- FROM `sys_menu` WHERE `perms` LIKE 'designer:job:%' OR `perms` IN (
--     'designer:application:list',      -- 查看申请列表
--     'designer:application:process',   -- 处理申请
--     'designer:application:query',     -- 查询申请详情
--     'designer:user:enterprise:profile' -- 企业档案管理
-- );

-- 院校管理员角色权限（只能管理院校和学生数据）
-- 注意：移除了 designer:designer:list 权限
-- INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) 
-- SELECT (SELECT role_id FROM sys_role WHERE role_key = 'school'), `menu_id` 
-- FROM `sys_menu` WHERE `perms` LIKE 'designer:school:%' OR `perms` IN (
--     'designer:user:school:profile'    -- 院校档案管理
-- );

-- 2. 为设计师管理接口添加特殊权限检查逻辑
-- 建议在代码层面添加额外的权限验证，确保：
-- - 只有系统管理员可以访问所有设计师管理接口
-- - 设计师只能通过用户档案接口管理自己的信息
-- - 企业和院校管理员完全无法访问设计师管理接口

-- 3. 安全检查SQL - 验证权限分配是否正确
-- 检查哪些角色拥有设计师管理权限
SELECT 
    r.role_name,
    r.role_key,
    m.menu_name,
    m.perms
FROM sys_role r
JOIN sys_role_menu rm ON r.role_id = rm.role_id
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE m.perms LIKE 'designer:designer:%'
ORDER BY r.role_key, m.perms;

-- 4. 权限清理 - 移除不当的权限分配
-- 移除院校管理员的设计师列表查询权限
DELETE rm FROM sys_role_menu rm
JOIN sys_role r ON rm.role_id = r.role_id
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE r.role_key = 'school' 
  AND m.perms = 'designer:designer:list';

-- 移除企业管理员的设计师管理权限（如果存在）
DELETE rm FROM sys_role_menu rm
JOIN sys_role r ON rm.role_id = r.role_id
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE r.role_key = 'enterprise' 
  AND m.perms LIKE 'designer:designer:%';

-- 移除设计师角色的设计师管理权限（如果存在）
DELETE rm FROM sys_role_menu rm
JOIN sys_role r ON rm.role_id = r.role_id
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE r.role_key = 'designer' 
  AND m.perms LIKE 'designer:designer:%';

-- 5. 验证清理结果
-- 执行完成后，应该只有系统管理员拥有 designer:designer:* 权限
SELECT 
    CASE 
        WHEN COUNT(*) = 0 THEN '✓ 权限清理成功：非管理员角色已移除设计师管理权限'
        ELSE CONCAT('❌ 权限清理失败：仍有 ', COUNT(*), ' 个非管理员角色拥有设计师管理权限')
    END as result
FROM sys_role_menu rm
JOIN sys_role r ON rm.role_id = r.role_id
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE r.role_key IN ('designer', 'enterprise', 'school')
  AND m.perms LIKE 'designer:designer:%'; 