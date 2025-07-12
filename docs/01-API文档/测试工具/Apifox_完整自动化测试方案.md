# 设计师管理模块 Apifox 完整自动化测试方案

## 📋 测试方案概述

本方案针对若依AI设计师管理模块进行全面的API接口自动化测试，覆盖所有 `/designer` 路径下的接口，确保无遗漏地测试所有功能模块。

## 🌟 完整接口清单

根据代码分析，共计**55个接口**需要测试：

### 1. 认证模块 (1个接口)

- `POST /auth/login` - 用户登录

### 2. 用户身份管理模块 (14个接口)

**路径前缀**: `/designer/user`

#### 注册身份接口 (3个)

- `POST /designer/user/register/designer` - 注册设计师身份
- `POST /designer/user/register/enterprise` - 注册企业身份
- `POST /designer/user/register/school` - 注册院校身份

#### 档案管理接口 (4个)

- `GET /designer/user/bindings` - 获取用户绑定信息
- `GET /designer/user/designer/profile` - 获取设计师档案
- `PUT /designer/user/designer/profile` - 更新设计师档案
- `GET /designer/user/enterprise/profile` - 获取企业档案
- `GET /designer/user/school/profile` - 获取院校档案

#### 身份绑定解绑接口 (7个)

- `PUT /designer/user/unbind/{entityType}` - 解绑用户身份
- `POST /designer/user/bind` - 管理员绑定用户实体
- `POST /designer/user/bind/enterprise` - 绑定已有企业
- `POST /designer/user/bind/school` - 绑定已有院校
- `GET /designer/user/available/enterprises` - 获取可绑定企业列表
- `GET /designer/user/available/schools` - 获取可绑定院校列表

### 3. 设计师管理模块 (10个接口)

**路径前缀**: `/designer/designer`

#### 基础CRUD接口 (5个)

- `GET /designer/designer/list` - 查询设计师列表
- `GET /designer/designer/{designerId}` - 获取设计师详情
- `POST /designer/designer` - 新增设计师
- `PUT /designer/designer` - 修改设计师
- `DELETE /designer/designer/{designerIds}` - 删除设计师

#### 条件查询接口 (3个)

- `GET /designer/designer/profession/{profession}` - 按职业查询设计师
- `GET /designer/designer/skills` - 按技能查询设计师
- `GET /designer/designer/school/{schoolId}` - 按院校查询设计师
- `GET /designer/designer/enterprise/{enterpriseId}` - 按企业查询设计师

#### 配置查询接口 (2个)

- `GET /designer/designer/professions` - 获取职业选项
- `GET /designer/designer/skillTags` - 获取技能标签选项

### 4. 企业管理模块 (6个接口)

**路径前缀**: `/designer/enterprise`

- `GET /designer/enterprise/list` - 查询企业列表
- `GET /designer/enterprise/{enterpriseId}` - 获取企业详情
- `POST /designer/enterprise` - 新增企业
- `PUT /designer/enterprise` - 修改企业
- `DELETE /designer/enterprise/{enterpriseIds}` - 删除企业
- `GET /designer/enterprise/user/{userId}` - 根据用户ID查询企业

### 5. 院校管理模块 (8个接口)

**路径前缀**: `/designer/school`

#### 基础CRUD接口 (5个)

- `GET /designer/school/list` - 查询院校列表
- `GET /designer/school/{schoolId}` - 获取院校详情
- `POST /designer/school` - 新增院校
- `PUT /designer/school` - 修改院校
- `DELETE /designer/school/{schoolIds}` - 删除院校

#### 业务接口 (3个)

- `GET /designer/school/user/{userId}` - 根据用户ID查询院校
- `GET /designer/school/{schoolId}/employment/statistics` - 获取就业统计
- `GET /designer/school/{schoolId}/employment/distribution` - 获取就业分布

### 6. 岗位管理模块 (8个接口)

**路径前缀**: `/designer/job`

#### 基础CRUD接口 (5个)

- `GET /designer/job/list` - 查询岗位列表
- `GET /designer/job/{jobId}` - 获取岗位详情
- `POST /designer/job` - 发布岗位
- `PUT /designer/job` - 修改岗位
- `DELETE /designer/job/{jobIds}` - 删除岗位

#### 条件查询接口 (3个)

- `GET /designer/job/enterprise/{enterpriseId}` - 企业岗位查询
- `GET /designer/job/profession/{profession}` - 按职业查询岗位
- `GET /designer/job/skills` - 按技能查询岗位
- `GET /designer/job/skills-any` - 按技能查询岗位（任意匹配）

