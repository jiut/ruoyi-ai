import type {
  Designer,
  Work,
  WorkExperience,
  Education,
  Award,
  Profession,
  SkillTag,
  WorkStatus
} from '@/types/talent/designer'

// 模拟设计师数据
export const mockDesigners: Designer[] = [
  {
    id: 1,
    designerName: '陈雨晴',
    profession: 'UI_UX_DESIGNER' as Profession,
    email: 'chenyu@example.com',
    phone: '13812345678',
    skillTags: JSON.stringify(['FIGMA', 'USER_RESEARCH', 'INTERACTION_DESIGN'] as SkillTag[]),
    socialLinks: JSON.stringify({
      dribbble: 'https://dribbble.com/chenyu',
      behance: 'https://behance.net/chenyu'
    }),
    portfolio: 'https://chenyudesign.com',
    description: '拥有 5 年 UI/UX 设计经验，专注于移动应用和 Web 产品的用户体验设计。擅长用户研究、交互设计和视觉设计，能够从用户需求出发，打造直观易用的产品界面。曾主导腾讯多个核心产品的设计工作，包括社交、游戏和企业应用等领域。',
    avatar: '',
    schoolId: 1,
    enterpriseId: 1,
    userId: 1,
    status: 'active',
    location: '深圳',
    experience: 5,
    workStatus: 'EMPLOYED' as WorkStatus,
    createdAt: '2023-01-01T00:00:00Z',
    updatedAt: '2023-12-01T00:00:00Z'
  },
  {
    id: 2,
    designerName: '林子豪',
    profession: 'VISUAL_DESIGNER' as Profession,
    email: 'linzihao@example.com',
    phone: '13923456789',
    skillTags: JSON.stringify(['PHOTOSHOP', 'ILLUSTRATOR', 'BRAND_DESIGN'] as SkillTag[]),
    socialLinks: JSON.stringify({
      instagram: 'https://instagram.com/linzihao'
    }),
    portfolio: 'https://linzihaodesign.com',
    description: '专业视觉设计师，专注于品牌设计和视觉传达。拥有丰富的品牌标识设计经验，善于通过视觉语言传达品牌价值。',
    avatar: '',
    userId: 2,
    status: 'active',
    location: '上海',
    experience: 7,
    workStatus: 'EMPLOYED' as WorkStatus,
    createdAt: '2022-06-01T00:00:00Z',
    updatedAt: '2023-12-01T00:00:00Z'
  },
  {
    id: 3,
    designerName: '王梦琪',
    profession: 'THREE_D_DESIGNER' as Profession,
    email: 'wangmengqi@example.com',
    phone: '13634567890',
    skillTags: JSON.stringify(['BLENDER', 'CINEMA_4D', 'ANIMATION_DESIGN'] as SkillTag[]),
    socialLinks: JSON.stringify({}),
    portfolio: 'https://wangmengqi3d.com',
    description: '3D 动画设计师，专注于三维建模和动画制作。拥有丰富的影视和游戏行业经验。',
    avatar: '',
    userId: 3,
    status: 'active',
    location: '北京',
    experience: 4,
    workStatus: 'FREELANCER' as WorkStatus,
    createdAt: '2023-03-01T00:00:00Z',
    updatedAt: '2023-12-01T00:00:00Z'
  },
  {
    id: 4,
    designerName: '赵明宇',
    profession: 'PRODUCT_DESIGNER' as Profession,
    email: 'zhaomingyu@example.com',
    phone: '13745678901',
    skillTags: JSON.stringify(['SKETCH', 'PROTOTYPE_DESIGN', 'USER_EXPERIENCE_DESIGN'] as SkillTag[]),
    socialLinks: JSON.stringify({}),
    portfolio: 'https://zhaomingyu.design',
    description: '产品设计师，专注于数字产品的用户体验设计和产品策略。',
    avatar: '',
    userId: 4,
    status: 'active',
    location: '杭州',
    experience: 6,
    workStatus: 'EMPLOYED' as WorkStatus,
    createdAt: '2022-09-01T00:00:00Z',
    updatedAt: '2023-12-01T00:00:00Z'
  }
]

// 模拟作品数据
export const mockWorks: Work[] = [
  {
    id: 1,
    title: '社交媒体应用 UI 设计',
    description: '移动应用界面设计',
    imageUrl: 'https://via.placeholder.com/400x300/6366f1/ffffff?text=Social+App+UI',
    category: 'UI设计',
    designerId: 1,
    createdAt: '2023-06-01T00:00:00Z',
    updatedAt: '2023-06-01T00:00:00Z'
  },
  {
    id: 2,
    title: '数据分析仪表盘',
    description: 'Web 应用界面设计',
    imageUrl: 'https://via.placeholder.com/400x300/8b5cf6/ffffff?text=Dashboard+UI',
    category: 'Web设计',
    designerId: 1,
    createdAt: '2023-08-01T00:00:00Z',
    updatedAt: '2023-08-01T00:00:00Z'
  },
  {
    id: 3,
    title: '电商应用产品页',
    description: '电子商务 UI 设计',
    imageUrl: 'https://via.placeholder.com/400x300/ec4899/ffffff?text=E-commerce+UI',
    category: 'UI设计',
    designerId: 1,
    createdAt: '2023-10-01T00:00:00Z',
    updatedAt: '2023-10-01T00:00:00Z'
  }
]

// 模拟工作经历数据
export const mockWorkExperience: WorkExperience[] = [
  {
    id: 1,
    company: '腾讯',
    position: '高级 UI/UX 设计师',
    startDate: '2022-03-01',
    endDate: undefined,
    description: '负责腾讯社交产品的用户体验设计，主导产品界面改版与优化，建立设计规范与组件库。参与用户研究与需求分析，提出基于数据的设计解决方案。',
    isCurrent: true,
    designerId: 1
  },
  {
    id: 2,
    company: '字节跳动',
    position: 'UI 设计师',
    startDate: '2020-06-01',
    endDate: '2022-02-28',
    description: '参与短视频应用的界面设计工作，负责功能迭代与视觉优化，协助建立设计规范。与产品和开发团队紧密合作，确保设计方案的顺利实现。',
    isCurrent: false,
    designerId: 1
  }
]

// 模拟教育背景数据
export const mockEducation: Education[] = [
  {
    id: 1,
    school: '中国美术学院',
    degree: '硕士',
    major: '设计学',
    startDate: '2015-09-01',
    endDate: '2018-06-30',
    description: '专业方向：数字媒体艺术，研究方向：交互设计与用户体验',
    designerId: 1
  },
  {
    id: 2,
    school: '浙江大学',
    degree: '学士',
    major: '工业设计',
    startDate: '2011-09-01',
    endDate: '2015-06-30',
    description: '主修课程：设计基础、人机交互、产品设计、计算机辅助设计',
    designerId: 1
  }
]

// 模拟获奖数据
export const mockAwards: Award[] = [
  {
    id: 1,
    title: '2023 IF 设计奖',
    organization: 'iF International Forum Design',
    year: '2023',
    description: '腾讯社交产品界面设计',
    designerId: 1
  },
  {
    id: 2,
    title: 'Google UX 设计专业认证',
    organization: 'Google',
    year: '2021',
    description: '',
    designerId: 1
  }
]
