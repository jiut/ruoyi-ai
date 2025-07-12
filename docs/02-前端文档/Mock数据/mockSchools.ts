import type {
  School,
  SchoolType,
  SchoolLevel,
  Major,
  Faculty,
  Employment,
  Award,
  Achievement
} from '@/types/talent/school'

// 模拟院校数据
export const mockSchools: School[] = [
  {
    id: 1,
    schoolName: '清华大学',
    schoolType: 'COMPREHENSIVE' as SchoolType,
    location: '北京市海淀区',
    province: '北京市',
    city: '北京市',
    level: 'UNDERGRADUATE' as SchoolLevel,
    ranking: 1,
    description: '清华大学美术学院设计系成立于1984年，是中国最早开设设计专业的院系之一。',
    logo: '',
    website: 'https://www.tsinghua.edu.cn',
    address: '北京市海淀区清华园1号',
    phone: '010-62782051',
    email: 'info@tsinghua.edu.cn',
    totalStudents: 48000,
    totalTeachers: 3485,
    facultyCount: 15,
    majorCount: 82,
    status: '0',
    isKey: true,
    is985: true,
    is211: true,
    isDoubleFirst: true,
    createdAt: '2025-01-01T00:00:00.000Z',
    updatedAt: '2025-01-27T00:00:00.000Z'
  },
  {
    id: 2,
    schoolName: '中央美术学院',
    schoolType: 'ART' as SchoolType,
    location: '北京市朝阳区',
    province: '北京市',
    city: '北京市',
    level: 'UNDERGRADUATE' as SchoolLevel,
    ranking: 1,
    description: '中央美术学院是中华人民共和国教育部直属的唯一一所高等美术学校。',
    logo: '',
    website: 'https://www.cafa.edu.cn',
    address: '北京市朝阳区花家地南街8号',
    phone: '010-64771056',
    email: 'info@cafa.edu.cn',
    totalStudents: 4500,
    totalTeachers: 572,
    facultyCount: 8,
    majorCount: 15,
    status: '0',
    isKey: true,
    is985: false,
    is211: false,
    isDoubleFirst: true,
    createdAt: '2025-01-01T00:00:00.000Z',
    updatedAt: '2025-01-27T00:00:00.000Z'
  },
  {
    id: 3,
    schoolName: '同济大学',
    schoolType: 'COMPREHENSIVE' as SchoolType,
    location: '上海市杨浦区',
    province: '上海市',
    city: '上海市',
    level: 'UNDERGRADUATE' as SchoolLevel,
    ranking: 20,
    description: '同济大学设计创意学院是国内最具影响力的设计学院之一。',
    logo: '',
    website: 'https://www.tongji.edu.cn',
    address: '上海市杨浦区四平路1239号',
    phone: '021-65982200',
    email: 'info@tongji.edu.cn',
    totalStudents: 35000,
    totalTeachers: 2804,
    facultyCount: 12,
    majorCount: 96,
    status: '0',
    isKey: true,
    is985: true,
    is211: true,
    isDoubleFirst: true,
    createdAt: '2025-01-01T00:00:00.000Z',
    updatedAt: '2025-01-27T00:00:00.000Z'
  },
  {
    id: 4,
    schoolName: '中国美术学院',
    schoolType: 'ART' as SchoolType,
    location: '浙江省杭州市',
    province: '浙江省',
    city: '杭州市',
    level: 'UNDERGRADUATE' as SchoolLevel,
    ranking: 2,
    description: '中国美术学院是中国第一所综合性的国立高等艺术学府。',
    logo: '',
    website: 'https://www.caa.edu.cn',
    address: '浙江省杭州市上城区南山路218号',
    phone: '0571-87164630',
    email: 'info@caa.edu.cn',
    totalStudents: 9000,
    totalTeachers: 900,
    facultyCount: 18,
    majorCount: 26,
    status: '0',
    isKey: true,
    is985: false,
    is211: false,
    isDoubleFirst: true,
    createdAt: '2025-01-01T00:00:00.000Z',
    updatedAt: '2025-01-27T00:00:00.000Z'
  },
  {
    id: 5,
    schoolName: '广州美术学院',
    schoolType: 'ART' as SchoolType,
    location: '广东省广州市',
    province: '广东省',
    city: '广州市',
    level: 'UNDERGRADUATE' as SchoolLevel,
    ranking: 3,
    description: '广州美术学院是华南地区唯一一所高等美术学府。',
    logo: '',
    website: 'https://www.gzarts.edu.cn',
    address: '广东省广州市海珠区昌岗东路257号',
    phone: '020-84017740',
    email: 'info@gzarts.edu.cn',
    totalStudents: 8000,
    totalTeachers: 700,
    facultyCount: 12,
    majorCount: 31,
    status: '0',
    isKey: true,
    is985: false,
    is211: false,
    isDoubleFirst: false,
    createdAt: '2025-01-01T00:00:00.000Z',
    updatedAt: '2025-01-27T00:00:00.000Z'
  },
  {
    id: 6,
    schoolName: '江南大学',
    schoolType: 'COMPREHENSIVE' as SchoolType,
    location: '江苏省无锡市',
    province: '江苏省',
    city: '无锡市',
    level: 'UNDERGRADUATE' as SchoolLevel,
    ranking: 41,
    description: '江南大学设计学院是国内工业设计教育的重要基地。',
    logo: '',
    website: 'https://www.jiangnan.edu.cn',
    address: '江苏省无锡市蠡湖大道1800号',
    phone: '0510-85913669',
    email: 'info@jiangnan.edu.cn',
    totalStudents: 20000,
    totalTeachers: 1500,
    facultyCount: 8,
    majorCount: 55,
    status: '0',
    isKey: true,
    is985: false,
    is211: true,
    isDoubleFirst: true,
    createdAt: '2025-01-01T00:00:00.000Z',
    updatedAt: '2025-01-27T00:00:00.000Z'
  },
  {
    id: 7,
    schoolName: '北京理工大学',
    schoolType: 'ENGINEERING' as SchoolType,
    location: '北京市海淀区',
    province: '北京市',
    city: '北京市',
    level: 'UNDERGRADUATE' as SchoolLevel,
    ranking: 25,
    description: '北京理工大学设计与艺术学院致力于培养具有创新精神的设计人才。',
    logo: '',
    website: 'https://www.bit.edu.cn',
    address: '北京市海淀区中关村南大街5号',
    phone: '010-68912114',
    email: 'info@bit.edu.cn',
    totalStudents: 28000,
    totalTeachers: 2200,
    facultyCount: 10,
    majorCount: 70,
    status: '0',
    isKey: true,
    is985: true,
    is211: true,
    isDoubleFirst: true,
    createdAt: '2025-01-01T00:00:00.000Z',
    updatedAt: '2025-01-27T00:00:00.000Z'
  },
  {
    id: 8,
    schoolName: '湖南大学',
    schoolType: 'COMPREHENSIVE' as SchoolType,
    location: '湖南省长沙市',
    province: '湖南省',
    city: '长沙市',
    level: 'UNDERGRADUATE' as SchoolLevel,
    ranking: 27,
    description: '湖南大学设计艺术学院是国内最早设立工业设计专业的院校之一。',
    logo: '',
    website: 'https://www.hnu.edu.cn',
    address: '湖南省长沙市岳麓区麓山南路2号',
    phone: '0731-88822818',
    email: 'info@hnu.edu.cn',
    totalStudents: 35000,
    totalTeachers: 2500,
    facultyCount: 11,
    majorCount: 75,
    status: '0',
    isKey: true,
    is985: true,
    is211: true,
    isDoubleFirst: true,
    createdAt: '2025-01-01T00:00:00.000Z',
    updatedAt: '2025-01-27T00:00:00.000Z'
  }
]

// 专业分类数据结构
interface MajorCategoryData {
  name: string
  icon: string
  description: string
  skills: string[]
}

// 课程体系数据结构
interface CourseGroup {
  name: string
  courses: string[]
}

