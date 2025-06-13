-- 修复 des_user_binding 表结构 - 添加缺失的 create_dept 字段
-- 此脚本用于修复 UserBinding 实体继承 BaseEntity 后缺失的字段问题

USE ruoyi_ai; -- 请根据实际数据库名修改

-- 1. 检查当前表结构
SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT, COLUMN_COMMENT 
FROM information_schema.columns 
WHERE table_schema = DATABASE() 
  AND table_name = 'des_user_binding' 
ORDER BY ORDINAL_POSITION;

-- 2. 添加缺失的 create_dept 字段（如果不存在）
SET @column_exists = (
    SELECT COUNT(*) 
    FROM information_schema.columns 
    WHERE table_schema = DATABASE() 
      AND table_name = 'des_user_binding' 
      AND column_name = 'create_dept'
);

SET @sql = IF(@column_exists = 0, 
    'ALTER TABLE `des_user_binding` ADD COLUMN `create_dept` BIGINT NULL COMMENT "创建部门" AFTER `binding_status`',
    'SELECT "create_dept 字段已存在" AS message'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 3. 添加缺失的 create_by 字段（如果不存在）
SET @column_exists = (
    SELECT COUNT(*) 
    FROM information_schema.columns 
    WHERE table_schema = DATABASE() 
      AND table_name = 'des_user_binding' 
      AND column_name = 'create_by'
);

SET @sql = IF(@column_exists = 0, 
    'ALTER TABLE `des_user_binding` ADD COLUMN `create_by` BIGINT NULL COMMENT "创建者" AFTER `create_dept`',
    'SELECT "create_by 字段已存在" AS message'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 4. 添加缺失的 update_by 字段（如果不存在）
SET @column_exists = (
    SELECT COUNT(*) 
    FROM information_schema.columns 
    WHERE table_schema = DATABASE() 
      AND table_name = 'des_user_binding' 
      AND column_name = 'update_by'
);

SET @sql = IF(@column_exists = 0, 
    'ALTER TABLE `des_user_binding` ADD COLUMN `update_by` BIGINT NULL COMMENT "更新者" AFTER `update_time`',
    'SELECT "update_by 字段已存在" AS message'
);

PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- 5. 验证修复结果
SELECT '=== des_user_binding 表结构修复完成 ===' AS message;

SELECT CONCAT('字段 ', COLUMN_NAME, ': ✓ 存在') AS verification_result
FROM information_schema.columns 
WHERE table_schema = DATABASE() 
  AND table_name = 'des_user_binding' 
  AND column_name IN ('create_dept', 'create_by', 'create_time', 'update_by', 'update_time')
ORDER BY 
  CASE COLUMN_NAME 
    WHEN 'create_dept' THEN 1
    WHEN 'create_by' THEN 2 
    WHEN 'create_time' THEN 3
    WHEN 'update_by' THEN 4
    WHEN 'update_time' THEN 5
  END;

-- 6. 显示修复后的完整表结构
SELECT '=== 修复后的表结构 ===' AS message;

SELECT COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_DEFAULT, COLUMN_COMMENT 
FROM information_schema.columns 
WHERE table_schema = DATABASE() 
  AND table_name = 'des_user_binding' 
ORDER BY ORDINAL_POSITION; 