# Apifox 自动化测试方案实施指南

## 📋 操作概述

本指南将逐步说明如何在Apifox中实施设计师管理模块的完整自动化测试方案，包括项目创建、环境配置、接口添加、脚本配置等所有步骤。

## 🚀 第一阶段：项目初始化

### 1.1 创建新项目

1. **打开Apifox客户端**
2. **点击"新建项目"**
3. **填写项目信息**：
   - 项目名称：`设计师管理模块自动化测试`
   - 项目描述：`若依AI设计师管理模块完整接口自动化测试`
   - 选择团队（如有）
4. **点击"创建项目"**

### 1.2 环境配置

#### 创建测试环境

1. **点击左侧菜单"环境管理"**
2. **点击"新建环境"**
3. **填写环境信息**：
   - 环境名称：`本地开发环境`
   - 前置URL：`http://localhost:6039`
4. **添加环境变量**，点击"环境变量" tab：

```
变量名                 初始值                描述
base_url             http://localhost:6039  后端服务地址
access_token         (留空)                 登录后获取的token
current_user_id      (留空)                 当前登录用户ID
refresh_token        (留空)                 刷新token

designer_id          (留空)                 设计师ID
enterprise_id        (留空)                 企业ID
school_id            (留空)                 院校ID

job_id               (留空)                 岗位ID
application_id       (留空)                 申请ID

test_username        admin               测试用户名
test_password        admin123               测试密码

other_user_id        (留空)                 其他用户ID
other_designer_id    (留空)                 其他设计师ID
other_enterprise_id  (留空)                 其他企业ID
other_school_id      (留空)                 其他院校ID

test_results         {}                     测试结果记录
```

5. **点击"保存"**

#### 设置全局参数

1. **点击项目设置 > 全局参数**
2. **在"请求头"页签中添加**：

```
Header名称           Header值                   说明
Content-Type        application/json           请求内容类型
Authorization       Bearer {{access_token}}   认证头（可选，在前置脚本中动态添加）
```

## 🎯 第二阶段：创建测试集合结构

### 2.1 创建文件夹结构

按照测试方案创建以下文件夹结构：

1. **在接口列表中右键点击 > 新建文件夹**
2. **创建以下文件夹**：

```
📁 A01-认证模块
📁 B01-用户身份注册
📁 B02-身份档案管理
📁 B03-绑定已有实体
📁 C01-设计师基础管理
📁 C02-设计师条件查询
📁 C03-设计师配置查询
📁 D01-企业管理
📁 E01-院校基础管理
📁 E02-院校业务功能
📁 F01-岗位基础管理
📁 F02-岗位条件查询
📁 G01-申请基础管理
📁 G02-申请业务流程
📁 H01-权限测试
📁 H02-异常场景测试
📁 H03-边界值测试
```

### 2.2 配置全局前置脚本

1. **点击项目设置 > 前置操作**
2. **在"前置脚本"中添加**：

```javascript
// 全局前置脚本
console.log("🚀 开始执行接口请求：" + pm.info.requestName);

// 检查token有效性
const token = pm.environment.get("access_token");
const currentUrl = pm.request.url.path.join('/');

// 不需要token的接口列表
const publicEndpoints = ['auth/login', 'captcha'];

// 检查是否需要token
const needsToken = !publicEndpoints.some(endpoint => currentUrl.includes(endpoint));

if (needsToken && !token) {
    console.log("⚠️ 警告: 缺少访问令牌，请先执行登录接口");
}

// 动态设置请求头
pm.request.headers.upsert({
    key: 'Content-Type',
    value: 'application/json'
});

// 如果有token，添加认证头
if (token && needsToken) {
    pm.request.headers.upsert({
        key: 'Authorization',
        value: `Bearer ${token}`
    });
    console.log("✅ 已设置认证头");
}

// 记录请求开始时间
pm.environment.set("request_start_time", new Date().getTime());
```

