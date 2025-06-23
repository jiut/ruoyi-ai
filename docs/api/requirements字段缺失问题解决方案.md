# Requirements字段缺失问题解决方案

## 问题描述
用户反馈数据库中已有 `requirements` 字段，但前端接收到的数据中没有 `requirements` 字段。

## 问题分析
根据前端返回的数据分析：
```json
{
    "enterpriseId": 2,
    "jobTitle": "资深视觉设计师",
    "description": "负责阿里巴巴集团品牌视觉设计工作...",
    // 缺少 requirements 字段
    "requiredProfession": "GRAPHIC_DESIGNER",
    // ... 其他字段
}
```

可能的原因：
1. **数据库中 requirements 字段值为空**：字段存在但没有数据
2. **数据插入时遗漏**：原有数据插入时没有包含 requirements 值
3. **字段映射问题**：后端实体类字段映射存在问题

## 解决方案

### 1. 执行数据更新脚本

**文件**：`script/sql/update/update_requirements_data.sql`

该脚本会为现有的岗位数据更新 requirements 字段：

```sql
-- 更新岗位2 - 资深视觉设计师
UPDATE `des_job_posting` 
SET `requirements` = '本科及以上学历，设计相关专业，3-5年视觉设计经验...'
WHERE `job_title` = '资深视觉设计师' AND `enterprise_id` = 2;
```

### 2. 增强实体类兼容性

**文件**：`ruoyi-modules/ruoyi-designer/src/main/java/org/ruoyi/designer/domain/JobPosting.java`

添加了多个兼容性方法，确保与前端 mock 数据格式一致：

```java
// 薪资范围格式化（25K-35K）
public String getSalary()

// 与前端字段名兼容
public String getWorkLocation()    // 对应 location
public String getWorkType()        // 对应 jobType
public String getExperienceRequired() // 对应 workYearsRequired
public String getTitle()           // 对应 jobTitle
public String getSkillsRequired()  // 对应 requiredSkills
```

### 3. 验证数据完整性

**步骤 1：检查数据库字段**
```sql
SELECT job_title, requirements 
FROM des_job_posting 
WHERE enterprise_id = 2 AND job_title = '资深视觉设计师';
```

**步骤 2：执行更新脚本**
```bash
mysql -u username -p database_name < script/sql/update/update_requirements_data.sql
```

**步骤 3：重启后端服务**
确保实体类变更生效

**步骤 4：测试 API 响应**
```bash
curl -X GET "http://localhost:8080/designer/job/list" | jq '.rows[0].requirements'
```

## 预期修复后的数据格式

执行修复后，前端应该接收到包含 requirements 字段的完整数据：

```json
{
    "enterpriseId": 2,
    "enterprise": { ... },
    "jobTitle": "资深视觉设计师",
    "title": "资深视觉设计师",
    "description": "负责阿里巴巴集团品牌视觉设计工作...",
    "requirements": "本科及以上学历，设计相关专业，3-5年视觉设计经验...",
    "requiredProfession": "GRAPHIC_DESIGNER",
    "requiredSkills": "[\"photoshop\", \"illustrator\", \"sketch\", \"brand_design\", \"visual_system\", \"web_design\"]",
    "skillsRequired": "[\"photoshop\", \"illustrator\", \"sketch\", \"brand_design\", \"visual_system\", \"web_design\"]",
    "workYearsRequired": "3-5年经验",
    "experienceRequired": "3-5年经验",
    "salaryMin": "30000.00",
    "salaryMax": "45000.00",
    "salary": "30K-45K",
    "location": "杭州·滨江区",
    "workLocation": "杭州·滨江区",
    "jobType": "全职",
    "workType": "全职",
    "educationRequired": "本科及以上",
    // ... 其他字段
}
```

## 字段映射对照表

| 前端字段 | 后端字段 | 说明 |
|---------|---------|------|
| title | jobTitle | 岗位标题 |
| workLocation | location | 工作地点 |
| workType | jobType | 工作类型 |
| experienceRequired | workYearsRequired | 经验要求 |
| skillsRequired | requiredSkills | 技能要求 |
| salary | 计算属性 | 格式化的薪资范围 |
| requirements | requirements | 岗位要求 |

## 注意事项

1. **数据备份**：执行更新脚本前建议备份数据库
2. **重启服务**：实体类修改后需要重启后端服务
3. **缓存清理**：如有缓存机制，需要清理相关缓存
4. **前端兼容性**：新增的兼容性字段确保了与前端 mock 数据的一致性

## 故障排除

如果执行后仍然没有 requirements 字段：

1. **检查字段是否存在**：
   ```sql
   DESCRIBE des_job_posting;
   ```

2. **检查数据是否更新**：
   ```sql
   SELECT requirements FROM des_job_posting WHERE job_title = '资深视觉设计师';
   ```

3. **检查实体类编译**：确保 JobPosting.java 正确编译

4. **检查日志**：查看后端服务启动和查询日志 