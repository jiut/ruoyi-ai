-- 视频信息表
CREATE TABLE `sys_video_info` (
    `video_id` bigint NOT NULL AUTO_INCREMENT COMMENT '视频ID',
    `oss_id` bigint NOT NULL COMMENT '关联的OSS文件ID',
    `title` varchar(200) NOT NULL COMMENT '视频标题',
    `description` text COMMENT '视频描述',
    `duration` int DEFAULT NULL COMMENT '视频时长（秒）',
    `width` int DEFAULT NULL COMMENT '视频宽度（像素）',
    `height` int DEFAULT NULL COMMENT '视频高度（像素）',
    `file_size` bigint DEFAULT NULL COMMENT '视频大小（字节）',
    `format` varchar(20) DEFAULT NULL COMMENT '视频格式',
    `thumbnail` varchar(500) DEFAULT NULL COMMENT '缩略图URL',
    `play_count` bigint DEFAULT 0 COMMENT '播放次数',
    `status` char(1) DEFAULT '0' COMMENT '状态（0正常 1停用）',
    `category` varchar(50) DEFAULT NULL COMMENT '分类',
    `tags` varchar(500) DEFAULT NULL COMMENT '标签（用逗号分隔）',
    `is_public` char(1) DEFAULT '1' COMMENT '是否公开（0私有 1公开）',
    `uploader_id` bigint DEFAULT NULL COMMENT '上传者ID',
    `uploader_name` varchar(30) DEFAULT NULL COMMENT '上传者名称',
    `tenant_id` varchar(20) DEFAULT '000000' COMMENT '租户编号',
    `create_dept` bigint DEFAULT NULL COMMENT '创建部门',
    `create_by` bigint DEFAULT NULL COMMENT '创建者',
    `create_time` datetime DEFAULT NULL COMMENT '创建时间',
    `update_by` bigint DEFAULT NULL COMMENT '更新者',
    `update_time` datetime DEFAULT NULL COMMENT '更新时间',
    `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
    PRIMARY KEY (`video_id`),
    KEY `idx_oss_id` (`oss_id`),
    KEY `idx_uploader_id` (`uploader_id`),
    KEY `idx_category` (`category`),
    KEY `idx_status` (`status`),
    KEY `idx_is_public` (`is_public`),
    KEY `idx_play_count` (`play_count`),
    KEY `idx_create_time` (`create_time`),
    KEY `idx_tenant_id` (`tenant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='视频信息表';

-- 插入视频相关权限到菜单表
INSERT INTO `sys_menu` (`menu_name`, `parent_id`, `order_num`, `path`, `component`, `query_param`, `is_frame`, `is_cache`, `menu_type`, `visible`, `status`, `perms`, `icon`, `create_dept`, `create_by`, `create_time`, `update_by`, `update_time`, `remark`) VALUES
('视频管理', 1, 7, 'video', 'system/video/index', '', 1, 0, 'C', '0', '0', 'system:video:list', 'video', 103, 1, now(), 1, now(), '视频管理菜单'),
('视频信息查询', (SELECT menu_id FROM sys_menu WHERE perms = 'system:video:list'), 1, '', '', '', 1, 0, 'F', '0', '0', 'system:video:query', '#', 103, 1, now(), 1, now(), ''),
('视频信息新增', (SELECT menu_id FROM sys_menu WHERE perms = 'system:video:list'), 2, '', '', '', 1, 0, 'F', '0', '0', 'system:video:add', '#', 103, 1, now(), 1, now(), ''),
('视频信息修改', (SELECT menu_id FROM sys_menu WHERE perms = 'system:video:list'), 3, '', '', '', 1, 0, 'F', '0', '0', 'system:video:edit', '#', 103, 1, now(), 1, now(), ''),
('视频信息删除', (SELECT menu_id FROM sys_menu WHERE perms = 'system:video:list'), 4, '', '', '', 1, 0, 'F', '0', '0', 'system:video:remove', '#', 103, 1, now(), 1, now(), ''),
('视频文件上传', (SELECT menu_id FROM sys_menu WHERE perms = 'system:oss:list'), 5, '', '', '', 1, 0, 'F', '0', '0', 'system:oss:upload:video', '#', 103, 1, now(), 1, now(), '视频文件上传权限');

-- 为管理员角色分配视频管理权限
INSERT INTO `sys_role_menu` (`role_id`, `menu_id`) 
SELECT 1, menu_id FROM `sys_menu` WHERE `perms` IN (
    'system:video:list', 
    'system:video:query', 
    'system:video:add', 
    'system:video:edit', 
    'system:video:remove',
    'system:oss:upload:video'
);

-- 示例数据（可选）
-- INSERT INTO `sys_video_info` (`oss_id`, `title`, `description`, `format`, `file_size`, `status`, `category`, `is_public`, `uploader_id`, `uploader_name`, `tenant_id`, `create_by`, `create_time`) VALUES
-- (1, '示例视频', '这是一个示例视频', 'mp4', 1048576, '0', '教育', '1', 1, 'admin', '000000', 1, now()); 