# 设计师模拟数据更新脚本说明

## 概述
此脚本用于将 `script/frontend/mockDesigners.ts` 中的模拟数据替换到数据库中的设计师相关表。

## 注意事项
⚠️ **警告：此脚本会删除现有的所有设计师相关数据，请谨慎使用！**

## 影响的表
- `des_designer` - 设计师基本信息
- `des_education` - 教育背景
- `des_work_experience` - 工作经历
- `des_work` - 作品集
- `des_award` - 获奖记录
- `des_user_binding` - 用户绑定关系（仅删除设计师相关绑定）

## 脚本功能
1. **数据清理**：删除现有的设计师相关数据
2. **重置自增ID**：重置所有相关表的自增ID
3. **插入新数据**：插入20个设计师的完整信息，包括：
   - 基本信息（姓名、联系方式、技能等）
   - 教育背景
   - 工作经历
   - 作品集
   - 获奖记录

## 使用方法

### 1. 备份数据库
在执行脚本前，请先备份数据库：
```bash
mysqldump -u username -p database_name > backup_$(date +%Y%m%d_%H%M%S).sql
```

### 2. 执行脚本
```bash
mysql -u username -p database_name < script/sql/update_mock_data.sql
```

### 3. 验证数据
执行完成后，可以通过以下查询验证数据：
```sql
-- 检查设计师数量
SELECT COUNT(*) FROM des_designer;

-- 检查教育背景数量
SELECT COUNT(*) FROM des_education;

-- 检查工作经历数量
SELECT COUNT(*) FROM des_work_experience;

-- 检查作品数量
SELECT COUNT(*) FROM des_work;

-- 检查获奖记录数量
SELECT COUNT(*) FROM des_award;
```

## 数据内容
脚本包含20个设计师的完整数据：
- 涵盖多种设计职业（UI/UX设计师、视觉设计师、3D设计师等）
- 包含完整的个人信息、技能标签、作品集链接
- 详细的教育背景和工作经历
- 真实的获奖记录和作品信息

## 恢复数据
如果需要恢复原始数据，请使用之前创建的备份：
```bash
mysql -u username -p database_name < backup_YYYYMMDD_HHMMSS.sql
```

## 联系信息
如有问题，请联系开发团队。 