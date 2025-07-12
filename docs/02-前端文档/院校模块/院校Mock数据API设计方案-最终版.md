# 院校Mock数据API设计方案 - 最终版

## 概述

本文档基于 `src/data/mockSchools.ts` 文件中的数据结构，严格设计对应的后端API接口，确保前端可以无缝从后端获取所有院校相关数据。

## 数据结构对照表

| Mock数据源 | 数据结构 | 对应API接口 | 优先级 |
|-----------|---------|------------|--------|
| mockSchools | School[] | GET /designer/school/list<br>GET /designer/school/{id} | 1 |
| mockMajorCategoriesBySchool | Record<number, MajorCategoryData[]> | GET /designer/school/{id}/major-categories | 2 |
| mockCourseSystemBySchool | Record<number, CourseGroup[]> | GET /designer/school/{id}/course-system | 2 |
| mockFacultyStatsBySchool | Record<number, FacultyStatsData> | GET /designer/school/{id}/faculty-stats | 2 |
| mockFacultyMembersBySchool | Record<number, TeacherData[]> | GET /designer/school/{id}/faculty-members | 3 |
| mockEmploymentStatsBySchool | Record<number, EmploymentStatsData> | GET /designer/school/{id}/employment-stats | 2 |
| mockEmployersBySchool | Record<number, EmployerData[]> | GET /designer/school/{id}/employers | 3 |
| mockChartDataBySchool | Record<number, ChartData> | GET /designer/school/{id}/employment-charts | 3 |
| mockAchievementStatsBySchool | Record<number, AchievementStatsData> | GET /designer/school/{id}/achievement-stats | 3 |
| mockTrendDataBySchool | Record<number, TrendData> | GET /designer/school/{id}/award-trends | 4 |
| mockAwardWorksBySchool | Record<number, AwardWorkData[]> | GET /designer/school/{id}/award-works | 4 |
| mockSchoolCardStatsBySchool | Record<number, SchoolCardStatsData> | GET /designer/school/{id}/card-stats | 4 |

## 详细API设计

### 1. 基础院校数据接口

#### 1.1 获取院校列表
```http
GET /designer/school/list
```

**对应Mock函数**: `getMockSchools(params?)`

**请求参数**:
```typescript
interface SchoolListParams {
  pageNum?: number      // 页码，默认1
  pageSize?: number     // 每页大小，默认20
  schoolName?: string   // 院校名称模糊查询
  schoolType?: string   // 院校类型: COMPREHENSIVE/ART/ENGINEERING/NORMAL/FINANCE
  province?: string     // 省份
  city?: string         // 城市
  level?: string        // 办学层次: UNDERGRADUATE/GRADUATE/VOCATIONAL
  isKey?: boolean       // 是否重点院校
  is985?: boolean       // 是否985院校
  is211?: boolean       // 是否211院校
  isDoubleFirst?: boolean // 是否双一流院校
}
```

**响应数据结构**:
```typescript
interface SchoolListResponse {
  total: number
  rows: School[]
}

interface School {
  id: number
  schoolName: string
  schoolType: 'COMPREHENSIVE' | 'ART' | 'ENGINEERING' | 'NORMAL' | 'FINANCE'
  location: string
  province: string
  city: string
  level: 'UNDERGRADUATE' | 'GRADUATE' | 'VOCATIONAL'
  ranking: number
  description: string
  logo: string
  website: string
  address: string
  phone: string
  email: string
  totalStudents: number
  totalTeachers: number
  facultyCount: number
  majorCount: number
  status: 'ACTIVE' | 'INACTIVE'
  isKey: boolean
  is985: boolean
  is211: boolean
  isDoubleFirst: boolean
  createdAt: string
  updatedAt: string
}
```

#### 1.2 获取院校详情
```http
GET /designer/school/{id}
```

**对应Mock函数**: `getMockSchoolById(id)`

**响应数据**: 单个 `School` 对象

### 2. 专业分类数据接口

#### 2.1 获取院校专业分类
```http
GET /designer/school/{id}/major-categories
```

**对应Mock函数**: `getMockMajorCategories(schoolId?)`

**响应数据结构**:
```typescript
interface MajorCategoryData {
  name: string        // 专业名称，如"信息艺术设计"
  icon: string        // 图标，如"ri-computer-line"
  description: string // 专业描述
  skills: string[]    // 技能列表
}
```

