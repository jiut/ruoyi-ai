-- 快速技能标签更新脚本 (简化版)
-- 适合在生产环境中快速执行，更新现有数据库中的技能标签格式

-- 开始事务
BEGIN;

-- 1. 创建备份表 (安全起见)
CREATE TABLE IF NOT EXISTS des_job_posting_backup_$(date +%Y%m%d) AS 
SELECT * FROM des_job_posting WHERE required_skills IS NOT NULL;

-- 2. 批量更新 - 工具类技能标签
UPDATE des_job_posting SET required_skills = 
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        REPLACE(required_skills, '"Figma"', '"figma"'),
                                        '"Sketch"', '"sketch"'),
                                    '"Photoshop"', '"photoshop"'),
                                '"Illustrator"', '"illustrator"'),
                            '"After Effects"', '"after_effects"'),
                        '"Cinema 4D"', '"cinema_4d"'),
                    '"3D Max"', '"3d_max"'),
                '"Maya"', '"maya"'),
            '"Axure RP"', '"axure_rp"')
WHERE required_skills LIKE '%Figma%' 
   OR required_skills LIKE '%Sketch%' 
   OR required_skills LIKE '%Photoshop%'
   OR required_skills LIKE '%Illustrator%'
   OR required_skills LIKE '%After Effects%'
   OR required_skills LIKE '%Cinema 4D%'
   OR required_skills LIKE '%3D Max%'
   OR required_skills LIKE '%Maya%'
   OR required_skills LIKE '%Axure RP%';

-- 3. 批量更新 - 专业领域类技能标签
UPDATE des_job_posting SET required_skills = 
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(required_skills, '"交互设计"', '"interaction_design"'),
                                '"UI设计"', '"ui_design"'),
                            '"品牌设计"', '"brand_design"'),
                        '"产品设计"', '"product_design"'),
                    '"动效设计"', '"motion_design"'),
                '"游戏美术"', '"game_art"'),
            '"网页设计"', '"web_design"'),
        '"移动端设计"', '"mobile_design"')
WHERE required_skills LIKE '%交互设计%' 
   OR required_skills LIKE '%UI设计%' 
   OR required_skills LIKE '%品牌设计%'
   OR required_skills LIKE '%产品设计%'
   OR required_skills LIKE '%动效设计%'
   OR required_skills LIKE '%游戏美术%'
   OR required_skills LIKE '%网页设计%'
   OR required_skills LIKE '%移动端设计%';

-- 4. 批量更新 - 技能方法类技能标签
UPDATE des_job_posting SET required_skills = 
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(
                            REPLACE(
                                REPLACE(
                                    REPLACE(
                                        REPLACE(required_skills, '"用户体验"', '"user_experience"'),
                                        '"用户研究"', '"user_research"'),
                                    '"原型设计"', '"prototype_design"'),
                                '"设计系统"', '"design_system"'),
                            '"信息架构"', '"information_architecture"'),
                        '"视觉系统"', '"visual_system"'),
                    '"线框设计"', '"wireframing"'),
                '"用户测试"', '"user_testing"'),
            '"视觉设计"', '"visual_design"'),
        '"字体设计"', '"typography"')
WHERE required_skills LIKE '%用户体验%' 
   OR required_skills LIKE '%用户研究%' 
   OR required_skills LIKE '%原型设计%'
   OR required_skills LIKE '%设计系统%'
   OR required_skills LIKE '%信息架构%'
   OR required_skills LIKE '%视觉系统%'
   OR required_skills LIKE '%线框设计%'
   OR required_skills LIKE '%用户测试%'
   OR required_skills LIKE '%视觉设计%'
   OR required_skills LIKE '%字体设计%';

-- 5. 额外的特殊技能标签更新
UPDATE des_job_posting SET required_skills = 
    REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(
                        REPLACE(required_skills, '"角色设计"', '"character_design"'),
                        '"场景设计"', '"scene_design"'),
                    '"动画制作"', '"animation_design"'),
                '"平面设计"', '"graphic_design"'),
            '"LOGO设计"', '"logo_design"'),
        '"插画设计"', '"illustration"')
WHERE required_skills LIKE '%角色设计%' 
   OR required_skills LIKE '%场景设计%' 
   OR required_skills LIKE '%动画制作%'
   OR required_skills LIKE '%平面设计%'
   OR required_skills LIKE '%LOGO设计%'
   OR required_skills LIKE '%插画%';

-- 6. 验证更新结果
SELECT 
    '更新完成，共处理记录数:' as status,
    COUNT(*) as total_records
FROM des_job_posting 
WHERE required_skills IS NOT NULL;

-- 7. 显示更新后的数据样例
SELECT 
    job_id,
    job_title,
    required_skills
FROM des_job_posting 
WHERE required_skills IS NOT NULL 
ORDER BY job_id 
LIMIT 10;

-- 8. 检查是否还有未转换的中文技能标签
SELECT 
    job_id,
    job_title,
    required_skills,
    '包含中文技能标签，需要手动检查' as warning
FROM des_job_posting 
WHERE required_skills REGEXP '"[\\u4e00-\\u9fa5]+'
   OR required_skills LIKE '%设计%'
   OR required_skills LIKE '%体验%'
   OR required_skills LIKE '%研究%'
ORDER BY job_id;

-- 9. 技能标签分类统计
SELECT 
    '工具类技能' as category,
    COUNT(*) as job_count
FROM des_job_posting 
WHERE required_skills LIKE '%figma%' 
   OR required_skills LIKE '%sketch%' 
   OR required_skills LIKE '%photoshop%'

UNION ALL

SELECT 
    '专业领域技能' as category,
    COUNT(*) as job_count
FROM des_job_posting 
WHERE required_skills LIKE '%interaction_design%' 
   OR required_skills LIKE '%ui_design%' 
   OR required_skills LIKE '%brand_design%'

UNION ALL

SELECT 
    '技能方法类' as category,
    COUNT(*) as job_count
FROM des_job_posting 
WHERE required_skills LIKE '%user_experience%' 
   OR required_skills LIKE '%user_research%' 
   OR required_skills LIKE '%prototype_design%';

-- 提交事务
COMMIT;

-- 注意：如果需要回滚，可以执行：
-- ROLLBACK;
-- 或者从备份表恢复：
-- UPDATE des_job_posting dest 
-- INNER JOIN des_job_posting_backup_$(date +%Y%m%d) src ON dest.job_id = src.job_id 
-- SET dest.required_skills = src.required_skills; 