// 模拟专业分类数据 - 按学校ID分类
export const mockMajorCategoriesBySchool: Record<number, MajorCategoryData[]> = {
  // 清华大学 - 综合性强，科技与艺术结合
  1: [
    {
      name: '信息艺术设计',
      icon: 'ri-computer-line',
      description: '结合清华理工科优势，培养具备信息可视化、人机交互等前沿设计能力的复合型人才。',
      skills: ['信息可视化', '交互设计', '数据艺术', '智能界面设计']
    },
    {
      name: '视觉传达设计',
      icon: 'ri-palette-line',
      description: '传承清华美院深厚底蕴，培养具备国际视野和创新思维的视觉传达设计人才。',
      skills: ['品牌战略设计', '文化创意设计', '出版物设计', '导视系统设计']
    },
    {
      name: '产品设计',
      icon: 'ri-lightbulb-line',
      description: '依托清华工科背景，注重设计与工程的深度融合，培养具备创新思维的产品设计师。',
      skills: ['智能产品设计', '交通工具设计', '可持续设计', '设计研究']
    },
    {
      name: '环境设计',
      icon: 'ri-building-line',
      description: '结合建筑学科优势，培养具备空间设计和环境营造能力的高端设计人才。',
      skills: ['展示空间设计', '公共艺术', '景观规划', '智慧空间设计']
    }
  ],

  // 中央美术学院 - 传统美术与现代设计并重
  2: [
    {
      name: '视觉传达设计',
      icon: 'ri-palette-line',
      description: '立足传统文化，面向当代设计，培养具有深厚艺术底蕴和国际视野的设计师。',
      skills: ['文字设计', '海报设计', '书籍装帧', '文化传播设计']
    },
    {
      name: '数字媒体艺术',
      icon: 'ri-computer-line',
      description: '探索艺术与科技融合，培养具备新媒体创作能力的当代艺术家和设计师。',
      skills: ['新媒体艺术', '数字影像', '虚拟现实艺术', '交互装置']
    },
    {
      name: '产品设计',
      icon: 'ri-lightbulb-line',
      description: '注重设计的文化内涵和艺术表达，培养具有人文关怀的产品设计师。',
      skills: ['生活方式设计', '文创产品设计', '家居用品设计', '艺术衍生品设计']
    },
    {
      name: '服装与服饰设计',
      icon: 'ri-shirt-line',
      description: '传承中华服饰文化，融合国际时尚趋势，培养具有原创能力的服装设计师。',
      skills: ['时装设计', '传统服饰研究', '纺织品设计', '时尚插画']
    }
  ],

  // 同济大学 - 建筑与设计结合，注重创新
  3: [
    {
      name: '工业设计',
      icon: 'ri-tools-line',
      description: '依托同济工程优势，培养具备系统思维和创新能力的工业设计师。',
      skills: ['交通工具设计', '智能制造设计', '服务设计', '可持续设计']
    },
    {
      name: '环境设计',
      icon: 'ri-building-line',
      description: '结合建筑学科背景，培养具备空间设计和城市规划视野的环境设计师。',
      skills: ['城市家具设计', '景观建筑', '展览空间设计', '历史建筑改造']
    },
    {
      name: '数字媒体艺术',
      icon: 'ri-computer-line',
      description: '融合技术与艺术，培养能够运用前沿技术进行创意表达的数字艺术家。',
      skills: ['计算机图形学', '增强现实', '人工智能艺术', '数字建造']
    },
    {
      name: '动画设计',
      icon: 'ri-film-line',
      description: '培养具备动画创作和数字影像制作能力的专业人才。',
      skills: ['角色动画', '建筑动画', '科学可视化', '影视后期']
    }
  ],

  // 中国美术学院 - 传统艺术与当代设计融合
  4: [
    {
      name: '视觉传达设计',
      icon: 'ri-palette-line',
      description: '传承国美深厚学术传统，培养具有东方美学素养和国际视野的视觉设计师。',
      skills: ['传统图形设计', '当代海报设计', '书法与字体', '文化品牌设计']
    },
    {
      name: '陶瓷艺术设计',
      icon: 'ri-goblet-line',
      description: '发扬中国陶瓷艺术传统，培养具备现代设计理念的陶瓷艺术家。',
      skills: ['传统陶艺', '现代陶瓷设计', '釉料研究', '陶瓷产品设计']
    },
    {
      name: '纤维艺术',
      icon: 'ri-thread-line',
      description: '探索纤维材料的艺术表达，培养具备创新精神的纤维艺术家。',
      skills: ['编织艺术', '纤维装置', '服装艺术', '材料创新']
    },
    {
      name: '综合艺术',
      icon: 'ri-artboard-line',
      description: '跨媒介艺术实践，培养具备多元化表达能力的当代艺术家。',
      skills: ['装置艺术', '行为艺术', '影像艺术', '公共艺术']
    }
  ],

  // 广州美术学院 - 岭南文化特色，开放包容
  5: [
    {
      name: '视觉传达设计',
      icon: 'ri-palette-line',
      description: '融合岭南文化特色，面向粤港澳大湾区，培养具有区域文化特色的设计师。',
      skills: ['岭南文化设计', '粤港澳文创', '商业设计', '包装设计']
    },
    {
      name: '产品设计',
      icon: 'ri-lightbulb-line',
      description: '立足制造业发达的珠三角地区，培养具备产业化思维的产品设计师。',
      skills: ['家电产品设计', '消费电子设计', '玩具设计', '文创产品']
    },
    {
      name: '环境设计',
      icon: 'ri-building-line',
      description: '结合岭南建筑文化和现代城市发展需求，培养环境设计专业人才。',
      skills: ['岭南园林设计', '商业空间设计', '旅游景观设计', '文化空间设计']
    },
    {
      name: '数字媒体艺术',
      icon: 'ri-computer-line',
      description: '面向数字创意产业，培养具备新媒体创作能力的数字艺术人才。',
      skills: ['游戏美术设计', '动漫设计', '短视频创作', 'VR/AR艺术']
    }
  ],

  // 江南大学 - 工业设计强校，注重实用性
  6: [
    {
      name: '工业设计',
      icon: 'ri-tools-line',
      description: '国内工业设计领域领军专业，培养具备系统设计思维的工业设计师。',
      skills: ['产品系统设计', '用户研究', '设计策略', '智能产品设计']
    },
    {
      name: '视觉传达设计',
      icon: 'ri-palette-line',
      description: '注重设计的功能性和商业价值，培养市场导向的视觉设计师。',
      skills: ['品牌形象设计', '包装设计', '网页设计', '移动界面设计']
    },
    {
      name: '环境设计',
      icon: 'ri-building-line',
      description: '强调设计的人文关怀和生态理念，培养可持续发展的环境设计师。',
      skills: ['可持续设计', '无障碍设计', '老龄化设计', '绿色建筑设计']
    },
    {
      name: '服装与服饰设计',
      icon: 'ri-shirt-line',
      description: '结合纺织工程优势，培养具备技术背景的服装设计师。',
      skills: ['功能性服装', '智能纺织品', '时尚设计', '纺织品图案设计']
    }
  ],

  // 北京理工大学 - 工科背景，科技含量高
  7: [
    {
      name: '工业设计',
      icon: 'ri-tools-line',
      description: '依托理工科优势，培养具备工程技术背景的工业设计师。',
      skills: ['机械产品设计', '军工产品设计', '精密仪器设计', '智能装备设计']
    },
    {
      name: '数字媒体技术',
      icon: 'ri-computer-line',
      description: '结合计算机科学与艺术设计，培养技术与艺术兼备的复合型人才。',
      skills: ['计算机图形学', '虚拟现实技术', '人工智能应用', '数字娱乐技术']
    },
    {
      name: '传播设计',
      icon: 'ri-broadcast-line',
      description: '面向信息时代传播需求，培养具备新媒体素养的传播设计师。',
      skills: ['信息设计', '数据可视化', '交互媒体设计', '科技传播设计']
    },
    {
      name: '文化遗产保护',
      icon: 'ri-ancient-pavilion-line',
      description: '运用现代技术手段保护和传承文化遗产，培养文化科技融合人才。',
      skills: ['数字文保', '虚拟博物馆', '文物数字化', '文化传播技术']
    }
  ],

  // 湖南大学 - 千年学府，设计与工程结合
  8: [
    {
      name: '工业设计',
      icon: 'ri-tools-line',
      description: '历史悠久的工业设计专业，培养具备深厚理论基础和实践能力的设计师。',
      skills: ['汽车造型设计', '机械产品设计', '智能硬件设计', '设计管理']
    },
    {
      name: '视觉传达设计',
      icon: 'ri-palette-line',
      description: '融合湖湘文化特色，培养具有地域特色和时代精神的视觉设计师。',
      skills: ['湖湘文化设计', '品牌设计', '数字媒体设计', '文创产品设计']
    },
    {
      name: '建筑学',
      icon: 'ri-building-2-line',
      description: '依托建筑学科优势，培养具备空间设计能力的建筑师。',
      skills: ['建筑设计', '城市设计', '历史建筑保护', '绿色建筑']
    },
    {
      name: '环境艺术设计',
      icon: 'ri-plant-line',
      description: '结合环境工程背景，培养生态环境与艺术设计兼备的专业人才。',
      skills: ['景观设计', '环境雕塑', '生态修复设计', '园林艺术']
    }
  ]
}

