# 申请状态字段问题修复

## 🚨 问题描述

在测试 `/designer/application/process` 接口时，发送 `status=APPROVED` 参数时出现以下错误：

```
Data truncation: Data too long for column 'status' at row 1
```

## 🔍 问题分析

### 数据库设计
数据库表 `des_job_application` 中的 `status` 字段定义为 `CHAR(1)`，只能存储单个字符：

```sql
`status` CHAR(1) DEFAULT '0' COMMENT '申请状态（0待审核 1通过 2拒绝 3撤回）'
```

### 状态码设计
根据注释，申请状态应该使用数字字符：
- `"0"` - 待审核
- `"1"` - 通过  
- `"2"` - 拒绝
- `"3"` - 撤回

### 问题原因
测试时传入的 `"APPROVED"`（8个字符）超出了数据库字段的长度限制（1个字符）。

## 🛠️ 解决方案

### 1. 创建状态枚举类

新增 `ApplicationStatus` 枚举类，支持英文名称与数据库代码的双向转换：

```java
@Getter
@AllArgsConstructor
public enum ApplicationStatus {
    PENDING("0", "待审核", "PENDING"),
    APPROVED("1", "通过", "APPROVED"),
    REJECTED("2", "拒绝", "REJECTED"),
    WITHDRAWN("3", "撤回", "WITHDRAWN");
    
    // 提供转换方法
    public static String convertEnumNameToCode(String enumName);
    public static String convertCodeToEnumName(String code);
}
```

### 2. 更新Service层

在 `JobApplicationServiceImpl.processApplication()` 方法中添加状态转换逻辑：

```java
// 转换状态：如果传入的是英文名称（如APPROVED），转换为数据库代码（如1）
String dbStatus = ApplicationStatus.convertEnumNameToCode(status);
jobApplication.setStatus(dbStatus);
```

### 3. 更新API文档

在 Controller 中添加详细的参数说明：

```java
@Parameter(name = "status", description = "处理结果", required = true, 
          example = "APPROVED",
          schema = @Schema(
              allowableValues = {"APPROVED", "REJECTED", "1", "2"},
              description = "支持英文常量（APPROVED=通过, REJECTED=拒绝）或数字代码（1=通过, 2=拒绝）"
          ))
```

## 🎯 修复效果

### 支持的输入格式

现在接口支持两种状态格式：

| 英文常量 | 数字代码 | 中文描述 | 数据库存储 |
|----------|----------|----------|------------|
| PENDING | 0 | 待审核 | "0" |
| APPROVED | 1 | 通过 | "1" |
| REJECTED | 2 | 拒绝 | "2" |
| WITHDRAWN | 3 | 撤回 | "3" |

### 测试示例

**使用英文常量（推荐）：**
```bash
PUT /designer/application/process
?applicationId=1933716131042836482
&status=APPROVED
&feedback=申请通过，请联系HR安排面试
```

**使用数字代码：**
```bash
PUT /designer/application/process
?applicationId=1933716131042836482
&status=1
&feedback=申请通过，请联系HR安排面试
```

## 📝 API 使用说明

### 处理申请接口

**接口**: `PUT /designer/application/process`

**参数**:
- `applicationId` (必需): 申请ID
- `status` (必需): 处理结果
  - 英文格式: `APPROVED` 或 `REJECTED`
  - 数字格式: `1` 或 `2`
- `feedback` (可选): 企业反馈信息

**响应示例**:
```json
{
    "code": 200,
    "msg": "操作成功",
    "data": null
}
```

### 状态查询

查询申请时，返回的状态字段为数据库存储的数字代码：

```json
{
    "code": 200,
    "msg": "操作成功",
    "data": {
        "applicationId": 1933716131042836482,
        "jobId": 1,
        "designerId": 1,
        "status": "1",  // 数字代码
        "feedback": "申请通过，请联系HR安排面试"
    }
}
```

如需获取状态的中文描述，可以使用枚举类的转换方法。

## 🔄 向后兼容性

- **完全兼容**: 原有的数字代码格式仍然有效
- **增强功能**: 新增英文常量格式，提高API易用性
- **自动转换**: 系统会自动将英文常量转换为对应的数字代码

## ✅ 验证步骤

1. **重启应用**: 确保新代码生效
2. **测试英文格式**: 使用 `status=APPROVED` 测试
3. **测试数字格式**: 使用 `status=1` 测试
4. **验证存储**: 确认数据库中存储的是数字代码
5. **检查日志**: 确保没有错误日志

---

**修复文件列表**:
- 新增: `ApplicationStatus.java` - 状态枚举类
- 修改: `JobApplicationServiceImpl.java` - 添加状态转换逻辑
- 修改: `JobApplicationController.java` - 更新API文档
- 修改: `JobApplication.java` - 优化实体类文档

**修复时间**: 2024年12月 