-- ================================
-- 智图工厂数据库升级脚本
-- 基于现有ruoyi.sql数据库结构的增量更新
-- 版本：1.0.0
-- 创建时间：2025-01-27
-- ================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ================================
-- 1. 任务基础信息表
-- ================================
DROP TABLE IF EXISTS `des_task`;
CREATE TABLE `des_task` (
  `task_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID（关联现有企业表）',
  `task_title` varchar(200) NOT NULL COMMENT '任务标题',
  `task_description` text COMMENT '任务描述',
  `task_type` varchar(50) COMMENT '任务类型（LOGO_DESIGN/UI_UX_DESIGN/GRAPHIC_DESIGN/ILLUSTRATION/BRAND_DESIGN）',
  `skill_tags` json COMMENT '技能标签（JSON数组）',
  `budget_min` decimal(10,2) COMMENT '预算最低值',
  `budget_max` decimal(10,2) COMMENT '预算最高值',
  `deadline` datetime COMMENT '截止时间',
  `urgent` tinyint(1) DEFAULT 0 COMMENT '是否紧急（0否 1是）',
  `status` varchar(20) DEFAULT 'DRAFT' COMMENT '任务状态（DRAFT草稿 PUBLISHED已发布 IN_PROGRESS进行中 COMPLETED已完成 CANCELLED已取消）',
  `deliverables` text COMMENT '交付物要求',
  `payment_terms` text COMMENT '付款条款',
  `views` int DEFAULT 0 COMMENT '浏览次数',
  `applications` int DEFAULT 0 COMMENT '申请数量',
  `create_by` bigint COMMENT '创建者',
  `create_time` datetime COMMENT '创建时间',
  `update_by` bigint COMMENT '更新者',
  `update_time` datetime COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0正常 1软删除 2硬删除）',
  `del_time` datetime COMMENT '删除时间',
  `del_by` bigint COMMENT '删除人ID',
  `create_dept` bigint COMMENT '创建部门ID',
  PRIMARY KEY (`task_id`) USING BTREE,
  INDEX `idx_enterprise_id` (`enterprise_id` ASC) USING BTREE,
  INDEX `idx_task_type` (`task_type` ASC) USING BTREE,
  INDEX `idx_status` (`status` ASC) USING BTREE,
  INDEX `idx_deadline` (`deadline` ASC) USING BTREE,
  INDEX `idx_urgent` (`urgent` ASC) USING BTREE,
  INDEX `idx_task_del_flag` (`del_flag` ASC) USING BTREE,
  INDEX `idx_task_del_time` (`del_time` ASC) USING BTREE,
  CONSTRAINT `fk_task_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `des_enterprise` (`enterprise_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务信息表' ROW_FORMAT = Dynamic;

-- ================================
-- 2. 任务申请表（支持双重审核）
-- ================================
DROP TABLE IF EXISTS `des_task_application`;
CREATE TABLE `des_task_application` (
  `application_id` bigint NOT NULL AUTO_INCREMENT COMMENT '申请ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `designer_id` bigint NOT NULL COMMENT '设计师ID',
  `proposal` text COMMENT '申请提案',
  `proposed_price` decimal(10,2) COMMENT '报价金额',
  `estimated_days` int COMMENT '预计完成天数',
  `portfolio_links` json COMMENT '作品链接（JSON数组）',

  -- 最终申请状态
  `status` char(1) DEFAULT '0' COMMENT '最终申请状态（0待审核 1系统管理员通过 2系统管理员拒绝 3企业管理员通过 4企业管理员拒绝 5已撤回）',
  `feedback` text COMMENT '统一的审核反馈',

  -- 双重审核扩展字段（对企业管理员和设计师完全隐藏）
  `admin_review_status` varchar(20) DEFAULT 'PENDING' COMMENT '系统管理员审核状态（PENDING待审核 APPROVED通过 REJECTED拒绝）',
  `admin_review_feedback` text COMMENT '系统管理员审核反馈',
  `admin_review_time` datetime COMMENT '系统管理员审核时间',
  `admin_review_by` bigint COMMENT '系统管理员审核人ID',

  -- 企业管理员审核字段
  `enterprise_review_status` varchar(20) DEFAULT 'PENDING' COMMENT '企业管理员审核状态（PENDING待审核 APPROVED通过 REJECTED拒绝）',
  `enterprise_review_feedback` text COMMENT '企业管理员审核反馈',
  `enterprise_review_time` datetime COMMENT '企业管理员审核时间',

  `review_mode` varchar(20) DEFAULT 'DUAL' COMMENT '审核模式（DUAL双重审核 ENTERPRISE企业自主审核）',

  `create_by` bigint COMMENT '创建者',
  `create_time` datetime COMMENT '创建时间',
  `update_by` bigint COMMENT '更新者',
  `update_time` datetime COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0正常 1软删除 2硬删除）',
  `del_time` datetime COMMENT '删除时间',
  `del_by` bigint COMMENT '删除人ID',
  `create_dept` bigint COMMENT '创建部门ID',
  
  PRIMARY KEY (`application_id`) USING BTREE,
  UNIQUE KEY `uk_task_designer` (`task_id`, `designer_id`, `del_flag`) USING BTREE,
  INDEX `idx_task_id` (`task_id` ASC) USING BTREE,
  INDEX `idx_designer_id` (`designer_id` ASC) USING BTREE,
  INDEX `idx_status` (`status` ASC) USING BTREE,
  INDEX `idx_review_mode` (`review_mode` ASC) USING BTREE,
  INDEX `idx_admin_review_status` (`admin_review_status` ASC) USING BTREE,
  INDEX `idx_enterprise_review_status` (`enterprise_review_status` ASC) USING BTREE,
  INDEX `idx_task_application_del_flag` (`del_flag` ASC) USING BTREE,
  INDEX `idx_task_application_del_time` (`del_time` ASC) USING BTREE,
  CONSTRAINT `fk_task_app_task` FOREIGN KEY (`task_id`) REFERENCES `des_task` (`task_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_task_app_designer` FOREIGN KEY (`designer_id`) REFERENCES `des_designer` (`designer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务申请表（支持双重审核）' ROW_FORMAT = Dynamic;

-- ================================
-- 3. 任务交付表
-- ================================
DROP TABLE IF EXISTS `des_task_deliverable`;
CREATE TABLE `des_task_deliverable` (
  `deliverable_id` bigint NOT NULL AUTO_INCREMENT COMMENT '交付物ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `designer_id` bigint NOT NULL COMMENT '设计师ID',
  `deliverable_content` text COMMENT '交付内容（可包含链接、提取码、说明等）',
  `version` int DEFAULT 1 COMMENT '版本号',
  `status` varchar(20) DEFAULT 'SUBMITTED' COMMENT '状态（SUBMITTED已提交 APPROVED已通过 REVISION_REQUIRED需要修改 REJECTED已拒绝）',
  `review_feedback` text COMMENT '审核反馈',
  `create_by` bigint COMMENT '创建者',
  `create_time` datetime COMMENT '创建时间',
  `update_by` bigint COMMENT '更新者',
  `update_time` datetime COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0正常 1软删除 2硬删除）',
  `del_time` datetime COMMENT '删除时间',
  `del_by` bigint COMMENT '删除人ID',
  `create_dept` bigint COMMENT '创建部门ID',
  PRIMARY KEY (`deliverable_id`) USING BTREE,
  INDEX `idx_task_id` (`task_id` ASC) USING BTREE,
  INDEX `idx_designer_id` (`designer_id` ASC) USING BTREE,
  INDEX `idx_status` (`status` ASC) USING BTREE,
  INDEX `idx_task_deliverable_del_flag` (`del_flag` ASC) USING BTREE,
  INDEX `idx_task_deliverable_del_time` (`del_time` ASC) USING BTREE,
  CONSTRAINT `fk_deliverable_task` FOREIGN KEY (`task_id`) REFERENCES `des_task` (`task_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_deliverable_designer` FOREIGN KEY (`designer_id`) REFERENCES `des_designer` (`designer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务交付表' ROW_FORMAT = Dynamic;

-- ================================
-- 4. 任务支付表
-- ================================
DROP TABLE IF EXISTS `des_task_payment`;
CREATE TABLE `des_task_payment` (
  `payment_id` bigint NOT NULL AUTO_INCREMENT COMMENT '支付ID',
  `task_id` bigint NOT NULL COMMENT '任务ID',
  `designer_id` bigint NOT NULL COMMENT '设计师ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID',
  `amount` decimal(10,2) NOT NULL COMMENT '支付金额',
  `payment_method` varchar(20) COMMENT '支付方式（ALIPAY支付宝 WECHAT微信 BANK_TRANSFER银行转账）',
  `status` varchar(20) DEFAULT 'PENDING' COMMENT '支付状态（PENDING待支付 PAID已支付 FAILED支付失败 REFUNDED已退款）',
  `order_no` varchar(64) COMMENT '支付订单号',
  `transaction_id` varchar(64) COMMENT '第三方交易号',
  `payment_time` datetime COMMENT '支付时间',
  `confirm_time` datetime COMMENT '确认时间',
  `create_by` bigint COMMENT '创建者',
  `create_time` datetime COMMENT '创建时间',
  `update_by` bigint COMMENT '更新者',
  `update_time` datetime COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0正常 1软删除 2硬删除）',
  `del_time` datetime COMMENT '删除时间',
  `del_by` bigint COMMENT '删除人ID',
  `create_dept` bigint COMMENT '创建部门ID',
  PRIMARY KEY (`payment_id`) USING BTREE,
  INDEX `idx_task_id` (`task_id` ASC) USING BTREE,
  INDEX `idx_designer_id` (`designer_id` ASC) USING BTREE,
  INDEX `idx_enterprise_id` (`enterprise_id` ASC) USING BTREE,
  INDEX `idx_status` (`status` ASC) USING BTREE,
  INDEX `idx_order_no` (`order_no` ASC) USING BTREE,
  INDEX `idx_task_payment_del_flag` (`del_flag` ASC) USING BTREE,
  INDEX `idx_task_payment_del_time` (`del_time` ASC) USING BTREE,
  CONSTRAINT `fk_payment_task` FOREIGN KEY (`task_id`) REFERENCES `des_task` (`task_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `fk_payment_designer` FOREIGN KEY (`designer_id`) REFERENCES `des_designer` (`designer_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_payment_enterprise` FOREIGN KEY (`enterprise_id`) REFERENCES `des_enterprise` (`enterprise_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '任务支付表' ROW_FORMAT = Dynamic;

-- ================================
-- 5. 企业管理员专用视图（严格隐藏系统管理员信息）
-- ================================
DROP VIEW IF EXISTS `v_enterprise_task_application`;
CREATE VIEW `v_enterprise_task_application` AS
SELECT
  ta.application_id,
  ta.task_id,
  ta.designer_id,
  ta.proposal,
  ta.proposed_price,
  ta.estimated_days,
  ta.portfolio_links,

  -- 企业管理员视角的状态映射
  CASE
    WHEN ta.status = '0' THEN 'PENDING'
    WHEN ta.status = '1' THEN 'PENDING'    -- 系统管理员通过，企业管理员看到的仍是待审核
    WHEN ta.status = '2' THEN 'REJECTED'   -- 系统管理员拒绝
    WHEN ta.status = '3' THEN 'APPROVED'   -- 企业管理员通过
    WHEN ta.status = '4' THEN 'REJECTED'   -- 企业管理员拒绝
    WHEN ta.status = '5' THEN 'WITHDRAWN'  -- 已撤回
    ELSE 'PENDING'
  END AS status,

  -- 企业管理员的反馈（不包含系统管理员反馈）
  ta.enterprise_review_feedback AS feedback,
  ta.create_time,
  ta.enterprise_review_time AS review_time,

  -- 关联任务和设计师信息
  t.task_title,
  t.enterprise_id,
  d.designer_name,
  d.avatar as designer_avatar

FROM des_task_application ta
JOIN des_task t ON ta.task_id = t.task_id
JOIN des_designer d ON ta.designer_id = d.designer_id
WHERE ta.del_flag = '0'
  AND t.del_flag = '0'
  AND d.del_flag = '0';

-- ================================
-- 6. 添加智图工厂相关权限码
-- ================================

-- 任务管理权限码
INSERT IGNORE INTO sys_menu (menu_id, menu_name, parent_id, order_num, path, component, is_frame, is_cache, menu_type, visible, status, perms, icon, create_time, remark) VALUES
(2000, '智图工厂', 0, 4, 'task', NULL, 1, 0, 'M', '0', '0', NULL, 'work', NOW(), '智图工厂任务管理'),
(2001, '任务广场', 2000, 1, 'marketplace', 'task/marketplace/index', 1, 0, 'C', '0', '0', 'designer:task:list', 'list', NOW(), '任务广场'),
(2002, '任务管理', 2000, 2, 'management', 'task/management/index', 1, 0, 'C', '0', '0', 'designer:task:add', 'edit', NOW(), '任务管理'),
(2003, '申请管理', 2000, 3, 'applications', 'task/applications/index', 1, 0, 'C', '0', '0', 'designer:task-application:list', 'form', NOW(), '申请管理'),
(2004, '交付管理', 2000, 4, 'deliverables', 'task/deliverables/index', 1, 0, 'C', '0', '0', 'designer:task-deliverable:list', 'upload', NOW(), '交付管理'),
(2005, '支付中心', 2000, 5, 'payments', 'task/payments/index', 1, 0, 'C', '0', '0', 'designer:task-payment:list', 'money', NOW(), '支付中心'),

-- 按钮权限
(2010, '任务查看', 2001, 1, '', '', 1, 0, 'F', '0', '0', 'designer:task:detail', '#', NOW(), ''),
(2011, '任务新增', 2002, 2, '', '', 1, 0, 'F', '0', '0', 'designer:task:add', '#', NOW(), ''),
(2012, '任务修改', 2002, 3, '', '', 1, 0, 'F', '0', '0', 'designer:task:edit', '#', NOW(), ''),
(2013, '任务删除', 2002, 4, '', '', 1, 0, 'F', '0', '0', 'designer:task:delete', '#', NOW(), ''),
(2014, '申请任务', 2001, 5, '', '', 1, 0, 'F', '0', '0', 'designer:task-application:apply', '#', NOW(), ''),
(2015, '审核申请', 2003, 6, '', '', 1, 0, 'F', '0', '0', 'designer:task-application:process', '#', NOW(), ''),
(2016, '提交交付物', 2004, 7, '', '', 1, 0, 'F', '0', '0', 'designer:task-deliverable:submit', '#', NOW(), ''),
(2017, '审核交付物', 2004, 8, '', '', 1, 0, 'F', '0', '0', 'designer:task-deliverable:review', '#', NOW(), ''),
(2018, '创建支付', 2005, 9, '', '', 1, 0, 'F', '0', '0', 'designer:task-payment:create', '#', NOW(), ''),
(2019, '系统管理员审核', 2003, 10, '', '', 1, 0, 'F', '0', '0', 'designer:task-application:admin-review', '#', NOW(), '');

-- ================================
-- 7. 初始化数据（可选）
-- ================================

-- 测试任务数据
INSERT IGNORE INTO `des_task` (`task_id`, `enterprise_id`, `task_title`, `task_description`, `task_type`, `skill_tags`, `budget_min`, `budget_max`, `deadline`, `urgent`, `status`, `deliverables`, `payment_terms`, `views`, `applications`, `create_by`, `create_time`) VALUES
(1, 1, 'LOGO设计项目', '为新创科技公司设计现代简约风格的LOGO，需要体现科技感和创新精神。', 'LOGO_DESIGN', JSON_ARRAY('logo_design', 'brand_design', 'illustrator', 'photoshop'), 3000.00, 5000.00, '2025-02-15 18:00:00', 0, 'PUBLISHED', '1. AI格式的矢量文件\n2. PNG格式（多种尺寸）\n3. 使用说明书\n4. 商标注册建议', '项目完成后7个工作日内付款', 0, 0, 1, NOW()),
(2, 1, 'UI界面设计', '移动应用的UI界面设计，包含登录、首页、个人中心等主要页面。', 'UI_UX_DESIGN', JSON_ARRAY('ui_design', 'figma', 'sketch', 'user_experience'), 8000.00, 12000.00, '2025-03-01 18:00:00', 1, 'PUBLISHED', '1. Figma设计稿\n2. 切图资源\n3. 设计规范文档\n4. 交互说明', '分阶段付款：设计稿确认后付50%，项目完成后付余款', 0, 0, 1, NOW());

SET FOREIGN_KEY_CHECKS = 1;

-- ================================
-- 升级完成提示
-- ================================
SELECT '智图工厂数据库升级完成！' AS status,
       '新增表：des_task, des_task_application, des_task_deliverable, des_task_payment' AS tables,
       '新增视图：v_enterprise_task_application' AS views,
       '新增权限：智图工厂相关菜单和按钮权限' AS permissions; 