// 模拟课程体系数据 - 按学校ID分类
export const mockCourseSystemBySchool: Record<number, CourseGroup[]> = {
  // 清华大学 - 科技与艺术融合
  1: [
    {
      name: '通识基础课程',
      courses: ['设计素描', '色彩构成', '立体构成', '设计史论', '计算机辅助设计', '工程制图基础']
    },
    {
      name: '专业核心课程',
      courses: ['人机交互设计', '信息可视化', '用户体验设计', '产品系统设计', '设计研究方法', '数字化设计']
    },
    {
      name: '科技融合课程',
      courses: ['人工智能与设计', '虚拟现实技术', '算法艺术', '智能制造设计', '可持续设计', '设计伦理学']
    },
    {
      name: '实践项目课程',
      courses: ['创新设计工作坊', '企业合作项目', '国际设计竞赛', '跨学科项目', '毕业设计', '创业实践']
    }
  ],

  // 中央美术学院 - 传统艺术与现代设计
  2: [
    {
      name: '艺术基础课程',
      courses: ['素描写生', '色彩写生', '书法基础', '中国美术史', '西方美术史', '传统工艺']
    },
    {
      name: '设计理论课程',
      courses: ['设计概论', '视觉心理学', '文化创意理论', '艺术批评', '美学原理', '设计哲学']
    },
    {
      name: '专业技能课程',
      courses: ['传统图形设计', '现代设计方法', '材料与工艺', '数字艺术创作', '装置艺术', '策展实践']
    },
    {
      name: '创作实践课程',
      courses: ['艺术创作工作坊', '文化项目实践', '美术馆实习', '国际艺术交流', '个人创作项目', '艺术市场实践']
    }
  ],

  // 同济大学 - 建筑与设计结合
  3: [
    {
      name: '设计基础课程',
      courses: ['设计表达', '形态构成', '空间构成', '设计史', '建筑初步', '城市规划基础']
    },
    {
      name: '技术整合课程',
      courses: ['数字建造', '参数化设计', '结构与材料', '环境技术', '交通工具工程', '可持续技术']
    },
    {
      name: '创新设计课程',
      courses: ['服务设计', '社会创新设计', '城市设计', '智慧城市设计', '交互空间设计', '未来出行设计']
    },
    {
      name: '综合实践课程',
      courses: ['联合设计工作坊', '国际合作项目', '城市更新实践', '工程项目实习', '设计创业', '学术研究训练']
    }
  ],

  // 中国美术学院 - 传统工艺与当代艺术
  4: [
    {
      name: '传统技艺课程',
      courses: ['水墨基础', '书法篆刻', '传统陶艺', '丝网版画', '木刻版画', '传统染织']
    },
    {
      name: '当代艺术课程',
      courses: ['装置艺术', '影像艺术', '行为艺术', '新媒体艺术', '观念艺术', '公共艺术']
    },
    {
      name: '理论研究课程',
      courses: ['东方美学', '当代艺术理论', '文化人类学', '艺术社会学', '策展学', '艺术市场']
    },
    {
      name: '创作实验课程',
      courses: ['跨媒介创作', '田野调查项目', '驻地创作', '国际工作坊', '个人项目', '毕业创作']
    }
  ],

  // 广州美术学院 - 岭南文化与商业设计
  5: [
    {
      name: '文化基础课程',
      courses: ['岭南文化', '粤语文化', '传统工艺', '民间艺术', '岭南建筑', '广府文化']
    },
    {
      name: '商业设计课程',
      courses: ['品牌策略', '市场营销', '商业插画', '包装工程', '展示设计', '零售空间设计']
    },
    {
      name: '数字创意课程',
      courses: ['游戏美术', '动漫设计', '短视频制作', 'VR内容制作', '移动应用设计', '电商设计']
    },
    {
      name: '产业实践课程',
      courses: ['企业实习', '创意产业调研', '文创项目开发', '商业案例分析', '创业孵化', '大湾区设计实践']
    }
  ],

  // 江南大学 - 工业设计与用户体验
  6: [
    {
      name: '设计科学课程',
      courses: ['设计心理学', '人机工程学', '材料科学', '制造工艺', '系统设计', '设计管理']
    },
    {
      name: '用户体验课程',
      courses: ['用户研究', '交互设计', '服务设计', '体验设计', '设计策略', '商业模式设计']
    },
    {
      name: '技术应用课程',
      courses: ['3D建模与渲染', '产品工程', 'IoT产品设计', '智能制造', '绿色设计', '设计评估']
    },
    {
      name: '综合项目课程',
      courses: ['企业合作项目', '设计比赛', '专利申请实践', '产品商业化', '国际交流', '设计创新实验']
    }
  ],

  // 北京理工大学 - 工程技术与设计
  7: [
    {
      name: '工程基础课程',
      courses: ['工程制图', '机械基础', '电子技术', '材料工程', '制造工艺', '质量控制']
    },
    {
      name: '技术设计课程',
      courses: ['CAD/CAM技术', '逆向工程', '有限元分析', '虚拟样机', '数字化制造', '精密测量']
    },
    {
      name: '前沿技术课程',
      courses: ['人工智能应用', '机器人设计', '无人系统', '航空航天设计', '军工产品设计', '智能控制']
    },
    {
      name: '产业化课程',
      courses: ['技术转化', '产品认证', '知识产权', '项目管理', '工程伦理', '科技创业']
    }
  ],

  // 湖南大学 - 工业设计与文化传承
  8: [
    {
      name: '设计基础课程',
      courses: ['工业设计史', '造型基础', '色彩设计', '材料与工艺', '人机工程', '设计心理学']
    },
    {
      name: '汽车设计课程',
      courses: ['汽车造型设计', '汽车工程基础', '车身结构', '内饰设计', '概念车设计', '汽车品牌设计']
    },
    {
      name: '文化设计课程',
      courses: ['湖湘文化研究', '传统工艺复兴', '文化产品设计', '旅游纪念品设计', '非遗保护设计', '地方品牌设计']
    },
    {
      name: '实践创新课程',
      courses: ['汽车企业实习', '设计竞赛训练', '文化调研项目', '产学研合作', '设计创业实践', '国际交换项目']
    }
  ]
}

// 模拟专业数据
export const mockMajors: Major[] = []

// 模拟学院数据
export const mockFaculties: Faculty[] = []

// 模拟就业数据
export const mockEmployment: Employment[] = []

// 模拟获奖数据
export const mockAwards: Award[] = []

// 模拟成果数据
export const mockAchievements: Achievement[] = []

// 获取模拟院校数据的函数
export function getMockSchools(params?: {
  pageNum?: number
  pageSize?: number
  schoolName?: string
  schoolType?: string
  province?: string
  city?: string
  level?: string
  isKey?: boolean
  is985?: boolean
  is211?: boolean
  isDoubleFirst?: boolean
}) {
  let filteredSchools = [...mockSchools]

  // 应用筛选条件
  if (params?.schoolName) {
    filteredSchools = filteredSchools.filter(school =>
      school.schoolName.includes(params.schoolName!)
    )
  }

  if (params?.schoolType) {
    filteredSchools = filteredSchools.filter(school =>
      school.schoolType === params.schoolType
    )
  }

  if (params?.province) {
    filteredSchools = filteredSchools.filter(school =>
      school.province === params.province
    )
  }

  if (params?.city) {
    filteredSchools = filteredSchools.filter(school =>
      school.city === params.city
    )
  }

  if (params?.level) {
    filteredSchools = filteredSchools.filter(school =>
      school.level === params.level
    )
  }

  if (params?.isKey !== undefined) {
    filteredSchools = filteredSchools.filter(school =>
      school.isKey === params.isKey
    )
  }

  if (params?.is985 !== undefined) {
    filteredSchools = filteredSchools.filter(school =>
      school.is985 === params.is985
    )
  }

  if (params?.is211 !== undefined) {
    filteredSchools = filteredSchools.filter(school =>
      school.is211 === params.is211
    )
  }

  if (params?.isDoubleFirst !== undefined) {
    filteredSchools = filteredSchools.filter(school =>
      school.isDoubleFirst === params.isDoubleFirst
    )
  }

  // 分页
  const pageNum = params?.pageNum || 1
  const pageSize = params?.pageSize || 20
  const startIndex = (pageNum - 1) * pageSize
  const endIndex = startIndex + pageSize

  return {
    rows: filteredSchools.slice(startIndex, endIndex),
    total: filteredSchools.length,
    pageNum,
    pageSize
  }
}

// 根据ID获取院校详情
export function getMockSchoolById(id: number) {
  return mockSchools.find(school => school.id === id) || null
}

// 获取专业分类数据
export function getMockMajorCategories(schoolId?: number) {
  if (schoolId && mockMajorCategoriesBySchool[schoolId]) {
    return mockMajorCategoriesBySchool[schoolId]
  }
  // 返回清华大学的数据作为默认值
  return mockMajorCategoriesBySchool[1]
}

// 获取课程体系数据
export function getMockCourseSystem(schoolId?: number) {
  if (schoolId && mockCourseSystemBySchool[schoolId]) {
    return mockCourseSystemBySchool[schoolId]
  }
  // 返回清华大学的数据作为默认值
  return mockCourseSystemBySchool[1]
}

// 师资统计数据结构
interface FacultyStatsData {
  totalFaculty: number
  professors: number
  doctorDegree: number
  overseasBackground: number
  description: string
}

// 教师信息数据结构
interface TeacherData {
  id: number
  name: string
  title: string
  expertise: string[]
  description: string
}

