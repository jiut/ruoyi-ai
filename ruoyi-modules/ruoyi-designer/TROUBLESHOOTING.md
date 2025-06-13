# 设计师管理模块故障排除指南

## 常见问题

### 1. SQL执行错误：Duplicate key name 'idx_user_id'

**问题描述：**
```
1061 - Duplicate key name 'idx_user_id'
```

**原因分析：**
尝试创建已经存在的索引。

**解决方案：**
使用安全的SQL脚本，可以重复执行：
```bash
# 使用安全脚本
Get-Content script/sql/designer_user_binding_safe.sql | mysql -u root -p -D ruoyi
```

或者手动删除已存在的索引：
```sql
-- 检查索引是否存在
SHOW INDEX FROM des_enterprise WHERE Key_name = 'idx_user_id';

-- 如果存在则删除
DROP INDEX idx_user_id ON des_enterprise;
DROP INDEX idx_user_id ON des_school;  
DROP INDEX idx_user_id ON des_designer;

-- 然后重新执行完整脚本
```

### 2. 角色创建失败：Field 'role_id' doesn't have a default value

**问题描述：**
```
ERROR 1364 (HY000): Field 'role_id' doesn't have a default value
```

**原因分析：**
`sys_role` 表的 `role_id` 字段不是自增字段，需要手动指定值。

**解决方案：**
使用修复后的SQL脚本，会自动计算下一个可用的 `role_id`。

### 3. 用户绑定失败

**问题描述：**
用户注册时提示"用户已绑定设计师身份"，但实际没有绑定。

**可能原因：**
1. 数据库中存在脏数据
2. 绑定状态不正确

**解决方案：**
```sql
-- 检查用户绑定状态
SELECT * FROM des_user_binding WHERE user_id = 用户ID;

-- 清理脏数据
DELETE FROM des_user_binding WHERE binding_status = '0';

-- 或者重置特定用户的绑定
DELETE FROM des_user_binding WHERE user_id = 用户ID;
```

### 4. 权限检查失败

**问题描述：**
用户已绑定身份，但权限检查返回false。

**可能原因：**
1. 用户未分配正确的角色
2. 绑定关系不完整

**解决方案：**
```sql
-- 检查用户角色
SELECT u.user_name, r.role_name, r.role_key 
FROM sys_user u 
LEFT JOIN sys_user_role sur ON u.user_id = sur.user_id
LEFT JOIN sys_role r ON sur.role_id = r.role_id
WHERE u.user_id = 用户ID;

-- 为用户分配角色
INSERT INTO sys_user_role (user_id, role_id) 
VALUES (用户ID, 角色ID);
```

### 5. 数据查询返回空

**问题描述：**
已绑定身份的用户查询不到相关数据。

**检查步骤：**
1. 确认用户绑定关系：
```sql
SELECT * FROM des_user_binding WHERE user_id = 用户ID;
```

2. 检查实体数据：
```sql
SELECT * FROM des_designer WHERE user_id = 用户ID;
SELECT * FROM des_enterprise WHERE user_id = 用户ID;
SELECT * FROM des_school WHERE user_id = 用户ID;
```

3. 验证权限工具类：
```java
@Autowired
private DesignerPermissionUtils permissionUtils;

// 在Controller中添加调试日志
log.info("当前用户ID: {}", LoginHelper.getUserId());
log.info("是否为设计师: {}", permissionUtils.isDesigner());
log.info("设计师ID: {}", permissionUtils.getCurrentDesignerId());
```

## 数据一致性检查

### 检查所有表的user_id字段
```sql
-- 检查字段是否存在
SELECT 
    table_name, 
    column_name,
    is_nullable,
    data_type
FROM information_schema.columns 
WHERE table_schema = DATABASE() 
    AND table_name IN ('des_enterprise', 'des_school', 'des_designer')
    AND column_name = 'user_id';
```

### 检查索引完整性
```sql
-- 检查所有相关索引
SELECT 
    table_name,
    index_name,
    column_name
FROM information_schema.statistics 
WHERE table_schema = DATABASE() 
    AND table_name IN ('des_enterprise', 'des_school', 'des_designer')
    AND index_name = 'idx_user_id';
```

### 检查角色完整性
```sql
-- 检查必需的角色
SELECT role_id, role_name, role_key, status 
FROM sys_role 
WHERE role_key IN ('designer', 'enterprise', 'school');
```

## 重置和清理

### 完全重置用户绑定功能
```sql
-- 警告：这将删除所有绑定数据！
DROP TABLE IF EXISTS des_user_binding;
DELETE FROM sys_role WHERE role_key IN ('designer', 'enterprise', 'school');

-- 然后重新执行安装脚本
```

### 清理特定用户的绑定
```sql
-- 安全地清理特定用户
DELETE FROM des_user_binding WHERE user_id = 用户ID;
DELETE FROM sys_user_role 
WHERE user_id = 用户ID 
    AND role_id IN (
        SELECT role_id FROM sys_role 
        WHERE role_key IN ('designer', 'enterprise', 'school')
    );
```

## 日志调试

### 启用详细日志
在 `application.yml` 中添加：
```yaml
logging:
  level:
    org.ruoyi.designer: DEBUG
    org.ruoyi.designer.util.DesignerPermissionUtils: TRACE
```

### 常用调试代码
```java
// 在Service或Controller中添加
@Slf4j
public class SomeController {
    
    public void debugUserBinding() {
        Long userId = LoginHelper.getUserId();
        log.debug("调试用户绑定 - 用户ID: {}", userId);
        
        List<UserBinding> bindings = userBindingService.getBindingsByUserId(userId);
        log.debug("用户绑定列表: {}", bindings);
        
        boolean isDesigner = permissionUtils.isDesigner();
        log.debug("是否为设计师: {}", isDesigner);
        
        if (isDesigner) {
            Long designerId = permissionUtils.getCurrentDesignerId();
            log.debug("设计师ID: {}", designerId);
        }
    }
}
```

## 联系支持

如果以上方案都无法解决问题，请提供以下信息：

1. 错误信息的完整堆栈跟踪
2. 相关的数据库表结构
3. 用户的绑定状态查询结果
4. 应用程序日志
5. 具体的操作步骤

将这些信息整理后可以进一步分析和解决问题。 