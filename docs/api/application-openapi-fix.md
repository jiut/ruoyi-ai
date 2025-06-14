# 申请管理接口 OpenAPI 文档修复

## 🚨 问题描述

在更新 `/designer/application/process` 接口的 OpenAPI 文档时，`feedback` 字段在 Swagger UI 中消失了。

## 🔍 问题分析

### 原因
之前使用了在 `@Operation` 注解的 `parameters` 数组中定义参数文档的方式：

```java
@Operation(
    parameters = {
        @Parameter(name = "feedback", description = "企业反馈信息", ...)
    }
)
public R<Void> processApplication(@RequestParam String feedback) {
    // ...
}
```

但是 SpringDoc OpenAPI 更推荐直接在方法参数上使用 `@Parameter` 注解的方式。

## 🛠️ 解决方案

### 修复方法
将参数文档从 `@Operation` 的 `parameters` 数组中移出，直接标注在方法参数上：

```java
@Operation(
    summary = "处理岗位申请",
    description = "企业处理设计师的岗位申请，可以通过或拒绝申请"
)
public R<Void> processApplication(
    @Parameter(name = "applicationId", description = "申请ID", required = true, example = "1") 
    @RequestParam Long applicationId,
    @Parameter(name = "status", description = "处理结果", required = true, 
              example = "APPROVED",
              schema = @Schema(allowableValues = {"APPROVED", "REJECTED", "1", "2"}))
    @RequestParam String status,
    @Parameter(name = "feedback", description = "企业反馈信息", required = false, 
              example = "申请通过，请联系HR安排面试")
    @RequestParam(required = false) String feedback) {
    // ...
}
```

## 🔧 完整更新内容

### 1. 处理申请接口 `/process`

**参数文档**：
- `applicationId` (必需): 申请ID
- `status` (必需): 处理结果，支持英文常量或数字代码
- `feedback` (可选): 企业反馈信息

### 2. 申请岗位接口 `/apply`

**参数文档**：
- `jobId` (必需): 岗位ID
- `designerId` (必需): 设计师ID
- `coverLetter` (可选): 申请说明
- `resumeUrl` (可选): 简历文件URL

### 3. 撤回申请接口 `/withdraw`

**参数文档**：
- `applicationId` (必需): 申请ID
- `designerId` (必需): 设计师ID

## 📋 更新后的接口文档

### 处理申请接口

```yaml
/designer/application/process:
  put:
    summary: 处理岗位申请
    description: 企业处理设计师的岗位申请，可以通过或拒绝申请
    parameters:
      - name: applicationId
        in: query
        required: true
        description: 申请ID
        example: 1
        schema:
          type: integer
      - name: status
        in: query
        required: true
        description: 处理结果
        example: APPROVED
        schema:
          type: string
          enum: [APPROVED, REJECTED, "1", "2"]
      - name: feedback
        in: query
        required: false
        description: 企业反馈信息
        example: 申请通过，请联系HR安排面试
        schema:
          type: string
```

## 🧪 验证步骤

1. **重启应用**：确保新的 OpenAPI 注解生效
2. **访问 Swagger UI**：查看 `/designer/application/process` 接口
3. **检查参数列表**：确认所有三个参数都正确显示
4. **测试接口**：在 Swagger UI 中测试接口功能
5. **验证文档**：确保参数说明清晰完整

## ✅ 预期结果

修复后，在 Swagger UI 中应该看到：

- ✅ `applicationId` 参数：必需，申请ID
- ✅ `status` 参数：必需，处理结果，包含枚举值说明
- ✅ `feedback` 参数：可选，企业反馈信息

所有参数都应该有完整的描述、示例和类型信息。

## 🔍 最佳实践

### SpringDoc OpenAPI 参数文档推荐做法

1. **直接注解参数**：在方法参数上直接使用 `@Parameter`
2. **保持简洁**：`@Operation` 只关注接口级别的信息
3. **完整信息**：为每个参数提供 description、example、required 等信息
4. **枚举值**：对于有限制的参数，使用 `allowableValues` 或 `schema.enum`

### 示例模板

```java
@Operation(summary = "接口摘要", description = "接口详细描述")
@PostMapping("/example")
public R<Void> example(
    @Parameter(name = "param1", description = "参数1说明", required = true, example = "示例值")
    @RequestParam String param1,
    @Parameter(name = "param2", description = "参数2说明", required = false, example = "可选示例")
    @RequestParam(required = false) String param2) {
    // 方法实现
}
```

---

**修复文件**：`JobApplicationController.java`  
**影响接口**：`/designer/application/process`, `/apply`, `/withdraw`  
**修复时间**：2024年12月 