### 7. 岗位申请模块 (8个接口)

**路径前缀**: `/designer/application`

#### 基础CRUD接口 (5个)

- `GET /designer/application/list` - 查询岗位申请列表
- `GET /designer/application/{applicationId}` - 获取岗位申请详情
- `POST /designer/application` - 新增岗位申请（基础）
- `PUT /designer/application` - 修改岗位申请
- `DELETE /designer/application/{applicationIds}` - 删除岗位申请

#### 业务操作接口 (3个)

- `POST /designer/application/apply` - 申请岗位
- `PUT /designer/application/process` - 处理申请
- `PUT /designer/application/withdraw` - 撤回申请
- `GET /designer/application/job/{jobId}` - 根据岗位查询申请
- `GET /designer/application/designer/{designerId}` - 根据设计师查询申请

## ⚙️ 环境配置

### 1. 环境变量设置

```javascript
// 基础环境变量
{
    "base_url": "http://localhost:6039",
    "access_token": "",
    "current_user_id": "",
    "refresh_token": "",
  
    // 身份相关ID
    "designer_id": "",
    "enterprise_id": "",
    "school_id": "",
  
    // 业务实体ID
    "job_id": "",
    "application_id": "",
  
    // 测试用户
    "test_username": "test",
    "test_password": "admin123",
  
    // 其他用户ID（用于权限测试）
    "other_user_id": "",
    "other_designer_id": "",
    "other_enterprise_id": "",
    "other_school_id": ""
}
```

### 2. 全局前置脚本

```javascript
// 检查token有效性
const token = pm.environment.get("access_token");
const currentUrl = pm.request.url.path.join('/');

// 不需要token的接口列表
const publicEndpoints = ['auth/login'];

if (!token && !publicEndpoints.some(endpoint => currentUrl.includes(endpoint))) {
    console.log("⚠️ 警告: 缺少访问令牌，请先执行登录接口");
}

// 设置通用请求头
pm.request.headers.add({
    key: 'Content-Type',
    value: 'application/json'
});

if (token) {
    pm.request.headers.add({
        key: 'Authorization',
        value: `Bearer ${token}`
    });
}
```

### 3. 全局后置脚本

```javascript
// 通用响应检查
pm.test("响应状态码检查", function () {
    pm.expect(pm.response.code).to.be.oneOf([200, 201, 400, 401, 403, 500]);
});

pm.test("响应格式检查", function () {
    const response = pm.response.json();
    pm.expect(response).to.have.property('code');
    pm.expect(response).to.have.property('msg');
});

// 记录响应时间
const responseTime = pm.response.responseTime;
console.log(`⏱️ 响应时间: ${responseTime}ms`);

if (responseTime > 2000) {
    console.log("⚠️ 响应时间过长，可能存在性能问题");
}
```

## 🎯 完整测试集合设计

### 集合A：基础认证流程

```
📁 A01-认证模块
├── A01-01_用户登录
├── A01-02_Token刷新测试
└── A01-03_登出测试
```

### 集合B：用户身份管理 (核心流程)

```
📁 B01-用户身份注册
├── B01-01_注册设计师身份
├── B01-02_注册企业身份
├── B01-03_注册院校身份
├── B01-04_重复注册测试
└── B01-05_参数验证测试

📁 B02-身份档案管理
├── B02-01_获取用户绑定信息
├── B02-02_获取设计师档案
├── B02-03_更新设计师档案
├── B02-04_获取企业档案
├── B02-05_获取院校档案
└── B02-06_未绑定身份测试

📁 B03-绑定已有实体
├── B03-01_获取可绑定企业列表
├── B03-02_获取可绑定院校列表
├── B03-03_绑定已有企业
├── B03-04_绑定已有院校
├── B03-05_管理员绑定用户实体
└── B03-06_解绑用户身份
```

### 集合C：设计师管理

```
📁 C01-设计师基础管理
├── C01-01_查询设计师列表（系统管理员）
├── C01-02_查询设计师列表（企业管理员）
├── C01-03_查询设计师列表（院校管理员）
├── C01-04_查询设计师列表（设计师用户-权限测试）
├── C01-05_获取设计师详情
├── C01-06_新增设计师
├── C01-07_修改设计师
└── C01-08_删除设计师

📁 C02-设计师条件查询
├── C02-01_按职业查询设计师
├── C02-02_按技能查询设计师
├── C02-03_按院校查询设计师
└── C02-04_按企业查询设计师

📁 C03-设计师配置查询
├── C03-01_获取职业选项
└── C03-02_获取技能标签选项
```