### 3. 课程体系数据接口

#### 3.1 获取院校课程体系
```http
GET /designer/school/{id}/course-system
```

**对应Mock函数**: `getMockCourseSystem(schoolId?)`

**响应数据结构**:
```typescript
interface CourseGroup {
  name: string      // 课程组名称，如"通识基础课程"
  courses: string[] // 课程列表
}
```

### 4. 师资统计数据接口

#### 4.1 获取院校师资统计
```http
GET /designer/school/{id}/faculty-stats
```

**对应Mock函数**: `getMockFacultyStats(schoolId?)`

**响应数据结构**:
```typescript
interface FacultyStatsData {
  totalFaculty: number      // 师资总数
  professors: number        // 教授人数
  doctorDegree: number      // 博士学位人数
  overseasBackground: number // 海外背景人数
  description: string       // 师资描述
}
```

#### 4.2 获取院校代表性教师
```http
GET /designer/school/{id}/faculty-members
```

**对应Mock函数**: `getMockFacultyMembers(schoolId?)`

**响应数据结构**:
```typescript
interface TeacherData {
  id: number          // 教师ID
  name: string        // 教师姓名
  title: string       // 职称
  expertise: string[] // 专业领域
  description: string // 教师描述
}
```

### 5. 就业统计数据接口

#### 5.1 获取院校就业统计
```http
GET /designer/school/{id}/employment-stats
```

**对应Mock函数**: `getMockEmploymentStats(schoolId?)`

**响应数据结构**:
```typescript
interface EmploymentStatsData {
  employmentRate: string       // 就业率，如"96.8%"
  averageSalary: string        // 平均薪资，如"18.5K"
  furtherStudyRate: string     // 深造率，如"38.2%"
  overseasEmploymentRate: string // 海外就业率，如"22.1%"
  description: string          // 就业描述
}
```

#### 5.2 获取院校代表性雇主
```http
GET /designer/school/{id}/employers
```

**对应Mock函数**: `getMockEmployers(schoolId?)`

**响应数据结构**:
```typescript
interface EmployerData {
  id: number      // 雇主ID
  name: string    // 雇主名称
  industry: string // 行业类型
}
```

#### 5.3 获取院校就业图表数据
```http
GET /designer/school/{id}/employment-charts
```

**对应Mock函数**: `getMockChartData(schoolId?)`

**响应数据结构**:
```typescript
interface ChartData {
  industryData: Array<{
    value: number                    // 数值
    name: string                     // 行业名称
  }>
  salaryData: number[]               // 薪资分布数据
  salaryLabels: string[]             // 薪资区间标签
}
```

### 6. 学生成果统计接口

#### 6.1 获取院校学生成果统计
```http
GET /designer/school/{id}/achievement-stats
```

**对应Mock函数**: `getMockAchievementStats(schoolId?)`

**响应数据结构**:
```typescript
interface AchievementStatsData {
  internationalAwards: number // 国际奖项数量
  nationalAwards: number      // 国家级奖项数量
  provincialAwards: number    // 省级奖项数量
  patents: number             // 专利数量
  description: string         // 成果描述
}
```

#### 6.2 获取院校获奖趋势数据
```http
GET /designer/school/{id}/award-trends
```

**对应Mock函数**: `getMockTrendData(schoolId?)`

**响应数据结构**:
```typescript
interface TrendData {
  years: string[]            // 年份数组
  internationalData: number[] // 国际奖项数据
  nationalData: number[]      // 国家级奖项数据
  provincialData: number[]    // 省级奖项数据
}
```

#### 6.3 获取院校获奖作品
```http
GET /designer/school/{id}/award-works
```

**对应Mock函数**: `getMockAwardWorks(schoolId?)`

**响应数据结构**:
```typescript
interface AwardWorkData {
  id: number          // 作品ID
  title: string       // 作品标题
  award: string       // 奖项名称
  description: string // 作品描述
}
```

### 7. 卡片统计数据接口

#### 7.1 获取院校卡片统计数据
```http
GET /designer/school/{id}/card-stats
```

**响应数据结构**:
```typescript
interface SchoolCardStatsData {
  employmentRates: string[]                           // 就业率数组
  facultyStrengths: string[]                          // 师资力量评分数组
  studentScores: string[]                             // 学生评分数组
  advantagePrograms: Record<string, string[]>         // 优势专业按院校类型分类
}
```

