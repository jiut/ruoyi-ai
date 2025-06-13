-- 设计师管理模块用户绑定 - 安全更新脚本
-- 此脚本可以在已有环境中安全地重复执行

-- 1. 检查并添加用户ID字段
-- des_enterprise 表
SELECT CONCAT('添加 des_enterprise.user_id 字段: ', 
    CASE WHEN COUNT(*) > 0 THEN '已存在' ELSE '需要添加' END) AS status
FROM information_schema.columns 
WHERE table_schema = DATABASE() AND table_name = 'des_enterprise' AND column_name = 'user_id';

-- des_school 表
SELECT CONCAT('添加 des_school.user_id 字段: ', 
    CASE WHEN COUNT(*) > 0 THEN '已存在' ELSE '需要添加' END) AS status
FROM information_schema.columns 
WHERE table_schema = DATABASE() AND table_name = 'des_school' AND column_name = 'user_id';

-- des_designer 表
SELECT CONCAT('添加 des_designer.user_id 字段: ', 
    CASE WHEN COUNT(*) > 0 THEN '已存在' ELSE '需要添加' END) AS status
FROM information_schema.columns 
WHERE table_schema = DATABASE() AND table_name = 'des_designer' AND column_name = 'user_id';

-- 2. 检查并添加索引
SELECT CONCAT('添加 des_enterprise.idx_user_id 索引: ', 
    CASE WHEN COUNT(*) > 0 THEN '已存在' ELSE '需要添加' END) AS status
FROM information_schema.statistics 
WHERE table_schema = DATABASE() AND table_name = 'des_enterprise' AND index_name = 'idx_user_id';

-- 3. 检查并添加角色
SELECT CONCAT('添加设计师角色: ', 
    CASE WHEN COUNT(*) > 0 THEN '已存在' ELSE '需要添加' END) AS status
FROM sys_role WHERE role_key = 'designer';

SELECT CONCAT('添加企业管理员角色: ', 
    CASE WHEN COUNT(*) > 0 THEN '已存在' ELSE '需要添加' END) AS status
FROM sys_role WHERE role_key = 'enterprise';

SELECT CONCAT('添加院校管理员角色: ', 
    CASE WHEN COUNT(*) > 0 THEN '已存在' ELSE '需要添加' END) AS status
FROM sys_role WHERE role_key = 'school';

-- 4. 检查并创建用户绑定表
SELECT CONCAT('创建 des_user_binding 表: ', 
    CASE WHEN COUNT(*) > 0 THEN '已存在' ELSE '需要创建' END) AS status
FROM information_schema.tables 
WHERE table_schema = DATABASE() AND table_name = 'des_user_binding';

-- 5. 创建用户绑定表（如果不存在）
CREATE TABLE IF NOT EXISTS `des_user_binding` (
    `binding_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '绑定ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `entity_type` VARCHAR(20) NOT NULL COMMENT '实体类型（designer/enterprise/school）',
    `entity_id` BIGINT NOT NULL COMMENT '实体ID',
    `binding_status` CHAR(1) DEFAULT '1' COMMENT '绑定状态（0解绑 1绑定）',
    `create_time` DATETIME COMMENT '创建时间',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`binding_id`),
    UNIQUE KEY `uk_user_entity` (`user_id`, `entity_type`),
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_entity` (`entity_type`, `entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户实体绑定关系表';

-- 6. 插入角色（如果不存在）
-- 获取下一个role_id
SET @next_role_id = (SELECT IFNULL(MAX(role_id), 100) + 1 FROM sys_role);

INSERT INTO `sys_role` (`role_id`, `tenant_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_time`, `remark`)
SELECT @next_role_id, '000000', '设计师', 'designer', 4, '5', 1, 1, '0', '0', NOW(), '设计师角色，管理个人信息和申请岗位'
WHERE NOT EXISTS (SELECT 1 FROM `sys_role` WHERE `role_key` = 'designer');

SET @next_role_id = @next_role_id + 1;
INSERT INTO `sys_role` (`role_id`, `tenant_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_time`, `remark`)
SELECT @next_role_id, '000000', '企业管理员', 'enterprise', 3, '2', 1, 1, '0', '0', NOW(), '企业管理员角色，管理企业信息和岗位招聘'
WHERE NOT EXISTS (SELECT 1 FROM `sys_role` WHERE `role_key` = 'enterprise');

SET @next_role_id = @next_role_id + 1;
INSERT INTO `sys_role` (`role_id`, `tenant_id`, `role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_time`, `remark`)
SELECT @next_role_id, '000000', '院校管理员', 'school', 3, '2', 1, 1, '0', '0', NOW(), '院校管理员角色，管理院校信息和学生数据'
WHERE NOT EXISTS (SELECT 1 FROM `sys_role` WHERE `role_key` = 'school');

-- 7. 最终状态检查
SELECT '=== 用户绑定功能安装检查 ===' AS result;

SELECT CONCAT('des_enterprise.user_id: ', 
    CASE WHEN COUNT(*) > 0 THEN '✓ 已添加' ELSE '✗ 缺失' END) AS result
FROM information_schema.columns 
WHERE table_schema = DATABASE() AND table_name = 'des_enterprise' AND column_name = 'user_id'
UNION ALL
SELECT CONCAT('des_school.user_id: ', 
    CASE WHEN COUNT(*) > 0 THEN '✓ 已添加' ELSE '✗ 缺失' END)
FROM information_schema.columns 
WHERE table_schema = DATABASE() AND table_name = 'des_school' AND column_name = 'user_id'
UNION ALL
SELECT CONCAT('des_designer.user_id: ', 
    CASE WHEN COUNT(*) > 0 THEN '✓ 已添加' ELSE '✗ 缺失' END)
FROM information_schema.columns 
WHERE table_schema = DATABASE() AND table_name = 'des_designer' AND column_name = 'user_id'
UNION ALL
SELECT CONCAT('des_user_binding表: ', 
    CASE WHEN COUNT(*) > 0 THEN '✓ 已创建' ELSE '✗ 缺失' END)
FROM information_schema.tables 
WHERE table_schema = DATABASE() AND table_name = 'des_user_binding'
UNION ALL
SELECT CONCAT('设计师角色: ', 
    CASE WHEN COUNT(*) > 0 THEN '✓ 已添加' ELSE '✗ 缺失' END)
FROM sys_role WHERE role_key = 'designer'
UNION ALL
SELECT CONCAT('企业管理员角色: ', 
    CASE WHEN COUNT(*) > 0 THEN '✓ 已添加' ELSE '✗ 缺失' END)
FROM sys_role WHERE role_key = 'enterprise'
UNION ALL
SELECT CONCAT('院校管理员角色: ', 
    CASE WHEN COUNT(*) > 0 THEN '✓ 已添加' ELSE '✗ 缺失' END)
FROM sys_role WHERE role_key = 'school';

SELECT '=== 安装完成 ===' AS result; 