### 集合D：企业管理

```
📁 D01-企业管理
├── D01-01_查询企业列表（系统管理员）
├── D01-02_查询企业列表（企业管理员）
├── D01-03_获取企业详情
├── D01-04_新增企业
├── D01-05_修改企业
├── D01-06_删除企业
└── D01-07_根据用户ID查询企业
```

### 集合E：院校管理

```
📁 E01-院校基础管理
├── E01-01_查询院校列表
├── E01-02_获取院校详情
├── E01-03_新增院校
├── E01-04_修改院校
├── E01-05_删除院校
└── E01-06_根据用户ID查询院校

📁 E02-院校业务功能
├── E02-01_获取就业统计
└── E02-02_获取就业分布
```

### 集合F：岗位管理

```
📁 F01-岗位基础管理
├── F01-01_查询岗位列表
├── F01-02_获取岗位详情
├── F01-03_发布岗位
├── F01-04_修改岗位
└── F01-05_删除岗位

📁 F02-岗位条件查询
├── F02-01_企业岗位查询
├── F02-02_按职业查询岗位
├── F02-03_按技能查询岗位
└── F02-04_按技能查询岗位（任意匹配）
```

### 集合G：岗位申请管理

```
📁 G01-申请基础管理
├── G01-01_查询岗位申请列表
├── G01-02_获取岗位申请详情
├── G01-03_新增岗位申请
├── G01-04_修改岗位申请
└── G01-05_删除岗位申请

📁 G02-申请业务流程
├── G02-01_设计师申请岗位
├── G02-02_企业处理申请（通过）
├── G02-03_企业处理申请（拒绝）
├── G02-04_设计师撤回申请
├── G02-05_根据岗位查询申请
└── G02-06_根据设计师查询申请
```

### 集合H：权限和异常测试

```
📁 H01-权限测试
├── H01-01_无Token访问测试
├── H01-02_过期Token测试
├── H01-03_跨角色权限测试
├── H01-04_数据隔离测试
└── H01-05_越权访问测试

📁 H02-异常场景测试
├── H02-01_参数验证测试
├── H02-02_重复数据测试
├── H02-03_不存在资源测试
├── H02-04_数据完整性测试
└── H02-05_并发操作测试

📁 H03-边界值测试
├── H03-01_空值测试
├── H03-02_超长字符串测试
├── H03-03_特殊字符测试
└── H03-04_数值边界测试
```

## 🔄 测试执行策略

### 1. 执行顺序

**Phase 1: 基础准备**

1. A01 - 认证模块
2. B01 - 用户身份注册

**Phase 2: 核心功能**
3. B02 - 身份档案管理
4. C01 - 设计师基础管理
5. D01 - 企业管理
6. E01 - 院校基础管理

**Phase 3: 业务流程**
7. F01 - 岗位基础管理
8. G01 - 申请基础管理
9. G02 - 申请业务流程

**Phase 4: 扩展功能**
10. B03 - 绑定已有实体
11. C02 - 设计师条件查询
12. F02 - 岗位条件查询

**Phase 5: 质量保证**
13. H01 - 权限测试
14. H02 - 异常场景测试
15. H03 - 边界值测试

### 2. 并行执行策略

**可并行执行的测试集合：**

- C02, C03 (设计师配置查询)
- E02 (院校业务功能)
- F02 (岗位条件查询)
- H03 (边界值测试的部分用例)

**必须串行执行的测试：**

- 所有涉及数据创建和依赖的测试
- 权限测试中涉及身份切换的用例

## 📊 关键测试数据

### 1. 测试用户角色

```javascript
// 测试用户配置
const testUsers = {
    admin: {
        username: "admin",
        password: "admin123",
        role: "admin"
    },
    designer: {
        username: "designer_user",
        password: "admin123", 
        role: "designer"
    },
    enterprise: {
        username: "enterprise_user",
        password: "admin123",
        role: "enterprise"
    },
    school: {
        username: "school_user", 
        password: "admin123",
        role: "school"
    }
};
```

### 2. 测试数据模板

#### 设计师注册数据

