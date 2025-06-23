-- 高级技能标签更新脚本
-- 使用存储过程和函数来处理复杂的技能标签转换
-- 该脚本可以处理混合格式、嵌套更新和复杂的 JSON 数组

DELIMITER $$

-- 创建技能标签转换函数
CREATE FUNCTION convert_skill_tag(input_tag VARCHAR(100)) 
RETURNS VARCHAR(50)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(50);
    
    -- 设计工具类 (TOOL)
    CASE 
        WHEN input_tag IN ('Figma', 'figma') THEN SET result = 'figma';
        WHEN input_tag IN ('Sketch', 'sketch') THEN SET result = 'sketch';
        WHEN input_tag IN ('Axure RP', 'Axure', 'axure_rp', 'axure') THEN SET result = 'axure_rp';
        WHEN input_tag IN ('Photoshop', 'PS', 'photoshop') THEN SET result = 'photoshop';
        WHEN input_tag IN ('Illustrator', 'AI', 'illustrator') THEN SET result = 'illustrator';
        WHEN input_tag IN ('After Effects', 'AE', 'after_effects') THEN SET result = 'after_effects';
        WHEN input_tag IN ('Cinema 4D', 'C4D', 'cinema_4d') THEN SET result = 'cinema_4d';
        WHEN input_tag IN ('3D Max', '3ds Max', '3d_max', '3dsmax') THEN SET result = '3d_max';
        WHEN input_tag IN ('Maya', 'maya') THEN SET result = 'maya';
        WHEN input_tag IN ('Adobe XD', 'XD', 'adobe_xd') THEN SET result = 'adobe_xd';
        WHEN input_tag IN ('InVision', 'invision') THEN SET result = 'invision';
        WHEN input_tag IN ('Framer', 'framer') THEN SET result = 'framer';
        WHEN input_tag IN ('Principle', 'principle') THEN SET result = 'principle';
        WHEN input_tag IN ('Zeplin', 'zeplin') THEN SET result = 'zeplin';
        WHEN input_tag IN ('Abstract', 'abstract') THEN SET result = 'abstract';
        WHEN input_tag IN ('Blender', 'blender') THEN SET result = 'blender';
        WHEN input_tag IN ('Lottie', 'lottie') THEN SET result = 'lottie';
        
        -- 设计专业领域类 (FIELD)
        WHEN input_tag IN ('交互设计', 'Interaction Design', 'interaction_design', 'IxD') THEN SET result = 'interaction_design';
        WHEN input_tag IN ('UI设计', 'UI Design', 'ui_design', 'Interface Design') THEN SET result = 'ui_design';
        WHEN input_tag IN ('品牌设计', 'Brand Design', 'brand_design', 'Branding') THEN SET result = 'brand_design';
        WHEN input_tag IN ('产品设计', 'Product Design', 'product_design') THEN SET result = 'product_design';
        WHEN input_tag IN ('动效设计', 'Motion Design', 'motion_design', 'Animation Design') THEN SET result = 'motion_design';
        WHEN input_tag IN ('游戏美术', 'Game Art', 'game_art') THEN SET result = 'game_art';
        WHEN input_tag IN ('网页设计', 'Web Design', 'web_design') THEN SET result = 'web_design';
        WHEN input_tag IN ('移动端设计', 'Mobile Design', 'mobile_design', 'App Design') THEN SET result = 'mobile_design';
        WHEN input_tag IN ('平面设计', 'Graphic Design', 'graphic_design') THEN SET result = 'graphic_design';
        WHEN input_tag IN ('LOGO设计', 'Logo Design', 'logo_design') THEN SET result = 'logo_design';
        WHEN input_tag IN ('界面设计', 'Interface Design', 'interface_design') THEN SET result = 'interface_design';
        WHEN input_tag IN ('品牌标识', 'Brand Identity', 'brand_identity') THEN SET result = 'brand_identity';
        WHEN input_tag IN ('动画制作', 'Animation Design', 'animation_design') THEN SET result = 'animation_design';
        
        -- 设计技能/方法类 (SKILL)
        WHEN input_tag IN ('用户体验', 'User Experience', 'user_experience', 'UX') THEN SET result = 'user_experience';
        WHEN input_tag IN ('用户研究', 'User Research', 'user_research', 'UX Research') THEN SET result = 'user_research';
        WHEN input_tag IN ('原型设计', 'Prototype Design', 'prototype_design', 'Prototyping') THEN SET result = 'prototype_design';
        WHEN input_tag IN ('设计系统', 'Design System', 'design_system') THEN SET result = 'design_system';
        WHEN input_tag IN ('信息架构', 'Information Architecture', 'information_architecture', 'IA') THEN SET result = 'information_architecture';
        WHEN input_tag IN ('视觉系统', 'Visual System', 'visual_system') THEN SET result = 'visual_system';
        WHEN input_tag IN ('线框设计', 'Wireframing', 'wireframing') THEN SET result = 'wireframing';
        WHEN input_tag IN ('用户测试', 'User Testing', 'user_testing', 'Usability Testing') THEN SET result = 'user_testing';
        WHEN input_tag IN ('用户画像', 'Persona Design', 'persona_design', 'User Persona') THEN SET result = 'persona_design';
        WHEN input_tag IN ('用户旅程', 'Journey Mapping', 'journey_mapping', 'User Journey') THEN SET result = 'journey_mapping';
        WHEN input_tag IN ('可用性测试', 'Usability Testing', 'usability_testing') THEN SET result = 'usability_testing';
        WHEN input_tag IN ('视觉设计', 'Visual Design', 'visual_design') THEN SET result = 'visual_design';
        WHEN input_tag IN ('字体设计', 'Typography', 'typography') THEN SET result = 'typography';
        WHEN input_tag IN ('色彩理论', 'Color Theory', 'color_theory') THEN SET result = 'color_theory';
        WHEN input_tag IN ('插画', 'Illustration', 'illustration') THEN SET result = 'illustration';
        WHEN input_tag IN ('角色设计', 'Character Design', 'character_design') THEN SET result = 'character_design';
        WHEN input_tag IN ('场景设计', 'Scene Design', 'scene_design') THEN SET result = 'scene_design';
        WHEN input_tag IN ('视觉识别', 'Visual Identity', 'visual_identity') THEN SET result = 'visual_identity';
        WHEN input_tag IN ('动画', 'Animation', 'animation') THEN SET result = 'animation';
        WHEN input_tag IN ('动效', 'Effects', 'effects') THEN SET result = 'effects';
        WHEN input_tag IN ('3D建模', '3D Modeling', '3d_modeling') THEN SET result = '3d_modeling';
        WHEN input_tag IN ('摄影', 'Photography', 'photography') THEN SET result = 'photography';
        WHEN input_tag IN ('视频剪辑', 'Video Editing', 'video_editing') THEN SET result = 'video_editing';
        
        -- 如果没有匹配，返回原值（转为小写并替换空格为下划线）
        ELSE SET result = LOWER(REPLACE(input_tag, ' ', '_'));
    END CASE;
    
    RETURN result;
