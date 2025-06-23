# Job ID 字段修复说明

## 问题描述
前端接收到的岗位数据中缺少 `id` 字段，无法进行岗位的唯一标识和操作。

## 问题分析
从前端接收到的数据来看：
```json
{
    "enterpriseId": 2,
    "jobTitle": "资深视觉设计师",
    // 缺少 id 字段
    "description": "负责阿里巴巴集团品牌视觉设计工作...",
    // ... 其他字段
}
```

**根本原因**：
`JobPosting` 实体类中的 `jobId` 字段被 `@JsonIgnore` 注解标记：

```java
@JsonIgnore
@Schema(description = "岗位ID", example = "1", accessMode = Schema.AccessMode.READ_ONLY)
@TableId(value = "job_id")
private Long jobId;
```

这导致该字段不会被序列化到JSON响应中。

## 解决方案

### 1. 添加 getId() 方法

**文件**：`ruoyi-modules/ruoyi-designer/src/main/java/org/ruoyi/designer/domain/JobPosting.java`

**修改内容**：
1. 添加 `@JsonProperty` 注解的导入
2. 添加 `getId()` 方法提供 `id` 字段

```java
import com.fasterxml.jackson.annotation.JsonProperty;

// ...

/**
 * 获取用于JSON序列化的ID字段
 * 为了与前端mock数据保持一致
 */
@JsonProperty("id")
public Long getId() {
    return this.jobId;
}
```

### 2. 设计思路

采用与 `Enterprise` 类相同的处理方式：
- 保持 `jobId` 字段的 `@JsonIgnore` 注解（避免重复序列化）
- 添加 `getId()` 方法，使用 `@JsonProperty("id")` 注解
- 确保与前端 mock 数据格式一致

## 修复后的效果

### 修复前
```json
{
    "enterpriseId": 2,
    "jobTitle": "资深视觉设计师",
    "description": "...",
    // 没有 id 字段
}
```

### 修复后
```json
{
    "id": 2,                           // ✅ 新增 id 字段
    "enterpriseId": 2,
    "jobTitle": "资深视觉设计师",
    "title": "资深视觉设计师",        // 兼容字段
    "description": "...",
    "requirements": "...",             // 岗位要求
    "salary": "30K-45K",              // 格式化薪资
    "workLocation": "杭州·滨江区",     // 兼容字段
    // ... 其他字段
}
```

## 字段映射完整对照

| 前端字段 | 后端字段 | 类型 | 说明 |
|---------|---------|------|------|
| **id** | **jobId** | **Long** | **岗位唯一标识** |
| title | jobTitle | String | 岗位标题 |
| workLocation | location | String | 工作地点 |
| workType | jobType | String | 工作类型 |
| experienceRequired | workYearsRequired | String | 经验要求 |
| skillsRequired | requiredSkills | String | 技能要求 |
| salary | 计算属性 | String | 格式化薪资 |
| requirements | requirements | String | 岗位要求 |

## 与 Enterprise 类的一致性

现在 `JobPosting` 和 `Enterprise` 都采用相同的 ID 处理方式：

**Enterprise 类**：
```java
@JsonIgnore
private Long enterpriseId;

@JsonProperty("id")
public Long getId() {
    return this.enterpriseId;
}
```

**JobPosting 类**：
```java
@JsonIgnore
private Long jobId;

@JsonProperty("id")
public Long getId() {
    return this.jobId;
}
```

## 部署说明

1. **重新编译**：确保 `JobPosting.java` 正确编译
2. **重启服务**：重启后端服务使修改生效
3. **测试验证**：调用 `/designer/job/list` 确认返回包含 `id` 字段

## 验证方法

```bash
# 测试 API 响应
curl -X GET "http://localhost:8080/designer/job/list" | jq '.rows[0].id'

# 期望输出：岗位的ID值（如：2）
```

## 注意事项

1. **保持向后兼容**：原有的 `jobId` 字段依然存在，不影响内部逻辑
2. **JSON 序列化优化**：通过 `@JsonIgnore` 和 `@JsonProperty` 的组合使用，避免字段重复
3. **前端兼容性**：确保与前端 mock 数据格式完全一致 