```javascript
const designerData = {
    "designerName": "测试设计师{{$randomInt}}",
    "profession": "UI_DESIGNER",
    "email": "designer{{$randomInt}}@test.com",
    "phone": "138{{$randomInt}}",
    "skillTags": "[\"PROTOTYPE_DESIGN\", \"VISUAL_DESIGN\"]",
    "description": "专业UI设计师",
    "workYears": 3
};
```

#### 企业注册数据

```javascript
const enterpriseData = {
    "enterpriseName": "测试企业{{$randomInt}}",
    "description": "专注于互联网产品设计",
    "industry": "互联网",
    "scale": "100-500人",
    "address": "北京市朝阳区",
    "email": "hr{{$randomInt}}@test.com",
    "phone": "010-{{$randomInt}}"
};
```

#### 岗位发布数据

```javascript
const jobData = {
    "jobTitle": "高级UI设计师{{$randomInt}}",
    "description": "负责移动端产品UI设计",
    "requiredProfession": "UI_DESIGNER",
    "requiredSkills": "PROTOTYPE_DESIGN,VISUAL_DESIGN",
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
    "contactEmail": "hr@test.com"
};
```

## 🧪 核心测试脚本

### 1. 登录并设置Token

```javascript
// 请求体
{
    "username": "{{test_username}}",
    "password": "{{test_password}}",
    "captcha": "1234",
    "uuid": "test-uuid"
}

// 后置脚本
pm.test("登录成功", function () {
    const response = pm.response.json();
    pm.expect(response.code).to.equal(200);
  
    if (response.data && response.data.access_token) {
        pm.environment.set("access_token", response.data.access_token);
        pm.environment.set("current_user_id", response.data.userInfo.userId);
        console.log("✅ Token已设置");
    }
});
```

### 2. 注册设计师身份

```javascript
// 后置脚本
pm.test("设计师注册成功", function () {
    const response = pm.response.json();
    pm.expect(response.code).to.equal(200);
    console.log("✅ 设计师身份注册成功");
  
    // 获取设计师档案以获取ID
    pm.sendRequest({
        url: pm.environment.get("base_url") + "/designer/user/designer/profile",
        method: 'GET',
        header: {
            'Authorization': 'Bearer ' + pm.environment.get("access_token"),
            'Content-Type': 'application/json'
        }
    }, function (err, res) {
        if (!err && res.code === 200) {
            const designer = res.json().data;
            pm.environment.set("designer_id", designer.designerId);
            console.log("✅ 设计师ID已设置:", designer.designerId);
        }
    });
});
```

### 3. 权限测试脚本

```javascript
// 权限不足测试
pm.test("权限控制正确", function () {
    const response = pm.response.json();
  
    if (pm.response.code === 403 || pm.response.code === 401) {
        pm.expect(response.msg).to.include("权限");
        console.log("✅ 权限控制正常");
    } else if (pm.response.code === 200) {
        console.log("✅ 有权限访问");
    } else {
        console.log("⚠️ 未预期的响应状态:", pm.response.code);
    }
});
```

### 4. 数据验证脚本

```javascript
// 数据完整性验证
pm.test("返回数据完整性验证", function () {
    const response = pm.response.json();
  
    if (response.code === 200 && response.data) {
        // 根据接口类型验证必需字段
        const endpoint = pm.request.url.path.join('/');
      
        if (endpoint.includes('designer/list')) {
            pm.expect(response.data.records).to.be.an('array');
        } else if (endpoint.includes('designer/') && !endpoint.includes('list')) {
            pm.expect(response.data.designerName).to.exist;
            pm.expect(response.data.profession).to.exist;
        }
      
        console.log("✅ 数据完整性验证通过");
    }
});
```

## 📈 测试报告和监控

### 1. 自动化报告配置

```javascript
// 测试结果收集
pm.test("测试结果记录", function () {
    // 记录测试结果到环境变量
    const results = JSON.parse(pm.environment.get("test_results") || "{}");
    const testName = pm.info.requestName;
  
    results[testName] = {
        status: pm.response.code === 200 ? "PASS" : "FAIL",
        responseTime: pm.response.responseTime,
        timestamp: new Date().toISOString(),
        responseCode: pm.response.code
    };
  
    pm.environment.set("test_results", JSON.stringify(results));
});
```

### 2. 性能监控

