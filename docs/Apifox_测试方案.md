# 设计师管理模块 Apifox 测试方案

## 📋 测试方案概述

本测试方案针对若依AI设计师管理模块进行全面的API接口测试，包括用户注册绑定、设计师管理、企业管理、院校管理、岗位招聘和申请管理等功能模块。

## 🔧 环境配置

### 1. 基础环境设置

**创建环境变量：**

| 变量名              | 变量值                    | 说明                          |
| ------------------- | ------------------------- | ----------------------------- |
| `base_url`        | `http://localhost:8080` | 后端服务地址                  |
| `access_token`    | ``                        | 登录后获取的token（动态更新） |
| `current_user_id` | ``                        | 当前登录用户ID                |
| `designer_id`     | ``                        | 创建的设计师ID                |
| `enterprise_id`   | ``                        | 创建的企业ID                  |
| `school_id`       | ``                        | 创建的院校ID                  |
| `job_id`          | ``                        | 创建的岗位ID                  |
| `application_id`  | ``                        | 创建的申请ID                  |

### 2. 全局请求头配置

```json
{
  "Content-Type": "application/json",
  "Authorization": "Bearer {{access_token}}"
}
```

### 3. 前置脚本（全局）

```javascript
// 在发送请求前检查token是否存在
const token = pm.environment.get("access_token");
if (!token && pm.request.url.path.join('/') !== 'auth/login') {
    console.log("警告: 缺少访问令牌，请先执行登录接口");
}
```

## 🧪 测试用例设计

### 阶段一：认证测试

#### TC001 - 用户登录

- **接口**: `POST /auth/login`
- **目的**: 获取访问令牌，为后续测试做准备
- **请求体**:

```json
{
    "username": "test",
    "password": "admin123",
    "captcha": "1234",
    "uuid": "test-uuid"
}
```

- **后置脚本**:

```javascript
// 提取token并设置环境变量
if (pm.response.code === 200) {
    const response = pm.response.json();
    if (response.code === 200) {
        pm.environment.set("access_token", response.data.access_token);
        pm.environment.set("current_user_id", response.data.userInfo.userId);
        console.log("登录成功，token已设置");
    }
}
```

### 阶段二：用户绑定测试

#### TC002 - 注册设计师身份

- **接口**: `POST {{base_url}}/designer/user/register/designer`
- **前置条件**: 已登录，有效token
- **测试数据**:

```json
{
    "designerName": "张三",
    "profession": "UI_DESIGNER",
    "email": "zhangsan@example.com",
    "phone": "13800138000",
    "skillTags": "[\"PROTOTYPE_DESIGN\", \"VISUAL_DESIGN\"]",
    "description": "专业UI设计师，擅长原型设计和视觉设计"
}
```

- **预期结果**: `code: 200, msg: "操作成功"`
- **后置脚本**:

```javascript
if (pm.response.code === 200) {
    const response = pm.response.json();
    if (response.code === 200) {
        console.log("设计师注册成功");
        // 设置标记，表示用户已绑定设计师身份
        pm.environment.set("user_has_designer", "true");
    }
}
```

#### TC003 - 注册企业身份

- **接口**: `POST {{base_url}}/designer/user/register/enterprise`
- **测试数据**:

```json
{
    "enterpriseName": "创新科技有限公司",
    "description": "专注于互联网产品设计与开发",
    "industry": "互联网",
    "scale": "100-500人",
    "address": "北京市朝阳区",
    "email": "hr@innovation.com",
    "phone": "010-12345678",
    "website": "https://www.innovation.com"
}
```

#### TC004 - 注册院校身份

- **接口**: `POST {{base_url}}/designer/user/register/school`
- **测试数据**:

```json
{
    "schoolName": "北京设计学院",
    "schoolType": "UNIVERSITY",
    "level": "本科",
    "address": "北京市海淀区",
    "description": "专业的设计教育机构"
}
```

### 阶段三：设计师管理测试

#### TC005 - 获取设计师档案

- **接口**: `GET {{base_url}}/designer/user/designer/profile`
- **前置条件**: 用户已绑定设计师身份
- **验证点**: 返回的设计师信息与注册时一致

#### TC006 - 查询设计师列表

- **接口**: `GET {{base_url}}/designer/designer/list`
- **参数**: `pageNum=1&pageSize=10`
- **权限**: `designer:designer:list`

#### TC007 - 获取设计师详情

- **接口**: `GET {{base_url}}/designer/designer/{{designer_id}}`
- **前置条件**: 需要先从列表中获取设计师ID

#### TC008 - 更新设计师信息

- **接口**: `PUT {{base_url}}/designer/designer`
- **测试数据**:

```json
{
    "designerId": "{{designer_id}}",
    "designerName": "张三-更新",
    "profession": "UI_DESIGNER",
    "email": "zhangsan_new@example.com",
    "phone": "13800138001",
    "skillTags": "[\"PROTOTYPE_DESIGN\", \"VISUAL_DESIGN\", \"ANIMATION_DESIGN\"]",
    "description": "资深UI设计师，新增动效设计技能"
}
```