// 模拟师资统计数据 - 按学校ID分类
export const mockFacultyStatsBySchool: Record<number, FacultyStatsData> = {
  1: { // 清华大学
    totalFaculty: 68,
    professors: 42,
    doctorDegree: 53,
    overseasBackground: 35,
    description: '清华大学美术学院设计系拥有一支高水平的师资队伍，包括长江学者特聘教授2名，国家杰出青年基金获得者3名，国家级教学名师2名。教师团队中有多位在国际设计领域具有重要影响力的专家学者，以及来自行业一线的兼职教师。学院注重教师的国际交流与合作，定期邀请国际知名设计师和学者来校讲学。'
  },
  2: { // 中央美术学院
    totalFaculty: 95,
    professors: 58,
    doctorDegree: 67,
    overseasBackground: 42,
    description: '中央美术学院设计学院汇聚了国内外顶尖的艺术与设计人才，拥有中国美术家协会理事12名，国际平面设计联盟(AGI)会员3名。师资队伍中既有在传统艺术领域造诣深厚的艺术大师，也有活跃在当代设计前沿的青年学者。学院与世界各大美术学院建立了广泛的交流合作关系。'
  },
  3: { // 同济大学
    totalFaculty: 75,
    professors: 48,
    doctorDegree: 61,
    overseasBackground: 38,
    description: '同济大学设计创意学院师资力量雄厚，拥有国家级教学团队1个，教育部新世纪优秀人才4名。学院注重产学研结合，多位教师担任国际知名企业设计顾问。师资队伍具有深厚的工程背景和国际视野，在可持续设计、智慧城市设计等领域具有重要影响力。'
  },
  4: { // 中国美术学院
    totalFaculty: 120,
    professors: 72,
    doctorDegree: 89,
    overseasBackground: 51,
    description: '中国美术学院设计艺术学院拥有深厚的学术传统和卓越的师资力量，包括国务院学科评议组成员、全国艺术专业学位研究生教育指导委员会委员等学术带头人。学院师资在传统工艺传承与当代艺术创新方面具有独特优势，多位教师作品被国内外重要美术馆收藏。'
  },
  5: { // 广州美术学院
    totalFaculty: 85,
    professors: 51,
    doctorDegree: 64,
    overseasBackground: 35,
    description: '广州美术学院设计学院立足岭南文化，面向粤港澳大湾区，拥有一支具有地域特色和国际视野的师资队伍。学院与港澳台地区以及海外设计院校建立了密切的合作关系，多位教师具有海外留学或工作背景，在文化创意产业和商业设计领域具有丰富经验。'
  },
  6: { // 江南大学
    totalFaculty: 92,
    professors: 56,
    doctorDegree: 71,
    overseasBackground: 48,
    description: '江南大学设计学院师资力量雄厚，拥有国家级教学名师1名，教育部新世纪优秀人才5名，江苏省教学名师3名。学院在工业设计领域具有深厚积淀，师资队伍实践经验丰富，与众多知名企业建立了长期合作关系，在用户体验设计和智能产品设计方面处于国内领先地位。'
  },
  7: { // 北京理工大学
    totalFaculty: 78,
    professors: 45,
    doctorDegree: 58,
    overseasBackground: 32,
    description: '北京理工大学设计与艺术学院依托学校强大的工程技术背景，形成了独特的"技术+艺术"师资特色。学院拥有国防科技创新团队1个，多位教师具有军工企业工作背景。师资队伍在智能装备设计、航空航天设计等高科技领域具有显著优势。'
  },
  8: { // 湖南大学
    totalFaculty: 88,
    professors: 52,
    doctorDegree: 66,
    overseasBackground: 36,
    description: '湖南大学设计艺术学院历史悠久，师资力量深厚，拥有国家级教学团队1个，湖南省芙蓉学者特聘教授2名。学院在汽车造型设计和工业设计领域具有传统优势，与国内外汽车企业建立了广泛合作，师资队伍实践经验丰富，在设计教育和产业应用方面成果显著。'
  }
}

// 模拟代表性教师数据 - 按学校ID分类
export const mockFacultyMembersBySchool: Record<number, TeacherData[]> = {
  1: [ // 清华大学
    {
      id: 1,
      name: '张松鹤',
      title: '教授 / 博士生导师',
      expertise: ['信息设计', '交互设计'],
      description: '前苹果公司首席设计师，在人机交互和信息可视化领域具有重要贡献，主导多项国家重大科技项目。'
    },
    {
      id: 2,
      name: '李江华',
      title: '教授 / 博士生导师',
      expertise: ['智能制造', '产品系统设计'],
      description: '国家杰出青年基金获得者，在智能制造和数字化设计领域贡献突出，拥有发明专利30余项。'
    },
    {
      id: 3,
      name: '王明非',
      title: '副教授 / 硕士生导师',
      expertise: ['可持续设计', '设计研究'],
      description: '联合国可持续发展目标设计顾问，在绿色设计和循环经济领域具有深入研究。'
    }
  ],
  2: [ // 中央美术学院
    {
      id: 1,
      name: '陈雅玲',
      title: '教授 / 博士生导师',
      expertise: ['传统图形', '文化设计'],
      description: '中国美术家协会理事，在传统文化的当代表达方面造诣深厚，作品被多家国际博物馆收藏。'
    },
    {
      id: 2,
      name: '刘德华',
      title: '教授 / 博士生导师',
      expertise: ['新媒体艺术', '数字影像'],
      description: '威尼斯双年展参展艺术家，在新媒体艺术和当代艺术理论研究方面具有国际影响力。'
    },
    {
      id: 3,
      name: '张艺苑',
      title: '副教授 / 硕士生导师',
      expertise: ['装置艺术', '策展实践'],
      description: '独立策展人，曾策划多个重要国际艺术展览，在当代艺术策展领域具有丰富经验。'
    }
  ],
  3: [ // 同济大学
    {
      id: 1,
      name: '林建国',
      title: '教授 / 博士生导师',
      expertise: ['交通工具设计', '可持续设计'],
      description: '曾任奔驰设计中心高级设计师，在新能源汽车设计和智慧出行领域具有前瞻性研究。'
    },
    {
      id: 2,
      name: '周晓雯',
      title: '教授 / 博士生导师',
      expertise: ['城市设计', '公共空间'],
      description: '联合国人居署顾问专家，在城市更新和公共空间设计方面具有重要贡献。'
    },
    {
      id: 3,
      name: '高志强',
      title: '副教授 / 硕士生导师',
      expertise: ['服务设计', '社会创新'],
      description: 'IDEO设计顾问，在服务设计和社会创新方面具有丰富的国际项目经验。'
    }
  ],
  4: [ // 中国美术学院
    {
      id: 1,
      name: '许江山',
      title: '教授 / 博士生导师',
      expertise: ['陶瓷艺术', '传统工艺'],
      description: '中国陶瓷艺术大师，在传统陶瓷工艺的当代转换方面具有突出贡献。'
    },
    {
      id: 2,
      name: '钱梦洁',
      title: '教授 / 博士生导师',
      expertise: ['纤维艺术', '材料研究'],
      description: '国际纤维艺术三年展评委，在纤维材料创新和艺术表达方面具有独特建树。'
    },
    {
      id: 3,
      name: '孙文华',
      title: '副教授 / 硕士生导师',
      expertise: ['书法设计', '汉字文化'],
      description: '中国书法家协会会员，在汉字文化的设计应用和理论研究方面成果丰硕。'
    }
  ],
  5: [ // 广州美术学院
    {
      id: 1,
      name: '黄志明',
      title: '教授 / 博士生导师',
      expertise: ['岭南文化', '品牌设计'],
      description: '岭南文化研究专家，为多个知名品牌提供文化设计咨询，在区域文化品牌化方面经验丰富。'
    },
    {
      id: 2,
      name: '吴彩霞',
      title: '教授 / 博士生导师',
      expertise: ['游戏美术', '数字娱乐'],
      description: '前腾讯游戏艺术总监，在游戏美术和数字娱乐产业方面具有深厚的行业背景。'
    },
    {
      id: 3,
      name: '梁启超',
      title: '副教授 / 硕士生导师',
      expertise: ['包装设计', '商业设计'],
      description: '曾任奥美广告创意总监，在包装设计和商业创意方面具有丰富的实战经验。'
    }
  ],
  6: [ // 江南大学
    {
      id: 1,
      name: '田飞龙',
      title: '教授 / 博士生导师',
      expertise: ['用户体验', '设计研究'],
      description: '国际用户体验专家协会理事，在用户研究和体验设计方法论方面具有重要贡献。'
    },
    {
      id: 2,
      name: '苏雅丽',
      title: '教授 / 博士生导师',
      expertise: ['智能产品', '物联网设计'],
      description: '智能制造领域专家，在IoT产品设计和智能家居系统方面具有丰富的项目经验。'
    },
    {
      id: 3,
      name: '马建华',
      title: '副教授 / 硕士生导师',
      expertise: ['可持续设计', '绿色制造'],
      description: '绿色设计联盟专家委员，在可持续设计和循环经济模式创新方面具有深入研究。'
    }
  ],
  7: [ // 北京理工大学
    {
      id: 1,
      name: '张军辉',
      title: '教授 / 博士生导师',
      expertise: ['军工设计', '精密仪器'],
      description: '国防科技创新团队带头人，在军工产品设计和精密仪器开发方面具有重要贡献。'
    },
    {
      id: 2,
      name: '李雪梅',
      title: '教授 / 博士生导师',
      expertise: ['人工智能', '智能制造'],
      description: 'AI设计实验室主任，在人工智能辅助设计和智能制造系统方面具有前沿研究。'
    },
    {
      id: 3,
      name: '王立新',
      title: '副教授 / 硕士生导师',
      expertise: ['航空设计', '系统工程'],
      description: '航空工业集团设计顾问，在航空器设计和复杂系统工程方面经验丰富。'
    }
  ],
  8: [ // 湖南大学
    {
      id: 1,
      name: '何志华',
      title: '教授 / 博士生导师',
      expertise: ['汽车设计', '造型设计'],
      description: '曾任上汽集团首席设计师，在汽车造型设计和品牌塑造方面具有丰富的行业经验。'
    },
    {
      id: 2,
      name: '赵美玲',
      title: '教授 / 博士生导师',
      expertise: ['工业设计', '创新方法'],
      description: '工业设计方法论专家，在设计思维和创新流程优化方面具有深入研究。'
    },
    {
      id: 3,
      name: '刘子明',
      title: '副教授 / 硕士生导师',
      expertise: ['交通设计', '未来出行'],
      description: '智能交通系统设计专家，在未来出行方式和交通工具创新设计方面具有前瞻研究。'
    }
  ]
}

