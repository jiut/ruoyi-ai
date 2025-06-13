-- 修复设计师表中gender字段的数据不一致问题
-- 将中文性别转换为数字代码：男->0, 女->1, 其他->2

-- 备份当前数据（可选）
-- CREATE TABLE des_designer_backup AS SELECT * FROM des_designer;

-- 修复性别字段数据
UPDATE des_designer 
SET gender = CASE 
    WHEN gender = '男' THEN '0'
    WHEN gender = '女' THEN '1'
    WHEN gender = '0' THEN '0'  -- 已经是正确格式，保持不变
    WHEN gender = '1' THEN '1'  -- 已经是正确格式，保持不变
    WHEN gender = '2' THEN '2'  -- 已经是正确格式，保持不变
    ELSE '2'  -- 其他值或NULL设置为未知
END
WHERE gender IS NOT NULL;

-- 将NULL值设置为未知
UPDATE des_designer 
SET gender = '2' 
WHERE gender IS NULL;

-- 验证修复结果
SELECT 
    gender,
    COUNT(*) as count,
    CASE 
        WHEN gender = '0' THEN '男'
        WHEN gender = '1' THEN '女'
        WHEN gender = '2' THEN '未知'
        ELSE '异常数据'
    END as gender_name
FROM des_designer 
GROUP BY gender
ORDER BY gender;

-- 检查是否还有异常数据
SELECT designer_id, designer_name, gender 
FROM des_designer 
WHERE gender NOT IN ('0', '1', '2'); 