-- 更新现有数据库中的技能标签数据
-- 将旧格式的技能标签转换为新的枚举代码格式
-- 该脚本用于迁移现有数据，确保与新的技能标签分类架构兼容

-- 开始事务
START TRANSACTION;

-- 备份原始数据（可选，用于回滚）
-- CREATE TABLE des_job_posting_backup AS SELECT * FROM des_job_posting;

-- 1. 更新 required_skills 字段中的技能标签
-- 将中文名称和英文名称统一转换为标准枚举代码

-- 设计工具类 (TOOL) 标签更新
UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Figma"', '"figma"')
WHERE required_skills LIKE '%"Figma"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Sketch"', '"sketch"')
WHERE required_skills LIKE '%"Sketch"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Axure RP"', '"axure_rp"')
WHERE required_skills LIKE '%"Axure RP"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Photoshop"', '"photoshop"')
WHERE required_skills LIKE '%"Photoshop"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Illustrator"', '"illustrator"')
WHERE required_skills LIKE '%"Illustrator"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"After Effects"', '"after_effects"')
WHERE required_skills LIKE '%"After Effects"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Cinema 4D"', '"cinema_4d"')
WHERE required_skills LIKE '%"Cinema 4D"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"3D Max"', '"3d_max"')
WHERE required_skills LIKE '%"3D Max"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Maya"', '"maya"')
WHERE required_skills LIKE '%"Maya"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Adobe XD"', '"adobe_xd"')
WHERE required_skills LIKE '%"Adobe XD"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"InVision"', '"invision"')
WHERE required_skills LIKE '%"InVision"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Framer"', '"framer"')
WHERE required_skills LIKE '%"Framer"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Principle"', '"principle"')
WHERE required_skills LIKE '%"Principle"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Zeplin"', '"zeplin"')
WHERE required_skills LIKE '%"Zeplin"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Abstract"', '"abstract"')
WHERE required_skills LIKE '%"Abstract"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Blender"', '"blender"')
WHERE required_skills LIKE '%"Blender"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"Lottie"', '"lottie"')
WHERE required_skills LIKE '%"Lottie"%';

-- 设计专业领域类 (FIELD) 标签更新
UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"交互设计"', '"interaction_design"')
WHERE required_skills LIKE '%"交互设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"UI设计"', '"ui_design"')
WHERE required_skills LIKE '%"UI设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"品牌设计"', '"brand_design"')
WHERE required_skills LIKE '%"品牌设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"产品设计"', '"product_design"')
WHERE required_skills LIKE '%"产品设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"动效设计"', '"motion_design"')
WHERE required_skills LIKE '%"动效设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"游戏美术"', '"game_art"')
WHERE required_skills LIKE '%"游戏美术"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"网页设计"', '"web_design"')
WHERE required_skills LIKE '%"网页设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"移动端设计"', '"mobile_design"')
WHERE required_skills LIKE '%"移动端设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"平面设计"', '"graphic_design"')
WHERE required_skills LIKE '%"平面设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"LOGO设计"', '"logo_design"')
WHERE required_skills LIKE '%"LOGO设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"界面设计"', '"interface_design"')
WHERE required_skills LIKE '%"界面设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"品牌标识"', '"brand_identity"')
WHERE required_skills LIKE '%"品牌标识"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"动画制作"', '"animation_design"')
WHERE required_skills LIKE '%"动画制作"%';

-- 设计技能/方法类 (SKILL) 标签更新
UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"用户体验"', '"user_experience"')
WHERE required_skills LIKE '%"用户体验"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"用户研究"', '"user_research"')
WHERE required_skills LIKE '%"用户研究"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"原型设计"', '"prototype_design"')
WHERE required_skills LIKE '%"原型设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"设计系统"', '"design_system"')
WHERE required_skills LIKE '%"设计系统"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"信息架构"', '"information_architecture"')
WHERE required_skills LIKE '%"信息架构"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"视觉系统"', '"visual_system"')
WHERE required_skills LIKE '%"视觉系统"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"线框设计"', '"wireframing"')
WHERE required_skills LIKE '%"线框设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"用户测试"', '"user_testing"')
WHERE required_skills LIKE '%"用户测试"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"用户画像"', '"persona_design"')
WHERE required_skills LIKE '%"用户画像"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"用户旅程"', '"journey_mapping"')
WHERE required_skills LIKE '%"用户旅程"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"可用性测试"', '"usability_testing"')
WHERE required_skills LIKE '%"可用性测试"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"视觉设计"', '"visual_design"')
WHERE required_skills LIKE '%"视觉设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"字体设计"', '"typography"')
WHERE required_skills LIKE '%"字体设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"色彩理论"', '"color_theory"')
WHERE required_skills LIKE '%"色彩理论"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"插画"', '"illustration"')
WHERE required_skills LIKE '%"插画"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"角色设计"', '"character_design"')
WHERE required_skills LIKE '%"角色设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"场景设计"', '"scene_design"')
WHERE required_skills LIKE '%"场景设计"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"视觉识别"', '"visual_identity"')
WHERE required_skills LIKE '%"视觉识别"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"动画"', '"animation"')
WHERE required_skills LIKE '%"动画"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"动效"', '"effects"')
WHERE required_skills LIKE '%"动效"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"3D建模"', '"3d_modeling"')
WHERE required_skills LIKE '%"3D建模"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"摄影"', '"photography"')
WHERE required_skills LIKE '%"摄影"%';