### 阶段四：企业管理测试

#### TC009 - 获取企业档案

- **接口**: `GET {{base_url}}/designer/user/enterprise/profile`

#### TC010 - 查询企业列表

- **接口**: `GET {{base_url}}/designer/enterprise/list`

#### TC011 - 更新企业信息

- **接口**: `PUT {{base_url}}/designer/enterprise`

### 阶段五：岗位招聘测试

#### TC012 - 发布岗位

- **接口**: `POST {{base_url}}/designer/job`
- **前置条件**: 用户已绑定企业身份
- **测试数据**:

```json
{
    "enterpriseId": 1,
    "jobTitle": "高级UI设计师",
    "description": "负责移动端产品UI设计，与产品经理和开发团队紧密合作",
    "requiredProfession": "UI_DESIGNER",
    "requiredSkills": "PROTOTYPE_DESIGN,VISUAL_DESIGN,USER_INTERFACE_DESIGN",
    "workYearsRequired": "3-5年",
    "salaryMin": 15000,
    "salaryMax": 25000,
    "location": "北京市朝阳区",
    "jobType": "全职",
    "educationRequired": "本科及以上",
    "recruitmentCount": 2,
    "deadline": "2024-12-31",
    "contactPerson": "王经理",
    "contactPhone": "010-12345678",
    "contactEmail": "hr@company.com",
    "status": "0"
}
```

**⚠️ 重要说明：requiredSkills 字段格式**
- 系统已优化处理，支持两种格式：
  1. **逗号分隔字符串**（推荐）：`"PROTOTYPE_DESIGN,VISUAL_DESIGN,USER_INTERFACE_DESIGN"`
  2. **JSON数组字符串**：`"[\"PROTOTYPE_DESIGN\", \"VISUAL_DESIGN\", \"USER_INTERFACE_DESIGN\"]"`
- 系统会自动将逗号分隔的字符串转换为数据库所需的JSON数组格式
- 这样可以更方便地从前端传递技能标签数据

#### TC013 - 查询岗位列表

- **接口**: `GET {{base_url}}/designer/job/list`

#### TC014 - 按职业查询岗位

- **接口**: `GET {{base_url}}/designer/job/profession/UI_DESIGNER`

#### TC015 - 按技能查询岗位

- **接口**: `GET {{base_url}}/designer/job/skills?skillTags=PROTOTYPE_DESIGN,VISUAL_DESIGN`

### 阶段六：岗位申请测试

#### TC016 - 申请岗位

- **接口**: `POST {{base_url}}/designer/application/apply`
- **前置条件**: 用户已绑定设计师身份，存在可申请的岗位
- **参数**:

```
jobId={{job_id}}
designerId={{designer_id}}
coverLetter=我对这个岗位很感兴趣，希望能加入团队
resumeUrl=https://example.com/resume.pdf
```

#### TC017 - 查询申请列表

- **接口**: `GET {{base_url}}/designer/application/list`

#### TC018 - 查询设计师的申请

- **接口**: `GET {{base_url}}/designer/application/designer/{{designer_id}}`

#### TC019 - 查询岗位的申请

- **接口**: `GET {{base_url}}/designer/application/job/{{job_id}}`

#### TC020 - 处理申请

- **接口**: `PUT {{base_url}}/designer/application/process`
- **前置条件**: 用户已绑定企业身份
- **测试数据**:

```json
{
    "applicationId": "{{application_id}}",
    "status": "APPROVED",
    "feedback": "申请通过，请联系HR安排面试"
}
```

### 阶段七：枚举和配置测试

#### TC021 - 获取职业选项

- **接口**: `GET {{base_url}}/designer/designer/professions`
- **预期结果**: 返回所有可用的职业类型

#### TC022 - 获取技能标签选项

- **接口**: `GET {{base_url}}/designer/designer/skillTags`
- **预期结果**: 返回所有可用的技能标签

### 阶段八：权限和安全测试

#### TC023 - 无token访问测试

- **目的**: 验证接口的认证机制
- **操作**: 移除Authorization头后访问受保护接口
- **预期结果**: `401 Unauthorized`

#### TC024 - 重复绑定测试

- **接口**: `POST {{base_url}}/designer/user/register/designer`
- **前置条件**: 用户已绑定设计师身份
- **预期结果**: `400 Bad Request` 或相应错误信息

#### TC025 - 跨用户数据访问测试

- **目的**: 验证数据隔离机制
- **操作**: 使用设计师身份访问企业管理接口
- **预期结果**: 权限不足错误

## 🗂️ 测试集合组织

### 集合结构

