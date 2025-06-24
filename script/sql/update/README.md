# 设计师管理模块数据库脚本使用指南

## 📋 概述

本目录包含了基于现有数据库结构分析的最新数据库脚本，用于设计师管理系统的部署和维护。所有脚本都经过重新设计，确保与现有系统的兼容性。

## 🗂️ 脚本文件说明

### 1. `check_database_structure.sql` - 数据库结构检查脚本
- **功能**: 全面分析现有数据库的表结构、字段、索引等信息
- **用途**: 在执行任何更新前，先了解当前数据库状态
- **输出**: 详细的检查报告，包括缺失表、字段检查、外键约束状态等
- **特点**: 只读操作，安全可靠

### 2. `create_designer_tables.sql` - 完整建表脚本
- **功能**: 创建设计师管理模块的完整表结构
- **用途**: 全新部署或重建整个设计师管理模块
- **包含**: 
  - 10个核心业务表
  - 完整的索引和外键约束
  - 设计师档案汇总视图
  - 基础示例数据
- **特点**: 
  - 支持多租户架构
  - 兼容 MySQL 5.7+
  - 包含JSON字段支持

## 🚀 使用流程

### 第一步：检查现有数据库结构

```bash
# 1. 连接到数据库并检查当前结构
mysql -u username -p database_name < check_database_structure.sql > check_result.txt

# 2. 查看检查结果
cat check_result.txt
```

### 第二步：根据检查结果选择操作

#### 情况A：数据库为空或没有设计师管理表
```bash
# 直接执行完整建表脚本
mysql -u username -p database_name < create_designer_tables.sql
```

#### 情况B：部分表存在但不完整
```bash
# 1. 先备份现有数据
mysqldump -u username -p database_name > backup_$(date +%Y%m%d_%H%M%S).sql

# 2. 执行完整建表脚本（会重建所有表）
mysql -u username -p database_name < create_designer_tables.sql
```

#### 情况C：表结构完整，只需验证
```bash
# 重新运行检查脚本确认状态
mysql -u username -p database_name < check_database_structure.sql
```

## 📊 脚本功能对比

| 脚本 | 检查结构 | 创建表 | 更新字段 | 插入数据 | 创建视图 | 幂等性 |
|------|----------|--------|----------|----------|----------|--------|
| `check_database_structure.sql` | ✅ | ❌ | ❌ | ❌ | ❌ | ✅ |
| `create_designer_tables.sql` | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |

## 🎯 核心表结构

### 主要业务表
1. **des_enterprise** - 企业信息表
2. **des_school** - 院校信息表  
3. **des_designer** - 设计师信息表
4. **des_work** - 设计师作品表
5. **des_job_posting** - 岗位招聘表
6. **des_job_application** - 岗位申请表

### 档案管理表
7. **des_work_experience** - 工作经历表
8. **des_education** - 教育背景表
9. **des_award** - 获奖记录表

### 系统支持表
10. **des_user_binding** - 用户绑定关系表

## 🔧 高级功能

### 1. 设计师档案汇总视图
- **视图名**: `v_designer_profile`
- **功能**: 聚合设计师的所有相关信息
- **包含**: 基本信息、关联企业/院校、统计数据等

### 2. 多租户支持
- 所有表都包含 `tenant_id` 字段
- 默认值为 0，兼容单租户系统
- 支持未来的多租户扩展

### 3. JSON字段支持
- `skill_tags` - 技能标签（设计师表）
- `required_skills` - 技能要求（岗位表）
- `social_links` - 社交媒体链接（设计师表）
- `tags` - 作品标签（作品表）

## ⚡ 性能优化

### 索引策略
- **主键索引**: 所有表的主键自动建立
- **外键索引**: 所有外键字段建立索引
- **业务索引**: 常用查询字段建立索引
- **复合索引**: 多字段查询优化

### 查询优化
- 使用视图简化复杂查询
- 合理的外键约束设计
- 状态字段索引优化

## 🛡️ 数据安全

### 备份策略
```bash
# 执行任何脚本前，务必备份
mysqldump -u username -p --single-transaction database_name > backup_$(date +%Y%m%d_%H%M%S).sql
```

### 回滚方案
```bash
# 如果出现问题，可以从备份恢复
mysql -u username -p database_name < backup_file.sql
```

## 📋 检查列表

### 执行前检查
- [ ] 数据库连接正常
- [ ] 用户权限充足（CREATE、DROP、ALTER）
- [ ] 数据库版本 >= MySQL 5.7
- [ ] 已创建数据库备份
- [ ] 磁盘空间充足

### 执行后验证
- [ ] 所有表创建成功
- [ ] 外键约束正常
- [ ] 视图可以正常查询
- [ ] 基础数据插入成功
- [ ] 索引创建完整

## 🚨 注意事项

### 重要提醒
1. **备份第一**: 执行任何脚本前务必备份数据库
2. **权限检查**: 确保数据库用户有足够权限
3. **版本兼容**: MySQL 5.7+ 支持JSON字段
4. **字符集**: 使用 utf8mb4 支持完整Unicode
5. **业务停机**: 生产环境建议在业务低峰期执行

### 常见问题

#### 1. JSON字段不支持
```
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'JSON' at line 1
```
**解决方案**: 升级到 MySQL 5.7 或更高版本

#### 2. 权限不足
```
ERROR 1142 (42000): CREATE command denied to user
```
**解决方案**: 赋予用户 CREATE、DROP、ALTER 权限

#### 3. 外键约束失败
```
ERROR 1215 (HY000): Cannot add foreign key constraint
```
**解决方案**: 检查被引用表是否存在，字段类型是否匹配

## 📞 技术支持

如遇问题，请提供以下信息：
- MySQL版本信息
- 执行的具体脚本
- 完整的错误信息
- 数据库现有表结构

## 📈 版本历史

- **v2.0** (2025-01-27) - 基于数据库结构分析的重新设计版本
  - 新增数据库结构检查脚本
  - 重新设计完整建表脚本
  - 优化表结构和索引
  - 添加多租户支持
  - 完善文档和使用指南

---

**重要提醒**: 生产环境使用前，请在测试环境充分验证！ 