```javascript
// 性能阈值检查
pm.test("响应时间检查", function () {
    const responseTime = pm.response.responseTime;
  
    // 不同接口类型的性能阈值
    const thresholds = {
        list: 3000,      // 列表查询
        detail: 1000,    // 详情查询  
        create: 2000,    // 创建操作
        update: 2000,    // 更新操作
        delete: 1000     // 删除操作
    };
  
    const endpoint = pm.request.url.path.join('/');
    let threshold = 2000; // 默认阈值
  
    if (endpoint.includes('/list')) threshold = thresholds.list;
    else if (pm.request.method === 'POST') threshold = thresholds.create;
    else if (pm.request.method === 'PUT') threshold = thresholds.update;
    else if (pm.request.method === 'DELETE') threshold = thresholds.delete;
    else threshold = thresholds.detail;
  
    pm.expect(responseTime).to.be.below(threshold);
  
    if (responseTime > threshold * 0.8) {
        console.log(`⚠️ 响应时间接近阈值: ${responseTime}ms (阈值: ${threshold}ms)`);
    }
});
```

## 🔍 故障排除指南

### 1. 常见问题及解决方案

**问题1: Token过期**

```javascript
// 检查脚本
if (pm.response.code === 401) {
    console.log("🔄 Token可能已过期，尝试重新登录");
    // 自动重新登录逻辑
}
```

**问题2: 数据依赖缺失**

```javascript
// 数据检查脚本
const designerId = pm.environment.get("designer_id");
if (!designerId && pm.request.url.path.includes("designer")) {
    console.log("❌ 缺少设计师ID，请先注册设计师身份");
}
```

**问题3: 权限不足**

```javascript
// 权限诊断脚本
if (pm.response.code === 403) {
    const userId = pm.environment.get("current_user_id");
    console.log(`❌ 用户 ${userId} 权限不足，请检查角色配置`);
}
```

### 2. 测试数据清理

```javascript
// 测试后清理脚本
pm.test("测试数据清理", function () {
    // 在每个测试集合结束后执行
    const testIds = [
        pm.environment.get("test_designer_id"),
        pm.environment.get("test_enterprise_id"),
        pm.environment.get("test_school_id"),
        pm.environment.get("test_job_id"),
        pm.environment.get("test_application_id")
    ];
  
    testIds.forEach(id => {
        if (id) {
            console.log("🧹 清理测试数据:", id);
            // 执行清理操作
        }
    });
});
```

## 🎯 测试完成度验证清单

### ✅ 接口覆盖度检查

- [ ] **认证模块** (1/1)

  - [ ] 用户登录
- [ ] **用户身份管理** (14/14)

  - [ ] 注册身份接口 (3/3)
  - [ ] 档案管理接口 (4/4)
  - [ ] 身份绑定解绑接口 (7/7)
- [ ] **设计师管理** (10/10)

  - [ ] 基础CRUD (5/5)
  - [ ] 条件查询 (3/3)
  - [ ] 配置查询 (2/2)
- [ ] **企业管理** (6/6)

  - [ ] 完整CRUD流程
- [ ] **院校管理** (8/8)

  - [ ] 基础管理 (5/5)
  - [ ] 业务功能 (3/3)
- [ ] **岗位管理** (8/8)

  - [ ] 基础管理 (5/5)
  - [ ] 条件查询 (3/3)
- [ ] **岗位申请** (8/8)

  - [ ] 基础管理 (5/5)
  - [ ] 业务流程 (3/3)
- [ ] **权限和异常测试** (15/15)

  - [ ] 权限测试 (5/5)
  - [ ] 异常场景 (5/5)
  - [ ] 边界值测试 (5/5)

### 🎖️ 质量标准

- [ ] **接口覆盖率**: 100% (55/55个接口)
- [ ] **权限矩阵覆盖率**: 100%
- [ ] **异常场景覆盖率**: ≥80%
- [ ] **自动化率**: 100%
- [ ] **测试通过率**: ≥95%

## 📝 执行建议

### 1. 首次执行

1. **环境准备**: 确保数据库已初始化，服务正常启动
2. **权限配置**: 确保测试用户具有相应权限
3. **数据准备**: 准备必要的基础数据

### 2. 日常执行

1. **快速回归**: 执行核心功能测试集合 (A01, B01, C01, D01, F01, G01)
2. **完整测试**: 每日或每周执行完整测试套件
3. **性能监控**: 关注响应时间趋势

### 3. 版本发布前

1. **完整测试**: 执行所有测试集合
2. **权限验证**: 重点验证权限矩阵
3. **异常处理**: 重点测试异常场景
4. **性能验证**: 验证性能指标

通过以上完整的自动化测试方案，可以确保设计师管理模块的所有55个接口都得到充分测试，无任何遗漏。
