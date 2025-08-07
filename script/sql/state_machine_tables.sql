-- ====================================================
-- 智图工厂状态机相关数据库表结构
-- ====================================================

-- 1. 任务申请状态转换日志表（可选：用于更详细的审计）
CREATE TABLE IF NOT EXISTS `des_task_application_state_log` (
  `log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `application_id` bigint NOT NULL COMMENT '申请ID',
  `from_status` varchar(20) NOT NULL COMMENT '原状态',
  `to_status` varchar(20) NOT NULL COMMENT '目标状态',
  `action` varchar(50) NOT NULL COMMENT '操作类型',
  `operator_id` bigint NOT NULL COMMENT '操作人ID',
  `operator_name` varchar(100) COMMENT '操作人姓名',
  `duration` bigint DEFAULT 0 COMMENT '操作耗时（毫秒）',
  `ip_address` varchar(50) COMMENT '操作IP地址',
  `user_agent` varchar(500) COMMENT '用户代理',
  `remarks` text COMMENT '备注说明',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`log_id`),
  KEY `idx_application_id` (`application_id`),
  KEY `idx_create_time` (`create_time`),
  KEY `idx_operator_id` (`operator_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='任务申请状态转换日志表';

-- 2. 状态机配置表（用于动态配置状态转换规则）
CREATE TABLE IF NOT EXISTS `des_state_machine_config` (
  `config_id` bigint NOT NULL AUTO_INCREMENT COMMENT '配置ID',
  `from_status` varchar(20) NOT NULL COMMENT '原状态',
  `to_status` varchar(20) NOT NULL COMMENT '目标状态',
  `action` varchar(50) NOT NULL COMMENT '操作类型',
  `review_mode` varchar(20) NOT NULL COMMENT '审核模式',
  `is_enabled` tinyint(1) DEFAULT 1 COMMENT '是否启用',
  `required_role` varchar(100) COMMENT '需要的角色',
  `condition_expression` text COMMENT '条件表达式',
  `description` varchar(500) COMMENT '描述',
  `sort_order` int DEFAULT 0 COMMENT '排序',
  `create_by` bigint COMMENT '创建者',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` bigint COMMENT '更新者',
  `update_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`config_id`),
  UNIQUE KEY `uk_transition_rule` (`from_status`, `to_status`, `action`, `review_mode`),
  KEY `idx_is_enabled` (`is_enabled`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='状态机配置表';

-- 3. 插入默认的状态转换规则
INSERT INTO `des_state_machine_config` 
(`from_status`, `to_status`, `action`, `review_mode`, `is_enabled`, `required_role`, `description`, `sort_order`) 
VALUES 
-- 双重审核模式规则
('PENDING', 'ADMIN_APPROVED', 'ADMIN_REVIEW', 'DUAL', 1, 'admin', '系统管理员审核通过', 1),
('PENDING', 'ADMIN_REJECTED', 'ADMIN_REVIEW', 'DUAL', 1, 'admin', '系统管理员审核拒绝', 2),
('ADMIN_APPROVED', 'ENTERPRISE_APPROVED', 'ENTERPRISE_REVIEW', 'DUAL', 1, 'enterprise', '企业管理员审核通过', 3),
('ADMIN_APPROVED', 'ENTERPRISE_REJECTED', 'ENTERPRISE_REVIEW', 'DUAL', 1, 'enterprise', '企业管理员审核拒绝', 4),
('PENDING', 'WITHDRAWN', 'WITHDRAW', 'DUAL', 1, 'designer', '设计师撤回申请（待审核状态）', 5),
('ADMIN_APPROVED', 'WITHDRAWN', 'WITHDRAW', 'DUAL', 1, 'designer', '设计师撤回申请（系统审核通过后）', 6),

-- 企业自主审核模式规则
('PENDING', 'ENTERPRISE_APPROVED', 'ENTERPRISE_REVIEW', 'ENTERPRISE', 1, 'enterprise', '企业管理员直接审核通过', 7),
('PENDING', 'ENTERPRISE_REJECTED', 'ENTERPRISE_REVIEW', 'ENTERPRISE', 1, 'enterprise', '企业管理员直接审核拒绝', 8),
('PENDING', 'WITHDRAWN', 'WITHDRAW', 'ENTERPRISE', 1, 'designer', '设计师撤回申请', 9);

-- 4. 状态转换统计视图
CREATE VIEW `v_state_transition_stats` AS
SELECT 
    DATE(create_time) as date,
    from_status,
    to_status,
    action,
    COUNT(*) as transition_count,
    AVG(duration) as avg_duration,
    MIN(duration) as min_duration,
    MAX(duration) as max_duration
FROM `des_task_application_state_log`
WHERE create_time >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY DATE(create_time), from_status, to_status, action
ORDER BY date DESC, transition_count DESC;

-- 5. 审核效率统计视图
CREATE VIEW `v_review_efficiency_stats` AS
SELECT 
    DATE(create_time) as date,
    action,
    operator_id,
    COUNT(*) as review_count,
    AVG(duration) as avg_review_time,
    COUNT(CASE WHEN to_status LIKE '%APPROVED%' THEN 1 END) as approved_count,
    COUNT(CASE WHEN to_status LIKE '%REJECTED%' THEN 1 END) as rejected_count,
    ROUND(COUNT(CASE WHEN to_status LIKE '%APPROVED%' THEN 1 END) * 100.0 / COUNT(*), 2) as approval_rate
FROM `des_task_application_state_log`
WHERE action IN ('ADMIN_REVIEW', 'ENTERPRISE_REVIEW')
  AND create_time >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
GROUP BY DATE(create_time), action, operator_id
ORDER BY date DESC, review_count DESC;

-- 6. 异常状态检测存储过程
DELIMITER //
CREATE PROCEDURE `sp_detect_abnormal_applications`()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE app_id BIGINT;
    DECLARE app_status VARCHAR(20);
    DECLARE last_update DATETIME;
    DECLARE review_mode VARCHAR(20);
    
    -- 游标：查找可能异常的申请
    DECLARE cur CURSOR FOR 
        SELECT application_id, status, update_time, review_mode
        FROM des_task_application 
        WHERE del_flag = '0'
          AND status IN ('0', '1')  -- 待审核或系统管理员审核通过
          AND update_time < DATE_SUB(NOW(), INTERVAL 7 DAY)  -- 7天未更新
        ORDER BY update_time ASC;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    
    -- 创建临时表存储结果
    DROP TEMPORARY TABLE IF EXISTS temp_abnormal_applications;
    CREATE TEMPORARY TABLE temp_abnormal_applications (
        application_id BIGINT,
        status VARCHAR(20),
        last_update DATETIME,
        review_mode VARCHAR(20),
        abnormal_reason VARCHAR(200),
        suggested_action VARCHAR(200)
    );
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO app_id, app_status, last_update, review_mode;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        -- 分析异常原因
        CASE 
            WHEN app_status = '0' AND review_mode = 'DUAL' THEN
                INSERT INTO temp_abnormal_applications VALUES (
                    app_id, app_status, last_update, review_mode,
                    '系统管理员审核超时', '提醒系统管理员处理或切换为企业自主审核模式'
                );
            WHEN app_status = '0' AND review_mode = 'ENTERPRISE' THEN
                INSERT INTO temp_abnormal_applications VALUES (
                    app_id, app_status, last_update, review_mode,
                    '企业管理员审核超时', '提醒企业管理员处理'
                );
            WHEN app_status = '1' THEN
                INSERT INTO temp_abnormal_applications VALUES (
                    app_id, app_status, last_update, review_mode,
                    '企业管理员二级审核超时', '提醒企业管理员处理或自动通过'
                );
        END CASE;
        
    END LOOP;
    
    CLOSE cur;
    
    -- 返回异常申请列表
    SELECT * FROM temp_abnormal_applications;
    
END //
DELIMITER ;

-- 7. 状态机性能监控存储过程
DELIMITER //
CREATE PROCEDURE `sp_state_machine_performance_report`(IN days INT)
BEGIN
    -- 默认查询最近30天
    IF days IS NULL OR days <= 0 THEN
        SET days = 30;
    END IF;
    
    -- 1. 状态转换量统计
    SELECT 
        '状态转换量统计' as report_type,
        action as metric_name,
        COUNT(*) as total_count,
        AVG(duration) as avg_duration_ms,
        MAX(duration) as max_duration_ms,
        DATE(MIN(create_time)) as start_date,
        DATE(MAX(create_time)) as end_date
    FROM des_task_application_state_log
    WHERE create_time >= DATE_SUB(CURDATE(), INTERVAL days DAY)
    GROUP BY action
    
    UNION ALL
    
    -- 2. 审核效率统计
    SELECT 
        '审核效率统计' as report_type,
        CONCAT(action, ' - 通过率') as metric_name,
        COUNT(CASE WHEN to_status LIKE '%APPROVED%' THEN 1 END) as total_count,
        ROUND(COUNT(CASE WHEN to_status LIKE '%APPROVED%' THEN 1 END) * 100.0 / COUNT(*), 2) as avg_duration_ms,
        NULL as max_duration_ms,
        DATE(MIN(create_time)) as start_date,
        DATE(MAX(create_time)) as end_date
    FROM des_task_application_state_log
    WHERE create_time >= DATE_SUB(CURDATE(), INTERVAL days DAY)
      AND action IN ('ADMIN_REVIEW', 'ENTERPRISE_REVIEW')
    GROUP BY action
    
    ORDER BY report_type, metric_name;
    
END //
DELIMITER ;

-- 8. 创建索引以提升性能
CREATE INDEX idx_task_application_status_time ON des_task_application(status, update_time);
CREATE INDEX idx_task_application_review_mode ON des_task_application(review_mode);
CREATE INDEX idx_state_log_app_action ON des_task_application_state_log(application_id, action);
CREATE INDEX idx_state_log_operator_time ON des_task_application_state_log(operator_id, create_time);

-- 9. 添加表注释
ALTER TABLE des_task_application COMMENT = '任务申请表（支持双重审核的状态机）';
ALTER TABLE des_task_application_state_log COMMENT = '任务申请状态转换审计日志表';
ALTER TABLE des_state_machine_config COMMENT = '状态机转换规则配置表';

-- 10. 数据完整性检查触发器
DELIMITER //
CREATE TRIGGER tr_task_application_state_change 
AFTER UPDATE ON des_task_application
FOR EACH ROW
BEGIN
    -- 记录状态变更日志
    IF OLD.status != NEW.status THEN
        INSERT INTO des_task_application_state_log (
            application_id, from_status, to_status, action, operator_id, operator_name, create_time
        ) VALUES (
            NEW.application_id, 
            OLD.status, 
            NEW.status, 
            'MANUAL_UPDATE',  -- 手动更新标识
            NEW.update_by,
            (SELECT nick_name FROM sys_user WHERE user_id = NEW.update_by LIMIT 1),
            NOW()
        );
    END IF;
END //
DELIMITER ;

-- ====================================================
-- 使用说明
-- ====================================================

/* 
状态机使用示例：

1. 查询当前异常申请：
   CALL sp_detect_abnormal_applications();

2. 生成性能报告：
   CALL sp_state_machine_performance_report(30);

3. 查看状态转换统计：
   SELECT * FROM v_state_transition_stats WHERE date >= '2024-01-01';

4. 查看审核效率：
   SELECT * FROM v_review_efficiency_stats WHERE date >= '2024-01-01';

5. 手动插入状态转换日志：
   INSERT INTO des_task_application_state_log 
   (application_id, from_status, to_status, action, operator_id, duration)
   VALUES (1, 'PENDING', 'ADMIN_APPROVED', 'ADMIN_REVIEW', 1, 5000);

6. 动态修改状态转换规则：
   UPDATE des_state_machine_config 
   SET is_enabled = 0 
   WHERE from_status = 'PENDING' AND action = 'ADMIN_REVIEW';
*/ 