# 院校数据库页面API优化方案

## 📋 方案概述

基于现有的若依设计师管理模块API，重新设计院校数据库页面的接口方案。尽量复用已有的API接口，同时针对Vue前端需求进行适当扩展，确保与现有系统的兼容性。

## 🔄 现有API分析

### 1. 已有院校管理接口
根据API文档，当前系统已提供以下院校相关接口：

```typescript
// 基础CRUD接口
GET    /designer/school/list             // 查询院校列表
GET    /designer/school/{id}             // 获取院校详情
POST   /designer/school                  // 新增院校
PUT    /designer/school                  // 修改院校
DELETE /designer/school/{ids}            // 删除院校

// 就业数据接口
GET    /designer/school/{id}/employment/statistics    // 就业统计
GET    /designer/school/{id}/employment/distribution  // 就业分布

// 用户相关接口
POST   /designer/user/register/school    // 注册院校身份
GET    /designer/user/school/profile     // 获取院校档案
```

### 2. 数据库表结构
- **des_school** - 院校信息表（已存在）
- **des_designer** - 设计师表（通过school_id关联院校）
- **des_user_binding** - 用户绑定关系表

## 🎯 API复用策略

### 1. 直接复用的接口

#### 1.1 院校列表查询
```typescript
// 复用现有接口
GET /designer/school/list

// 请求参数扩展
interface SchoolListParams {
  pageNum?: number
  pageSize?: number
  schoolName?: string        // 院校名称搜索
  schoolType?: string        // 院校类型筛选
  location?: string          // 地区筛选
  orderBy?: string          // 排序字段
  orderDirection?: 'asc' | 'desc'
}

// 响应数据结构
interface SchoolListResponse {
  total: number
  rows: School[]
}

interface School {
  id: number
  schoolName: string
  schoolType: 'UNIVERSITY' | 'COLLEGE' | 'TECHNICAL' | 'VOCATIONAL'
  level: string             // 本科/专科/研究生
  address: string
  description: string
  userId?: number           // 关联用户ID
  establishedYear?: number  // 建校年份
  logo?: string            // 院校logo
  website?: string         // 官网地址
  phone?: string           // 联系电话
  email?: string           // 邮箱
  // 统计字段（需要后端计算）
  studentCount?: number     // 学生数量
  teacherCount?: number     // 教师数量
  majorCount?: number       // 专业数量
  employmentRate?: number   // 就业率
}
```

#### 1.2 院校详情查询
```typescript
// 复用现有接口
GET /designer/school/{id}

// 响应数据结构（扩展版）
interface SchoolDetailResponse extends School {
  // 基础信息继承自School

  // 关联数据（需要新增查询）
  studentList?: DesignerProfile[]     // 在校学生列表
  graduateList?: DesignerProfile[]    // 毕业生列表
  majorList?: Major[]                 // 专业列表
  achievements?: Achievement[]        // 获奖成果

  // 统计数据
  statistics?: {
    totalStudents: number
    totalGraduates: number
    currentEmploymentRate: number
    averageSalary: number
    majorDistribution: Array<{category: string, count: number}>
  }
}
```

#### 1.3 就业数据查询
```typescript
// 复用现有接口
GET /designer/school/{id}/employment/statistics
GET /designer/school/{id}/employment/distribution

// 统计数据结构
interface EmploymentStatistics {
  year: number
  totalGraduates: number
  employedCount: number
  employmentRate: number
  averageSalary: number
  salaryRanges: Array<{
    range: string
    count: number
    percentage: number
  }>
}

// 分布数据结构
interface EmploymentDistribution {
  // 行业分布
  industryDistribution: Array<{
    industry: string
    count: number
    percentage: number
  }>

  // 地区分布
  regionDistribution: Array<{
    region: string
    count: number
    percentage: number
  }>

  // 企业规模分布
  companySizeDistribution: Array<{
    size: string
    count: number
    percentage: number
  }>
}
```

### 2. 需要扩展的接口

#### 2.1 院校学生查询
```typescript
// 新增接口：查询院校学生列表
GET /designer/school/{id}/students

// 请求参数
interface SchoolStudentsParams {
  pageNum?: number
  pageSize?: number
  status?: 'current' | 'graduate'    // 在校/毕业
  profession?: string                 // 专业筛选
  graduationYear?: number            // 毕业年份
}

// 响应数据
interface SchoolStudentsResponse {
  total: number
  rows: DesignerProfile[]
}
```

#### 2.2 院校专业查询
```typescript
// 新增接口：查询院校专业
GET /designer/school/{id}/majors

// 响应数据
interface SchoolMajorsResponse {
  majors: Major[]
}

interface Major {
  id: number
  majorName: string
  category: string          // 专业类别
  degree: string           // 学位类型
  duration: number         // 学制年限
  studentCount: number     // 在校生数
  employmentRate: number   // 就业率
  averageSalary: number    // 平均薪资
  description?: string     // 专业描述
}
```