### 2.3 配置全局后置脚本

1. **点击项目设置 > 后置操作**
2. **在"后置脚本"中添加**：

```javascript
// 全局后置脚本
console.log("✅ 接口响应完成：" + pm.info.requestName);

// 基础响应检查
pm.test("响应状态码检查", function () {
    pm.expect(pm.response.code).to.be.oneOf([200, 201, 400, 401, 403, 404, 500]);
});

// 响应时间记录
const responseTime = pm.response.responseTime;
console.log(`⏱️ 响应时间: ${responseTime}ms`);

if (responseTime > 2000) {
    console.log("⚠️ 响应时间过长，可能存在性能问题");
}

// 检查响应格式（仅针对成功响应）
if (pm.response.code === 200) {
    pm.test("响应格式检查", function () {
        const response = pm.response.json();
        pm.expect(response).to.have.property('code');
        pm.expect(response).to.have.property('msg');
    });
}

// 测试结果记录
pm.test("测试结果记录", function () {
    const results = JSON.parse(pm.environment.get("test_results") || "{}");
    const testName = pm.info.requestName;
    const requestId = pm.info.requestId || testName;
    
    results[requestId] = {
        name: testName,
        status: pm.response.code === 200 ? "PASS" : "FAIL",
        responseTime: pm.response.responseTime,
        responseCode: pm.response.code,
        timestamp: new Date().toISOString()
    };
    
    pm.environment.set("test_results", JSON.stringify(results));
});
```

## 🔧 第三阶段：添加核心接口

### 3.1 添加登录接口（A01-认证模块）

1. **在"A01-认证模块"文件夹中右键 > 新建接口**
2. **配置接口基础信息**：
   - 接口名称：`A01-01_用户登录`
   - 请求方法：`POST`
   - 请求URL：`{{base_url}}/auth/login`

3. **设置请求体**（Body > raw > JSON）：
```json
{
    "username": "{{test_username}}",
    "password": "{{test_password}}",
    "captcha": "1234",
    "uuid": "test-uuid"
}
```

4. **配置后置脚本**：
```javascript
pm.test("登录成功检查", function () {
    const response = pm.response.json();
    console.log("登录响应：", response);
    
    if (pm.response.code === 200 && response.code === 200) {
        // 保存token和用户信息
        if (response.data && response.data.access_token) {
            pm.environment.set("access_token", response.data.access_token);
            pm.environment.set("current_user_id", response.data.userInfo.userId);
            console.log("✅ Token已设置:", response.data.access_token);
            console.log("✅ 用户ID已设置:", response.data.userInfo.userId);
        }
        pm.expect(response.code).to.equal(200);
        pm.expect(response.data.access_token).to.exist;
    } else {
        console.log("❌ 登录失败:", response.msg);
    }
});
```

### 3.2 添加设计师注册接口（B01-用户身份注册）

1. **在"B01-用户身份注册"文件夹中新建接口**：
   - 接口名称：`B01-01_注册设计师身份`
   - 请求方法：`POST`
   - 请求URL：`{{base_url}}/designer/user/register/designer`

2. **设置请求体**：
```json
{
    "designerName": "测试设计师{{$randomInt}}",
    "avatar": "https://avatars.githubusercontent.com/u/27265998",
    "gender": "0",
    "birthDate": "1995-06-15",
    "phone": "138{{$randomInt}}",
    "email": "designer{{$randomInt}}@test.com",
    "description": "专业UI设计师，擅长原型设计和视觉设计",
    "profession": "UI_DESIGNER",
    "skillTags": "[\"PROTOTYPE_DESIGN\", \"VISUAL_DESIGN\"]",
    "workYears": 3,
    "graduationDate": "2022-06-30",
    "portfolioUrl": "https://portfolio.example.com",
    "socialLinks": "{\"github\":\"https://github.com/test\",\"behance\":\"https://behance.net/test\"}"
}
```