// 获取师资统计数据
export function getMockFacultyStats(schoolId?: number) {
  if (schoolId && mockFacultyStatsBySchool[schoolId]) {
    return mockFacultyStatsBySchool[schoolId]
  }
  // 返回清华大学的数据作为默认值
  return mockFacultyStatsBySchool[1]
}

// 获取代表性教师数据
export function getMockFacultyMembers(schoolId?: number) {
  if (schoolId && mockFacultyMembersBySchool[schoolId]) {
    return mockFacultyMembersBySchool[schoolId]
  }
  // 返回清华大学的数据作为默认值
  return mockFacultyMembersBySchool[1]
}

// 就业概况数据结构
interface EmploymentStatsData {
  employmentRate: string
  averageSalary: string
  furtherStudyRate: string
  overseasEmploymentRate: string
  description: string
}

// 雇主信息数据结构
interface EmployerData {
  id: number
  name: string
  industry: string
}

// 图表数据结构
interface ChartData {
      industryData: Array<{ value: number; name: string }>
  salaryData: number[]
  salaryLabels: string[]
}

// 模拟就业概况数据 - 按学校ID分类
export const mockEmploymentStatsBySchool: Record<number, EmploymentStatsData> = {
  1: { // 清华大学
    employmentRate: '96.8%',
    averageSalary: '18.5K',
    furtherStudyRate: '38.2%',
    overseasEmploymentRate: '22.1%',
    description: '清华大学设计系毕业生就业情况良好，就业率常年保持在95%以上。毕业生主要就业方向包括互联网科技公司、设计咨询公司、广告传媒机构、高校及研究机构等。近年来，随着设计与科技的深度融合，越来越多的毕业生选择在科技企业从事用户体验设计、交互设计等工作，也有部分学生选择自主创业。'
  },
  2: { // 中央美术学院
    employmentRate: '94.3%',
    averageSalary: '16.8K',
    furtherStudyRate: '42.6%',
    overseasEmploymentRate: '28.7%',
    description: '中央美术学院设计学院毕业生在艺术与设计领域享有极高声誉，就业前景广阔。主要就业去向包括美术馆、画廊、文化创意机构、影视制作公司、出版社等。许多毕业生选择继续深造或海外留学，也有不少成为独立艺术家或设计师，在国内外艺术市场具有重要影响力。'
  },
  3: { // 同济大学
    employmentRate: '95.7%',
    averageSalary: '17.2K',
    furtherStudyRate: '35.4%',
    overseasEmploymentRate: '19.8%',
    description: '同济大学设计创意学院毕业生凭借扎实的工程背景和创新设计能力，在就业市场上具有独特优势。主要就业领域包括汽车设计、建筑设计、城市规划、工业设计等。许多毕业生进入世界500强企业担任设计职务，也有部分选择在设计咨询公司或自主创业。'
  },
  4: { // 中国美术学院
    employmentRate: '92.1%',
    averageSalary: '15.6K',
    furtherStudyRate: '45.3%',
    overseasEmploymentRate: '31.2%',
    description: '中国美术学院设计艺术学院毕业生在传统工艺与当代设计结合方面具有独特优势。主要就业方向包括文化创意产业、工艺美术企业、设计工作室、教育机构等。学院注重培养学生的艺术修养和文化内涵，许多毕业生成为具有影响力的艺术家和设计师。'
  },
  5: { // 广州美术学院
    employmentRate: '93.8%',
    averageSalary: '14.9K',
    furtherStudyRate: '28.7%',
    overseasEmploymentRate: '15.4%',
    description: '广州美术学院设计学院毕业生立足粤港澳大湾区，在文化创意产业和商业设计领域具有显著优势。主要就业方向包括游戏公司、动漫制作、广告设计、包装设计、电商平台等。许多毕业生选择在深圳、广州等一线城市发展，也有部分进入港澳地区工作。'
  },
  6: { // 江南大学
    employmentRate: '97.2%',
    averageSalary: '16.3K',
    furtherStudyRate: '31.8%',
    overseasEmploymentRate: '17.6%',
    description: '江南大学设计学院毕业生在工业设计和用户体验设计领域具有显著优势，就业率连续多年保持在95%以上。主要就业方向包括制造业企业、互联网公司、设计咨询机构等。许多毕业生进入华为、小米、海尔等知名企业担任设计师职务，薪资水平在同类院校中处于领先地位。'
  },
  7: { // 北京理工大学
    employmentRate: '96.5%',
    averageSalary: '17.8K',
    furtherStudyRate: '33.7%',
    overseasEmploymentRate: '16.9%',
    description: '北京理工大学设计与艺术学院毕业生凭借强大的工程技术背景，在高科技设计领域具有独特竞争力。主要就业方向包括航空航天企业、军工集团、科技公司、精密仪器制造等。许多毕业生进入中科院、航天科技、兵器工业等国家重点单位，在国防科技设计领域发挥重要作用。'
  },
  8: { // 湖南大学
    employmentRate: '95.1%',
    averageSalary: '16.7K',
    furtherStudyRate: '29.3%',
    overseasEmploymentRate: '14.2%',
    description: '湖南大学设计艺术学院毕业生在汽车设计和工业设计领域享有盛誉，就业前景良好。主要就业方向包括汽车制造企业、工程机械公司、家电制造、设计咨询等。许多毕业生进入上汽、一汽、广汽、三一重工等知名企业，在汽车造型设计和工业产品设计方面具有重要影响力。'
  }
}

