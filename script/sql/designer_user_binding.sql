-- 设计师管理模块用户绑定相关SQL

-- 1. 修改现有表结构，添加用户ID字段（如果不存在）
-- 检查并添加 des_enterprise 的 user_id 字段
SET @exist_enterprise_col = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'des_enterprise' AND column_name = 'user_id');
SET @sql_enterprise_col = IF(@exist_enterprise_col = 0, 'ALTER TABLE `des_enterprise` ADD COLUMN `user_id` BIGINT COMMENT "关联用户ID" AFTER `enterprise_id`', 'SELECT "Column user_id already exists in des_enterprise"');
PREPARE stmt FROM @sql_enterprise_col;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 检查并添加 des_school 的 user_id 字段
SET @exist_school_col = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'des_school' AND column_name = 'user_id');
SET @sql_school_col = IF(@exist_school_col = 0, 'ALTER TABLE `des_school` ADD COLUMN `user_id` BIGINT COMMENT "关联用户ID" AFTER `school_id`', 'SELECT "Column user_id already exists in des_school"');
PREPARE stmt FROM @sql_school_col;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 检查并添加 des_designer 的 user_id 字段
SET @exist_designer_col = (SELECT COUNT(*) FROM information_schema.columns WHERE table_schema = DATABASE() AND table_name = 'des_designer' AND column_name = 'user_id');
SET @sql_designer_col = IF(@exist_designer_col = 0, 'ALTER TABLE `des_designer` ADD COLUMN `user_id` BIGINT COMMENT "关联用户ID" AFTER `designer_id`', 'SELECT "Column user_id already exists in des_designer"');
PREPARE stmt FROM @sql_designer_col;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 2. 添加外键约束（可选，根据实际需要）
-- ALTER TABLE `des_enterprise` ADD CONSTRAINT `fk_enterprise_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user`(`user_id`) ON DELETE SET NULL;
-- ALTER TABLE `des_school` ADD CONSTRAINT `fk_school_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user`(`user_id`) ON DELETE SET NULL;
-- ALTER TABLE `des_designer` ADD CONSTRAINT `fk_designer_user` FOREIGN KEY (`user_id`) REFERENCES `sys_user`(`user_id`) ON DELETE SET NULL;

-- 3. 添加索引（如果不存在）
-- 检查并添加 des_enterprise 的索引
SET @exist_enterprise_idx = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'des_enterprise' AND index_name = 'idx_user_id');
SET @sql_enterprise = IF(@exist_enterprise_idx = 0, 'ALTER TABLE `des_enterprise` ADD INDEX `idx_user_id` (`user_id`)', 'SELECT "Index idx_user_id already exists on des_enterprise"');
PREPARE stmt FROM @sql_enterprise;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 检查并添加 des_school 的索引
SET @exist_school_idx = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'des_school' AND index_name = 'idx_user_id');
SET @sql_school = IF(@exist_school_idx = 0, 'ALTER TABLE `des_school` ADD INDEX `idx_user_id` (`user_id`)', 'SELECT "Index idx_user_id already exists on des_school"');
PREPARE stmt FROM @sql_school;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 检查并添加 des_designer 的索引
SET @exist_designer_idx = (SELECT COUNT(*) FROM information_schema.statistics WHERE table_schema = DATABASE() AND table_name = 'des_designer' AND index_name = 'idx_user_id');
SET @sql_designer = IF(@exist_designer_idx = 0, 'ALTER TABLE `des_designer` ADD INDEX `idx_user_id` (`user_id`)', 'SELECT "Index idx_user_id already exists on des_designer"');
PREPARE stmt FROM @sql_designer;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 4. 插入设计师管理相关角色（如果不存在）
INSERT INTO `sys_role` (`role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_time`, `remark`)
SELECT '设计师', 'designer', 4, '5', 1, 1, '0', '0', NOW(), '设计师角色，管理个人信息和申请岗位'
WHERE NOT EXISTS (SELECT 1 FROM `sys_role` WHERE `role_key` = 'designer');

INSERT INTO `sys_role` (`role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_time`, `remark`)
SELECT '企业管理员', 'enterprise', 3, '2', 1, 1, '0', '0', NOW(), '企业管理员角色，管理企业信息和岗位招聘'
WHERE NOT EXISTS (SELECT 1 FROM `sys_role` WHERE `role_key` = 'enterprise');

INSERT INTO `sys_role` (`role_name`, `role_key`, `role_sort`, `data_scope`, `menu_check_strictly`, `dept_check_strictly`, `status`, `del_flag`, `create_time`, `remark`)
SELECT '院校管理员', 'school', 3, '2', 1, 1, '0', '0', NOW(), '院校管理员角色，管理院校信息和学生数据'
WHERE NOT EXISTS (SELECT 1 FROM `sys_role` WHERE `role_key` = 'school');

