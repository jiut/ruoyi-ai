# 数据库技能标签更新指南

## 📋 概述

本目录包含三个用于更新现有数据库中技能标签格式的SQL脚本，将旧格式的技能标签转换为新的枚举代码格式，以兼容新的技能标签分类架构。

## 🗂️ 脚本文件说明

### 1. `quick_update_skills.sql` 【推荐】
- **适用场景**: 生产环境快速更新
- **特点**: 简化版本，执行速度快，安全可靠
- **功能**: 批量更新常用技能标签，自动备份，结果验证

### 2. `update_existing_skill_tags.sql`
- **适用场景**: 详细的逐项更新
- **特点**: 逐个更新每种技能标签，更精确
- **功能**: 完整的技能标签转换，包含验证和统计

### 3. `update_skill_tags_advanced.sql`
- **适用场景**: 复杂的数据转换需求  
- **特点**: 使用存储过程和函数，智能识别
- **功能**: 高级转换逻辑，处理复杂格式

## 🚀 执行步骤

### 准备工作

1. **备份数据库**
   ```bash
   mysqldump -u username -p database_name > backup_$(date +%Y%m%d).sql
   ```

2. **检查当前数据**
   ```sql
   SELECT job_id, job_title, required_skills 
   FROM des_job_posting 
   WHERE required_skills IS NOT NULL 
   LIMIT 10;
   ```

### 方案一：快速更新 (推荐)

执行 `quick_update_skills.sql`:

```bash
mysql -u username -p database_name < quick_update_skills.sql
```

或在MySQL客户端中：
```sql
source script/sql/quick_update_skills.sql;
```

### 方案二：详细更新

执行 `update_existing_skill_tags.sql`:

```bash
mysql -u username -p database_name < update_existing_skill_tags.sql
```

### 方案三：高级更新

执行 `update_skill_tags_advanced.sql`:

```bash
mysql -u username -p database_name < update_skill_tags_advanced.sql
```

## 📊 更新对照表

### 工具类技能 (TOOL)
| 原格式 | 新格式 | 说明 |
|--------|--------|------|
| "Figma" | "figma" | 设计工具 |
| "Sketch" | "sketch" | 设计工具 |
| "Photoshop" | "photoshop" | 图像处理 |
| "Illustrator" | "illustrator" | 矢量图形 |
| "After Effects" | "after_effects" | 动效制作 |
| "Cinema 4D" | "cinema_4d" | 3D建模 |
| "3D Max" | "3d_max" | 3D建模 |
| "Maya" | "maya" | 3D动画 |
| "Axure RP" | "axure_rp" | 原型工具 |

### 专业领域类 (FIELD)
| 原格式 | 新格式 | 说明 |
|--------|--------|------|
| "交互设计" | "interaction_design" | 交互设计 |
| "UI设计" | "ui_design" | 界面设计 |
| "品牌设计" | "brand_design" | 品牌视觉 |
| "产品设计" | "product_design" | 产品设计 |
| "动效设计" | "motion_design" | 动效设计 |
| "游戏美术" | "game_art" | 游戏美术 |
| "网页设计" | "web_design" | 网页设计 |
| "移动端设计" | "mobile_design" | 移动端UI |

### 技能方法类 (SKILL)
| 原格式 | 新格式 | 说明 |
|--------|--------|------|
| "用户体验" | "user_experience" | UX设计 |
| "用户研究" | "user_research" | 用户调研 |
| "原型设计" | "prototype_design" | 原型制作 |
| "设计系统" | "design_system" | 设计规范 |
| "信息架构" | "information_architecture" | 信息结构 |
| "视觉系统" | "visual_system" | 视觉规范 |
| "线框设计" | "wireframing" | 线框图 |
| "用户测试" | "user_testing" | 可用性测试 |

## ✅ 验证更新结果

### 1. 检查更新数量
```sql
SELECT 
    '更新前记录数' as type,
    COUNT(*) as count
FROM des_job_posting_backup 
WHERE required_skills IS NOT NULL

UNION ALL

SELECT 
    '更新后记录数' as type,
    COUNT(*) as count
FROM des_job_posting 
WHERE required_skills IS NOT NULL;
```

### 2. 对比更新前后
```sql
SELECT 
    p.job_id,
    p.job_title,
    b.required_skills as old_skills,
    p.required_skills as new_skills
FROM des_job_posting p
INNER JOIN des_job_posting_backup b ON p.job_id = b.job_id
WHERE p.required_skills != b.required_skills
ORDER BY p.job_id;
```

### 3. 检查未转换的中文标签
```sql
SELECT 
    job_id,
    job_title,
    required_skills
FROM des_job_posting 
WHERE required_skills LIKE '%设计%'
   OR required_skills LIKE '%体验%'
   OR required_skills LIKE '%研究%'
ORDER BY job_id;
```

### 4. 统计技能标签分布
```sql
SELECT 
    CASE 
        WHEN required_skills LIKE '%figma%' OR required_skills LIKE '%sketch%' THEN '🔵 工具类'
        WHEN required_skills LIKE '%interaction_design%' OR required_skills LIKE '%ui_design%' THEN '🟣 专业领域类'
        WHEN required_skills LIKE '%user_experience%' OR required_skills LIKE '%user_research%' THEN '🩷 技能方法类'
        ELSE '其他'
    END as category,
    COUNT(*) as job_count
FROM des_job_posting 
WHERE required_skills IS NOT NULL
GROUP BY category;
```

## 🔄 回滚操作

如果更新出现问题，可以进行回滚：

### 方法一：从备份表恢复
```sql
UPDATE des_job_posting dest 
INNER JOIN des_job_posting_backup src ON dest.job_id = src.job_id 
SET dest.required_skills = src.required_skills;
```

### 方法二：从备份文件恢复
```bash
mysql -u username -p database_name < backup_$(date +%Y%m%d).sql
```

## ⚠️ 注意事项

### 执行前检查
1. **确保数据库备份完整**
2. **在测试环境先验证脚本**
3. **检查当前数据格式是否符合预期**

### 执行时注意
1. **在低峰期执行，避免影响业务**
2. **监控执行过程，及时发现异常**
3. **保留事务，便于回滚**

### 执行后验证
1. **检查更新数量是否正确**
2. **验证技能标签格式是否统一**
3. **测试相关功能是否正常**

## 🛠️ 故障排除

### 常见问题

#### 1. 权限不足
```
ERROR 1142 (42000): CREATE command denied
```
**解决方案**: 确保数据库用户有CREATE TABLE权限

#### 2. 字符集问题
```
ERROR 1366 (HY000): Incorrect string value
```
**解决方案**: 确保数据库使用UTF-8字符集

#### 3. 事务超时
```
ERROR 1205 (HY000): Lock wait timeout exceeded
```
**解决方案**: 增加锁等待超时时间或分批处理

### 性能优化

1. **分批处理大量数据**
   ```sql
   UPDATE des_job_posting 
   SET required_skills = ... 
   WHERE job_id BETWEEN 1 AND 1000;
   ```

2. **创建临时索引**
   ```sql
   CREATE INDEX idx_temp_skills ON des_job_posting(required_skills);
   -- 执行更新
   DROP INDEX idx_temp_skills ON des_job_posting;
   ```

## 📞 技术支持

如遇问题，请提供以下信息：
- 数据库版本和字符集
- 错误信息和日志
- 当前数据样例
- 执行的具体脚本

---

**重要提醒**: 请在生产环境执行前，务必在测试环境充分验证！ 