```
设计师管理模块测试
├── 01-认证模块
│   └── 用户登录
├── 02-用户绑定模块
│   ├── 注册设计师身份
│   ├── 注册企业身份
│   ├── 注册院校身份
│   └── 获取绑定信息
├── 03-设计师管理模块
│   ├── 获取设计师档案
│   ├── 查询设计师列表
│   ├── 获取设计师详情
│   ├── 更新设计师信息
│   └── 按条件查询设计师
├── 04-企业管理模块
│   ├── 获取企业档案
│   ├── 查询企业列表
│   └── 更新企业信息
├── 05-岗位管理模块
│   ├── 发布岗位
│   ├── 查询岗位列表
│   ├── 更新岗位信息
│   └── 按条件查询岗位
├── 06-申请管理模块
│   ├── 申请岗位
│   ├── 查询申请列表
│   ├── 处理申请
│   └── 撤回申请
├── 07-配置查询模块
│   ├── 获取职业选项
│   └── 获取技能标签选项
└── 08-异常测试模块
    ├── 认证失败测试
    ├── 权限不足测试
    ├── 参数校验测试
    └── 重复操作测试
```

## 📊 测试执行策略

### 1. 测试顺序

1. **认证测试** - 必须首先执行
2. **用户绑定测试** - 按需执行，为后续测试准备数据
3. **功能模块测试** - 可并行执行
4. **异常测试** - 最后执行

### 2. 数据准备策略

- 使用环境变量存储测试过程中创建的ID
- 通过后置脚本自动提取和设置相关数据
- 为不同测试环境维护独立的数据集

### 3. 断言策略

```javascript
// 基础响应断言
pm.test("响应状态码为200", function () {
    pm.response.to.have.status(200);
});

pm.test("响应体包含成功标识", function () {
    const response = pm.response.json();
    pm.expect(response.code).to.equal(200);
    pm.expect(response.msg).to.include("成功");
});

// 数据格式断言
pm.test("返回数据格式正确", function () {
    const response = pm.response.json();
    pm.expect(response).to.have.property('code');
    pm.expect(response).to.have.property('msg');
    pm.expect(response).to.have.property('data');
});

// 业务逻辑断言
pm.test("设计师信息创建成功", function () {
    const response = pm.response.json();
    if (response.code === 200 && response.data) {
        pm.expect(response.data.designerName).to.equal("张三");
        pm.expect(response.data.profession).to.equal("UI_DESIGNER");
    }
});
```

## 🐛 异常场景测试

### 1. 输入验证测试

- 空值测试
- 超长字符串测试
- 特殊字符测试
- 类型错误测试

### 2. 业务规则测试

- 重复注册测试
- 权限边界测试
- 状态转换测试
- 数据关联测试

### 3. 性能测试

- 大数据量查询测试
- 并发请求测试
- 响应时间测试

## 📈 测试报告

### 1. 自动化报告

配置Apifox的持续集成功能，生成自动化测试报告

### 2. 测试结果统计

- 通过率统计
- 失败原因分析
- 性能指标统计

### 3. 问题跟踪

- Bug记录模板
- 修复验证流程
- 回归测试计划

## 🔍 调试技巧

### 1. 使用控制台调试

```javascript
// 打印完整响应
console.log("Response:", pm.response.text());

// 打印特定字段
const response = pm.response.json();
console.log("User ID:", response.data.userInfo.userId);

// 打印环境变量
console.log("Current Token:", pm.environment.get("access_token"));
```

### 2. 响应时间监控

```javascript
pm.test("响应时间小于2秒", function () {
    pm.expect(pm.response.responseTime).to.be.below(2000);
});
```

### 3. 详细错误信息

```javascript
pm.test("请求成功或记录错误详情", function () {
    const response = pm.response.json();
    if (response.code !== 200) {
        console.error("请求失败:", response.msg);
        console.error("错误详情:", response.data);
    }
    pm.expect(response.code).to.equal(200);
});
```

## ⚙️ 配置建议

### 1. 环境管理

- 开发环境：`http://localhost:8080`
- 测试环境：`http://test-api.example.com`
- 生产环境：`http://api.example.com`

### 2. 超时设置

- 连接超时：5秒
- 响应超时：10秒

### 3. 重试策略

- 自动重试次数：3次
- 重试间隔：1秒

## 🛠️ 已知问题修复

### requiredSkills 字段格式问题

**问题描述：**
- 数据库表 `des_job_posting` 的 `required_skills` 字段定义为 JSON 类型
- 之前版本传入逗号分隔字符串时会出现数据截断错误：`Invalid JSON text: "Invalid value."`

**修复方案：**
- 在 `JobPosting` 实体类中添加了智能处理逻辑
- 自动将逗号分隔字符串转换为 JSON 数组格式
- 兼容现有的 JSON 数组格式输入

**测试建议：**
- 使用逗号分隔字符串格式进行测试：`"PROTOTYPE_DESIGN,VISUAL_DESIGN,USER_INTERFACE_DESIGN"`
- 系统将自动转换为：`["PROTOTYPE_DESIGN", "VISUAL_DESIGN", "USER_INTERFACE_DESIGN"]`

这个测试方案涵盖了设计师管理模块的完整功能测试，包括了对已修复问题的详细说明。建议先从认证和基础功能开始测试，逐步扩展到完整的业务流程测试。