3. **配置后置脚本**：
```javascript
pm.test("设计师注册成功", function () {
    const response = pm.response.json();
    console.log("设计师注册响应：", response);
    
    if (pm.response.code === 200 && response.code === 200) {
        console.log("✅ 设计师身份注册成功");
        
        // 获取设计师档案以获取ID
        setTimeout(() => {
            pm.sendRequest({
                url: pm.environment.get("base_url") + "/designer/user/designer/profile",
                method: 'GET',
                header: {
                    'Authorization': 'Bearer ' + pm.environment.get("access_token"),
                    'Content-Type': 'application/json'
                }
            }, function (err, res) {
                if (!err && res.code === 200) {
                    const designerData = res.json().data;
                    pm.environment.set("designer_id", designerData.designerId);
                    console.log("✅ 设计师ID已设置:", designerData.designerId);
                } else {
                    console.log("⚠️ 获取设计师档案失败:", err || res.json());
                }
            });
        }, 500);
        
        pm.expect(response.code).to.equal(200);
    } else {
        console.log("❌ 设计师注册失败:", response.msg);
    }
});
```

### 3.3 添加企业注册接口

1. **在"B01-用户身份注册"文件夹中新建接口**：
   - 接口名称：`B01-02_注册企业身份`
   - 请求方法：`POST`
   - 请求URL：`{{base_url}}/designer/user/register/enterprise`

2. **设置请求体**：
```json
{
    "enterpriseName": "测试企业{{$randomInt}}",
    "description": "专注于互联网产品设计与开发",
    "industry": "互联网",
    "scale": "100-500人",
    "address": "北京市朝阳区",
    "email": "hr{{$randomInt}}@test.com",
    "phone": "010-{{$randomInt}}",
    "website": "https://www.test{{$randomInt}}.com"
}
```

3. **配置后置脚本**：
```javascript
pm.test("企业注册成功", function () {
    const response = pm.response.json();
    console.log("企业注册响应：", response);
    
    if (pm.response.code === 200 && response.code === 200) {
        console.log("✅ 企业身份注册成功");
        
        // 获取企业档案以获取ID
        setTimeout(() => {
            pm.sendRequest({
                url: pm.environment.get("base_url") + "/designer/user/enterprise/profile",
                method: 'GET',
                header: {
                    'Authorization': 'Bearer ' + pm.environment.get("access_token"),
                    'Content-Type': 'application/json'
                }
            }, function (err, res) {
                if (!err && res.code === 200) {
                    const enterpriseData = res.json().data;
                    pm.environment.set("enterprise_id", enterpriseData.enterpriseId);
                    console.log("✅ 企业ID已设置:", enterpriseData.enterpriseId);
                }
            });
        }, 500);
        
        pm.expect(response.code).to.equal(200);
    }
});
```

## 🔄 第四阶段：批量添加接口

### 4.1 设计师管理接口（C01-设计师基础管理）

#### 查询设计师列表
- **接口名称**：`C01-01_查询设计师列表`
- **方法**：`GET`
- **URL**：`{{base_url}}/designer/designer/list?pageNum=1&pageSize=10`
- **后置脚本**：
```javascript
pm.test("设计师列表查询", function () {
    const response = pm.response.json();
    if (pm.response.code === 200 && response.code === 200) {
        pm.expect(response.data).to.have.property('records');
        pm.expect(response.data.records).to.be.an('array');
        console.log("✅ 设计师列表查询成功，共" + response.data.total + "条记录");
        
        // 如果有数据，保存第一个设计师ID用于后续测试
        if (response.data.records.length > 0) {
            pm.environment.set("first_designer_id", response.data.records[0].designerId);
        }
    }
});
```

#### 获取设计师详情
- **接口名称**：`C01-05_获取设计师详情`
- **方法**：`GET`
- **URL**：`{{base_url}}/designer/designer/{{designer_id}}`
- **前置脚本**：
```javascript
// 检查设计师ID是否存在
const designerId = pm.environment.get("designer_id");
if (!designerId) {
    console.log("❌ 缺少设计师ID，请先注册设计师身份或查询设计师列表");
    throw new Error("设计师ID未设置");
}
```