#### 2.3 院校成果查询
```typescript
// 新增接口：查询院校获奖成果
GET /designer/school/{id}/achievements

// 响应数据
interface SchoolAchievementsResponse {
  achievements: Achievement[]
}

interface Achievement {
  id: number
  title: string
  category: string         // 成果类别
  level: string           // 获奖级别
  year: number            // 获奖年份
  description?: string    // 成果描述
  awardOrganization?: string // 颁奖机构
  participants?: string   // 参与人员
}
```

#### 2.4 用户交互接口
```typescript
// 新增接口：院校收藏
POST /designer/school/{id}/favorite      // 收藏院校
DELETE /designer/school/{id}/favorite    // 取消收藏
GET /designer/school/favorites           // 我的收藏

// 响应数据
interface FavoriteResponse {
  success: boolean
  message: string
}
```

## 🎨 前端适配方案

### 1. API服务层适配

#### 1.1 基础API服务 (src/api/talent/school.ts)
```typescript
import { http } from '@/utils/request'

// 复用现有API的基础服务
export const schoolApi = {
  // 直接复用现有接口
  getSchoolList: (params: SchoolListParams) =>
    http.get<SchoolListResponse>('/designer/school/list', { params }),

  getSchoolDetail: (id: number) =>
    http.get<SchoolDetailResponse>(`/designer/school/${id}`),

  getEmploymentStats: (id: number) =>
    http.get<EmploymentStatistics>(`/designer/school/${id}/employment/statistics`),

  getEmploymentDistribution: (id: number) =>
    http.get<EmploymentDistribution>(`/designer/school/${id}/employment/distribution`),

  // 扩展API（需要后端新增）
  getSchoolStudents: (id: number, params: SchoolStudentsParams) =>
    http.get<SchoolStudentsResponse>(`/designer/school/${id}/students`, { params }),

  getSchoolMajors: (id: number) =>
    http.get<SchoolMajorsResponse>(`/designer/school/${id}/majors`),

  getSchoolAchievements: (id: number) =>
    http.get<SchoolAchievementsResponse>(`/designer/school/${id}/achievements`),
}

// 用户交互API
export const schoolInteractionApi = {
  favoriteSchool: (id: number) =>
    http.post<FavoriteResponse>(`/designer/school/${id}/favorite`),

  unfavoriteSchool: (id: number) =>
    http.delete<FavoriteResponse>(`/designer/school/${id}/favorite`),

  getFavoriteSchools: () =>
    http.get<SchoolListResponse>('/designer/school/favorites'),
}
```

### 2. 状态管理适配 (src/stores/talent/school.ts)
```typescript
import { defineStore } from 'pinia'
import { schoolApi, schoolInteractionApi } from '@/api/talent/school'

export const useSchoolStore = defineStore('school', () => {
  // 状态定义
  const schoolList = ref<School[]>([])
  const currentSchool = ref<SchoolDetailResponse | null>(null)
  const employmentStats = ref<EmploymentStatistics | null>(null)
  const employmentDistribution = ref<EmploymentDistribution | null>(null)
  const favoriteSchools = ref<School[]>([])

  // 使用现有API的方法
  const fetchSchoolList = async (params: SchoolListParams) => {
    try {
      const { data } = await schoolApi.getSchoolList(params)
      schoolList.value = data.rows
      return data
    } catch (error) {
      console.error('获取院校列表失败:', error)
      throw error
    }
  }

  const fetchSchoolDetail = async (id: number) => {
    try {
      const { data } = await schoolApi.getSchoolDetail(id)
      currentSchool.value = data
      return data
    } catch (error) {
      console.error('获取院校详情失败:', error)
      throw error
    }
  }

  const fetchEmploymentData = async (id: number) => {
    try {
      const [statsRes, distributionRes] = await Promise.all([
        schoolApi.getEmploymentStats(id),
        schoolApi.getEmploymentDistribution(id)
      ])

      employmentStats.value = statsRes.data
      employmentDistribution.value = distributionRes.data

      return {
        stats: statsRes.data,
        distribution: distributionRes.data
      }
    } catch (error) {
      console.error('获取就业数据失败:', error)
      throw error
    }
  }

  // 用户交互方法
  const toggleFavorite = async (schoolId: number) => {
    try {
      const isFavorited = favoriteSchools.value.some(s => s.id === schoolId)

      if (isFavorited) {
        await schoolInteractionApi.unfavoriteSchool(schoolId)
        favoriteSchools.value = favoriteSchools.value.filter(s => s.id !== schoolId)
      } else {
        await schoolInteractionApi.favoriteSchool(schoolId)
        // 重新获取收藏列表
        await fetchFavoriteSchools()
      }
    } catch (error) {
      console.error('收藏操作失败:', error)
      throw error
    }
  }

  return {
    // 状态
    schoolList,
    currentSchool,
    employmentStats,
    employmentDistribution,
    favoriteSchools,

    // 方法
    fetchSchoolList,
    fetchSchoolDetail,
    fetchEmploymentData,
    toggleFavorite,
  }
})
```

