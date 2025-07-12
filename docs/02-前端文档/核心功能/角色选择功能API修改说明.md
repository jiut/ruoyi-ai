# 前端API调用修改说明

## 📋 修改概要

根据后端API检查结果，需要对角色选择功能的API调用进行以下调整：

## ✅ 无需修改的接口

### 获取用户信息
```typescript
// 保持不变 - 完全符合文档要求
GET /system/user/getInfo
```

## 🔧 需要修改的接口

### 更新用户角色
**原接口**（文档中）:
```typescript
POST /system/user/updateRole
参数: { roleId: string }
```

**实际可用接口**:
```typescript
PUT /system/user/authRole
参数: { userId: Long, roleIds: Long[] }
```

## 📝 具体修改步骤

### 1. 修改API调用文件 (`src/api/user.ts`)

```typescript
// 修改前
export const updateUserRole = (roleId: string) => {
  return request.post('/system/user/updateRole', { roleId });
};

// 修改后
export const updateUserRole = (roleId: string) => {
  const loginUser = getLoginUser(); // 需要获取当前登录用户信息
  return request.put('/system/user/authRole', { 
    userId: loginUser.userId,
    roleIds: [Number(roleId)] // 转换为数字数组
  });
};
```

### 2. 确保用户信息获取

在调用更新角色接口前，确保能获取到当前用户ID：

```typescript
import { useUserStore } from '@/store/modules/user';

const updateUserRole = (roleId: string) => {
  const userStore = useUserStore();
  const userId = userStore.userInfo?.user?.userId;
  
  if (!userId) {
    throw new Error('无法获取用户信息');
  }
  
  return request.put('/system/user/authRole', { 
    userId: userId,
    roleIds: [Number(roleId)]
  });
};
```

### 3. 添加权限处理（可选）

由于后端接口需要用户编辑权限，可能需要处理权限相关的错误：

```typescript
// 在角色选择组件中添加错误处理
try {
  await updateUserRole(selectedRoleId);
  // 成功处理
} catch (error) {
  if (error.code === 403) {
    message.error('没有权限修改用户角色');
  } else {
    message.error('更新角色失败，请重试');
  }
}
```

## 🚀 快速修改清单

- [ ] 修改API接口路径：`POST /updateRole` → `PUT /authRole`
- [ ] 修改请求参数：`{ roleId }` → `{ userId, roleIds: [roleId] }`
- [ ] 添加用户ID获取逻辑
- [ ] 将角色ID转换为数字类型
- [ ] 测试角色更新功能

## ⚠️ 注意事项

1. **数据类型**：角色ID需要转换为数字类型（Long）
2. **权限要求**：用户可能需要特定权限才能更新角色
3. **用户信息**：确保在调用前能正确获取当前用户ID
4. **错误处理**：添加适当的错误提示和处理逻辑

## 🧪 测试验证

修改完成后，请测试：
1. 用户注册后自动跳转到角色选择页面
2. 选择角色后能成功更新
3. 更新后用户信息正确刷新
4. 错误情况下的提示信息

## 📅 修改记录

| 日期 | 修改内容 | 修改人 |
|------|----------|--------|
| 2024-12-19 | 初始版本，根据后端API检查结果创建修改说明 | AI助手 |

## 🔗 相关文档

- [角色选择功能使用说明](./角色选择功能使用说明.md)
- [后端API检查报告](../API文档修正说明.md) 