// 模拟代表性雇主数据 - 按学校ID分类
export const mockEmployersBySchool: Record<number, EmployerData[]> = {
  1: [ // 清华大学
    { id: 1, name: '苹果', industry: '国际科技' },
    { id: 2, name: '谷歌', industry: '国际科技' },
    { id: 3, name: '微软', industry: '国际科技' },
    { id: 4, name: '腾讯', industry: '互联网科技' },
    { id: 5, name: '字节跳动', industry: '互联网科技' },
    { id: 6, name: 'IDEO', industry: '设计咨询' },
    { id: 7, name: '华为', industry: '通信科技' },
    { id: 8, name: '中科院', industry: '科研院所' }
  ],
  2: [ // 中央美术学院
    { id: 1, name: '故宫博物院', industry: '文化机构' },
    { id: 2, name: '中国美术馆', industry: '文化机构' },
    { id: 3, name: '央视', industry: '传媒机构' },
    { id: 4, name: '凤凰传媒', industry: '传媒机构' },
    { id: 5, name: '奥美', industry: '广告创意' },
    { id: 6, name: '正大制作', industry: '影视制作' },
    { id: 7, name: '嘉德拍卖', industry: '艺术市场' },
    { id: 8, name: '当代艺术馆', industry: '艺术机构' }
  ],
  3: [ // 同济大学
    { id: 1, name: '奔驰设计', industry: '汽车设计' },
    { id: 2, name: '宝马集团', industry: '汽车设计' },
    { id: 3, name: 'IDEO', industry: '设计咨询' },
    { id: 4, name: '腾讯', industry: '互联网科技' },
    { id: 5, name: '上海建工', industry: '建筑设计' },
    { id: 6, name: '华建集团', industry: '建筑设计' },
    { id: 7, name: '迪士尼', industry: '娱乐设计' },
    { id: 8, name: '上汽集团', industry: '汽车制造' }
  ],
  4: [ // 中国美术学院
    { id: 1, name: '浙江博物馆', industry: '文化机构' },
    { id: 2, name: '西湖艺术馆', industry: '艺术机构' },
    { id: 3, name: '阿里巴巴', industry: '互联网科技' },
    { id: 4, name: '网易', industry: '互联网科技' },
    { id: 5, name: '朵云轩', industry: '传统工艺' },
    { id: 6, name: '景德镇陶瓷', industry: '传统工艺' },
    { id: 7, name: '天猫设计', industry: '电商设计' },
    { id: 8, name: '今日头条', industry: '新媒体' }
  ],
  5: [ // 广州美术学院
    { id: 1, name: '腾讯游戏', industry: '游戏设计' },
    { id: 2, name: '网易游戏', industry: '游戏设计' },
    { id: 3, name: '奥飞娱乐', industry: '动漫制作' },
    { id: 4, name: '美的集团', industry: '家电设计' },
    { id: 5, name: '比亚迪', industry: '汽车设计' },
    { id: 6, name: '华为', industry: '通信科技' },
    { id: 7, name: '字节跳动', industry: '互联网科技' },
    { id: 8, name: '正佳集团', industry: '商业设计' }
  ],
  6: [ // 江南大学
    { id: 1, name: '海尔集团', industry: '家电制造' },
    { id: 2, name: '美的集团', industry: '家电制造' },
    { id: 3, name: '小米科技', industry: '消费电子' },
    { id: 4, name: '华为', industry: '通信科技' },
    { id: 5, name: '腾讯', industry: '互联网科技' },
    { id: 6, name: '阿里巴巴', industry: '互联网科技' },
    { id: 7, name: 'OPPO', industry: '消费电子' },
    { id: 8, name: 'vivo', industry: '消费电子' }
  ],
  7: [ // 北京理工大学
    { id: 1, name: '中科院', industry: '科研院所' },
    { id: 2, name: '航天科技', industry: '航空航天' },
    { id: 3, name: '兵器工业', industry: '军工企业' },
    { id: 4, name: '华为', industry: '通信科技' },
    { id: 5, name: '小米', industry: '消费电子' },
    { id: 6, name: '字节跳动', industry: '互联网科技' },
    { id: 7, name: '中船重工', industry: '重工制造' },
    { id: 8, name: '大疆创新', industry: '无人机' }
  ],
  8: [ // 湖南大学
    { id: 1, name: '上汽集团', industry: '汽车制造' },
    { id: 2, name: '一汽集团', industry: '汽车制造' },
    { id: 3, name: '广汽集团', industry: '汽车制造' },
    { id: 4, name: '比亚迪', industry: '新能源汽车' },
    { id: 5, name: '三一重工', industry: '工程机械' },
    { id: 6, name: '中联重科', industry: '工程机械' },
    { id: 7, name: '华为', industry: '通信科技' },
    { id: 8, name: '腾讯', industry: '互联网科技' }
  ]
}

// 模拟图表数据 - 按学校ID分类
export const mockChartDataBySchool: Record<number, ChartData> = {
  1: { // 清华大学 - 偏向科技互联网，高薪资
    industryData: [
              { value: 45, name: '互联网科技' },
        { value: 18, name: '设计咨询' },
        { value: 15, name: '高校研究' },
        { value: 12, name: '国际企业' },
        { value: 10, name: '其他行业' }
    ],
    salaryData: [2, 8, 15, 35, 25, 15],
    salaryLabels: ['8K-', '8-12K', '12-15K', '15-20K', '20-25K', '25K+']
  },
  2: { // 中央美术学院 - 偏向文化艺术，薪资分布较为平均
    industryData: [
              { value: 35, name: '文化艺术' },
        { value: 25, name: '广告传媒' },
        { value: 20, name: '教育培训' },
        { value: 12, name: '互联网科技' },
        { value: 8, name: '其他行业' }
    ],
    salaryData: [8, 18, 30, 25, 15, 4],
    salaryLabels: ['8K-', '8-12K', '12-15K', '15-20K', '20-25K', '25K+']
  },
  3: { // 同济大学 - 汽车设计和建筑设计强，中高薪资
    industryData: [
              { value: 30, name: '汽车设计' },
        { value: 25, name: '建筑设计' },
        { value: 20, name: '互联网科技' },
        { value: 15, name: '设计咨询' },
        { value: 10, name: '其他行业' }
    ],
    salaryData: [3, 10, 20, 35, 22, 10],
    salaryLabels: ['8K-', '8-12K', '12-15K', '15-20K', '20-25K', '25K+']
  },
  4: { // 中国美术学院 - 传统工艺与当代艺术
    industryData: [
      { value: 40, name: '文化创意' },
      { value: 22, name: '传统工艺' },
      { value: 18, name: '教育培训' },
      { value: 12, name: '互联网科技' },
      { value: 8, name: '其他行业' }
    ],
    salaryData: [12, 22, 28, 22, 12, 4],
    salaryLabels: ['8K-', '8-12K', '12-15K', '15-20K', '20-25K', '25K+']
  },
  5: { // 广州美术学院 - 游戏动漫和商业设计
    industryData: [
      { value: 32, name: '游戏动漫' },
      { value: 28, name: '商业设计' },
      { value: 20, name: '互联网科技' },
      { value: 12, name: '广告传媒' },
      { value: 8, name: '其他行业' }
    ],
    salaryData: [6, 15, 28, 30, 18, 3],
    salaryLabels: ['8K-', '8-12K', '12-15K', '15-20K', '20-25K', '25K+']
  },
  6: { // 江南大学 - 工业设计强校，就业率高
    industryData: [
      { value: 38, name: '制造业设计' },
      { value: 25, name: '互联网科技' },
      { value: 18, name: '消费电子' },
      { value: 12, name: '设计咨询' },
      { value: 7, name: '其他行业' }
    ],
    salaryData: [4, 12, 25, 32, 20, 7],
    salaryLabels: ['8K-', '8-12K', '12-15K', '15-20K', '20-25K', '25K+']
  },
  7: { // 北京理工大学 - 高科技领域，高薪资
    industryData: [
      { value: 35, name: '科技制造' },
      { value: 25, name: '国防科技' },
      { value: 20, name: '互联网科技' },
      { value: 12, name: '精密仪器' },
      { value: 8, name: '其他行业' }
    ],
    salaryData: [2, 6, 18, 30, 28, 16],
    salaryLabels: ['8K-', '8-12K', '12-15K', '15-20K', '20-25K', '25K+']
  },
  8: { // 湖南大学 - 汽车设计见长
    industryData: [
      { value: 40, name: '汽车制造' },
      { value: 22, name: '工程机械' },
      { value: 18, name: '互联网科技' },
      { value: 12, name: '设计咨询' },
      { value: 8, name: '其他行业' }
    ],
    salaryData: [5, 14, 26, 30, 20, 5],
    salaryLabels: ['8K-', '8-12K', '12-15K', '15-20K', '20-25K', '25K+']
  }
}

// 模拟图表数据（默认数据，用于兼容）
export const mockChartData: ChartData = {
  industryData: [
    { value: 42, name: '互联网科技' },
    { value: 23, name: '设计咨询' },
    { value: 15, name: '广告传媒' },
    { value: 12, name: '高校研究' },
    { value: 8, name: '其他行业' }
  ],
  salaryData: [5, 12, 25, 30, 18, 10],
  salaryLabels: ['8K-', '8-12K', '12-15K', '15-20K', '20-25K', '25K+']
}

// 获取就业概况数据
export function getMockEmploymentStats(schoolId?: number) {
  if (schoolId && mockEmploymentStatsBySchool[schoolId]) {
    return mockEmploymentStatsBySchool[schoolId]
  }
  // 返回清华大学的数据作为默认值
  return mockEmploymentStatsBySchool[1]
}

// 获取代表性雇主数据
export function getMockEmployers(schoolId?: number) {
  if (schoolId && mockEmployersBySchool[schoolId]) {
    return mockEmployersBySchool[schoolId]
  }
  // 返回清华大学的数据作为默认值
  return mockEmployersBySchool[1]
}

// 获取图表数据
export function getMockChartData(schoolId?: number) {
  if (schoolId && mockChartDataBySchool[schoolId]) {
    return mockChartDataBySchool[schoolId]
  }
  // 返回清华大学的数据作为默认值
  return mockChartDataBySchool[1] || mockChartData
}

// 学生成果数据结构
interface AchievementStatsData {
  internationalAwards: number
  nationalAwards: number
  provincialAwards: number
  patents: number
  description: string
}

// 获奖趋势数据结构
interface TrendData {
  years: string[]
  internationalData: number[]
  nationalData: number[]
  provincialData: number[]
}

// 获奖作品数据结构
interface AwardWorkData {
  id: number
  title: string
  award: string
  description: string
}