### 3. 组合式函数适配 (src/composables/talent/useSchool.ts)
```typescript
import { useSchoolStore } from '@/stores/talent/school'

export function useSchoolList() {
  const schoolStore = useSchoolStore()

  // 搜索和筛选
  const searchParams = ref<SchoolListParams>({
    pageNum: 1,
    pageSize: 20,
    schoolName: '',
    schoolType: '',
    location: '',
    orderBy: 'id',
    orderDirection: 'desc'
  })

  // 使用现有API
  const loadSchoolList = async () => {
    try {
      const result = await schoolStore.fetchSchoolList(searchParams.value)
      return result
    } catch (error) {
      console.error('加载院校列表失败:', error)
      throw error
    }
  }

  return {
    searchParams,
    schoolList: computed(() => schoolStore.schoolList),
    loadSchoolList,
  }
}

export function useSchoolDetail(schoolId: number) {
  const schoolStore = useSchoolStore()

  const loadSchoolDetail = async () => {
    try {
      await schoolStore.fetchSchoolDetail(schoolId)
      await schoolStore.fetchEmploymentData(schoolId)
    } catch (error) {
      console.error('加载院校详情失败:', error)
      throw error
    }
  }

  return {
    school: computed(() => schoolStore.currentSchool),
    employmentStats: computed(() => schoolStore.employmentStats),
    employmentDistribution: computed(() => schoolStore.employmentDistribution),
    loadSchoolDetail,
  }
}
```

## 🔧 后端扩展建议

### 1. 现有表结构利用
```sql
-- 利用现有的 des_school 表
-- 建议增加字段：
ALTER TABLE des_school ADD COLUMN established_year INT COMMENT '建校年份';
ALTER TABLE des_school ADD COLUMN logo VARCHAR(255) COMMENT '院校logo';
ALTER TABLE des_school ADD COLUMN website VARCHAR(255) COMMENT '官网地址';
ALTER TABLE des_school ADD COLUMN phone VARCHAR(20) COMMENT '联系电话';
ALTER TABLE des_school ADD COLUMN email VARCHAR(100) COMMENT '邮箱';

-- 利用现有的 des_designer 表关联院校学生
-- 通过 school_id 字段关联院校

-- 可选：新增专业表
CREATE TABLE des_school_major (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  school_id BIGINT NOT NULL COMMENT '院校ID',
  major_name VARCHAR(100) NOT NULL COMMENT '专业名称',
  category VARCHAR(50) COMMENT '专业类别',
  degree VARCHAR(20) COMMENT '学位类型',
  duration INT COMMENT '学制年限',
  description TEXT COMMENT '专业描述',
  create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
  update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (school_id) REFERENCES des_school(id)
);
```

### 2. 控制器扩展建议
```java
@RestController
@RequestMapping("/designer/school")
public class SchoolController {

    // 现有方法保持不变
    // ... existing methods ...

    // 新增扩展方法
    @GetMapping("/{id}/students")
    public R<PageResult<Designer>> getSchoolStudents(
        @PathVariable Long id,
        @RequestParam(defaultValue = "1") Integer pageNum,
        @RequestParam(defaultValue = "20") Integer pageSize,
        @RequestParam(required = false) String status,
        @RequestParam(required = false) String profession) {

        // 查询院校学生逻辑
        PageQuery pageQuery = new PageQuery(pageNum, pageSize);
        PageResult<Designer> result = schoolService.getSchoolStudents(id, status, profession, pageQuery);
        return R.ok(result);
    }

    @GetMapping("/{id}/majors")
    public R<List<SchoolMajor>> getSchoolMajors(@PathVariable Long id) {
        List<SchoolMajor> majors = schoolService.getSchoolMajors(id);
        return R.ok(majors);
    }

    @PostMapping("/{id}/favorite")
    public R<Void> favoriteSchool(@PathVariable Long id) {
        schoolService.favoriteSchool(id, LoginHelper.getUserId());
        return R.ok();
    }
}
```

## 📝 实施步骤

### 阶段1：基础功能实现（复用现有API）
1. ✅ 实现院校列表页面，使用现有 `/designer/school/list` 接口
2. ✅ 实现院校详情页面，使用现有 `/designer/school/{id}` 接口
3. ✅ 实现就业数据展示，使用现有就业统计接口
4. ✅ 完成基础的搜索、筛选、分页功能

### 阶段2：功能扩展（新增API）
1. 🔄 后端新增学生列表、专业列表接口
2. 🔄 实现用户收藏功能
3. 🔄 完善数据可视化图表

### 阶段3：优化完善
1. 🔄 性能优化和缓存策略
2. 🔄 移动端适配
3. 🔄 用户体验优化
4. 🔄 测试和bug修复

## 🎯 优势总结

1. **最大化复用现有API**：直接使用已有的院校管理接口，减少开发工作量
2. **渐进式扩展**：基于现有功能逐步扩展，风险可控
3. **保持架构一致性**：与现有设计师、企业模块保持技术栈和代码风格一致
4. **权限体系兼容**：完全兼容现有的用户绑定和权限管理系统
5. **数据库结构复用**：最大化利用现有表结构，减少数据迁移成本

这个优化方案既满足了Vue前端的功能需求，又最大化地复用了现有的API资源，确保与现有系统的完美集成。