### 4.2 岗位管理接口（F01-岗位基础管理）

#### 发布岗位
- **接口名称**：`F01-03_发布岗位`
- **方法**：`POST`
- **URL**：`{{base_url}}/designer/job`
- **请求体**：
```json
{
    "jobTitle": "高级UI设计师{{$randomInt}}",
    "description": "负责移动端产品UI设计，与产品经理和开发团队紧密合作",
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
    "contactEmail": "hr@test.com",
    "status": "0"
}
```

- **前置脚本**：
```javascript
// 检查企业ID是否存在
const enterpriseId = pm.environment.get("enterprise_id");
if (!enterpriseId) {
    console.log("❌ 缺少企业ID，请先注册企业身份");
    throw new Error("企业ID未设置");
}
```

- **后置脚本**：
```javascript
pm.test("岗位发布成功", function () {
    const response = pm.response.json();
    if (pm.response.code === 200 && response.code === 200) {
        console.log("✅ 岗位发布成功");
        
        // 查询岗位列表获取刚发布的岗位ID
        setTimeout(() => {
            pm.sendRequest({
                url: pm.environment.get("base_url") + "/designer/job/list?pageNum=1&pageSize=1",
                method: 'GET',
                header: {
                    'Authorization': 'Bearer ' + pm.environment.get("access_token")
                }
            }, function (err, res) {
                if (!err && res.code === 200) {
                    const jobData = res.json().data;
                    if (jobData.records && jobData.records.length > 0) {
                        pm.environment.set("job_id", jobData.records[0].jobId);
                        console.log("✅ 岗位ID已设置:", jobData.records[0].jobId);
                    }
                }
            });
        }, 500);
    }
});
```

## 🎮 第五阶段：创建测试集合

### 5.1 创建基础流程测试集合

1. **点击左侧菜单"测试管理"**
2. **点击"新建测试集合"**
3. **填写集合信息**：
   - 集合名称：`核心业务流程测试`
   - 描述：`设计师管理模块核心业务流程自动化测试`

4. **添加测试用例**：
   - 点击"添加测试用例"
   - 选择"从接口导入"
   - 按顺序选择以下接口：
     - A01-01_用户登录
     - B01-01_注册设计师身份
     - B01-02_注册企业身份
     - B02-02_获取设计师档案
     - C01-01_查询设计师列表
     - F01-03_发布岗位
     - G02-01_设计师申请岗位
     - G02-02_企业处理申请

### 5.2 创建权限测试集合

1. **新建测试集合**：`权限矩阵验证测试`
2. **添加前置条件**：
```javascript
// 测试集合前置脚本
console.log("🔐 开始权限测试，当前用户:", pm.environment.get("current_user_id"));

// 记录原始token
pm.environment.set("original_token", pm.environment.get("access_token"));
```

3. **添加后置清理**：
```javascript
// 测试集合后置脚本
console.log("🔐 权限测试完成");

// 恢复原始token
const originalToken = pm.environment.get("original_token");
if (originalToken) {
    pm.environment.set("access_token", originalToken);
}
```

## 🚀 第六阶段：执行和监控

### 6.1 单个接口测试

1. **选择要测试的接口**
2. **点击"发送"按钮**
3. **查看响应结果**
4. **检查测试结果**：
   - 绿色✅表示测试通过
   - 红色❌表示测试失败
5. **查看控制台日志**获取详细信息

### 6.2 批量执行测试集合

1. **选择测试集合**
2. **点击"运行"按钮**
3. **配置运行参数**：
   - 选择环境：`本地开发环境`
   - 设置延迟：建议设置500ms避免过于频繁的请求
   - 选择是否并行执行（建议串行执行核心流程）

4. **开始执行**
5. **实时查看执行进度**

