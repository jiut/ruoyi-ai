-- ====================================================================
-- 智图工厂权限完整修复脚本
-- 基于当前数据库结构修复权限配置问题
-- 日期：2025-07-18
-- ====================================================================

-- 1. 为超级管理员角色(ID=1)分配智图工厂的核心权限
-- 智图工厂模块菜单权限 (ID=2000)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2000);

-- 任务广场权限 (ID=2001)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2001);

-- 任务管理权限 (ID=2002)  
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2002);

-- 申请管理权限 (ID=2003)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2003);

-- 交付管理权限 (ID=2004)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2004);

-- 支付中心权限 (ID=2005)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2005);

-- 任务查看权限 (ID=2010)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2010);

-- 任务新增权限 (ID=2011)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2011);

-- 任务修改权限 (ID=2012)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2012);

-- 任务删除权限 (ID=2013)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2013);

-- 申请任务权限 (ID=2014)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2014);

-- 审核申请权限 (ID=2015)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2015);

-- 提交交付物权限 (ID=2016)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2016);

-- 审核交付物权限 (ID=2017)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2017);

-- 创建支付权限 (ID=2018)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2018);

-- 🔑 关键修复：系统管理员审核权限 (ID=2019)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 2019);

-- 🔑 关键修复：企业任务创建权限 (ID=9001)
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1, 9001);

-- 2. 为管理员角色(ID=1729685491108446210)分配相同权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2000);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2001);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2002);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2003);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2004);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2005);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2010);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2011);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2012);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2013);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2014);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2015);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2016);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2017);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2018);
-- 🔑 关键修复：系统管理员审核权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 2019);
-- 🔑 关键修复：企业任务创建权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1729685491108446210, 9001);

-- 3. 为企业管理员角色(ID=1932319128081666051)分配企业相关权限
-- 任务广场查看权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2000);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2001);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2010);

-- 任务管理权限（企业管理员需要）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2002);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2011);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2012);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2013);

-- 申请管理权限（企业管理员需要审核）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2003);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2015);

-- 交付管理权限（企业管理员需要审核交付物）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2004);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2017);

-- 支付权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2005);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 2018);

-- 🔑 关键修复：企业任务创建权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666051, 9001);

-- 4. 为设计师角色(ID=1932319128081666050)分配设计师相关权限
-- 任务广场查看权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666050, 2000);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666050, 2001);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666050, 2010);

-- 申请任务权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666050, 2003);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666050, 2014);

-- 交付管理权限（设计师需要提交交付物）
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666050, 2004);
INSERT IGNORE INTO sys_role_menu (role_id, menu_id) VALUES (1932319128081666050, 2016);

-- 5. 添加缺失的智图工厂权限字符串（如果不存在）
INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
SELECT 
    COALESCE((SELECT MAX(menu_id) FROM sys_menu), 0) + 10000,
    '企业管理员审核权限', 0, 98, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task-application:enterprise-review', '#', NULL, 1, NOW(), 1, NOW(), '企业管理员审核任务申请权限'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = 'designer:task-application:enterprise-review');

INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
SELECT 
    COALESCE((SELECT MAX(menu_id) FROM sys_menu), 0) + 10001,
    '设计师交付物提交权限', 0, 99, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task-deliverable:submit', '#', NULL, 1, NOW(), 1, NOW(), '设计师提交交付物权限'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = 'designer:task-deliverable:submit');

INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
SELECT 
    COALESCE((SELECT MAX(menu_id) FROM sys_menu), 0) + 10002,
    '设计师申请任务权限', 0, 100, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task-application:apply', '#', NULL, 1, NOW(), 1, NOW(), '设计师申请任务权限'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = 'designer:task-application:apply');

INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
SELECT 
    COALESCE((SELECT MAX(menu_id) FROM sys_menu), 0) + 10003,
    '任务详情查看权限', 0, 101, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task:query', '#', NULL, 1, NOW(), 1, NOW(), '查询任务详情权限'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = 'designer:task:query');

INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
SELECT 
    COALESCE((SELECT MAX(menu_id) FROM sys_menu), 0) + 10004,
    '企业待审核申请权限', 0, 102, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task-application:enterprise-pending', '#', NULL, 1, NOW(), 1, NOW(), '企业管理员查看待审核申请权限'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = 'designer:task-application:enterprise-pending');

INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, query_param, is_frame, is_cache, menu_type, visible, status, perms, icon, create_dept, create_by, create_time, update_by, update_time, remark)
SELECT 
    COALESCE((SELECT MAX(menu_id) FROM sys_menu), 0) + 10005,
    '系统管理员待审核申请权限', 0, 103, '', NULL, NULL, 1, 0, 'F', '0', '0', 'designer:task-application:admin-pending', '#', NULL, 1, NOW(), 1, NOW(), '系统管理员查看待审核申请权限'
WHERE NOT EXISTS (SELECT 1 FROM sys_menu WHERE perms = 'designer:task-application:admin-pending');

-- 6. 为新创建的权限分配给相应角色
-- 企业管理员审核权限
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT r.role_id, m.menu_id 
FROM sys_role r, sys_menu m 
WHERE r.role_key IN ('superadmin', 'admin') 
  AND m.perms = 'designer:task-application:enterprise-review'
  AND NOT EXISTS (
    SELECT 1 FROM sys_role_menu rm 
    WHERE rm.role_id = r.role_id AND rm.menu_id = m.menu_id
  );

INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT r.role_id, m.menu_id 
FROM sys_role r, sys_menu m 
WHERE r.role_key = 'enterprise'
  AND m.perms = 'designer:task-application:enterprise-review'
  AND NOT EXISTS (
    SELECT 1 FROM sys_role_menu rm 
    WHERE rm.role_id = r.role_id AND rm.menu_id = m.menu_id
  );

-- 设计师权限分配
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT r.role_id, m.menu_id 
FROM sys_role r, sys_menu m 
WHERE r.role_key IN ('superadmin', 'admin') 
  AND m.perms IN ('designer:task-deliverable:submit', 'designer:task-application:apply', 'designer:task:query')
  AND NOT EXISTS (
    SELECT 1 FROM sys_role_menu rm 
    WHERE rm.role_id = r.role_id AND rm.menu_id = m.menu_id
  );

INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT r.role_id, m.menu_id 
FROM sys_role r, sys_menu m 
WHERE r.role_key = 'designer'
  AND m.perms IN ('designer:task-deliverable:submit', 'designer:task-application:apply', 'designer:task:query')
  AND NOT EXISTS (
    SELECT 1 FROM sys_role_menu rm 
    WHERE rm.role_id = r.role_id AND rm.menu_id = m.menu_id
  );

-- 企业管理员权限分配
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT r.role_id, m.menu_id 
FROM sys_role r, sys_menu m 
WHERE r.role_key = 'enterprise'
  AND m.perms IN ('designer:task-application:enterprise-pending', 'designer:task:query')
  AND NOT EXISTS (
    SELECT 1 FROM sys_role_menu rm 
    WHERE rm.role_id = r.role_id AND rm.menu_id = m.menu_id
  );

-- 系统管理员权限分配
INSERT IGNORE INTO sys_role_menu (role_id, menu_id)
SELECT r.role_id, m.menu_id 
FROM sys_role r, sys_menu m 
WHERE r.role_key IN ('superadmin', 'admin')
  AND m.perms = 'designer:task-application:admin-pending'
  AND NOT EXISTS (
    SELECT 1 FROM sys_role_menu rm 
    WHERE rm.role_id = r.role_id AND rm.menu_id = m.menu_id
  );

-- ====================================================================
-- 权限修复验证查询
-- ====================================================================

-- 查询admin角色权限数量（验证修复效果）
SELECT 
    r.role_name,
    r.role_key,
    COUNT(rm.menu_id) as permission_count
FROM sys_role r
LEFT JOIN sys_role_menu rm ON r.role_id = rm.role_id
WHERE r.role_key IN ('superadmin', 'admin', 'enterprise', 'designer')
GROUP BY r.role_id, r.role_name, r.role_key
ORDER BY r.role_key;

-- 查询智图工厂相关权限分配情况
SELECT 
    r.role_name,
    r.role_key,
    m.menu_name,
    m.perms
FROM sys_role r
JOIN sys_role_menu rm ON r.role_id = rm.role_id
JOIN sys_menu m ON rm.menu_id = m.menu_id
WHERE m.perms LIKE 'designer:%'
ORDER BY r.role_key, m.perms; 