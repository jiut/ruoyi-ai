-- 简化版 des_user_binding 表结构修复脚本
-- 请将 'ruoyi_ai' 替换为您的实际数据库名

-- 第一步：检查当前表是否存在
SHOW TABLES LIKE 'des_user_binding';

-- 第二步：查看当前表结构（如果表存在）
DESC des_user_binding;

-- 第三步：如果表不存在，创建完整的表
CREATE TABLE IF NOT EXISTS `des_user_binding` (
    `binding_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '绑定ID',
    `user_id` BIGINT NOT NULL COMMENT '用户ID',
    `entity_type` VARCHAR(20) NOT NULL COMMENT '实体类型（designer/enterprise/school）',
    `entity_id` BIGINT NOT NULL COMMENT '实体ID',
    `binding_status` CHAR(1) DEFAULT '1' COMMENT '绑定状态（0解绑 1绑定）',
    `create_dept` BIGINT NULL COMMENT '创建部门',
    `create_by` BIGINT NULL COMMENT '创建者',
    `create_time` DATETIME NULL COMMENT '创建时间',
    `update_by` BIGINT NULL COMMENT '更新者',
    `update_time` DATETIME NULL COMMENT '更新时间',
    PRIMARY KEY (`binding_id`),
    UNIQUE KEY `uk_user_entity` (`user_id`, `entity_type`),
    INDEX `idx_user_id` (`user_id`),
    INDEX `idx_entity` (`entity_type`, `entity_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='用户实体绑定关系表';

-- 第四步：如果表存在但缺少字段，单独添加每个字段
-- 添加 create_dept 字段
-- ALTER TABLE `des_user_binding` ADD COLUMN `create_dept` BIGINT NULL COMMENT '创建部门';

-- 添加 create_by 字段  
-- ALTER TABLE `des_user_binding` ADD COLUMN `create_by` BIGINT NULL COMMENT '创建者';

-- 添加 update_by 字段
-- ALTER TABLE `des_user_binding` ADD COLUMN `update_by` BIGINT NULL COMMENT '更新者';

-- 第五步：最终验证表结构
DESC des_user_binding; 