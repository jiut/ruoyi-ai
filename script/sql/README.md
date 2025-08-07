# 智图工厂数据库升级文件包

## 📋 文件说明

本文件包包含将现有若依AI系统升级为支持智图工厂功能的所有必要文件。

### 🗂️ 文件列表

| 文件名 | 说明 | 平台 |
|--------|------|------|
| `zhitu_factory_upgrade.sql` | 主要升级脚本 | 全平台 |
| `智图工厂数据库升级指南.md` | 详细升级指南 | 全平台 |
| `execute_upgrade.sh` | Linux/macOS自动升级脚本 | Linux/macOS |
| `execute_upgrade.bat` | Windows自动升级脚本 | Windows |
| `README.md` | 本说明文件 | 全平台 |

## 🚀 快速开始

### 方式一：自动升级（推荐）

#### Linux/macOS用户：
```bash
# 给脚本执行权限
chmod +x execute_upgrade.sh

# 执行升级
./execute_upgrade.sh localhost root your_database_name 3306
```

#### Windows用户：
```cmd
# 直接运行批处理文件
execute_upgrade.bat localhost root your_database_name 3306
```

### 方式二：手动升级

```bash
# 1. 备份数据库
mysqldump -u用户名 -p密码 数据库名 > backup.sql

# 2. 执行升级脚本
mysql -u用户名 -p密码 数据库名 < zhitu_factory_upgrade.sql
```

## 📊 升级内容

### 新增数据表

1. **`des_task`** - 任务基础信息表
   - 存储任务标题、描述、预算、截止时间等基础信息
   - 关联企业表，支持企业发布任务

2. **`des_task_application`** - 任务申请表（支持双重审核）
   - 支持DUAL（双重审核）和ENTERPRISE（企业自主审核）两种模式
   - 系统管理员审核信息对企业管理员和设计师完全透明
   - 包含完整的申请状态管理和审核流程

3. **`des_task_deliverable`** - 任务交付表
   - 支持灵活的文本交付方式
   - 可包含链接、提取码、说明等混合内容
   - 版本管理和审核反馈功能

4. **`des_task_payment`** - 任务支付表
   - 支持多种支付方式（支付宝、微信、银行转账）
   - 完整的支付状态跟踪
   - 订单号和交易号管理

### 新增数据视图

- **`v_enterprise_task_application`** - 企业管理员专用视图
  - 严格隐藏系统管理员审核信息
  - 确保审核透明性原则

### 新增权限菜单

- 智图工厂主菜单
- 任务广场、任务管理、申请管理、交付管理、支付中心子菜单
- 完整的按钮级权限控制

## ✅ 升级验证

升级完成后，请验证以下内容：

### 1. 检查新表
```sql
SHOW TABLES LIKE 'des_task%';
-- 应显示：des_task, des_task_application, des_task_deliverable, des_task_payment
```

### 2. 检查权限菜单
```sql
SELECT menu_name, path, perms FROM sys_menu WHERE menu_name LIKE '%智图工厂%';
-- 应显示智图工厂相关菜单项
```

### 3. 检查测试数据
```sql
SELECT COUNT(*) FROM des_task;
-- 应显示已创建的测试任务数量
```

## 🔧 升级后配置

### 1. 应用配置
```yaml
# application.yml
zhitu:
  factory:
    review:
      mode: DUAL  # 审核模式：DUAL/ENTERPRISE
```

### 2. 前端环境变量
```bash
# .env文件
VITE_TASK_REVIEW_MODE=DUAL
```

### 3. 角色权限分配
- 为设计师角色分配任务浏览和申请权限
- 为企业管理员角色分配任务发布和审核权限
- 为系统管理员角色分配系统审核权限

## 🎯 核心特性

### 1. 双重审核机制
- **透明性原则**：企业管理员和设计师无感知系统管理员审核
- **模式切换**：支持双重审核和企业自主审核两种模式
- **环境配置**：通过环境变量灵活控制审核模式

### 2. 灵活交付方式
- **自然文本交付**：支持链接、提取码、说明混合输入
- **版本管理**：支持交付物版本迭代
- **智能识别**：自动识别文本中的链接信息

### 3. 完整权限体系
- **角色分离**：设计师、企业管理员、系统管理员权限明确
- **按钮级控制**：精确的功能权限控制
- **数据隔离**：严格的数据访问权限控制

## 📞 技术支持

### 常见问题

1. **Q: 外键约束错误**
   A: 确保基础表（des_enterprise、des_designer）中有有效数据

2. **Q: JSON字段不支持**
   A: 确保MySQL版本为5.7+

3. **Q: 权限菜单不显示**
   A: 检查角色权限分配是否正确

### 兼容性要求

- MySQL 5.7+ (推荐8.0+)
- 已导入ruoyi.sql基础数据库
- 存在基础表：des_designer、des_enterprise、des_school

## 📈 业务价值

智图工厂升级为现有设计师生态系统提供了：

- **任务化合作模式**：从长期雇佣转向项目合作
- **质量保障机制**：双重审核确保平台质量
- **透明用户体验**：技术复杂性对用户透明
- **灵活配置管理**：支持不同业务模式需求

升级完成后，您的系统将具备完整的智图工厂功能，支持现代化的设计项目合作流程。 