### 8. 格式化数据接口

#### 8.1 获取格式化就业率
```http
GET /designer/school/{id}/formatted/employment-rate
```

**对应Mock函数**: `getMockEmploymentRate(schoolId)`

**响应数据**: 字符串，如 "96.8%"

#### 8.2 获取格式化师资力量评分
```http
GET /designer/school/{id}/formatted/faculty-strength
```

**对应Mock函数**: `getMockFacultyStrength(schoolId)`

**响应数据**: 字符串，如 "5.0"

#### 8.3 获取格式化学生评分
```http
GET /designer/school/{id}/formatted/student-score
```

**对应Mock函数**: `getMockStudentScore(schoolId)`

**响应数据**: 字符串，如 "4.9"

#### 8.4 获取格式化优势专业
```http
GET /designer/school/{id}/formatted/advantage-programs
```

**对应Mock函数**: `getMockAdvantagePrograms(school)`

**响应数据**: 字符串，如 "信息艺术设计、智能产品设计、交互设计"

### 9. 综合数据接口

#### 9.1 获取院校完整信息
```http
GET /designer/school/{id}/full-info
```

**响应数据结构**:
```typescript
interface SchoolFullInfo {
  basicInfo: School                      // 基础院校信息
  majorCategories: MajorCategoryData[]   // 专业分类数据
  courseSystem: CourseGroup[]            // 课程体系数据
  facultyStats: FacultyStatsData         // 师资统计数据
  facultyMembers: TeacherData[]          // 代表性教师数据
  employmentStats: EmploymentStatsData   // 就业统计数据
  employers: EmployerData[]              // 代表性雇主数据
  chartData: ChartData                   // 图表数据
  achievementStats: AchievementStatsData // 学生成果统计
  trendData: TrendData                   // 获奖趋势数据
  awardWorks: AwardWorkData[]            // 获奖作品数据
  cardStats: SchoolCardStatsData         // 卡片统计数据
}
```

## 标准响应格式

所有接口都采用统一的响应格式：

```typescript
interface ApiResponse<T> {
  code: number    // 状态码，200表示成功
  msg: string     // 响应消息
  data: T         // 响应数据
}
```

## Mock数据覆盖验证

### ✅ 数据源覆盖检查

1. ✅ **mockSchools** → `GET /designer/school/list` & `GET /designer/school/{id}`
2. ✅ **mockMajorCategoriesBySchool** → `GET /designer/school/{id}/major-categories`
3. ✅ **mockCourseSystemBySchool** → `GET /designer/school/{id}/course-system`
4. ✅ **mockFacultyStatsBySchool** → `GET /designer/school/{id}/faculty-stats`
5. ✅ **mockFacultyMembersBySchool** → `GET /designer/school/{id}/faculty-members`
6. ✅ **mockEmploymentStatsBySchool** → `GET /designer/school/{id}/employment-stats`
7. ✅ **mockEmployersBySchool** → `GET /designer/school/{id}/employers`
8. ✅ **mockChartDataBySchool** → `GET /designer/school/{id}/employment-charts`
9. ✅ **mockAchievementStatsBySchool** → `GET /designer/school/{id}/achievement-stats`
10. ✅ **mockTrendDataBySchool** → `GET /designer/school/{id}/award-trends`
11. ✅ **mockAwardWorksBySchool** → `GET /designer/school/{id}/award-works`
12. ✅ **mockSchoolCardStatsBySchool** → `GET /designer/school/{id}/card-stats`

### ✅ 函数覆盖检查

1. ✅ **getMockSchools()** → `GET /designer/school/list`
2. ✅ **getMockSchoolById()** → `GET /designer/school/{id}`
3. ✅ **getMockMajorCategories()** → `GET /designer/school/{id}/major-categories`
4. ✅ **getMockCourseSystem()** → `GET /designer/school/{id}/course-system`
5. ✅ **getMockFacultyStats()** → `GET /designer/school/{id}/faculty-stats`
6. ✅ **getMockFacultyMembers()** → `GET /designer/school/{id}/faculty-members`
7. ✅ **getMockEmploymentStats()** → `GET /designer/school/{id}/employment-stats`
8. ✅ **getMockEmployers()** → `GET /designer/school/{id}/employers`
9. ✅ **getMockChartData()** → `GET /designer/school/{id}/employment-charts`
10. ✅ **getMockAchievementStats()** → `GET /designer/school/{id}/achievement-stats`
11. ✅ **getMockTrendData()** → `GET /designer/school/{id}/award-trends`
12. ✅ **getMockAwardWorks()** → `GET /designer/school/{id}/award-works`
13. ✅ **getMockEmploymentRate()** → `GET /designer/school/{id}/formatted/employment-rate`
14. ✅ **getMockFacultyStrength()** → `GET /designer/school/{id}/formatted/faculty-strength`
15. ✅ **getMockStudentScore()** → `GET /designer/school/{id}/formatted/student-score`
16. ✅ **getMockAdvantagePrograms()** → `GET /designer/school/{id}/formatted/advantage-programs`