-- 5. 创建用户类型枚举表（如果不存在）
CREATE TABLE IF NOT EXISTS `des_user_type` (
    `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
    `type_code` VARCHAR(20) NOT NULL COMMENT '用户类型编码',
    `type_name` VARCHAR(50) NOT NULL COMMENT '用户类型名称',
    `description` TEXT COMMENT '类型描述',
    `status` CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `create_time` DATETIME COMMENT '创建时间',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`id`),
    UNIQUE KEY `uk_type_code` (`type_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='设计师系统用户类型表';

-- 插入用户类型数据（如果不存在）
INSERT INTO `des_user_type` (`type_code`, `type_name`, `description`, `create_time`)
SELECT 'designer', '设计师用户', '设计师个人用户，可以管理个人信息、上传作品、申请岗位', NOW()
WHERE NOT EXISTS (SELECT 1 FROM `des_user_type` WHERE `type_code` = 'designer');

INSERT INTO `des_user_type` (`type_code`, `type_name`, `description`, `create_time`)
SELECT 'enterprise', '企业用户', '企业机构用户，可以发布岗位、管理招聘流程', NOW()
WHERE NOT EXISTS (SELECT 1 FROM `des_user_type` WHERE `type_code` = 'enterprise');

INSERT INTO `des_user_type` (`type_code`, `type_name`, `description`, `create_time`)
SELECT 'school', '院校用户', '教育机构用户，可以管理学生信息、查看就业统计', NOW()
WHERE NOT EXISTS (SELECT 1 FROM `des_user_type` WHERE `type_code` = 'school');

-- 6. 创建用户绑定关系表（如果不存在）
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

-- 7. 创建角色权限配置数据

-- 首先获取刚插入的角色ID（需要根据实际情况调整）
-- 假设设计师角色ID为101，企业管理员角色ID为102，院校管理员角色ID为103

-- 设计师角色权限（示例）
-- INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) 
-- SELECT 101, `menu_id` FROM `sys_menu` WHERE `perms` LIKE 'designer:designer:%' OR `perms` LIKE 'designer:application:%';

-- 企业管理员角色权限（示例）
-- INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) 
-- SELECT 102, `menu_id` FROM `sys_menu` WHERE `perms` LIKE 'designer:job:%' OR `perms` LIKE 'designer:application:%';

-- 院校管理员角色权限（示例）
-- INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) 
-- SELECT 103, `menu_id` FROM `sys_menu` WHERE `perms` LIKE 'designer:school:%' OR `perms` LIKE 'designer:designer:list';

-- 8. 示例：为现有数据创建对应用户（可选，根据实际需要执行）
/*
-- 为现有企业创建用户账号
INSERT INTO `sys_user` (`dept_id`, `user_name`, `nick_name`, `user_type`, `email`, `phonenumber`, `sex`, `status`, `create_time`)
SELECT 
    103, -- 默认部门ID，需要根据实际情况调整
    CONCAT('enterprise_', enterprise_id),
    enterprise_name,
    'enterprise',
    email,
    phone,
    '2',
    '0',
    NOW()
FROM `des_enterprise` WHERE `status` = '0';

-- 更新企业表的用户ID
UPDATE `des_enterprise` e 
SET `user_id` = (
    SELECT `user_id` FROM `sys_user` u 
    WHERE u.user_name = CONCAT('enterprise_', e.enterprise_id)
) 
WHERE e.`status` = '0';

-- 为企业用户分配角色
INSERT INTO `sys_user_role` (`user_id`, `role_id`)
SELECT e.user_id, 102 -- 企业管理员角色ID
FROM `des_enterprise` e 
WHERE e.user_id IS NOT NULL;
*/

-- 9. 创建触发器，自动维护绑定关系（如果不存在）
DELIMITER $$

-- 删除已存在的触发器（如果存在）
DROP TRIGGER IF EXISTS `tr_enterprise_user_binding`$$
CREATE TRIGGER `tr_enterprise_user_binding` 
AFTER UPDATE ON `des_enterprise`
FOR EACH ROW
BEGIN
    IF NEW.user_id IS NOT NULL AND (OLD.user_id IS NULL OR OLD.user_id != NEW.user_id) THEN
        INSERT INTO `des_user_binding` (`user_id`, `entity_type`, `entity_id`, `create_time`)
        VALUES (NEW.user_id, 'enterprise', NEW.enterprise_id, NOW())
        ON DUPLICATE KEY UPDATE 
            `binding_status` = '1',
            `update_time` = NOW();
    END IF;
END$$

DROP TRIGGER IF EXISTS `tr_school_user_binding`$$
CREATE TRIGGER `tr_school_user_binding` 
AFTER UPDATE ON `des_school`
FOR EACH ROW
BEGIN
    IF NEW.user_id IS NOT NULL AND (OLD.user_id IS NULL OR OLD.user_id != NEW.user_id) THEN
        INSERT INTO `des_user_binding` (`user_id`, `entity_type`, `entity_id`, `create_time`)
        VALUES (NEW.user_id, 'school', NEW.school_id, NOW())
        ON DUPLICATE KEY UPDATE 
            `binding_status` = '1',
            `update_time` = NOW();
    END IF;
END$$

DROP TRIGGER IF EXISTS `tr_designer_user_binding`$$
CREATE TRIGGER `tr_designer_user_binding` 
AFTER UPDATE ON `des_designer`
FOR EACH ROW
BEGIN
    IF NEW.user_id IS NOT NULL AND (OLD.user_id IS NULL OR OLD.user_id != NEW.user_id) THEN
        INSERT INTO `des_user_binding` (`user_id`, `entity_type`, `entity_id`, `create_time`)
        VALUES (NEW.user_id, 'designer', NEW.designer_id, NOW())
        ON DUPLICATE KEY UPDATE 
            `binding_status` = '1',
            `update_time` = NOW();
    END IF;
END$$

DELIMITER ; `