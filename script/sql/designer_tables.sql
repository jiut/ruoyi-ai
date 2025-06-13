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
    INDEX `idx_school_id` (`school_id`),
    INDEX `idx_enterprise_id` (`enterprise_id`),
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
INSERT INTO `des_designer` (`designer_name`, `gender`, `birth_date`, `phone`, `email`, `description`, `profession`, `skill_tags`, `work_years`, `school_id`, `status`, `create_time`)
VALUES 
('张三', '0', '1995-06-15', '13800138001', 'zhangsan@example.com', '专注UI/UX设计，有丰富的移动端设计经验', 'ui_designer', '["ui_design", "ux_design", "prototype_design"]', 3, 1, '0', NOW()),
('李四', '1', '1998-03-22', '13800138002', 'lisi@example.com', '插画师，擅长角色设计和场景绘制', 'illustrator', '["illustration", "character_design", "digital_painting"]', 2, 2, '0', NOW()),
('王五', '0', '1992-11-08', '13800138003', 'wangwu@example.com', '品牌设计师，专注企业形象设计', 'brand_designer', '["branding", "logo_design", "visual_identity"]', 5, NULL, '0', NOW()); 