### ✅ 数据结构覆盖检查

1. ✅ **School** - 包含所有字段 (id, schoolName, schoolType 等 22个字段)
2. ✅ **MajorCategoryData** - 包含 name, icon, description, skills
3. ✅ **CourseGroup** - 包含 name, courses
4. ✅ **FacultyStatsData** - 包含 totalFaculty, professors, doctorDegree, overseasBackground, description
5. ✅ **TeacherData** - 包含 id, name, title, expertise, description
6. ✅ **EmploymentStatsData** - 包含 employmentRate, averageSalary, furtherStudyRate, overseasEmploymentRate, description
7. ✅ **EmployerData** - 包含 id, name, industry
8. ✅ **ChartData** - 包含 industryData, salaryData, salaryLabels
9. ✅ **AchievementStatsData** - 包含 internationalAwards, nationalAwards, provincialAwards, patents, description
10. ✅ **TrendData** - 包含 years, internationalData, nationalData, provincialData
11. ✅ **AwardWorkData** - 包含 id, title, award, description
12. ✅ **SchoolCardStatsData** - 包含 employmentRates, facultyStrengths, studentScores, advantagePrograms

## 实施建议

### 1. 开发优先级

**P1 (立即实施)**:
- 院校基础数据接口 (列表、详情)
- 院校完整信息接口

**P2 (核心功能)**:
- 专业分类、课程体系、师资统计、就业统计接口

**P3 (增强展示)**:
- 代表性教师、雇主、图表数据、学生成果接口

**P4 (完善功能)**:
- 获奖趋势、获奖作品、卡片统计、格式化接口

### 2. 数据库设计建议

根据Mock数据结构，建议创建对应的数据库表来存储真实数据。

### 3. 缓存策略

- 基础数据 (1小时缓存)
- 统计数据 (30分钟缓存)
- 图表数据 (15分钟缓存)

### 4. 兼容性说明

本API设计遵循设计师管理模块的接口规范，所有接口都在 `/designer` 路径下：

- **符合模块架构**：与现有设计师管理模块保持一致的URL结构
- **路径规范统一**：`/designer/school/*` 作为院校相关接口的统一前缀
- **权限体系兼容**：继承 `designer:school:*` 权限码体系
- **与管理接口区分**：展示类接口与管理类接口分离，避免混淆

### 5. 权限说明

参考README.md中的权限设计，院校展示接口的权限控制：

- **公开接口**：基础院校信息、专业分类等对所有用户开放
- **受限接口**：详细统计数据需要相应权限
- **权限码**：`designer:school:list`、`designer:school:view` 等

## 总结

本设计方案严格按照 `mockSchools.ts` 中的数据结构设计API接口，并遵循设计师管理模块的架构规范：

### 📋 Mock数据覆盖率 100%
- **12个主要数据源** 全部对应API接口
- **16个Mock函数** 全部对应API接口
- **12个数据结构** 全部在API响应中体现
- **支持所有筛选参数** (pageNum, pageSize, schoolName等)
- **包含格式化函数** 对应的便捷接口

### 🏗️ 架构设计统一性
- **URL规范**：所有接口采用 `/designer/school/*` 路径结构
- **权限体系**：集成 `designer:school:*` 权限码体系
- **响应格式**：统一的 ApiResponse<T> 响应结构
- **模块兼容**：与现有设计师管理模块完全兼容

### ✅ 实施保障
- **无缝切换**：前端可以零修改从Mock数据切换到后端API
- **数据一致性**：API响应与Mock数据结构完全一致
- **扩展性**：预留格式化接口和综合接口，便于后续功能扩展

通过本设计，可确保院校数据展示功能与整个设计师生态管理系统的有机集成。