END$$

-- 创建技能标签数组转换函数
CREATE FUNCTION convert_skills_json(input_json TEXT) 
RETURNS TEXT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE result TEXT DEFAULT '';
    DECLARE temp_json TEXT;
    DECLARE tag VARCHAR(100);
    DECLARE converted_tag VARCHAR(50);
    DECLARE pos INT DEFAULT 1;
    DECLARE tag_start INT;
    DECLARE tag_end INT;
    
    -- 如果输入为空或NULL，返回空数组
    IF input_json IS NULL OR input_json = '' THEN
        RETURN '[]';
    END IF;
    
    -- 如果不是JSON格式，尝试解析为逗号分隔的字符串
    IF LEFT(TRIM(input_json), 1) != '[' THEN
        -- 处理逗号分隔的字符串
        SET temp_json = CONCAT('["', REPLACE(TRIM(input_json), ',', '","'), '"]');
        SET input_json = temp_json;
    END IF;
    
    SET result = '[';
    SET temp_json = input_json;
    
    -- 移除开头的 [
    SET temp_json = SUBSTRING(temp_json, 2);
    -- 移除结尾的 ]
    SET temp_json = SUBSTRING(temp_json, 1, LENGTH(temp_json) - 1);
    
    -- 处理每个技能标签
    WHILE LENGTH(temp_json) > 0 DO
        -- 找到下一个引号的位置
        SET tag_start = LOCATE('"', temp_json);
        IF tag_start = 0 THEN
            LEAVE WHILE;
        END IF;
        
        -- 移除开头部分到第一个引号
        SET temp_json = SUBSTRING(temp_json, tag_start + 1);
        
        -- 找到结束引号的位置
        SET tag_end = LOCATE('"', temp_json);
        IF tag_end = 0 THEN
            LEAVE WHILE;
        END IF;
        
        -- 提取标签
        SET tag = SUBSTRING(temp_json, 1, tag_end - 1);
        
        -- 转换标签
        SET converted_tag = convert_skill_tag(tag);
        
        -- 添加到结果中
        IF LENGTH(result) > 1 THEN
            SET result = CONCAT(result, ',');
        END IF;
        SET result = CONCAT(result, '"', converted_tag, '"');
        
        -- 移除已处理的部分
        SET temp_json = SUBSTRING(temp_json, tag_end + 1);
        -- 移除逗号和空格
        SET temp_json = LTRIM(SUBSTRING(temp_json, LOCATE(',', temp_json) + 1));
    END WHILE;
    
    SET result = CONCAT(result, ']');
    
    RETURN result;
