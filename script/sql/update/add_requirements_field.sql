-- 为岗位招聘表添加requirements字段
-- 执行时间：2025-01-27

-- 检查字段是否已存在，如果不存在则添加
SET @column_exists = (
    SELECT COUNT(*)
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'des_job_posting'
    AND COLUMN_NAME = 'requirements'
);

-- 如果字段不存在则添加
SET @sql = IF(@column_exists = 0,
    'ALTER TABLE `des_job_posting` ADD COLUMN `requirements` TEXT COMMENT ''岗位要求'' AFTER `description`',
    'SELECT ''字段 requirements 已存在，跳过添加'' AS message'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt; 