UPDATE des_job_posting 
SET required_skills = REPLACE(required_skills, '"视频剪辑"', '"video_editing"')
WHERE required_skills LIKE '%"视频剪辑"%';

-- 2. 如果存在设计师表，也更新其中的技能标签
-- UPDATE des_designer 
-- SET skills = ... WHERE skills LIKE '%需要更新的技能%';

-- 3. 验证更新结果
SELECT 
    job_id,
    job_title,
    required_skills,
    CASE 
        WHEN required_skills LIKE '%figma%' OR required_skills LIKE '%sketch%' OR required_skills LIKE '%photoshop%' THEN '包含工具类技能'
        WHEN required_skills LIKE '%interaction_design%' OR required_skills LIKE '%ui_design%' OR required_skills LIKE '%brand_design%' THEN '包含领域类技能'
        WHEN required_skills LIKE '%user_experience%' OR required_skills LIKE '%user_research%' OR required_skills LIKE '%prototype_design%' THEN '包含技能类技能'
        ELSE '未知技能类型'
    END as skill_category_check
FROM des_job_posting 
WHERE required_skills IS NOT NULL AND required_skills != ''
ORDER BY job_id;

-- 4. 检查是否还有未转换的中文技能标签
SELECT 
    job_id,
    job_title,
    required_skills
FROM des_job_posting 
WHERE required_skills REGEXP '["，][\u4e00-\u9fa5]+["，]'
   OR required_skills LIKE '%设计%'
   OR required_skills LIKE '%体验%'
   OR required_skills LIKE '%研究%'
ORDER BY job_id;

-- 5. 统计技能标签分类数量
SELECT 
    '工具类(TOOL)' as category,
    COUNT(*) as count
FROM des_job_posting 
WHERE required_skills LIKE '%figma%' 
   OR required_skills LIKE '%sketch%' 
   OR required_skills LIKE '%photoshop%'
   OR required_skills LIKE '%illustrator%'
   OR required_skills LIKE '%after_effects%'
   OR required_skills LIKE '%cinema_4d%'
   OR required_skills LIKE '%3d_max%'
   OR required_skills LIKE '%maya%'

UNION ALL

SELECT 
    '专业领域类(FIELD)' as category,
    COUNT(*) as count
FROM des_job_posting 
WHERE required_skills LIKE '%interaction_design%' 
   OR required_skills LIKE '%ui_design%' 
   OR required_skills LIKE '%brand_design%'
   OR required_skills LIKE '%product_design%'
   OR required_skills LIKE '%motion_design%'
   OR required_skills LIKE '%game_art%'
   OR required_skills LIKE '%web_design%'
   OR required_skills LIKE '%mobile_design%'

UNION ALL

SELECT 
    '技能方法类(SKILL)' as category,
    COUNT(*) as count
FROM des_job_posting 
WHERE required_skills LIKE '%user_experience%' 
   OR required_skills LIKE '%user_research%' 
   OR required_skills LIKE '%prototype_design%'
   OR required_skills LIKE '%design_system%'
   OR required_skills LIKE '%information_architecture%'
   OR required_skills LIKE '%visual_system%'
   OR required_skills LIKE '%wireframing%'
   OR required_skills LIKE '%user_testing%';

-- 提交事务
COMMIT;

-- 如果需要回滚，可以执行以下语句：
-- ROLLBACK;
-- UPDATE des_job_posting dest 
-- INNER JOIN des_job_posting_backup src ON dest.job_id = src.job_id 
-- SET dest.required_skills = src.required_skills; 