END$$

-- 创建批量更新存储过程
CREATE PROCEDURE update_all_skill_tags()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE current_id INT;
    DECLARE current_skills TEXT;
    DECLARE new_skills TEXT;
    
    -- 声明游标
    DECLARE skill_cursor CURSOR FOR 
        SELECT job_id, required_skills 
        FROM des_job_posting 
        WHERE required_skills IS NOT NULL AND required_skills != '';
    
    -- 声明异常处理
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- 开始事务
    START TRANSACTION;
    
    -- 创建备份表
    DROP TABLE IF EXISTS des_job_posting_backup;
    CREATE TABLE des_job_posting_backup AS SELECT * FROM des_job_posting;
    
    -- 打开游标
    OPEN skill_cursor;
    
    -- 循环处理每一行
    skill_loop: LOOP
        FETCH skill_cursor INTO current_id, current_skills;
        
        IF done THEN
            LEAVE skill_loop;
        END IF;
        
        -- 转换技能标签
        SET new_skills = convert_skills_json(current_skills);
        
        -- 更新记录
        UPDATE des_job_posting 
        SET required_skills = new_skills 
        WHERE job_id = current_id;
        
    END LOOP;
    
    -- 关闭游标
    CLOSE skill_cursor;
    
    -- 提交事务
    COMMIT;
    
    -- 输出统计信息
    SELECT '技能标签更新完成' as message, COUNT(*) as updated_records 
    FROM des_job_posting 
    WHERE required_skills IS NOT NULL AND required_skills != '';
    
END$$

DELIMITER ;

-- 执行更新
CALL update_all_skill_tags();

-- 验证更新结果
SELECT 
    job_id,
    job_title,
    required_skills as new_skills,
    (SELECT required_skills FROM des_job_posting_backup WHERE job_id = des_job_posting.job_id) as old_skills
FROM des_job_posting 
WHERE required_skills IS NOT NULL AND required_skills != ''
ORDER BY job_id;

-- 检查技能标签分布统计
SELECT 
    SUBSTRING_INDEX(SUBSTRING_INDEX(skill_item, '"', 2), '"', -1) as skill_code,
    COUNT(*) as usage_count
FROM (
    SELECT 
        SUBSTRING_INDEX(SUBSTRING_INDEX(required_skills, ',', numbers.n), ',', -1) as skill_item
    FROM des_job_posting
    CROSS JOIN (
        SELECT 1 n UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL 
        SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL 
        SELECT 9 UNION ALL SELECT 10
    ) numbers
    WHERE required_skills IS NOT NULL 
    AND CHAR_LENGTH(required_skills) - CHAR_LENGTH(REPLACE(required_skills, ',', '')) >= numbers.n - 1
) skill_extraction
WHERE skill_item LIKE '%"%'
GROUP BY skill_code
ORDER BY usage_count DESC;

-- 清理函数和存储过程（可选）
-- DROP FUNCTION IF EXISTS convert_skill_tag;
-- DROP FUNCTION IF EXISTS convert_skills_json;
-- DROP PROCEDURE IF EXISTS update_all_skill_tags;
-- DROP TABLE IF EXISTS des_job_posting_backup;