// 模拟学生成果统计数据 - 按学校ID分类
export const mockAchievementStatsBySchool: Record<number, AchievementStatsData> = {
  1: { // 清华大学
    internationalAwards: 126,
    nationalAwards: 287,
    provincialAwards: 453,
    patents: 192,
    description: '清华大学设计系学生在国内外各类设计竞赛中表现突出，近五年来获得红点设计奖、IF设计奖、IDEA设计奖等国际知名设计奖项126项，国家级学科竞赛奖项287项。学生作品多次入选国内外重要设计展览，部分优秀设计成果已实现产业化转化。'
  },
  2: { // 中央美术学院
    internationalAwards: 89,
    nationalAwards: 195,
    provincialAwards: 328,
    patents: 67,
    description: '中央美术学院设计学院学生在国际艺术与设计竞赛中屡获殊荣，作品在威尼斯双年展、卡塞尔文献展等重要展览中展出。学生在传统工艺复兴、当代艺术创作等领域表现优异，多项作品被国内外重要美术馆收藏。'
  },
  3: { // 同济大学
    internationalAwards: 98,
    nationalAwards: 234,
    provincialAwards: 387,
    patents: 156,
    description: '同济大学设计创意学院学生在国际设计竞赛中成绩斐然，特别在可持续设计、城市创新、交通工具设计等领域获得广泛认可。学生作品在米兰设计周、荷兰设计周等国际设计展上频频亮相，体现了学院的国际化教学水平。'
  },
  4: { // 中国美术学院
    internationalAwards: 76,
    nationalAwards: 168,
    provincialAwards: 295,
    patents: 45,
    description: '中国美术学院设计艺术学院学生传承学院深厚的艺术传统，在传统工艺创新、当代艺术表达等方面独树一帜。学生作品在国际陶艺双年展、亚洲纤维艺术展等专业展览中获得重要奖项，展现了东方美学的当代价值。'
  },
  5: { // 广州美术学院
    internationalAwards: 52,
    nationalAwards: 145,
    provincialAwards: 267,
    patents: 38,
    description: '广州美术学院设计学院学生立足粤港澳大湾区，在商业设计、数字创意等领域表现出色。学生作品在亚洲数字艺术大奖、粤港澳设计展等区域性竞赛中获得优异成绩，体现了岭南文化的创新活力。'
  },
  6: { // 江南大学
    internationalAwards: 134,
    nationalAwards: 298,
    provincialAwards: 421,
    patents: 203,
    description: '江南大学设计学院学生在工业设计和用户体验设计领域表现卓越，连续多年在国际顶级设计竞赛中获奖。学生作品在红点设计奖、IF设计奖等国际竞赛中屡获殊荣，多项设计成果实现产业化应用，体现了设计的实用价值。'
  },
  7: { // 北京理工大学
    internationalAwards: 67,
    nationalAwards: 156,
    provincialAwards: 234,
    patents: 187,
    description: '北京理工大学设计与艺术学院学生凭借强大的技术背景，在高科技设计领域独占鳌头。学生作品在国际工业设计竞赛、科技创新大赛中频获大奖，特别在航空航天设计、军工产品设计等专业领域具有显著优势。'
  },
  8: { // 湖南大学
    internationalAwards: 78,
    nationalAwards: 189,
    provincialAwards: 312,
    patents: 142,
    description: '湖南大学设计艺术学院学生在汽车设计和工业设计领域成绩突出，作品在国际汽车设计竞赛中多次获奖。学生设计作品体现了深厚的工程底蕴和创新思维，多项成果与知名汽车企业建立合作，实现了学术与产业的良性互动。'
  }
}

// 模拟获奖趋势数据 - 按学校ID分类
export const mockTrendDataBySchool: Record<number, TrendData> = {
  1: { // 清华大学 - 稳步增长，国际奖项优势明显
    years: ['2019', '2020', '2021', '2022', '2023', '2024'],
    internationalData: [18, 22, 26, 28, 25, 27],
    nationalData: [45, 48, 52, 56, 53, 57],
    provincialData: [72, 78, 84, 82, 78, 85]
  },
  2: { // 中央美术学院 - 艺术类奖项稳定增长
    years: ['2019', '2020', '2021', '2022', '2023', '2024'],
    internationalData: [12, 15, 18, 20, 17, 19],
    nationalData: [28, 32, 36, 39, 35, 38],
    provincialData: [48, 55, 62, 58, 52, 56]
  },
  3: { // 同济大学 - 设计类竞赛表现优异
    years: ['2019', '2020', '2021', '2022', '2023', '2024'],
    internationalData: [14, 17, 21, 24, 22, 24],
    nationalData: [35, 39, 43, 47, 44, 46],
    provincialData: [58, 65, 72, 69, 65, 68]
  },
  4: { // 中国美术学院 - 传统文化类奖项突出
    years: ['2019', '2020', '2021', '2022', '2023', '2024'],
    internationalData: [10, 13, 16, 18, 15, 17],
    nationalData: [24, 28, 32, 35, 31, 34],
    provincialData: [42, 48, 55, 52, 47, 51]
  },
  5: { // 广州美术学院 - 商业设计奖项增长
    years: ['2019', '2020', '2021', '2022', '2023', '2024'],
    internationalData: [8, 11, 14, 16, 13, 15],
    nationalData: [22, 26, 30, 33, 29, 32],
    provincialData: [38, 44, 51, 48, 43, 47]
  },
  6: { // 江南大学 - 工业设计奖项领先
    years: ['2019', '2020', '2021', '2022', '2023', '2024'],
    internationalData: [20, 24, 28, 31, 28, 30],
    nationalData: [48, 52, 56, 62, 58, 61],
    provincialData: [75, 82, 89, 86, 81, 86]
  },
  7: { // 北京理工大学 - 科技类奖项优势
    years: ['2019', '2020', '2021', '2022', '2023', '2024'],
    internationalData: [11, 14, 17, 19, 16, 18],
    nationalData: [26, 30, 34, 37, 33, 36],
    provincialData: [38, 44, 48, 45, 41, 44]
  },
  8: { // 湖南大学 - 汽车设计奖项突出
    years: ['2019', '2020', '2021', '2022', '2023', '2024'],
    internationalData: [13, 16, 19, 21, 18, 20],
    nationalData: [28, 32, 36, 39, 35, 38],
    provincialData: [45, 52, 58, 55, 50, 54]
  }
}

// 模拟获奖趋势数据（默认数据，用于兼容）
export const mockTrendData: TrendData = {
  years: ['2019', '2020', '2021', '2022', '2023', '2024'],
  internationalData: [15, 18, 22, 25, 23, 23],
  nationalData: [42, 45, 48, 52, 49, 51],
  provincialData: [68, 75, 82, 78, 74, 76]
}