### 6.3 查看测试报告

1. **执行完成后点击"查看报告"**
2. **报告包含内容**：
   - 执行概览（通过率、失败率）
   - 详细执行结果
   - 响应时间统计
   - 错误信息汇总

### 6.4 设置持续集成

1. **点击"持续集成"**
2. **选择触发条件**：
   - 定时执行：每日/每小时
   - Git推送触发
   - 手动触发

3. **配置通知方式**：
   - 邮件通知
   - 企业微信/钉钉通知
   - Webhook通知

## 🔍 第七阶段：监控和维护

### 7.1 性能监控

创建性能监控脚本：
```javascript
// 在全局后置脚本中添加
const responseTime = pm.response.responseTime;
const endpoint = pm.request.url.path.join('/');

// 性能阈值配置
const performanceThresholds = {
    "/auth/login": 1000,
    "/designer/user/register": 2000,
    "/designer/designer/list": 3000,
    "/designer/job": 2000,
    "default": 2000
};

// 获取当前接口的阈值
let threshold = performanceThresholds.default;
for (let path in performanceThresholds) {
    if (endpoint.includes(path)) {
        threshold = performanceThresholds[path];
        break;
    }
}

// 性能检查
pm.test(`响应时间检查 (阈值: ${threshold}ms)`, function () {
    pm.expect(responseTime).to.be.below(threshold);
});

if (responseTime > threshold * 0.8) {
    console.log(`⚠️ 性能警告: ${endpoint} 响应时间 ${responseTime}ms 接近阈值 ${threshold}ms`);
}
```

### 7.2 数据清理

创建数据清理脚本：
```javascript
// 测试完成后的清理脚本
pm.test("测试数据清理", function () {
    const testDataKeys = [
        "test_designer_id",
        "test_enterprise_id", 
        "test_school_id",
        "test_job_id",
        "test_application_id"
    ];
    
    testDataKeys.forEach(key => {
        const value = pm.environment.get(key);
        if (value) {
            console.log(`🧹 清理测试数据: ${key} = ${value}`);
            pm.environment.unset(key);
        }
    });
});
```

### 7.3 结果分析

1. **定期查看测试趋势**
2. **分析失败原因**
3. **优化测试脚本**
4. **更新测试数据**

## 📊 完整执行顺序

### 首次完整执行步骤：

1. **Phase 1 - 环境准备**
   ```
   → 执行 A01-01_用户登录
   → 检查token是否正确设置
   ```

2. **Phase 2 - 身份注册**
   ```
   → 执行 B01-01_注册设计师身份
   → 执行 B01-02_注册企业身份
   → 执行 B01-03_注册院校身份
   → 检查各身份ID是否正确设置
   ```

3. **Phase 3 - 档案管理**
   ```
   → 执行 B02-02_获取设计师档案
   → 执行 B02-04_获取企业档案
   → 执行 B02-05_获取院校档案
   ```

4. **Phase 4 - 核心功能**
   ```
   → 执行所有C01设计师管理接口
   → 执行所有D01企业管理接口
   → 执行所有E01院校管理接口
   ```

5. **Phase 5 - 业务流程**
   ```
   → 执行所有F01岗位管理接口
   → 执行所有G01申请管理接口
   → 执行所有G02申请业务流程接口
   ```

6. **Phase 6 - 质量保证**
   ```
   → 执行所有H01权限测试接口
   → 执行所有H02异常场景测试接口
   → 执行所有H03边界值测试接口
   ```

## 🎯 成功标准

- ✅ **所有55个接口**都能成功调用
- ✅ **权限控制**按照权限矩阵正确生效
- ✅ **数据创建和查询**流程完整
- ✅ **异常处理**符合预期
- ✅ **性能指标**在可接受范围内
- ✅ **测试通过率** ≥ 95%

通过以上详细步骤，您可以在Apifox中完整实施设计师管理模块的自动化测试方案。 