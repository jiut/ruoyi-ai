-- ================================
-- 智图工厂有限状态机数据库表结构
-- 支持双重审核的任务申请系统
-- ================================

-- 1. 任务申请表（支持双重审核）
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

  -- 双重审核扩展字段（对企业管理员完全不可见）
  `admin_review_status` varchar(20) DEFAULT 'PENDING' COMMENT '系统管理员审核状态（PENDING待审核 APPROVED通过 REJECTED拒绝 SKIPPED跳过）',
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
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  
  PRIMARY KEY (`application_id`),
  UNIQUE KEY `uk_task_designer` (`task_id`, `designer_id`, `del_flag`),
  KEY `idx_task_id` (`task_id`),
  KEY `idx_designer_id` (`designer_id`),
  KEY `idx_status` (`status`),
  KEY `idx_review_mode` (`review_mode`),
  KEY `idx_admin_review_status` (`admin_review_status`),
  KEY `idx_enterprise_review_status` (`enterprise_review_status`),
  KEY `idx_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='任务申请表（支持双重审核）';

-- 2. 申请状态变更日志表
CREATE TABLE `des_application_state_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `application_id` bigint NOT NULL COMMENT '申请ID',
  `from_status` varchar(20) COMMENT '原状态',
  `to_status` varchar(20) COMMENT '目标状态',
  `action` varchar(30) COMMENT '操作类型（ADMIN_REVIEW系统管理员审核 ENTERPRISE_REVIEW企业管理员审核 WITHDRAW用户撤回 SYSTEM_AUTO系统自动）',
  `feedback` text COMMENT '审核反馈',
  `operator_id` bigint COMMENT '操作人ID',
  `operator_name` varchar(100) COMMENT '操作人姓名',
  `transition_time` datetime COMMENT '转换时间',
  `review_mode` varchar(20) COMMENT '审核模式',
  `duration` bigint COMMENT '操作耗时（毫秒）',
  `client_ip` varchar(50) COMMENT '客户端IP',
  `user_agent` text COMMENT '用户代理',
  `metadata` json COMMENT '附加信息（JSON格式）',
  
  `create_by` bigint COMMENT '创建者',
  `create_time` datetime COMMENT '创建时间',
  `update_by` bigint COMMENT '更新者',
  `update_time` datetime COMMENT '更新时间',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  
  PRIMARY KEY (`log_id`),
  KEY `idx_application_id` (`application_id`),
  KEY `idx_action` (`action`),
  KEY `idx_operator_id` (`operator_id`),
  KEY `idx_transition_time` (`transition_time`),
  KEY `idx_review_mode` (`review_mode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='申请状态变更日志表';

-- 3. 企业管理员专用视图（严格隐藏系统管理员信息）
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
  ta.enterprise_review_time AS review_time

FROM des_task_application ta
WHERE ta.del_flag = '0'
-- 严格保证：视图中完全不包含系统管理员相关字段;

-- 4. 初始化基础数据
INSERT INTO `des_task_application` 
(`application_id`, `task_id`, `designer_id`, `proposal`, `proposed_price`, `estimated_days`, 
 `portfolio_links`, `status`, `review_mode`, `admin_review_status`, `enterprise_review_status`,
 `create_by`, `create_time`, `del_flag`) 
VALUES 
(1, 1, 1, '我对这个Logo设计项目很感兴趣，有5年的品牌设计经验，能够在3天内完成高质量的Logo设计。', 
 2500.00, 3, '["https://portfolio1.example.com", "https://portfolio2.example.com"]', 
 '0', 'DUAL', 'PENDING', 'PENDING', 1, NOW(), '0'),
(2, 1, 2, '专业UI设计师，擅长现代简约风格，可以提供多个设计方案供选择。', 
 3000.00, 5, '["https://dribbble.com/designer2", "https://behance.net/designer2"]', 
 '0', 'DUAL', 'PENDING', 'PENDING', 2, NOW(), '0');

-- 5. 索引优化建议
-- 为查询性能优化添加复合索引
CREATE INDEX `idx_status_review_mode` ON `des_task_application` (`status`, `review_mode`);
CREATE INDEX `idx_admin_review_status_time` ON `des_task_application` (`admin_review_status`, `admin_review_time`);
CREATE INDEX `idx_enterprise_review_status_time` ON `des_task_application` (`enterprise_review_status`, `enterprise_review_time`);

-- 为日志表添加复合索引
CREATE INDEX `idx_application_action_time` ON `des_application_state_log` (`application_id`, `action`, `transition_time`);
CREATE INDEX `idx_operator_action_time` ON `des_application_state_log` (`operator_id`, `action`, `transition_time`);

-- 6. 权限控制存储过程
DELIMITER //
CREATE PROCEDURE `sp_get_enterprise_applications`(
  IN p_enterprise_id BIGINT,
  IN p_status VARCHAR(20),
  IN p_limit INT,
  IN p_offset INT
)
BEGIN
  DECLARE EXIT HANDLER FOR SQLEXCEPTION
  BEGIN
    ROLLBACK;
    RESIGNAL;
  END;

  START TRANSACTION;

  -- 使用企业管理员专用视图，确保不返回系统管理员信息
  SELECT
    application_id,
    task_id,
    designer_id,
    proposal,
    proposed_price,
    estimated_days,
    portfolio_links,
    status,
    feedback,
    create_time,
    review_time
  FROM v_enterprise_task_application veta
  LEFT JOIN des_task t ON veta.task_id = t.task_id
  WHERE t.enterprise_id = p_enterprise_id
    AND (p_status IS NULL OR veta.status = p_status)
  ORDER BY veta.create_time DESC
  LIMIT p_limit OFFSET p_offset;

  -- 统计信息（仅企业管理员相关）
  SELECT
    COUNT(*) as total_count,
    SUM(CASE WHEN veta.status = 'PENDING' THEN 1 ELSE 0 END) as pending_count,
    SUM(CASE WHEN veta.status = 'APPROVED' THEN 1 ELSE 0 END) as approved_count,
    SUM(CASE WHEN veta.status = 'REJECTED' THEN 1 ELSE 0 END) as rejected_count,
    SUM(CASE WHEN DATE(veta.review_time) = CURDATE() THEN 1 ELSE 0 END) as reviewed_today
  FROM v_enterprise_task_application veta
  LEFT JOIN des_task t ON veta.task_id = t.task_id
  WHERE t.enterprise_id = p_enterprise_id;

  COMMIT;
END //
DELIMITER ;

-- 7. 数据访问权限检查函数
DELIMITER //
CREATE FUNCTION `fn_check_enterprise_application_access`(
  p_application_id BIGINT,
  p_user_id BIGINT
) RETURNS BOOLEAN
READS SQL DATA
DETERMINISTIC
BEGIN
  DECLARE v_count INT DEFAULT 0;

  -- 检查用户是否有权限访问该申请
  -- 只有该申请所属任务的企业管理员可以访问
  SELECT COUNT(*) INTO v_count
  FROM des_task_application ta
  LEFT JOIN des_task t ON ta.task_id = t.task_id
  LEFT JOIN des_enterprise e ON t.enterprise_id = e.enterprise_id
  WHERE ta.application_id = p_application_id
    AND e.user_id = p_user_id
    AND ta.del_flag = '0'
    AND t.del_flag = '0'
    AND e.del_flag = '0';

  RETURN v_count > 0;
END //
DELIMITER ;

-- 8. 数据清理定时任务（清理过期日志）
-- 注意：需要根据配置的日志保留天数定期执行
-- DELETE FROM des_application_state_log 
-- WHERE del_flag = '0' 
--   AND create_time < DATE_SUB(NOW(), INTERVAL 365 DAY);

-- ================================
-- 表结构创建完成
-- ================================ 