// 模拟代表性获奖作品数据 - 按学校ID分类
export const mockAwardWorksBySchool: Record<number, AwardWorkData[]> = {
  1: [ // 清华大学
    {
      id: 1,
      title: '「循迹」智能导盲系统',
      award: '2024 红点设计奖 · 最佳设计奖',
      description: '基于计算机视觉和触觉反馈的创新型导盲设备，为视障人士提供更安全、便捷的出行体验。'
    },
    {
      id: 2,
      title: '「量子」交互界面设计',
      award: '2023 IF设计奖 · 交互设计金奖',
      description: '面向量子计算时代的用户界面设计，通过创新的视觉语言让复杂的量子概念变得易懂。'
    },
    {
      id: 3,
      title: '「智链」区块链可视化系统',
      award: '2023 IDEA设计奖 · 银奖',
      description: '将抽象的区块链技术通过直观的视觉化设计呈现，帮助用户理解去中心化金融概念。'
    }
  ],
  2: [ // 中央美术学院
    {
      id: 1,
      title: '「古韵新声」传统文化复兴计划',
      award: '2024 威尼斯双年展 · 金狮奖',
      description: '通过当代艺术手法重新诠释中国传统文化符号，在国际舞台展现东方美学的时代价值。'
    },
    {
      id: 2,
      title: '「山水间」数字影像装置',
      award: '2023 卡塞尔文献展 · 特别提名奖',
      description: '融合传统山水画与新媒体技术，创造出诗意而富有哲思的沉浸式艺术体验。'
    },
    {
      id: 3,
      title: '「器韵」陶瓷艺术系列',
      award: '2023 国际陶艺双年展 · 金奖',
      description: '在传统陶瓷工艺基础上融入当代设计理念，展现中华文化的深厚底蕴和时代活力。'
    }
  ],
  3: [ // 同济大学
    {
      id: 1,
      title: '「未来出行」可持续交通系统',
      award: '2024 米兰设计周 · 最佳概念奖',
      description: '整合城市规划、交通工具和服务设计的综合性可持续出行解决方案。'
    },
    {
      id: 2,
      title: '「绿洲」城市更新设计',
      award: '2023 威尼斯建筑双年展 · 金狮奖',
      description: '通过生态设计理念改造城市废弃空间，为都市居民创造绿色宜居的生活环境。'
    },
    {
      id: 3,
      title: '「智慧城市」服务设计平台',
      award: '2023 红点设计奖 · 概念设计奖',
      description: '运用服务设计思维构建智慧城市生态系统，提升城市管理效率和居民生活质量。'
    }
  ],
  4: [ // 中国美术学院
    {
      id: 1,
      title: '「丝路印象」纤维艺术作品',
      award: '2024 国际纤维艺术三年展 · 大奖',
      description: '以丝绸之路为主题的大型纤维装置，展现东西方文化交流的历史脉络和当代意义。'
    },
    {
      id: 2,
      title: '「水墨新境」数字绘画系统',
      award: '2023 亚洲数字艺术奖 · 创新奖',
      description: '将传统水墨画技法与数字技术结合，为水墨艺术的传承与发展开辟新的可能性。'
    },
    {
      id: 3,
      title: '「匠心」传统工艺复兴项目',
      award: '2023 联合国教科文组织 · 文化遗产保护奖',
      description: '通过设计介入保护和传承濒危传统工艺，让古老技艺在当代社会焕发新的生命力。'
    }
  ],
  5: [ // 广州美术学院
    {
      id: 1,
      title: '「粤韵」岭南文化品牌设计',
      award: '2024 亚洲品牌设计奖 · 金奖',
      description: '提取岭南文化精髓，为粤港澳大湾区文化产业打造具有地域特色的品牌形象。'
    },
    {
      id: 2,
      title: '「次元世界」游戏美术设计',
      award: '2023 独立游戏节 · 最佳视觉奖',
      description: '融合中华传统文化元素与现代数字艺术，创造出独具特色的游戏视觉体验。'
    },
    {
      id: 3,
      title: '「潮玩宇宙」文创产品系列',
      award: '2023 中国文创产品大赛 · 金奖',
      description: '将传统广府文化与潮流文化相结合，设计出深受年轻人喜爱的文创产品。'
    }
  ],
  6: [ // 江南大学
    {
      id: 1,
      title: '「智慧家庭」物联网产品系统',
      award: '2024 红点设计奖 · 产品设计奖',
      description: '基于用户需求洞察设计的智能家居生态系统，提供无缝连接的智慧生活体验。'
    },
    {
      id: 2,
      title: '「适老化」无障碍设计解决方案',
      award: '2023 IF设计奖 · 社会影响力奖',
      description: '关注老龄化社会需求，通过人性化设计提升老年人的生活品质和社会参与度。'
    },
    {
      id: 3,
      title: '「绿色制造」可持续产品设计',
      award: '2023 IDEA设计奖 · 环境责任奖',
      description: '贯彻循环经济理念的产品设计，在全生命周期中最大化减少环境影响。'
    }
  ],
  7: [ // 北京理工大学
    {
      id: 1,
      title: '「天眼」卫星导航系统界面',
      award: '2024 国际工业设计大赛 · 特等奖',
      description: '为北斗卫星导航系统设计的专业级用户界面，提升了系统的操作效率和用户体验。'
    },
    {
      id: 2,
      title: '「战鹰」无人机操控系统',
      award: '2023 军用装备设计竞赛 · 金奖',
      description: '集成先进人机工程学理念的无人机操控界面，显著提升了操作精度和安全性。'
    },
    {
      id: 3,
      title: '「精工」精密仪器设计',
      award: '2023 中国工业设计奖 · 金奖',
      description: '运用先进制造工艺设计的高精度测量仪器，在航空航天领域实现重要应用。'
    }
  ],
  8: [ // 湖南大学
    {
      id: 1,
      title: '「风驰」电动汽车造型设计',
      award: '2024 国际汽车设计大赛 · 最佳造型奖',
      description: '融合空气动力学与美学的电动汽车外观设计，体现了新能源时代的设计理念。'
    },
    {
      id: 2,
      title: '「湘韵」文化创意产品',
      award: '2023 中华传统文化设计大赛 · 金奖',
      description: '提取湖湘文化元素设计的文创产品系列，传承和弘扬了深厚的地域文化。'
    },
    {
      id: 3,
      title: '「重器」工程机械设计',
      award: '2023 全国机械设计大赛 · 一等奖',
      description: '结合人机工程学和工业美学的工程机械设计，提升了操作体验和工作效率。'
    }
  ]
}

// 获取学生成果统计数据
export function getMockAchievementStats(schoolId?: number) {
  if (schoolId && mockAchievementStatsBySchool[schoolId]) {
    return mockAchievementStatsBySchool[schoolId]
  }
  // 返回清华大学的数据作为默认值
  return mockAchievementStatsBySchool[1]
}

// 获取获奖趋势数据
export function getMockTrendData(schoolId?: number) {
  if (schoolId && mockTrendDataBySchool[schoolId]) {
    return mockTrendDataBySchool[schoolId]
  }
  // 返回清华大学的数据作为默认值
  return mockTrendDataBySchool[1] || mockTrendData
}

// 获取代表性获奖作品数据
export function getMockAwardWorks(schoolId?: number) {
  if (schoolId && mockAwardWorksBySchool[schoolId]) {
    return mockAwardWorksBySchool[schoolId]
  }
  // 返回清华大学的数据作为默认值
  return mockAwardWorksBySchool[1]
}



// SchoolCard组件所需的格式化数据
interface SchoolCardStatsData {
  employmentRates: string[]
  facultyStrengths: string[]
  studentScores: string[]
  advantagePrograms: string[]
}

// 模拟SchoolCard卡片统计数据 - 按学校ID分类
export const mockSchoolCardStatsBySchool: Record<number, SchoolCardStatsData> = {
  1: { // 清华大学
    employmentRates: ['96.8%'],
    facultyStrengths: ['5.0'],
    studentScores: ['4.9'],
    advantagePrograms: ['信息艺术设计', '智能产品设计', '交互设计']
  },
  2: { // 中央美术学院
    employmentRates: ['94.3%'],
    facultyStrengths: ['4.9'],
    studentScores: ['4.8'],
    advantagePrograms: ['视觉传达设计', '数字媒体艺术', '传统文化设计']
  },
  3: { // 同济大学
    employmentRates: ['95.7%'],
    facultyStrengths: ['4.8'],
    studentScores: ['4.7'],
    advantagePrograms: ['汽车设计', '可持续设计', '城市设计']
  },
  4: { // 中国美术学院
    employmentRates: ['92.1%'],
    facultyStrengths: ['4.8'],
    studentScores: ['4.7'],
    advantagePrograms: ['陶瓷艺术', '纤维艺术', '文化创意设计']
  },
  5: { // 广州美术学院
    employmentRates: ['93.8%'],
    facultyStrengths: ['4.6'],
    studentScores: ['4.5'],
    advantagePrograms: ['游戏美术设计', '岭南文化设计', '商业设计']
  },
  6: { // 江南大学
    employmentRates: ['97.2%'],
    facultyStrengths: ['4.9'],
    studentScores: ['4.8'],
    advantagePrograms: ['工业设计', '用户体验设计', '智能产品设计']
  },
  7: { // 北京理工大学
    employmentRates: ['96.5%'],
    facultyStrengths: ['4.7'],
    studentScores: ['4.6'],
    advantagePrograms: ['军工设计', '精密仪器设计', 'AI设计']
  },
  8: { // 湖南大学
    employmentRates: ['95.1%'],
    facultyStrengths: ['4.7'],
    studentScores: ['4.6'],
    advantagePrograms: ['汽车造型设计', '工程机械设计', '文化设计']
  }
}

// 模拟SchoolCard卡片统计数据（默认数据，用于兼容）
export const mockSchoolCardStats: SchoolCardStatsData = {
  employmentRates: ['96.8%', '95.2%', '92.8%', '91.5%', '89.3%', '87.6%'],
  facultyStrengths: ['5.0', '4.9', '4.8', '4.7', '4.6', '4.5'],
  studentScores: ['4.9', '4.8', '4.7', '4.6', '4.5', '4.4'],
  advantagePrograms: ['UI/UX设计', '视觉传达', '产品设计', '工业设计', '数字媒体']
}

// 格式化就业率
export function getMockEmploymentRate(schoolId: number) {
  if (mockSchoolCardStatsBySchool[schoolId]) {
    return mockSchoolCardStatsBySchool[schoolId].employmentRates[0]
  }
  // 回退到原来的逻辑
  const rates = mockSchoolCardStats.employmentRates
  const hash = schoolId % rates.length
  return rates[hash]
}

// 格式化师资力量评分
export function getMockFacultyStrength(schoolId: number) {
  if (mockSchoolCardStatsBySchool[schoolId]) {
    return mockSchoolCardStatsBySchool[schoolId].facultyStrengths[0]
  }
  // 回退到原来的逻辑
  const scores = mockSchoolCardStats.facultyStrengths
  const hash = (schoolId + 1) % scores.length
  return scores[hash]
}

// 格式化学生评分
export function getMockStudentScore(schoolId: number) {
  if (mockSchoolCardStatsBySchool[schoolId]) {
    return mockSchoolCardStatsBySchool[schoolId].studentScores[0]
  }
  // 回退到原来的逻辑
  const scores = mockSchoolCardStats.studentScores
  const hash = (schoolId + 2) % scores.length
  return scores[hash]
}

// 获取优势专业
export function getMockAdvantagePrograms(school: School) {
  if (mockSchoolCardStatsBySchool[school.id]) {
    const programs = mockSchoolCardStatsBySchool[school.id].advantagePrograms
    return programs.join('、')
  }
  // 回退到原来的逻辑
  const programs = mockSchoolCardStats.advantagePrograms
  return programs.join('、')
}

