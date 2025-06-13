# Apifox 快速开始指南

## 🚀 5分钟快速设置

### 第一步：创建环境

1. 打开Apifox，创建新项目"设计师管理模块测试"
2. 进入"环境管理"，创建"开发环境"
3. 添加以下环境变量：

```
base_url = http://localhost:1002/api
access_token = (留空，登录后自动填充)
```

### 第二步：设置全局请求头

在"项目设置" → "全局参数" → "请求头"中添加：

```
Authorization: Bearer {{access_token}}
Content-Type: application/json
```

### 第三步：导入接口或手动创建

## 🎯 核心测试流程

### 1. 登录获取Token

```
POST {{base_url}}/auth/login
Body:
{
    "username": "test",
    "password": "admin123",
    "captcha": "1234",
    "uuid": "test-uuid"
}

后置脚本：
if (pm.response.code === 200) {
    const response = pm.response.json();
    if (response.code === 200) {
        pm.environment.set("access_token", response.data.access_token);
    }
}
```

### 2. 注册设计师身份

```
POST {{base_url}}/designer/user/register/designer
Body:
{
    "designerName": "张三",
    "profession": "UI_DESIGNER",
    "email": "zhangsan@example.com",
    "phone": "13800138000",
    "skillTags": "[\"PROTOTYPE_DESIGN\", \"VISUAL_DESIGN\"]",
    "bio": "专业UI设计师"
}
```

### 3. 获取设计师档案

```
GET {{base_url}}/designer/user/designer/profile
```

### 4. 查询设计师列表

```
GET {{base_url}}/designer/designer/list?pageNum=1&pageSize=10
```

## ⚡ 关键检查点

### ✅ 成功标识

- HTTP状态码：200
- 响应体：`{"code": 200, "msg": "操作成功"}`

### ❌ 常见错误

- 401：Token过期或无效 → 重新登录
- 500：数据库字段缺失 → 执行数据库修复脚本
- 403：权限不足 → 检查用户角色和权限

## 🔧 问题排查

### Token相关

```javascript
// 检查token是否存在
console.log("Token:", pm.environment.get("access_token"));

// 解析JWT token查看内容（可选）
const token = pm.environment.get("access_token");
if (token) {
    const payload = JSON.parse(atob(token.split('.')[1]));
    console.log("Token Payload:", payload);
}
```

### 数据库问题

如果遇到"Unknown column 'create_dept'"错误，执行：

```sql
ALTER TABLE des_user_binding ADD COLUMN create_dept BIGINT NULL COMMENT '创建部门';
```

## 📝 必备测试用例

### 基础流程测试

1. **登录** → **注册设计师** → **获取档案** → **更新信息**
2. **登录** → **注册企业** → **发布岗位** → **查看申请**
3. **权限测试**：无token访问、跨角色访问

### 核心断言脚本

```javascript
// 基础检查
pm.test("状态码200", () => {
    pm.response.to.have.status(200);
});

pm.test("业务成功", () => {
    const res = pm.response.json();
    pm.expect(res.code).to.equal(200);
});

// 数据验证
pm.test("数据完整性", () => {
    const res = pm.response.json();
    if (res.data) {
        pm.expect(res.data).to.be.an('object');
        // 具体字段验证
    }
});
```

## 🎨 Apifox最佳实践

### 1. 环境变量命名

- 使用下划线：`base_url`, `access_token`
- 见名知意：`designer_id`, `current_user_id`

### 2. 接口组织

```
📁 01-认证
📁 02-设计师管理
📁 03-企业管理  
📁 04-岗位管理
📁 05-申请管理
📁 99-异常测试
```

### 3. 测试数据管理

- 使用变量替换固定值
- 通过脚本动态生成测试数据
- 保持测试数据的一致性

## 🏃‍♂️ 立即开始

1. **复制上述登录接口代码到Apifox**
2. **执行登录请求获取token**
3. **复制设计师注册接口并测试**
4. **验证数据库表结构是否完整**
5. **逐步添加其他接口测试**

记住：**先修复数据库表结构，再进行接口测试！**
