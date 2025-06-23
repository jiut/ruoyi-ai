-- 设计师管理模块数据库表结构

-- 企业表
CREATE TABLE `des_enterprise` (
    `enterprise_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '企业ID',
    `enterprise_name` VARCHAR(100) NOT NULL COMMENT '企业名称',
    `description` TEXT COMMENT '企业简介',
    `address` VARCHAR(255) COMMENT '企业地址',
    `phone` VARCHAR(20) COMMENT '联系电话',
    `email` VARCHAR(100) COMMENT '联系邮箱',
    `website` VARCHAR(255) COMMENT '企业网站',
    `scale` VARCHAR(50) COMMENT '企业规模',
    `industry` VARCHAR(100) COMMENT '行业类型',
    `logo` VARCHAR(255) COMMENT '企业LOGO',
    `status` CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `create_dept` BIGINT COMMENT '创建部门',
    `create_by` BIGINT COMMENT '创建者',
    `create_time` DATETIME COMMENT '创建时间',
    `update_by` BIGINT COMMENT '更新者',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`enterprise_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='企业信息表';

-- 院校表
CREATE TABLE `des_school` (
    `school_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '院校ID',
    `school_name` VARCHAR(100) NOT NULL COMMENT '院校名称',
    `description` TEXT COMMENT '院校简介',
    `address` VARCHAR(255) COMMENT '院校地址',
    `phone` VARCHAR(20) COMMENT '联系电话',
    `email` VARCHAR(100) COMMENT '联系邮箱',
    `website` VARCHAR(255) COMMENT '院校网站',
    `school_type` VARCHAR(50) COMMENT '院校类型',
    `level` VARCHAR(50) COMMENT '院校等级',
    `logo` VARCHAR(255) COMMENT '院校LOGO',
    `status` CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `create_dept` BIGINT COMMENT '创建部门',
    `create_by` BIGINT COMMENT '创建者',
    `create_time` DATETIME COMMENT '创建时间',
    `update_by` BIGINT COMMENT '更新者',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`school_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='院校信息表';

-- 设计师表
CREATE TABLE `des_designer` (
    `designer_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '设计师ID',
    `user_id` BIGINT COMMENT '关联用户ID',
    `designer_name` VARCHAR(100) NOT NULL COMMENT '设计师姓名',
    `avatar` VARCHAR(255) COMMENT '头像',
    `gender` CHAR(1) COMMENT '性别（0男 1女 2未知）',
    `birth_date` DATE COMMENT '出生日期',
    `phone` VARCHAR(20) COMMENT '联系电话',
    `email` VARCHAR(100) COMMENT '联系邮箱',
    `description` TEXT COMMENT '个人简介',
    `profession` VARCHAR(50) COMMENT '职业（插画师、交互设计师等）',
    `skill_tags` JSON COMMENT '技能标签（JSON数组格式）',
    `work_years` INT COMMENT '工作年限',
    `work_status` VARCHAR(20) COMMENT '工作状态（EMPLOYED在职、FREELANCER自由职业者等）',
    `location` VARCHAR(100) COMMENT '工作地点',
    `school_id` BIGINT COMMENT '所属院校ID（可为空）',
    `enterprise_id` BIGINT COMMENT '所属企业ID（可为空）',
    `graduation_date` DATE COMMENT '毕业时间（如果是学生）',
    `join_date` DATE COMMENT '入职时间（如果有企业）',
    `portfolio_url` VARCHAR(255) COMMENT '作品集链接',
    `social_links` JSON COMMENT '社交媒体链接（JSON格式）',
    `status` CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `create_dept` BIGINT COMMENT '创建部门',
    `create_by` BIGINT COMMENT '创建者',
    `create_time` DATETIME COMMENT '创建时间',
    `update_by` BIGINT COMMENT '更新者',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`designer_id`),
    INDEX `idx_profession` (`profession`),
    INDEX `idx_work_status` (`work_status`),
    INDEX `idx_school_id` (`school_id`),
    INDEX `idx_enterprise_id` (`enterprise_id`),
    INDEX `idx_user_id` (`user_id`),
    FOREIGN KEY (`school_id`) REFERENCES `des_school`(`school_id`) ON DELETE SET NULL,
    FOREIGN KEY (`enterprise_id`) REFERENCES `des_enterprise`(`enterprise_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='设计师信息表';

-- 作品表
CREATE TABLE `des_work` (
    `work_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '作品ID',
    `designer_id` BIGINT NOT NULL COMMENT '设计师ID',
    `title` VARCHAR(200) NOT NULL COMMENT '作品标题',
    `description` TEXT COMMENT '作品描述',
    `work_type` VARCHAR(20) NOT NULL COMMENT '作品类型（image/video）',
    `file_url` VARCHAR(500) NOT NULL COMMENT '文件URL',
    `thumbnail_url` VARCHAR(500) COMMENT '缩略图URL',
    `file_size` BIGINT COMMENT '文件大小（字节）',
    `tags` JSON COMMENT '作品标签（JSON数组格式）',
    `like_count` INT DEFAULT 0 COMMENT '点赞数',
    `view_count` INT DEFAULT 0 COMMENT '浏览数',
    `is_featured` CHAR(1) DEFAULT '0' COMMENT '是否为代表作品（0否 1是）',
    `status` CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `create_dept` BIGINT COMMENT '创建部门',
    `create_by` BIGINT COMMENT '创建者',
    `create_time` DATETIME COMMENT '创建时间',
    `update_by` BIGINT COMMENT '更新者',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`work_id`),
    INDEX `idx_designer_id` (`designer_id`),
    INDEX `idx_work_type` (`work_type`),
    INDEX `idx_is_featured` (`is_featured`),
    FOREIGN KEY (`designer_id`) REFERENCES `des_designer`(`designer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='设计师作品表';

-- 岗位招聘表
CREATE TABLE `des_job_posting` (
    `job_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
    `enterprise_id` BIGINT NOT NULL COMMENT '企业ID',
    `job_title` VARCHAR(100) NOT NULL COMMENT '岗位名称',
    `description` TEXT COMMENT '岗位描述',
    `requirements` TEXT COMMENT '岗位要求',
    `required_profession` VARCHAR(50) COMMENT '职业要求（对应设计师职业）',
    `required_skills` JSON COMMENT '技能要求（JSON数组格式）',
    `work_years_required` VARCHAR(50) COMMENT '工作年限要求',
    `salary_min` DECIMAL(10,2) COMMENT '薪资范围最低值',
    `salary_max` DECIMAL(10,2) COMMENT '薪资范围最高值',
    `location` VARCHAR(100) COMMENT '工作地点',
    `job_type` VARCHAR(20) COMMENT '工作类型（全职/兼职/实习）',
    `education_required` VARCHAR(50) COMMENT '学历要求',
    `recruitment_count` INT COMMENT '招聘人数',
    `deadline` DATE COMMENT '截止日期',
    `contact_person` VARCHAR(50) COMMENT '联系人',
    `contact_phone` VARCHAR(20) COMMENT '联系电话',
    `contact_email` VARCHAR(100) COMMENT '联系邮箱',
    `status` CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用 2已结束）',
    `create_dept` BIGINT COMMENT '创建部门',
    `create_by` BIGINT COMMENT '创建者',
    `create_time` DATETIME COMMENT '创建时间',
    `update_by` BIGINT COMMENT '更新者',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`job_id`),
    INDEX `idx_enterprise_id` (`enterprise_id`),
    INDEX `idx_required_profession` (`required_profession`),
    INDEX `idx_deadline` (`deadline`),
    FOREIGN KEY (`enterprise_id`) REFERENCES `des_enterprise`(`enterprise_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='岗位招聘表';

-- 岗位申请表
CREATE TABLE `des_job_application` (
    `application_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '申请ID',
    `job_id` BIGINT NOT NULL COMMENT '岗位ID',
    `designer_id` BIGINT NOT NULL COMMENT '设计师ID',
    `cover_letter` TEXT COMMENT '申请说明',
    `resume_url` VARCHAR(500) COMMENT '简历文件URL',
    `status` CHAR(1) DEFAULT '0' COMMENT '申请状态（0待审核 1通过 2拒绝 3撤回）',
    `feedback` TEXT COMMENT '企业反馈',
    `create_dept` BIGINT COMMENT '创建部门',
    `create_by` BIGINT COMMENT '创建者',
    `create_time` DATETIME COMMENT '创建时间',
    `update_by` BIGINT COMMENT '更新者',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`application_id`),
    INDEX `idx_job_id` (`job_id`),
    INDEX `idx_designer_id` (`designer_id`),
    INDEX `idx_status` (`status`),
    UNIQUE KEY `uk_job_designer` (`job_id`, `designer_id`),
    FOREIGN KEY (`job_id`) REFERENCES `des_job_posting`(`job_id`) ON DELETE CASCADE,
    FOREIGN KEY (`designer_id`) REFERENCES `des_designer`(`designer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='岗位申请表';

-- 工作经历表
CREATE TABLE `des_work_experience` (
    `experience_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '工作经历ID',
    `designer_id` BIGINT NOT NULL COMMENT '设计师ID',
    `company` VARCHAR(100) NOT NULL COMMENT '公司名称',
    `position` VARCHAR(100) NOT NULL COMMENT '职位名称',
    `start_date` DATE NOT NULL COMMENT '开始日期',
    `end_date` DATE COMMENT '结束日期',
    `is_current` BOOLEAN DEFAULT FALSE COMMENT '是否为当前工作',
    `description` TEXT COMMENT '工作描述',
    `location` VARCHAR(100) COMMENT '工作地点',
    `industry` VARCHAR(50) COMMENT '行业类型',
    `status` CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `create_dept` BIGINT COMMENT '创建部门',
    `create_by` BIGINT COMMENT '创建者',
    `create_time` DATETIME COMMENT '创建时间',
    `update_by` BIGINT COMMENT '更新者',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`experience_id`),
    INDEX `idx_designer_id` (`designer_id`),
    INDEX `idx_start_date` (`start_date`),
    FOREIGN KEY (`designer_id`) REFERENCES `des_designer`(`designer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='设计师工作经历表';

-- 教育背景表
CREATE TABLE `des_education` (
    `education_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '教育背景ID',
    `designer_id` BIGINT NOT NULL COMMENT '设计师ID',
    `school` VARCHAR(100) NOT NULL COMMENT '学校名称',
    `degree` VARCHAR(50) NOT NULL COMMENT '学位',
    `major` VARCHAR(100) NOT NULL COMMENT '专业',
    `start_date` DATE NOT NULL COMMENT '开始日期',
    `end_date` DATE COMMENT '结束日期',
    `is_current` BOOLEAN DEFAULT FALSE COMMENT '是否在读',
    `description` TEXT COMMENT '描述',
    `gpa` DECIMAL(3,2) COMMENT 'GPA',
    `ranking` INT COMMENT '排名',
    `total_students` INT COMMENT '总人数',
    `status` CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `create_dept` BIGINT COMMENT '创建部门',
    `create_by` BIGINT COMMENT '创建者',
    `create_time` DATETIME COMMENT '创建时间',
    `update_by` BIGINT COMMENT '更新者',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`education_id`),
    INDEX `idx_designer_id` (`designer_id`),
    INDEX `idx_start_date` (`start_date`),
    FOREIGN KEY (`designer_id`) REFERENCES `des_designer`(`designer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='设计师教育背景表';

-- 获奖表
CREATE TABLE `des_award` (
    `award_id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '获奖ID',
    `designer_id` BIGINT NOT NULL COMMENT '设计师ID',
    `title` VARCHAR(200) NOT NULL COMMENT '奖项名称',
    `organization` VARCHAR(200) NOT NULL COMMENT '颁发机构',
    `year` VARCHAR(4) NOT NULL COMMENT '获奖年份',
    `level` VARCHAR(50) COMMENT '奖项等级',
    `category` VARCHAR(100) COMMENT '奖项类别',
    `work_title` VARCHAR(200) COMMENT '获奖作品',
    `description` TEXT COMMENT '描述',
    `certificate_url` VARCHAR(500) COMMENT '证书链接',
    `sort` INT DEFAULT 0 COMMENT '排序号',
    `status` CHAR(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `create_dept` BIGINT COMMENT '创建部门',
    `create_by` BIGINT COMMENT '创建者',
    `create_time` DATETIME COMMENT '创建时间',
    `update_by` BIGINT COMMENT '更新者',
    `update_time` DATETIME COMMENT '更新时间',
    PRIMARY KEY (`award_id`),
    INDEX `idx_designer_id` (`designer_id`),
    INDEX `idx_year` (`year`),
    INDEX `idx_sort` (`sort`),
    FOREIGN KEY (`designer_id`) REFERENCES `des_designer`(`designer_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='设计师获奖表';

-- 插入初始数据
-- 企业数据
INSERT INTO `des_enterprise` (`enterprise_name`, `description`, `address`, `phone`, `email`, `website`, `scale`, `industry`, `status`, `create_time`)
VALUES 
('字节跳动', '全球领先的移动互联网公司', '北京市海淀区知春路甲48号', '010-12345678', 'hr@bytedance.com', 'https://bytedance.com', '5000+', '互联网', '0', NOW()),
('腾讯科技', '中国领先的互联网增值服务提供商', '深圳市南山区科技园', '0755-12345678', 'hr@tencent.com', 'https://tencent.com', '5000+', '互联网', '0', NOW()),
('阿里巴巴', '全球电子商务领导者', '杭州市余杭区文一西路969号', '0571-12345678', 'hr@alibaba.com', 'https://alibaba.com', '5000+', '电子商务', '0', NOW());

-- 院校数据
INSERT INTO `des_school` (`school_name`, `description`, `address`, `phone`, `email`, `website`, `school_type`, `level`, `status`, `create_time`)
VALUES 
('清华大学美术学院', '中国著名的艺术设计院校', '北京市海淀区清华园1号', '010-62785001', 'info@tsinghua.edu.cn', 'https://www.ad.tsinghua.edu.cn', '公立', '985', '0', NOW()),
('中央美术学院', '中国历史最悠久的美术院校', '北京市朝阳区花家地南街8号', '010-64771056', 'info@cafa.edu.cn', 'https://www.cafa.edu.cn', '公立', '211', '0', NOW()),
('广州美术学院', '华南地区重要的美术院校', '广州市海珠区昌岗东路257号', '020-84017740', 'info@gzarts.edu.cn', 'https://www.gzarts.edu.cn', '公立', '普通本科', '0', NOW());

-- 设计师数据示例
INSERT INTO `des_designer` (`designer_name`, `gender`, `birth_date`, `phone`, `email`, `description`, `profession`, `skill_tags`, `work_years`, `work_status`, `location`, `school_id`, `enterprise_id`, `portfolio_url`, `social_links`, `status`, `create_time`)
VALUES 
('陈雨晴', '1', '1995-06-15', '13812345678', 'chenyu@example.com', '拥有 5 年 UI/UX 设计经验，专注于移动应用和 Web 产品的用户体验设计。擅长用户研究、交互设计和视觉设计，能够从用户需求出发，打造直观易用的产品界面。曾主导腾讯多个核心产品的设计工作，包括社交、游戏和企业应用等领域。', 'UI_UX_DESIGNER', '["FIGMA", "USER_RESEARCH", "INTERACTION_DESIGN"]', 5, 'EMPLOYED', '深圳', 1, 2, 'https://chenyudesign.com', '{"dribbble": "https://dribbble.com/chenyu", "behance": "https://behance.net/chenyu"}', '0', '2023-01-01 00:00:00'),
('林子豪', '0', '1990-03-22', '13923456789', 'linzihao@example.com', '专业视觉设计师，专注于品牌设计和视觉传达。拥有丰富的品牌标识设计经验，善于通过视觉语言传达品牌价值。', 'VISUAL_DESIGNER', '["PHOTOSHOP", "ILLUSTRATOR", "BRAND_DESIGN"]', 7, 'EMPLOYED', '上海', NULL, NULL, 'https://linzihaodesign.com', '{"instagram": "https://instagram.com/linzihao"}', '0', '2022-06-01 00:00:00'),
('王梦琪', '1', '1996-11-08', '13634567890', 'wangmengqi@example.com', '3D 动画设计师，专注于三维建模和动画制作。拥有丰富的影视和游戏行业经验。', 'THREE_D_DESIGNER', '["BLENDER", "CINEMA_4D", "ANIMATION_DESIGN"]', 4, 'FREELANCER', '北京', NULL, NULL, 'https://wangmengqi3d.com', '{}', '0', '2023-03-01 00:00:00'),
('赵明宇', '0', '1993-09-15', '13745678901', 'zhaomingyu@example.com', '产品设计师，专注于数字产品的用户体验设计和产品策略。', 'PRODUCT_DESIGNER', '["SKETCH", "PROTOTYPE_DESIGN", "USER_EXPERIENCE_DESIGN"]', 6, 'EMPLOYED', '杭州', NULL, 3, 'https://zhaomingyu.design', '{}', '0', '2022-09-01 00:00:00');

-- 工作经历数据示例
INSERT INTO `des_work_experience` (`designer_id`, `company`, `position`, `start_date`, `end_date`, `is_current`, `description`, `location`, `industry`, `status`, `create_time`)
VALUES 
(1, '腾讯', '高级 UI/UX 设计师', '2022-03-01', NULL, TRUE, '负责腾讯社交产品的用户体验设计，主导产品界面改版与优化，建立设计规范与组件库。参与用户研究与需求分析，提出基于数据的设计解决方案。', '深圳', '互联网', '0', NOW()),
(1, '字节跳动', 'UI 设计师', '2020-06-01', '2022-02-28', FALSE, '参与短视频应用的界面设计工作，负责功能迭代与视觉优化，协助建立设计规范。与产品和开发团队紧密合作，确保设计方案的顺利实现。', '北京', '互联网', '0', NOW());

-- 教育背景数据示例
INSERT INTO `des_education` (`designer_id`, `school`, `degree`, `major`, `start_date`, `end_date`, `is_current`, `description`, `gpa`, `status`, `create_time`)
VALUES 
(1, '中国美术学院', '硕士', '设计学', '2015-09-01', '2018-06-30', FALSE, '专业方向：数字媒体艺术，研究方向：交互设计与用户体验', 3.8, '0', NOW()),
(1, '浙江大学', '学士', '工业设计', '2011-09-01', '2015-06-30', FALSE, '主修课程：设计基础、人机交互、产品设计、计算机辅助设计', 3.6, '0', NOW());

-- 获奖数据示例
INSERT INTO `des_award` (`designer_id`, `title`, `organization`, `year`, `level`, `category`, `work_title`, `description`, `sort`, `status`, `create_time`)
VALUES 
(1, '2023 iF 设计奖', 'iF International Forum Design', '2023', '优秀奖', '产品设计', '腾讯社交产品界面设计', '该作品在用户体验和视觉设计方面表现出色', 1, '0', NOW()),
(1, 'Google UX 设计专业认证', 'Google', '2021', '认证', '专业认证', '', '通过Google官方用户体验设计认证考试', 2, '0', NOW()); 