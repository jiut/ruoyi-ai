-- ====================================================================
-- 智图工厂任务表逻辑删除字段迁移脚本
-- 根据设计师模块逻辑删除标准规范实施
-- 日期：2025-01-27
-- ====================================================================

USE ruoyi;

-- 检查 des_task 表是否已存在逻辑删除字段
SET @column_exists = 0;
SELECT COUNT(*) INTO @column_exists 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'ruoyi' 
  AND TABLE_NAME = 'des_task' 
  AND COLUMN_NAME = 'del_time';

-- 如果字段不存在，则添加逻辑删除相关字段
SET @sql = '';
SET @sql = CASE 
    WHEN @column_exists = 0 THEN 
        'ALTER TABLE des_task 
         ADD COLUMN del_flag char(1) DEFAULT ''0'' COMMENT ''删除标志（0正常 1软删除 2硬删除）'',
         ADD COLUMN del_time datetime DEFAULT NULL COMMENT ''删除时间'',
         ADD COLUMN del_by bigint DEFAULT NULL COMMENT ''删除人ID'';'
    ELSE 
        'SELECT ''逻辑删除字段已存在，跳过添加'' AS message;'
END;

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 创建索引以优化查询性能
CREATE INDEX IF NOT EXISTS idx_task_del_flag ON des_task(del_flag);
CREATE INDEX IF NOT EXISTS idx_task_del_time ON des_task(del_time);
CREATE INDEX IF NOT EXISTS idx_task_enterprise_del_flag ON des_task(enterprise_id, del_flag);

-- 验证字段是否添加成功
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE,
    COLUMN_DEFAULT,
    COLUMN_COMMENT
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'ruoyi' 
  AND TABLE_NAME = 'des_task' 
  AND COLUMN_NAME IN ('del_flag', 'del_time', 'del_by')
ORDER BY COLUMN_NAME;

-- 验证索引是否创建成功
SHOW INDEX FROM des_task WHERE Key_name LIKE '%del%';

SELECT '任务表逻辑删除字段迁移完成' AS status; 