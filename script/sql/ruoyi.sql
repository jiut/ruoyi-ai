/*
 Navicat Premium Dump SQL

 Source Server         : MySQL
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3306
 Source Schema         : ruoyi

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 30/06/2025 11:20:07
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for chat_agent_manage
-- ----------------------------
DROP TABLE IF EXISTS `chat_agent_manage`;
CREATE TABLE `chat_agent_manage`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `app_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用名称',
  `app_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用类型',
  `app_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用头像',
  `app_description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用描述',
  `introduction` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '开场介绍',
  `model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型',
  `conversation_model` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对话可选模型',
  `application_settings` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用设定',
  `plugin_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '插件id',
  `Knowledge_id` bigint NULL DEFAULT NULL COMMENT '知识库id',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '智能体管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_agent_manage
-- ----------------------------

-- ----------------------------
-- Table structure for chat_app_store
-- ----------------------------
DROP TABLE IF EXISTS `chat_app_store`;
CREATE TABLE `chat_app_store`  (
  `id` bigint NOT NULL COMMENT 'id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'logo',
  `app_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应用商店' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_app_store
-- ----------------------------
INSERT INTO `chat_app_store` VALUES (1, '知识库', '创建属于自己的本地知识库', 'http://panda-1253683406.cos.ap-guangzhou.myqcloud.com/panda/2025/02/11/9178bd7126b0478b9713e18844de58d4.png', '/knowledge', '', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_app_store` VALUES (2, '绘画', '开启创意绘画之旅', 'http://panda-1253683406.cos.ap-guangzhou.myqcloud.com/panda/2025/02/11/e8b4ff15af6945d09accb59f5dd6279b.png', '/draw', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_app_store` VALUES (3, '翻译', '提供精准高效的语言翻译服务', 'http://panda-1253683406.cos.ap-guangzhou.myqcloud.com/panda/2025/02/11/3b5e87263c004ba389d6af8d43552770.png', '/fanyi', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_app_store` VALUES (4, '音乐创作', '激发音乐创作潜能', 'http://panda-1253683406.cos.ap-guangzhou.myqcloud.com/panda/2025/02/11/a761c32e823945d29daeaeaf45a6dfe9.png', '/music', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_app_store` VALUES (5, '智能PPT', '一键生成专业 PPT', 'http://panda-1253683406.cos.ap-guangzhou.myqcloud.com/panda/2025/02/11/8de63c7a2d5e4c22bc8121a3c9e0fec1.png', '/ppt', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `chat_app_store` VALUES (6, '文生视频', '将文字内容转化为生动视频', 'http://panda-1253683406.cos.ap-guangzhou.myqcloud.com/panda/2025/02/11/15d878c58db248afa886032efb292467.png', '/video', NULL, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for chat_config
-- ----------------------------
DROP TABLE IF EXISTS `chat_config`;
CREATE TABLE `chat_config`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置类型',
  `config_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置名称',
  `config_value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '配置值',
  `config_dict` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '说明',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `version` int NULL DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `update_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新IP',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_category_key`(`category` ASC, `config_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1904862904897019906 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '配置信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_config
-- ----------------------------
INSERT INTO `chat_config` VALUES (1779450794448789505, 'chat', 'apiKey', 'sk-xxs', 'API 密钥', 103, '2024-04-14 18:05:05', '1', '1', '2025-03-31 19:54:16', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779450794448799507, 'cover', 'token', 'xx', '绘声美音token', 103, '2024-04-14 18:05:05', '1', '1', '2024-04-23 23:56:54', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779450794448799508, 'cover', 'cover_url', 'https://wechatscan.com/a/open/karaoke/cover', '翻唱地址', 103, '2024-04-14 18:05:05', '1', '1', '2024-04-23 23:56:54', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779450794448799509, 'cover', 'search_music_url', 'https://wechatscan.com/a/open/karaoke/search', '查找歌曲', 103, '2024-04-14 18:05:05', '1', '1', '2024-04-23 23:56:54', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779450794448799601, 'ppt', 'apiKey', 'xx', '文多多apikey', 103, '2024-04-14 18:05:05', '1', '1', '2024-04-23 23:56:54', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779450794872414210, 'chat', 'apiHost', 'https://api.pandarobot.chat/', 'API 地址', 103, '2024-04-14 18:05:05', '1', '1', '2025-03-31 19:54:16', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779450794872414211, 'chat', 'apiUrl', 'v1/chat/completions', 'API 请求后缀', 103, '2024-04-14 18:05:05', '1', '1', '2025-04-23 22:29:04', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779497340548784129, 'pay', 'pid', '1000', '商户PID', 103, '2024-04-14 21:10:02', '1', NULL, '2025-03-31 17:31:19', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779497340938854401, 'pay', 'key', 'xx', '商户密钥', 103, '2024-04-14 21:10:02', '1', NULL, '2025-03-31 17:31:19', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779497341135986690, 'pay', 'payUrl', 'https://pay.pandarobot.chat/mapi.php', '支付地址', 103, '2024-04-14 21:10:02', '1', NULL, '2025-03-31 17:31:19', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779497341400227842, 'pay', 'notify_url', 'https://www.pandarobot.chat/pay/notifyUrl', '回调地址', 103, '2024-04-14 21:10:02', '1', NULL, '2025-03-31 17:31:19', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779497341588971522, 'pay', 'return_url', 'https://www.pandarobot.chat/pay/returnUrl', '跳转通知', 103, '2024-04-14 21:10:02', '1', '1', '2024-04-28 17:46:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779513580331835394, 'mail', 'host', 'smtp.qq.com', '主机地址', 103, '2024-04-14 22:14:34', '1', '1', '2024-07-17 17:28:51', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779513580658991106, 'mail', 'port', '465', '主机端口', 103, '2024-04-14 22:14:34', '1', '1', '2024-07-17 17:28:51', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779513580919037953, 'mail', 'from', '1151386302@qq.com', '发送方', 103, '2024-04-14 22:14:34', '1', '1', '2024-07-17 17:28:51', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779513581107781634, 'mail', 'user', '1151386302@qq.com', '用户名', 103, '2024-04-14 22:14:34', '1', '1', '2024-07-17 17:28:52', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779513581309108225, 'mail', 'pass', 'wlondlmqgzmhigjc', '邮箱授权码', 103, '2024-04-14 22:14:34', '1', '1', '2024-07-17 17:28:52', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779726450625687553, 'mj', 'apiKey', 'sk-xx', 'API 密钥', 103, '2024-04-15 12:20:26', '1', '1', '2024-04-23 23:56:58', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1779726451036729346, 'mj', 'apiHost', 'https://api.pandarobot.chat/', 'API 地址', 103, '2024-04-15 12:20:26', '1', '1', '2024-04-23 23:56:59', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1782331509679181825, 'mj', 'imagine', '1', '文生图', 103, '2024-04-22 16:52:01', '1', '1', '2025-03-31 19:54:28', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1782331509939228674, 'mj', 'blend', '0', '图生图', 103, '2024-04-22 16:52:01', '1', '1', '2025-03-31 19:54:28', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1782331510199275522, 'mj', 'describe', '0', '图生文', 103, '2024-04-22 16:52:01', '1', '1', '2025-03-31 19:54:28', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1782331510392213505, 'mj', 'change', '0', '变化价格', 103, '2024-04-22 16:52:01', '1', '1', '2025-03-31 19:54:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1782331510652260353, 'mj', 'upsample', '0', '放大价格', 103, '2024-04-22 16:52:01', '1', '1', '2025-03-31 19:54:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1782331510845198338, 'mj', 'inpaint', '0', '局部重绘', 103, '2024-04-22 16:52:01', '1', '1', '2025-03-31 19:54:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1782331511117828098, 'mj', 'faceSwapping', '0', '换脸价格', 103, '2024-04-22 16:52:01', '1', '1', '2025-03-31 19:54:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1782331511306571778, 'mj', 'shorten', '0', '提示词分析', 103, '2024-04-22 16:52:01', '1', '1', '2025-03-31 19:54:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1782766864937119746, 'mail', 'amount', '999', '用户注册额度', 103, '2024-04-23 21:41:57', '1', '1', '2024-07-17 17:28:52', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1784166479104135169, 'audio', 'apiKey', 'sk-xx', 'API 密钥', 103, '2024-04-27 18:23:31', '1', '1', '2024-04-27 18:24:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1784166479615840258, 'audio', 'apiHost', 'https://v1.reecho.cn/', 'API 地址', 103, '2024-04-27 18:23:32', '1', '1', '2024-04-27 18:24:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1786058372188569602, 'review', 'enabled', 'false', '文本审核', 103, '2024-05-02 23:41:14', '1', '1', '2025-03-30 22:45:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1786058372637360129, 'review', 'apiKey', 'xx', 'apiKey', 103, '2024-05-02 23:41:14', '1', '1', '2025-03-30 22:45:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1786058372897406977, 'review', 'secretKey', 'xx', 'secretKey', 103, '2024-05-02 23:41:14', '1', '1', '2025-03-30 22:45:29', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792069350789324801, 'weixin', 'appId', 'xx', '应用ID', 103, '2024-05-19 13:46:43', '1', '1', '2025-03-28 17:33:46', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792069351246503938, 'weixin', 'appSecret', 'xx', '应用密钥', 103, '2024-05-19 13:46:43', '1', '1', '2025-03-28 17:33:47', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792069351246503939, 'weixin', 'mchId', '1677338089', '商户ID', 103, '2024-05-19 13:46:43', '1', '1', '2025-03-28 17:33:47', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792183360796790785, 'weixin', 'notifyUrl', 'https://mp.pandarobot.chat/pay/notify/wxOrder', '回调地址', 103, '2024-05-19 21:19:45', '1', '1', '2025-03-28 17:33:47', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792183361065226241, 'weixin', 'enabled', 'true', '开启支付', 103, '2024-05-19 21:19:45', '1', '1', '2025-03-28 17:33:47', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792207511704100866, 'sys', 'name', '熊猫助手', '网站名称', 103, '2024-05-19 22:55:43', '1', '1', '2025-03-26 19:48:33', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792207512089976834, 'sys', 'logoImage', 'http://panda-1253683406.cos.ap-guangzhou.myqcloud.com/panda/2024/05/19/4c106628754b4bd882a4c002eaa317f5.jpg', '网站logo', 103, '2024-05-19 22:55:43', '1', '1', '2025-03-26 19:48:33', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792207512412938241, 'sys', 'copyright', 'ageerle', '版权信息', 103, '2024-05-19 22:55:43', '1', '1', '2025-03-26 19:48:33', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792207512740093954, 'sys', 'customImage', '', '客服二维码', 103, '2024-05-19 22:55:43', '1', '1', '2025-03-26 19:48:33', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1792207512740093955, 'sys', 'activate', 'true', '系统激活状态', 103, '2024-05-19 22:55:43', '1', '1', '2024-06-04 04:26:14', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1795022320576143362, 'sys', 'authcode', '1716475338010', '证书编号', 103, '2024-05-27 17:20:46', NULL, NULL, '2024-05-27 17:20:46', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1795022320576143363, 'stripe', 'success', 'http://xx:6039/success', '成功回调', 103, '2024-05-27 17:20:46', NULL, '1', '2024-08-11 12:02:41', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1795022320576143364, 'stripe', 'cancel', 'http://xx:6039/cancel', '取消回调', 103, '2024-05-27 17:20:46', NULL, '1', '2024-08-11 12:02:41', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1795022320576143365, 'stripe', 'key', 'xx0005', '支付密钥', 103, '2024-05-27 17:20:46', NULL, '1', '2024-08-11 12:02:42', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1795022320576143366, 'stripe', 'secret', 'xx0005', '回调密钥', 103, '2024-05-27 17:20:46', NULL, '1', '2024-08-11 12:02:42', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1811317731650797570, 'mail', 'free', '3', '免费对话次数', 103, '2024-07-11 16:32:55', '1', '1', '2024-07-17 17:28:52', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1811317732300914689, 'mail', 'mailModel', '<p>您此次的验证码为：{code}，有效期为30分钟，请尽快填写!</p><p><br></p>', '邮箱模板', 103, '2024-07-11 16:32:55', '1', '1', '2024-07-17 17:28:52', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1813506141979254785, 'mail', 'mailTitle', '【亿思】验证码', '邮箱标题', 103, '2024-07-17 17:28:52', '1', '1', '2024-07-17 17:28:52', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1818270017648070657, 'stripe', 'prompt', 'This system is for demonstration only and does not currently support this feature!', '提示语', 103, '2024-07-30 20:58:49', '1', '1', '2024-08-11 12:02:42', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1818270017966837761, 'stripe', 'enabled', 'true', '开启支付', 103, '2024-07-30 20:58:49', '1', '1', '2024-08-11 12:02:42', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412050, 'weaviate', 'protocol', 'http', '协议', 103, '2025-03-06 21:10:02', '1', '1', '2025-03-06 21:10:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412051, 'weaviate', 'host', '127.0.0.1:6038', '地址', 103, '2025-03-06 21:10:02', '1', '1', '2025-03-06 21:10:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412052, 'weaviate', 'classname', 'LocalKnowledge', '分类名称', 103, '2025-03-06 21:10:02', '1', '1', '2025-03-06 21:10:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412053, 'milvus', 'host', '127.0.0.1', '地址', 103, '2025-03-06 21:10:02', '1', '1', '2025-03-06 21:10:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412054, 'milvus', 'port', '19530', '端口', 103, '2025-03-06 21:10:02', '1', '1', '2025-03-06 21:10:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412055, 'milvus', 'dimension', '1536', '维度', 103, '2025-03-06 21:10:02', '1', '1', '2025-03-06 21:10:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412056, 'milvus', 'collection', 'LocalKnowledge', '分类名称', 103, '2025-03-06 21:10:02', '1', '1', '2025-03-06 21:10:31', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1897610056458412057, 'zhipu', 'key', '', '智谱清言key', 103, '2025-03-12 00:13:12', '1', '1', '2025-03-12 00:13:10', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_config` VALUES (1904862904897019905, 'sys', 'model', '', '系统模型', 103, '2025-03-26 19:48:02', '1', '1', '2025-03-26 19:48:02', NULL, NULL, '0', NULL, 0);

-- ----------------------------
-- Table structure for chat_gpts
-- ----------------------------
DROP TABLE IF EXISTS `chat_gpts`;
CREATE TABLE `chat_gpts`  (
  `id` bigint NOT NULL COMMENT 'id',
  `gid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'gpts应用id',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'gpts应用名称',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'gpts图标',
  `info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'gpts描述',
  `author_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者id',
  `author_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作者名称',
  `use_cnt` int NULL DEFAULT 0 COMMENT '点赞',
  `bad` int NULL DEFAULT 0 COMMENT '差评',
  `type` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类型',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `version` int NULL DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `update_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新IP',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '应用管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_gpts
-- ----------------------------
INSERT INTO `chat_gpts` VALUES (1810602934286237698, 'gpt-4-gizmo-g-RQAWjtI6u', '翻译助手', 'https://external-content.duckduckgo.com/ip3/chat.openai.com.ico', '中英和英中翻译专家', NULL, NULL, 0, 0, NULL, 103, '2024-07-09 17:12:34', '1', '1', '2024-07-12 15:40:13', 'Ms. Smith, the AI-powered Language Teacher, is a revolutionary GPT-based bot that offers personalized language learning experiences in over 20 languages, including Spanish, German, French, English, Chinese, Korean, Japanese, and more\n', NULL, '0', NULL, 0);
INSERT INTO `chat_gpts` VALUES (1811668415990931458, 'gpt-4-gizmo-g-XbReEL4Uq', '清北全科医生', 'https://external-content.duckduckgo.com/ip3/chat.openai.com.ico', '富有同情心的全科医生提供健康指导', NULL, NULL, 0, 0, NULL, 103, '2024-07-12 15:46:24', '1', '1', '2024-07-12 15:46:24', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_gpts` VALUES (1811670922074988545, 'gpt-4-gizmo-g-AphhNRLxt', '提示词优化', 'https://external-content.duckduckgo.com/ip3/chat.openai.com.ico', '擅长为Prompt 提升清晰度和创造力的大师', NULL, NULL, 0, 0, NULL, 103, '2024-07-12 15:56:22', '1', '1', '2024-07-12 15:56:22', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_gpts` VALUES (1811815442062188545, 'gpt-4-gizmo-g-ThuHxKi7e', '小红书文案生成器', 'https://external-content.duckduckgo.com/ip3/chat.openai.com.ico', '小红书文案生成器', NULL, NULL, 0, 0, NULL, 103, '2024-07-13 01:30:38', '1', '1', '2024-07-13 01:30:38', NULL, NULL, '0', NULL, 0);
INSERT INTO `chat_gpts` VALUES (1811817605668741121, 'gpt-4-gizmo-g-AsQCd3k8', '中国法律助手', 'https://external-content.duckduckgo.com/ip3/chat.openai.com.ico', '全面掌握中国法律的智能助手，可帮助起草文书，分析案件，进行法律咨询', NULL, NULL, 0, 0, NULL, 103, '2024-07-13 01:39:14', '1', '1', '2024-07-13 01:39:14', NULL, NULL, '2', NULL, 0);
INSERT INTO `chat_gpts` VALUES (1811817605668741122, 'gpt-4-gizmo-g-IXwub6dJu', '英语老师', 'https://external-content.duckduckgo.com/ip3/chat.openai.com.ico', '英语学习GPT是一个专门设计来帮助用户提高他们的英语技能的人工智能助手', NULL, NULL, 0, 0, NULL, NULL, NULL, '', '', NULL, NULL, NULL, '0', NULL, 0);

-- ----------------------------
-- Table structure for chat_message
-- ----------------------------
DROP TABLE IF EXISTS `chat_message`;
CREATE TABLE `chat_message`  (
  `id` bigint NOT NULL COMMENT '主键',
  `session_id` bigint NULL DEFAULT NULL COMMENT '会话id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '消息内容',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '对话角色',
  `deduct_cost` double(20, 2) NULL DEFAULT 0.00 COMMENT '扣除金额',
  `total_tokens` int NULL DEFAULT 0 COMMENT '累计 Tokens',
  `model_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型名称',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天消息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_message
-- ----------------------------

-- ----------------------------
-- Table structure for chat_model
-- ----------------------------
DROP TABLE IF EXISTS `chat_model`;
CREATE TABLE `chat_model`  (
  `id` bigint NOT NULL COMMENT '主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `category` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型分类',
  `model_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型名称',
  `model_describe` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型描述',
  `model_price` double NULL DEFAULT NULL COMMENT '模型价格',
  `model_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '计费类型',
  `model_show` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否显示',
  `system_prompt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统提示词',
  `api_host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求地址',
  `api_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '密钥',
  `api_url` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求后缀',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天模型' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_model
-- ----------------------------
INSERT INTO `chat_model` VALUES (1781709495515783171, '000000', 'chat', 'gpt-4-all', 'gpt-4-hhh', 0, '2', '0', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-20 23:40:41', 1, '2025-03-31 16:32:19', 'My name is Tr0e');
INSERT INTO `chat_model` VALUES (1781715781896646657, '000000', 'chat', 'suno-v3', 'suno-v3', 0.3, '1', '0', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-21 00:05:20', 1, '2025-03-31 13:24:33', 'suno-v3');
INSERT INTO `chat_model` VALUES (1781728235120791553, '000000', 'chat', 'stable-diffusion', 'stable-diffusion', 0.1, '2', '1', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-21 00:54:49', 1, '2025-03-26 10:46:38', 'stable-diffusion');
INSERT INTO `chat_model` VALUES (1782736322308943873, '000000', 'chat', 'dall-e-3', 'dall3', 0.3, '2', '1', '', 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-23 19:40:36', 1, '2025-03-27 10:08:07', 'dall3');
INSERT INTO `chat_model` VALUES (1782736729471004673, '000000', 'chat', 'gpt-4-gizmo', 'gpt-4-gizmo', 0.2, '2', '1', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-23 19:42:13', 1, '2025-03-06 20:16:42', 'gpt-4-gizmo');
INSERT INTO `chat_model` VALUES (1782792839548735490, '000000', 'chat', 'midjourney', 'midjourney', 0.5, '2', '1', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-23 23:25:10', 1, '2025-03-23 09:15:55', 'midjourney');
INSERT INTO `chat_model` VALUES (1782792839548735491, '000000', 'chat', 'suno', 'suno', 0.3, '2', '1', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-23 23:25:10', 1, '2024-12-27 22:29:15', 'suno');
INSERT INTO `chat_model` VALUES (1782792839548735492, '000000', 'chat', 'luma', 'luma', 1, '2', '1', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-04-23 23:25:10', 1, '2025-03-27 10:08:15', 'luma');
INSERT INTO `chat_model` VALUES (1782792839548735493, '000000', 'chat', 'ppt', 'ppt', 1.1, '2', '1', NULL, 'https://docmee.cn', 'sk-xx', NULL, 103, 1, '2025-01-10 23:25:10', 1, '2025-03-22 08:30:29', 'ppt');
INSERT INTO `chat_model` VALUES (1811030708604317697, '000000', 'chat', 'gemini-1.5-pro', 'gemini-1.5-pro', 0.2, '1', '0', '', 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-07-10 21:32:23', 1, '2025-03-27 16:37:17', 'gemini-1.5-pro');
INSERT INTO `chat_model` VALUES (1813306888443305986, '000000', 'chat', 'claude-3-5-sonnet-20240620', 'claude-3-5-sonnet-20240620', 0.2, '1', '1', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-07-17 04:17:06', 1, '2025-03-23 09:15:49', 'claude-3-5-sonnet-20240620');
INSERT INTO `chat_model` VALUES (1814227154275082242, '000000', 'chat', 'o1-mini-2024-09-12', 'o1-mini-2024-09-12', 0.01, '1', '1', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-07-19 17:13:55', 1, '2025-03-23 09:15:41', 'o1-mini-2024-09-12');
INSERT INTO `chat_model` VALUES (1828324413241466881, '000000', 'chat', 'deepseek-r1', 'deepseek-r1', 0.01, '1', '0', NULL, 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-08-27 14:51:23', NULL, '2025-03-27 16:21:04', 'chatgpt-4o-latest');
INSERT INTO `chat_model` VALUES (1859570229117022211, '000000', 'chat', 'gpt-4o-mini', 'gpt-4o-mini', 0.1, '2', '0', '', 'https://api.pandarobot.chat/', 'sk-xx', NULL, 103, 1, '2024-11-21 20:11:06', 1, '2025-03-27 16:20:39', '1');
INSERT INTO `chat_model` VALUES (1907575746601119746, '000000', 'vector', 'text-embedding-3-small', 'text-embedding-3-small', 0, '2', '0', NULL, 'https://api.pandarobot.chat/', 'sk-cdBlIaZcufccm2RaDe547cBd054d49C7B0782eCa72A0052b', NULL, 103, 1, '2025-04-03 07:27:54', 1, '2025-04-03 07:27:54', 'text-embedding-3-small');
INSERT INTO `chat_model` VALUES (1907576007017066497, '000000', 'vector', 'quentinz/bge-large-zh-v1.5', 'bge-large-zh-v1.5', 0, '2', '0', NULL, 'http://127.0.0.1:11434/', 'cdBlIaZcufccm2RaDe547cBd054d49C7B0782eCa72A0052b', NULL, 103, 1, '2025-04-03 07:28:56', 1, '2025-04-03 07:28:56', 'bge-large-zh-v1.5');
INSERT INTO `chat_model` VALUES (1907576806191362049, '000000', 'vector', 'nomic-embed-text', 'nomic-embed-text', 0, '2', '0', NULL, 'http://127.0.0.1:11434/', 'nomic-embed-text', NULL, 103, 1, '2025-04-03 07:32:06', 1, '2025-04-03 07:32:06', 'nomic-embed-text');
INSERT INTO `chat_model` VALUES (1907577073490161665, '000000', 'vector', 'snowflake-arctic-embed', 'snowflake-arctic-embed', 0, '2', '0', NULL, 'http://127.0.0.1:11434/', 'snowflake-arctic-embed', NULL, 103, 1, '2025-04-03 07:33:10', 1, '2025-04-03 07:33:10', 'snowflake-arctic-embed');

-- ----------------------------
-- Table structure for chat_package_plan
-- ----------------------------
DROP TABLE IF EXISTS `chat_package_plan`;
CREATE TABLE `chat_package_plan`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '套餐名称',
  `price` double(10, 2) NOT NULL COMMENT '套餐价格',
  `duration` int NOT NULL COMMENT '有效时间',
  `plan_detail` varchar(5000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '计划详情',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1819934166912442370 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '套餐管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_package_plan
-- ----------------------------
INSERT INTO `chat_package_plan` VALUES (1787085620534378498, '初级套餐', 4.90, 30, 'o1-mini-2024-09-12', 103, 1, '2024-05-05 19:43:09', 1, '2024-08-27 15:00:35', '3');
INSERT INTO `chat_package_plan` VALUES (1787085808271425538, '中级套餐', 9.90, 30, 'o1-mini-2024-09-12', 103, 1, '2024-05-05 19:43:54', 1, '2024-08-27 15:01:32', '3');
INSERT INTO `chat_package_plan` VALUES (1787085903419211778, '高级套餐', 14.90, 30, 'o1-mini-2024-09-12', 103, 1, '2024-05-05 19:44:16', 1, '2024-08-27 15:02:16', '3');
INSERT INTO `chat_package_plan` VALUES (1819933853652459522, 'Visitor', 0.00, 365, 'o1-mini-2024-09-12', 103, 1, '2024-08-04 11:10:18', 1, '2024-08-27 15:32:01', '1');
INSERT INTO `chat_package_plan` VALUES (1819934166912442369, 'Free', 0.00, 365, 'o1-mini-2024-09-12', 103, 1, '2024-08-04 11:11:33', 1, '2024-08-27 15:31:51', '2');

-- ----------------------------
-- Table structure for chat_pay_order
-- ----------------------------
DROP TABLE IF EXISTS `chat_pay_order`;
CREATE TABLE `chat_pay_order`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `order_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单编号',
  `order_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '订单名称',
  `amount` decimal(10, 2) NOT NULL COMMENT '金额',
  `payment_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付状态',
  `payment_method` char(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '支付方式',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户ID',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '支付订单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_pay_order
-- ----------------------------

-- ----------------------------
-- Table structure for chat_plugin
-- ----------------------------
DROP TABLE IF EXISTS `chat_plugin`;
CREATE TABLE `chat_plugin`  (
  `id` bigint NOT NULL COMMENT '主键',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '插件名称',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '插件编码',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '插件管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_plugin
-- ----------------------------

-- ----------------------------
-- Table structure for chat_rob_config
-- ----------------------------
DROP TABLE IF EXISTS `chat_rob_config`;
CREATE TABLE `chat_rob_config`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` bigint NULL DEFAULT NULL COMMENT '所属用户',
  `bot_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '机器人名称',
  `unique_key` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '机器唯一码',
  `default_friend` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '\0' COMMENT '默认好友回复开关',
  `default_group` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '\0' COMMENT '默认群回复开关',
  `enable` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '机器人状态  0正常 1启用',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `udx_wx_rob_config_uniquekey`(`unique_key` ASC) USING BTREE,
  UNIQUE INDEX `udx_wx_name`(`bot_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '聊天机器人配置' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_rob_config
-- ----------------------------

-- ----------------------------
-- Table structure for chat_session
-- ----------------------------
DROP TABLE IF EXISTS `chat_session`;
CREATE TABLE `chat_session`  (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `session_title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '会话标题',
  `session_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '会话内容',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '会话管理' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_session
-- ----------------------------

-- ----------------------------
-- Table structure for chat_usage_token
-- ----------------------------
DROP TABLE IF EXISTS `chat_usage_token`;
CREATE TABLE `chat_usage_token`  (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NOT NULL COMMENT '用户',
  `token` int NULL DEFAULT NULL COMMENT '待结算token',
  `model_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '模型名称',
  `total_token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '累计使用token',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户token使用详情' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_usage_token
-- ----------------------------

-- ----------------------------
-- Table structure for chat_voucher
-- ----------------------------
DROP TABLE IF EXISTS `chat_voucher`;
CREATE TABLE `chat_voucher`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '主键',
  `code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '兑换码',
  `amount` double(10, 2) NOT NULL COMMENT '兑换金额',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '兑换状态',
  `balance_before` double(10, 2) NULL DEFAULT NULL COMMENT '兑换前余额',
  `balance_after` double(10, 2) NULL DEFAULT NULL COMMENT '兑换后余额',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户兑换记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of chat_voucher
-- ----------------------------

-- ----------------------------
-- Table structure for des_award
-- ----------------------------
DROP TABLE IF EXISTS `des_award`;
CREATE TABLE `des_award`  (
  `award_id` bigint NOT NULL AUTO_INCREMENT COMMENT '获奖ID',
  `designer_id` bigint NOT NULL COMMENT '设计师ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '奖项名称',
  `organization` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '颁发机构',
  `year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '获奖年份',
  `level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '奖项等级',
  `category` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '奖项类别',
  `work_title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '获奖作品',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  `certificate_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '证书链接',
  `sort` int NULL DEFAULT 0 COMMENT '排序号',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`award_id`) USING BTREE,
  INDEX `idx_designer_id`(`designer_id` ASC) USING BTREE,
  INDEX `idx_year`(`year` ASC) USING BTREE,
  INDEX `idx_sort`(`sort` ASC) USING BTREE,
  INDEX `idx_category`(`category` ASC) USING BTREE,
  CONSTRAINT `fk_award_designer` FOREIGN KEY (`designer_id`) REFERENCES `des_designer` (`designer_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设计师获奖表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_award
-- ----------------------------
INSERT INTO `des_award` VALUES (1, 1, '2023 iF 设计奖', 'iF International Forum Design', '2023', '金奖', 'UI/UX设计', '腾讯社交产品界面设计', '腾讯社交产品界面设计获得国际认可，在用户体验和视觉设计方面表现出色', NULL, 1, '0', NULL, NULL, '2023-01-01 00:00:00', NULL, '2023-01-01 00:00:00');
INSERT INTO `des_award` VALUES (2, 1, 'Google UX 设计专业认证', 'Google', '2021', '认证', '专业认证', NULL, '通过Google官方用户体验设计课程认证，掌握专业的UX设计方法和工具', NULL, 2, '0', NULL, NULL, '2021-01-01 00:00:00', NULL, '2021-01-01 00:00:00');
INSERT INTO `des_award` VALUES (3, 1, '中国设计红星奖', '中国工业设计协会', '2022', '银奖', 'UI设计', '智慧出行APP界面设计', '移动应用UI设计作品获得红星奖，体现了优秀的设计创新能力', NULL, 3, '0', NULL, NULL, '2022-01-01 00:00:00', NULL, '2022-01-01 00:00:00');
INSERT INTO `des_award` VALUES (4, 2, 'D&AD 设计奖', 'D&AD', '2023', '铜奖', '品牌设计', '绿色科技公司品牌设计', '品牌设计作品在国际设计大赛中获奖，展现了卓越的创意表达能力', NULL, 1, '0', NULL, NULL, '2023-01-01 00:00:00', NULL, '2023-01-01 00:00:00');
INSERT INTO `des_award` VALUES (5, 2, '亚洲设计大奖', '亚洲设计师联盟', '2022', '优秀奖', '包装设计', '咖啡品牌包装设计', '包装设计作品获得亚洲设计大奖，在视觉创意和实用性方面获得好评', NULL, 2, '0', NULL, NULL, '2022-01-01 00:00:00', NULL, '2022-01-01 00:00:00');
INSERT INTO `des_award` VALUES (6, 3, '国际动画节最佳角色设计奖', '安纳西国际动画节', '2023', '最佳奖', '角色设计', '科幻角色设计系列', '原创角色设计作品在国际动画节中获得最佳角色设计奖，获得业内高度认可', NULL, 1, '0', NULL, NULL, '2023-01-01 00:00:00', NULL, '2023-01-01 00:00:00');
INSERT INTO `des_award` VALUES (7, 3, 'CGI 全球设计大赛', 'CGI Society', '2022', '金奖', '3D动画', '产品宣传动画', '3D动画作品在全球设计大赛中获奖，技术实力和创意表达获得认可', NULL, 2, '0', NULL, NULL, '2022-01-01 00:00:00', NULL, '2022-01-01 00:00:00');
INSERT INTO `des_award` VALUES (8, 4, 'UX Design Awards', 'UX Design Institute', '2023', '优秀奖', '用户体验设计', NULL, 'B端产品用户体验设计获得专业认可，在复杂业务场景设计方面表现突出', NULL, 1, '0', NULL, NULL, '2023-01-01 00:00:00', NULL, '2023-01-01 00:00:00');
INSERT INTO `des_award` VALUES (9, 5, '全国大学生设计大赛', '教育部', '2020', '一等奖', '交互设计', NULL, '在校期间参与全国大学生设计大赛并获奖，展现了良好的设计基础和创新能力', NULL, 1, '0', NULL, NULL, '2020-01-01 00:00:00', NULL, '2020-01-01 00:00:00');

-- ----------------------------
-- Table structure for des_designer
-- ----------------------------
DROP TABLE IF EXISTS `des_designer`;
CREATE TABLE `des_designer`  (
  `designer_id` bigint NOT NULL AUTO_INCREMENT COMMENT '设计师ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '关联用户ID',
  `designer_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '设计师姓名',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像',
  `gender` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '性别（0男 1女 2未知）',
  `birth_date` date NULL DEFAULT NULL COMMENT '出生日期',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系邮箱',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '个人简介',
  `profession` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职业（插画师、交互设计师等）',
  `skill_tags` json NULL COMMENT '技能标签（JSON数组格式）',
  `work_years` int NULL DEFAULT NULL COMMENT '工作年限',
  `work_status` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作状态（EMPLOYED在职、FREELANCER自由职业者等）',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作地点',
  `school_id` bigint NULL DEFAULT NULL COMMENT '所属院校ID（可为空）',
  `enterprise_id` bigint NULL DEFAULT NULL COMMENT '所属企业ID（可为空）',
  `graduation_date` date NULL DEFAULT NULL COMMENT '毕业时间（如果是学生）',
  `join_date` date NULL DEFAULT NULL COMMENT '入职时间（如果有企业）',
  `portfolio_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '作品集链接',
  `social_links` json NULL COMMENT '社交媒体链接（JSON格式）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`designer_id`) USING BTREE,
  INDEX `idx_profession`(`profession` ASC) USING BTREE,
  INDEX `idx_school_id`(`school_id` ASC) USING BTREE,
  INDEX `idx_enterprise_id`(`enterprise_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_work_status`(`work_status` ASC) USING BTREE,
  CONSTRAINT `des_designer_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE SET NULL ON UPDATE RESTRICT,
  CONSTRAINT `des_designer_ibfk_2` FOREIGN KEY (`enterprise_id`) REFERENCES `des_enterprise` (`enterprise_id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 21 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设计师信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_designer
-- ----------------------------
INSERT INTO `des_designer` VALUES (1, 1, '陈雨晴', 'https://api.dicebear.com/9.x/shapes/svg?seed=chenyu', '1', '1995-06-15', '13812345678', 'chenyu@example.com', '拥有 5 年 UI/UX 设计经验，专注于移动应用和 Web 产品的用户体验设计。擅长用户研究、交互设计和视觉设计，能够从用户需求出发，打造直观易用的产品界面。曾主导腾讯多个核心产品的设计工作，包括社交、游戏和企业应用等领域。精通用户研究方法，具备敏锐的用户洞察力和优秀的设计执行力。', 'UI_UX_DESIGNER', '[\"figma\", \"user_research\", \"interaction_design\", \"prototype_design\", \"design_system\"]', 5, 'EMPLOYED', '深圳市南山区', 1, 1, '2018-06-30', '2022-03-01', 'https://chenyudesign.com', '{\"behance\": \"https://behance.net/chenyu\", \"dribbble\": \"https://dribbble.com/chenyu\", \"linkedin\": \"https://linkedin.com/in/chenyu\"}', '0', NULL, NULL, '2023-01-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (2, 2, '林子豪', 'https://api.dicebear.com/9.x/shapes/svg?seed=linzihao', '0', '1990-03-22', '13923456789', 'linzihao@example.com', '专业视觉设计师，专注于品牌设计和视觉传达。拥有丰富的品牌标识设计经验，善于通过视觉语言传达品牌价值。曾为多家知名企业设计品牌形象，包括LOGO设计、VI系统、包装设计等。在色彩搭配和字体设计方面有独到见解，作品风格简约而富有张力。', 'VISUAL_DESIGNER', '[\"photoshop\", \"illustrator\", \"brand_design\", \"typography\", \"visual_design\"]', 7, 'EMPLOYED', '上海市浦东新区', NULL, 2, NULL, NULL, 'https://linzihaodesign.com', '{\"behance\": \"https://behance.net/linzihao\", \"instagram\": \"https://instagram.com/linzihao\"}', '0', NULL, NULL, '2022-06-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (3, 3, '王梦琪', 'https://api.dicebear.com/9.x/shapes/svg?seed=wangmengqi', '1', '1992-08-10', '13634567890', 'wangmengqi@example.com', '3D 动画设计师，专注于三维建模和动画制作。拥有丰富的影视和游戏行业经验，擅长角色建模、场景设计和动画制作。作品曾在多个国际动画节获奖，具备扎实的美术功底和前沿的技术实力。', 'THREE_D_DESIGNER', '[\"blender\", \"cinema_4d\", \"animation_design\", \"character_design\", \"visual_design\"]', 4, 'FREELANCER', '北京市朝阳区', NULL, NULL, NULL, NULL, 'https://wangmengqi3d.com', '{\"artstation\": \"https://artstation.com/wangmengqi\"}', '0', NULL, NULL, '2023-03-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (4, 4, '赵明宇', 'https://api.dicebear.com/9.x/shapes/svg?seed=zhaomingyu', '0', '1991-12-05', '13745678901', 'zhaomingyu@example.com', '产品设计师，专注于数字产品的用户体验设计和产品策略。拥有深厚的产品思维和用户洞察能力，善于从商业目标出发，设计既美观又实用的产品界面。在B端产品设计方面经验丰富，曾主导多个企业级产品的设计工作。', 'PRODUCT_DESIGNER', '[\"sketch\", \"prototype_design\", \"user_experience\", \"design_system\", \"user_research\"]', 6, 'EMPLOYED', '杭州市西湖区', NULL, 3, NULL, NULL, 'https://zhaomingyu.design', '{\"medium\": \"https://medium.com/@zhaomingyu\"}', '0', NULL, NULL, '2022-09-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (5, 5, '李思雨', 'https://api.dicebear.com/9.x/shapes/svg?seed=lisiyu', '1', '1996-04-18', '13856789012', 'lisiyu@example.com', '交互设计师，专注于数字产品的交互体验设计。具备丰富的用户研究经验和交互设计技能，善于通过原型设计和用户测试验证设计方案。曾参与多个大型互联网产品的交互设计工作，在移动端交互设计方面有深入研究。', 'INTERACTION_DESIGNER', '[\"figma\", \"prototype_design\", \"user_research\", \"wireframing\", \"user_testing\"]', 3, 'EMPLOYED', '成都市高新区', 2, NULL, '2020-06-30', '2020-07-15', 'https://lisiyu.design', '{\"github\": \"https://github.com/lisiyu\", \"dribbble\": \"https://dribbble.com/lisiyu\"}', '0', NULL, NULL, '2023-05-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (6, 6, '张伟强', 'https://api.dicebear.com/9.x/shapes/svg?seed=zhangweiqiang', '0', '1989-09-30', '13967890123', 'zhangweiqiang@example.com', '品牌设计师，专注于企业品牌形象设计和视觉识别系统构建。拥有多年品牌设计经验，为众多知名企业提供过品牌设计服务。擅长将品牌理念转化为视觉符号，在LOGO设计、VI系统、包装设计等领域具备专业能力。', 'BRAND_DESIGNER', '[\"illustrator\", \"photoshop\", \"brand_design\", \"typography\", \"color_theory\"]', 8, 'FREELANCER', '广州市天河区', NULL, NULL, NULL, NULL, 'https://zhangweiqiang.design', '{\"behance\": \"https://behance.net/zhangweiqiang\", \"instagram\": \"https://instagram.com/zhangweiqiang\"}', '0', NULL, NULL, '2022-01-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (7, 7, '刘小雅', 'https://api.dicebear.com/9.x/shapes/svg?seed=liuxiaoya', '1', '1994-07-12', '13078901234', 'liuxiaoya@example.com', '动效设计师，专注于数字媒体动画和视觉特效设计。具备丰富的动效制作经验，善于运用各种动效技术创造引人入胜的视觉体验。作品涵盖品牌动画、产品演示动画、UI动效等多个领域，在创意表达和技术实现方面都有出色表现。', 'MOTION_DESIGNER', '[\"after_effects\", \"cinema_4d\", \"animation_design\", \"visual_design\", \"illustration\"]', 4, 'EMPLOYED', '武汉市洪山区', NULL, 4, NULL, NULL, 'https://liuxiaoya.motion', '{\"vimeo\": \"https://vimeo.com/liuxiaoya\", \"behance\": \"https://behance.net/liuxiaoya\"}', '0', NULL, NULL, '2023-02-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (8, 8, '孙志华', 'https://api.dicebear.com/9.x/shapes/svg?seed=sunzhihua', '0', '1990-11-28', '13189012345', 'sunzhihua@example.com', '插画师，专注于商业插画和角色设计。具备扎实的美术功底和独特的创作风格，作品风格多样，能够根据不同项目需求调整创作方向。在儿童绘本、品牌插画、游戏角色设计等领域有丰富经验，作品多次获得业内认可。', 'ILLUSTRATOR', '[\"illustrator\", \"photoshop\", \"illustration\", \"character_design\", \"visual_design\"]', 6, 'FREELANCER', '西安市雁塔区', NULL, NULL, NULL, NULL, 'https://sunzhihua.art', '{\"instagram\": \"https://instagram.com/sunzhihua\", \"artstation\": \"https://artstation.com/sunzhihua\"}', '0', NULL, NULL, '2022-08-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (9, 9, '周雅琪', 'https://api.dicebear.com/9.x/shapes/svg?seed=zhouyaqi', '1', '1993-05-14', '13290123456', 'zhouyaqi@example.com', '平面设计师，专注于印刷品设计和数字媒体设计。在杂志排版、海报设计、宣传册制作等方面有丰富经验。善于运用色彩和排版创造视觉冲击力，作品风格现代简约，注重信息传达的清晰性和美观性。', 'GRAPHIC_DESIGNER', '[\"photoshop\", \"illustrator\", \"graphic_design\", \"typography\", \"layout_design\"]', 5, 'EMPLOYED', '南京市鼓楼区', NULL, 5, NULL, NULL, 'https://zhouyaqi.design', '{\"behance\": \"https://behance.net/zhouyaqi\", \"pinterest\": \"https://pinterest.com/zhouyaqi\"}', '0', NULL, NULL, '2022-11-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (10, 10, '吴志强', 'https://api.dicebear.com/9.x/shapes/svg?seed=wuzhiqiang', '0', '1994-09-20', '13301234567', 'wuzhiqiang@example.com', 'UI设计师，专注于移动应用和Web界面的视觉设计。具备敏锐的视觉感知能力和优秀的设计执行力，善于将品牌元素融入界面设计中。在电商、金融、教育等多个行业有丰富的设计经验，作品注重用户体验和视觉美感的平衡。', 'UI_DESIGNER', '[\"figma\", \"sketch\", \"ui_design\", \"visual_design\", \"design_system\"]', 4, 'EMPLOYED', '苏州市工业园区', NULL, 6, NULL, NULL, 'https://wuzhiqiang.design', '{\"dribbble\": \"https://dribbble.com/wuzhiqiang\", \"linkedin\": \"https://linkedin.com/in/wuzhiqiang\"}', '0', NULL, NULL, '2023-01-15 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (11, 11, '林小雨', 'https://api.dicebear.com/9.x/shapes/svg?seed=linxiaoyu', '1', '1991-12-08', '13412345678', 'linxiaoyu@example.com', 'UX设计师，专注于用户体验研究和交互设计。具备深厚的用户研究背景，善于通过数据分析和用户访谈洞察用户需求。在复杂业务场景的UX设计方面有丰富经验，曾为多个大型企业级产品提供用户体验优化服务。', 'UX_DESIGNER', '[\"user_research\", \"prototype_design\", \"user_testing\", \"information_architecture\", \"wireframing\"]', 6, 'EMPLOYED', '重庆市渝北区', NULL, 7, NULL, NULL, 'https://linxiaoyu.ux', '{\"medium\": \"https://medium.com/@linxiaoyu\", \"linkedin\": \"https://linkedin.com/in/linxiaoyu\"}', '0', NULL, NULL, '2022-07-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (12, 12, '陈志明', 'https://api.dicebear.com/9.x/shapes/svg?seed=chenzhiming', '0', '1989-04-16', '13523456789', 'chenzhiming@example.com', '动效设计师，专注于数字媒体动画和视觉特效制作。具备丰富的影视后期制作经验，善于运用各种动效技术创造震撼的视觉体验。作品涵盖广告动画、产品演示、品牌宣传片等多个领域，在创意表达和技术实现方面都有出色表现。', 'MOTION_DESIGNER', '[\"after_effects\", \"cinema_4d\", \"motion_design\", \"animation\", \"visual_effects\"]', 7, 'FREELANCER', '天津市和平区', NULL, NULL, NULL, NULL, 'https://chenzhiming.motion', '{\"vimeo\": \"https://vimeo.com/chenzhiming\", \"instagram\": \"https://instagram.com/chenzhiming\"}', '0', NULL, NULL, '2022-03-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (13, 13, '黄雅婷', 'https://api.dicebear.com/9.x/shapes/svg?seed=huangyating', '1', '1992-07-25', '13634567890', 'huangyating@example.com', 'UI/UX设计师，专注于移动应用和Web产品的用户体验设计。具备深厚的用户研究背景和优秀的设计执行力，善于通过数据驱动的方法优化产品体验。在电商、社交、教育等多个领域有丰富经验，作品注重用户需求和商业目标的平衡。', 'UI_UX_DESIGNER', '[\"figma\", \"sketch\", \"user_research\", \"prototype_design\", \"design_system\"]', 5, 'EMPLOYED', '厦门市思明区', NULL, 8, NULL, NULL, 'https://huangyating.design', '{\"dribbble\": \"https://dribbble.com/huangyating\", \"linkedin\": \"https://linkedin.com/in/huangyating\"}', '0', NULL, NULL, '2022-09-15 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (14, 14, '杨志强', 'https://api.dicebear.com/9.x/shapes/svg?seed=yangzhiqiang', '0', '1988-11-12', '13745678901', 'yangzhiqiang@example.com', '品牌设计师，专注于企业品牌形象设计和视觉识别系统构建。拥有多年品牌设计经验，为众多知名企业提供过品牌设计服务。擅长将品牌理念转化为视觉符号，在LOGO设计、VI系统、品牌应用等方面具备专业能力。', 'BRAND_DESIGNER', '[\"illustrator\", \"photoshop\", \"brand_design\", \"typography\", \"visual_identity\"]', 8, 'FREELANCER', '青岛市市南区', NULL, NULL, NULL, NULL, 'https://yangzhiqiang.brand', '{\"behance\": \"https://behance.net/yangzhiqiang\", \"instagram\": \"https://instagram.com/yangzhiqiang\"}', '0', NULL, NULL, '2021-12-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (15, 15, '刘梦琪', 'https://api.dicebear.com/9.x/shapes/svg?seed=liumengqi', '1', '1991-03-18', '13856789012', 'liumengqi@example.com', '3D设计师，专注于三维建模和角色设计。具备扎实的美术功底和前沿的技术实力，在游戏美术、影视特效、产品展示等领域有丰富经验。擅长角色建模、场景设计和动画制作，作品风格独特，技术精湛。', 'THREE_D_DESIGNER', '[\"blender\", \"maya\", \"3d_modeling\", \"character_design\", \"animation_design\"]', 6, 'EMPLOYED', '大连市中山区', NULL, 9, NULL, NULL, 'https://liumengqi.3d', '{\"instagram\": \"https://instagram.com/liumengqi\", \"artstation\": \"https://artstation.com/liumengqi\"}', '0', NULL, NULL, '2022-05-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (16, 16, '张雅文', 'https://api.dicebear.com/9.x/shapes/svg?seed=zhangyawen', '1', '1995-08-30', '13967890123', 'zhangyawen@example.com', '产品设计师，专注于数字产品的用户体验设计和产品策略。具备深厚的产品思维和用户洞察能力，善于从商业目标出发，设计既美观又实用的产品界面。在B端产品设计方面经验丰富，曾主导多个企业级产品的设计工作。', 'PRODUCT_DESIGNER', '[\"sketch\", \"figma\", \"user_experience\", \"prototype_design\", \"design_system\"]', 4, 'EMPLOYED', '无锡市滨湖区', NULL, 10, NULL, NULL, 'https://zhangyawen.product', '{\"medium\": \"https://medium.com/@zhangyawen\", \"linkedin\": \"https://linkedin.com/in/zhangyawen\"}', '0', NULL, NULL, '2023-02-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (17, 17, '王浩然', 'https://api.dicebear.com/9.x/shapes/svg?seed=wanghaoran', '0', '1993-01-15', '13078901234', 'wanghaoran@example.com', '交互设计师，专注于数字产品的交互体验设计。具备丰富的用户研究经验和交互设计技能，善于通过原型设计和用户测试验证设计方案。曾参与多个大型互联网产品的交互设计工作，在移动端交互设计方面有深入研究。', 'INTERACTION_DESIGNER', '[\"figma\", \"axure_rp\", \"user_research\", \"wireframing\", \"user_testing\"]', 5, 'EMPLOYED', '福州市鼓楼区', NULL, 11, NULL, NULL, 'https://wanghaoran.interaction', '{\"github\": \"https://github.com/wanghaoran\", \"dribbble\": \"https://dribbble.com/wanghaoran\"}', '0', NULL, NULL, '2022-11-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (18, 18, '李雅琴', 'https://api.dicebear.com/9.x/shapes/svg?seed=liyaqin', '1', '1990-06-22', '13189012345', 'liyaqin@example.com', '视觉设计师，专注于品牌视觉设计和视觉传达。拥有丰富的视觉设计经验，善于通过色彩、字体、图形等视觉元素传达品牌价值。在品牌标识设计、视觉系统构建、创意广告设计等方面有专业能力。', 'VISUAL_DESIGNER', '[\"photoshop\", \"illustrator\", \"visual_design\", \"color_theory\", \"typography\"]', 7, 'FREELANCER', '济南市历下区', NULL, NULL, NULL, NULL, 'https://liyaqin.visual', '{\"behance\": \"https://behance.net/liyaqin\", \"pinterest\": \"https://pinterest.com/liyaqin\"}', '0', NULL, NULL, '2022-01-15 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (19, 19, '陈志豪', 'https://api.dicebear.com/9.x/shapes/svg?seed=chenzhihao', '0', '1992-12-08', '13290123456', 'chenzhihao@example.com', '插画师，专注于商业插画和概念设计。具备扎实的美术功底和独特的创作风格，作品风格多样，能够根据不同项目需求调整创作方向。在游戏美术、品牌插画、概念设计等领域有丰富经验，作品多次获得业内认可。', 'ILLUSTRATOR', '[\"illustrator\", \"photoshop\", \"illustration\", \"character_design\", \"scene_design\"]', 5, 'FREELANCER', '郑州市金水区', NULL, NULL, NULL, NULL, 'https://chenzhihao.art', '{\"instagram\": \"https://instagram.com/chenzhihao\", \"artstation\": \"https://artstation.com/chenzhihao\"}', '0', NULL, NULL, '2022-07-01 00:00:00', NULL, '2023-12-01 00:00:00');
INSERT INTO `des_designer` VALUES (20, 20, '赵雅琪', 'https://api.dicebear.com/9.x/shapes/svg?seed=zhaoyaqi', '1', '1991-09-14', '13301234567', 'zhaoyaqi@example.com', '平面设计师，专注于印刷品设计和数字媒体设计。在杂志排版、海报设计、宣传册制作等方面有丰富经验。善于运用色彩和排版创造视觉冲击力，作品风格现代简约，注重信息传达的清晰性和美观性。', 'GRAPHIC_DESIGNER', '[\"photoshop\", \"illustrator\", \"graphic_design\", \"layout_design\", \"print_design\"]', 6, 'EMPLOYED', '长沙市岳麓区', NULL, 12, NULL, NULL, 'https://zhaoyaqi.graphic', '{\"behance\": \"https://behance.net/zhaoyaqi\", \"linkedin\": \"https://linkedin.com/in/zhaoyaqi\"}', '0', NULL, NULL, '2022-04-01 00:00:00', NULL, '2023-12-01 00:00:00');

-- ----------------------------
-- Table structure for des_education
-- ----------------------------
DROP TABLE IF EXISTS `des_education`;
CREATE TABLE `des_education`  (
  `education_id` bigint NOT NULL AUTO_INCREMENT COMMENT '教育背景ID',
  `designer_id` bigint NOT NULL COMMENT '设计师ID',
  `school` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学校名称',
  `degree` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '学位',
  `major` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '专业',
  `start_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '结束日期',
  `is_current` tinyint(1) NULL DEFAULT 0 COMMENT '是否在读',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '描述',
  `gpa` decimal(3, 2) NULL DEFAULT NULL COMMENT 'GPA',
  `ranking` int NULL DEFAULT NULL COMMENT '排名',
  `total_students` int NULL DEFAULT NULL COMMENT '总人数',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`education_id`) USING BTREE,
  INDEX `idx_designer_id`(`designer_id` ASC) USING BTREE,
  INDEX `idx_start_date`(`start_date` ASC) USING BTREE,
  INDEX `idx_degree`(`degree` ASC) USING BTREE,
  CONSTRAINT `fk_education_designer` FOREIGN KEY (`designer_id`) REFERENCES `des_designer` (`designer_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设计师教育背景表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_education
-- ----------------------------
INSERT INTO `des_education` VALUES (1, 1, '中国美术学院', '硕士', '设计学', '2015-09-01', '2018-06-30', 0, '专业方向：数字媒体艺术，研究方向：交互设计与用户体验。主要课程包括用户体验设计、交互设计方法、视觉传达设计等。', 3.80, 5, 48, '0', NULL, NULL, '2015-09-01 00:00:00', NULL, '2018-06-30 00:00:00');
INSERT INTO `des_education` VALUES (2, 1, '浙江大学', '学士', '工业设计', '2011-09-01', '2015-06-30', 0, '主修课程：设计基础、人机交互、产品设计、计算机辅助设计。参与多项设计竞赛并获奖，具备扎实的设计理论基础。', 3.60, 8, 120, '0', NULL, NULL, '2011-09-01 00:00:00', NULL, '2015-06-30 00:00:00');
INSERT INTO `des_education` VALUES (3, 2, '清华大学美术学院', '学士', '视觉传达设计', '2012-09-01', '2016-06-30', 0, '主修课程：平面设计、品牌设计、包装设计、广告设计等。在校期间多次获得设计奖学金，作品在多个展览中展出。', 3.90, 2, 60, '0', NULL, NULL, '2012-09-01 00:00:00', NULL, '2016-06-30 00:00:00');
INSERT INTO `des_education` VALUES (4, 3, '北京电影学院', '学士', '动画设计', '2014-09-01', '2018-06-30', 0, '主修课程：三维动画、角色设计、场景设计、动画导演等。毕业作品《未来城市》获得学院优秀毕业作品奖。', 3.70, 6, 80, '0', NULL, NULL, '2014-09-01 00:00:00', NULL, '2018-06-30 00:00:00');
INSERT INTO `des_education` VALUES (5, 4, '同济大学', '硕士', '工业设计', '2015-09-01', '2018-06-30', 0, '研究方向：交互设计与用户体验。参与多个产品设计项目，在人机交互和用户研究方面有深入学习。', 3.80, 3, 40, '0', NULL, NULL, '2015-09-01 00:00:00', NULL, '2018-06-30 00:00:00');
INSERT INTO `des_education` VALUES (6, 4, '华中科技大学', '学士', '工业设计', '2011-09-01', '2015-06-30', 0, '主修课程：产品设计、人机工程学、设计心理学、计算机辅助设计等。', 3.50, 15, 90, '0', NULL, NULL, '2011-09-01 00:00:00', NULL, '2015-06-30 00:00:00');
INSERT INTO `des_education` VALUES (7, 5, '四川美术学院', '学士', '数字媒体艺术', '2016-09-01', '2020-06-30', 0, '主修课程：交互设计、用户体验设计、界面设计、数字媒体技术等。毕业设计作品获得优秀毕业设计奖。', 3.70, 4, 70, '0', NULL, NULL, '2016-09-01 00:00:00', NULL, '2020-06-30 00:00:00');
INSERT INTO `des_education` VALUES (8, 6, '广州美术学院', '学士', '视觉传达设计', '2012-09-01', '2016-06-30', 0, '主修课程：品牌设计、广告设计、包装设计、企业形象设计等。在校期间多次参与设计竞赛并获奖。', 3.80, 3, 65, '0', NULL, NULL, '2012-09-01 00:00:00', NULL, '2016-06-30 00:00:00');
INSERT INTO `des_education` VALUES (9, 7, '湖北美术学院', '学士', '动画设计', '2014-09-01', '2018-06-30', 0, '主修课程：动画制作、影视后期、数字媒体技术、视觉特效等。毕业作品获得学院优秀作品奖。', 3.60, 8, 75, '0', NULL, NULL, '2014-09-01 00:00:00', NULL, '2018-06-30 00:00:00');
INSERT INTO `des_education` VALUES (10, 8, '西安美术学院', '学士', '插画设计', '2014-09-01', '2018-06-30', 0, '主修课程：插画技法、角色设计、场景设计、绘本创作等。在校期间为多家出版社创作插画作品。', 3.90, 2, 55, '0', NULL, NULL, '2014-09-01 00:00:00', NULL, '2018-06-30 00:00:00');
INSERT INTO `des_education` VALUES (11, 9, '南京艺术学院', '学士', '平面设计', '2015-09-01', '2019-06-30', 0, '主修课程：平面设计、排版设计、印刷工艺、数字媒体设计等。毕业设计获得优秀毕业设计奖。', 3.70, 5, 80, '0', NULL, NULL, '2015-09-01 00:00:00', NULL, '2019-06-30 00:00:00');
INSERT INTO `des_education` VALUES (12, 10, '苏州大学', '学士', '数字媒体艺术', '2016-09-01', '2020-06-30', 0, '主修课程：UI设计、交互设计、数字媒体技术、视觉设计等。在校期间参与多个设计项目。', 3.50, 12, 85, '0', NULL, NULL, '2016-09-01 00:00:00', NULL, '2020-06-30 00:00:00');
INSERT INTO `des_education` VALUES (13, 11, '重庆大学', '硕士', '设计学', '2017-09-01', '2020-06-30', 0, '研究方向：用户体验设计。参与多个用户体验研究项目，在人机交互和用户研究方面有深入学习。', 3.80, 4, 35, '0', NULL, NULL, '2017-09-01 00:00:00', NULL, '2020-06-30 00:00:00');
INSERT INTO `des_education` VALUES (14, 11, '西南大学', '学士', '工业设计', '2013-09-01', '2017-06-30', 0, '主修课程：产品设计、人机工程学、设计心理学、计算机辅助设计等。', 3.60, 10, 95, '0', NULL, NULL, '2013-09-01 00:00:00', NULL, '2017-06-30 00:00:00');
INSERT INTO `des_education` VALUES (15, 12, '天津美术学院', '学士', '数字媒体艺术', '2014-09-01', '2018-06-30', 0, '主修课程：动画制作、影视后期、数字媒体技术、视觉特效等。毕业作品获得学院优秀作品奖。', 3.70, 6, 70, '0', NULL, NULL, '2014-09-01 00:00:00', NULL, '2018-06-30 00:00:00');
INSERT INTO `des_education` VALUES (16, 13, '厦门大学', '学士', '数字媒体艺术', '2016-09-01', '2020-06-30', 0, '主修课程：UI设计、交互设计、数字媒体技术、视觉设计等。在校期间参与多个设计项目。', 3.60, 8, 75, '0', NULL, NULL, '2016-09-01 00:00:00', NULL, '2020-06-30 00:00:00');
INSERT INTO `des_education` VALUES (17, 14, '青岛大学', '学士', '视觉传达设计', '2014-09-01', '2018-06-30', 0, '主修课程：品牌设计、广告设计、包装设计、企业形象设计等。在校期间多次参与设计竞赛并获奖。', 3.80, 4, 60, '0', NULL, NULL, '2014-09-01 00:00:00', NULL, '2018-06-30 00:00:00');
INSERT INTO `des_education` VALUES (18, 15, '大连工业大学', '学士', '动画设计', '2015-09-01', '2019-06-30', 0, '主修课程：三维动画、角色设计、场景设计、动画导演等。毕业作品《未来世界》获得学院优秀毕业作品奖。', 3.70, 5, 65, '0', NULL, NULL, '2015-09-01 00:00:00', NULL, '2019-06-30 00:00:00');
INSERT INTO `des_education` VALUES (19, 16, '江南大学', '学士', '工业设计', '2017-09-01', '2021-06-30', 0, '主修课程：产品设计、人机工程学、设计心理学、计算机辅助设计等。毕业设计获得优秀毕业设计奖。', 3.50, 12, 85, '0', NULL, NULL, '2017-09-01 00:00:00', NULL, '2021-06-30 00:00:00');
INSERT INTO `des_education` VALUES (20, 17, '福建师范大学', '学士', '数字媒体艺术', '2016-09-01', '2020-06-30', 0, '主修课程：交互设计、用户体验设计、界面设计、数字媒体技术等。在校期间参与多个设计项目。', 3.60, 9, 70, '0', NULL, NULL, '2016-09-01 00:00:00', NULL, '2020-06-30 00:00:00');
INSERT INTO `des_education` VALUES (21, 18, '山东艺术学院', '学士', '视觉传达设计', '2015-09-01', '2019-06-30', 0, '主修课程：平面设计、品牌设计、包装设计、广告设计等。在校期间多次获得设计奖学金。', 3.80, 3, 55, '0', NULL, NULL, '2015-09-01 00:00:00', NULL, '2019-06-30 00:00:00');
INSERT INTO `des_education` VALUES (22, 19, '郑州轻工业大学', '学士', '动画设计', '2016-09-01', '2020-06-30', 0, '主修课程：插画技法、角色设计、场景设计、概念设计等。在校期间为多家出版社创作插画作品。', 3.70, 6, 60, '0', NULL, NULL, '2016-09-01 00:00:00', NULL, '2020-06-30 00:00:00');
INSERT INTO `des_education` VALUES (23, 20, '湖南师范大学', '学士', '平面设计', '2016-09-01', '2020-06-30', 0, '主修课程：平面设计、排版设计、印刷工艺、数字媒体设计等。毕业设计获得优秀毕业设计奖。', 3.60, 8, 75, '0', NULL, NULL, '2016-09-01 00:00:00', NULL, '2020-06-30 00:00:00');

-- ----------------------------
-- Table structure for des_enterprise
-- ----------------------------
DROP TABLE IF EXISTS `des_enterprise`;
CREATE TABLE `des_enterprise`  (
  `enterprise_id` bigint NOT NULL AUTO_INCREMENT COMMENT '企业ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '关联用户ID',
  `enterprise_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '企业名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '企业简介',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业地址',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系邮箱',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业网站',
  `scale` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业规模',
  `industry` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '行业类型',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业LOGO',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`enterprise_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1933345394062909443 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '企业信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_enterprise
-- ----------------------------
INSERT INTO `des_enterprise` VALUES (1, NULL, '腾讯互娱', '腾讯互动娱乐是腾讯集团旗下的游戏业务部门，是全球领先的游戏开发和发行商。我们致力于通过创新科技和优质内容，为全球玩家创造愉悦的互动娱乐体验。公司拥有多款知名游戏产品，包括《王者荣耀》、《和平精英》、《英雄联盟》等。我们提供具有市场竞争力的薪酬福利，完善的培训体系，以及广阔的职业发展空间。', '深圳市南山区科技园', '0755-86013388', 'hr@tencent.com', 'https://tencent.com', '10000+人', '互联网', NULL, '0', NULL, NULL, '2024-01-01 00:00:00', NULL, '2025-01-24 10:00:00');
INSERT INTO `des_enterprise` VALUES (2, NULL, '阿里巴巴', '阿里巴巴集团是以电子商务为核心的数字经济体，业务涵盖电商、云计算、数字媒体等多个领域。我们致力于让天下没有难做的生意，通过技术创新为全球商业发展提供基础设施。公司拥有淘宝、天猫、支付宝、阿里云等知名品牌和产品。我们提供有竞争力的薪酬、完善的福利体系和广阔的发展平台。', '杭州市滨江区网商路699号', '0571-85022088', 'hr@alibaba.com', 'https://alibaba.com', '10000+人', '电子商务', NULL, '0', NULL, NULL, '2024-01-01 00:00:00', NULL, '2025-01-26 09:00:00');
INSERT INTO `des_enterprise` VALUES (3, NULL, '字节跳动', '字节跳动是一家全球化的互联网技术公司，致力于用技术丰富人们的生活。公司旗下拥有抖音、今日头条、西瓜视频等多款知名产品。我们秉承\"始终创业\"的理念，为用户创造价值，为社会带来美好。公司提供有竞争力的薪酬福利和良好的工作环境。', '北京市朝阳区北三环东路6号', '010-82600000', 'hr@bytedance.com', 'https://bytedance.com', '10000+人', '互联网', NULL, '0', NULL, NULL, '2024-01-01 00:00:00', NULL, '2025-01-25 14:00:00');
INSERT INTO `des_enterprise` VALUES (4, NULL, '网易游戏', '网易游戏是网易公司旗下的游戏业务部门，是中国领先的游戏开发和运营商。公司拥有《梦幻西游》、《大话西游》、《阴阳师》等多款知名游戏产品。我们致力于为全球玩家提供优质的游戏体验和服务。公司提供完善的福利待遇和良好的职业发展机会。', '广州市天河区科韵路16号', '020-85105163', 'hr@netease.com', 'https://netease.com', '5000-10000人', '游戏', NULL, '0', NULL, NULL, '2024-01-01 00:00:00', NULL, '2025-01-22 11:00:00');
INSERT INTO `des_enterprise` VALUES (5, NULL, '百度', '百度是全球最大的中文搜索引擎，致力于用科技让复杂的世界更简单。公司在人工智能、云计算、自动驾驶等领域都有重要布局。我们拥有强大的技术实力和创新能力，为用户提供优质的产品和服务。公司提供有竞争力的薪酬和广阔的发展平台。', '北京市海淀区上地十街10号', '010-59928888', 'hr@baidu.com', 'https://baidu.com', '10000+人', '互联网', NULL, '0', NULL, NULL, '2024-01-01 00:00:00', NULL, '2025-01-25 16:00:00');
INSERT INTO `des_enterprise` VALUES (6, NULL, '小米', '小米是一家以手机、智能硬件和IoT平台为核心的互联网公司。公司致力于让全球每个人都能享受科技带来的美好生活。我们拥有完整的智能生态链产品，为用户提供优质的科技体验。公司提供有竞争力的薪酬福利和良好的工作环境。', '北京市海淀区清河中街68号', '010-60606666', 'hr@xiaomi.com', 'https://xiaomi.com', '5000-10000人', '智能硬件', NULL, '0', NULL, NULL, '2024-01-01 00:00:00', NULL, '2025-01-23 13:00:00');

-- ----------------------------
-- Table structure for des_job_application
-- ----------------------------
DROP TABLE IF EXISTS `des_job_application`;
CREATE TABLE `des_job_application`  (
  `application_id` bigint NOT NULL AUTO_INCREMENT COMMENT '申请ID',
  `job_id` bigint NOT NULL COMMENT '岗位ID',
  `designer_id` bigint NOT NULL COMMENT '设计师ID',
  `cover_letter` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '申请说明',
  `resume_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '简历文件URL',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '申请状态（0待审核 1通过 2拒绝 3撤回）',
  `feedback` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '企业反馈',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`application_id`) USING BTREE,
  UNIQUE INDEX `uk_job_designer`(`job_id` ASC, `designer_id` ASC) USING BTREE,
  INDEX `idx_job_id`(`job_id` ASC) USING BTREE,
  INDEX `idx_designer_id`(`designer_id` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  CONSTRAINT `des_job_application_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `des_job_posting` (`job_id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `des_job_application_ibfk_2` FOREIGN KEY (`designer_id`) REFERENCES `des_designer` (`designer_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1933720396339707907 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位申请表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_job_application
-- ----------------------------

-- ----------------------------
-- Table structure for des_job_posting
-- ----------------------------
DROP TABLE IF EXISTS `des_job_posting`;
CREATE TABLE `des_job_posting`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `enterprise_id` bigint NOT NULL COMMENT '企业ID',
  `job_title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '岗位描述',
  `requirements` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '岗位要求',
  `required_profession` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '职业要求（对应设计师职业）',
  `required_skills` json NULL COMMENT '技能要求（JSON数组格式）',
  `work_years_required` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作年限要求',
  `salary_min` decimal(10, 2) NULL DEFAULT NULL COMMENT '薪资范围最低值',
  `salary_max` decimal(10, 2) NULL DEFAULT NULL COMMENT '薪资范围最高值',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作地点',
  `job_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作类型（全职/兼职/实习）',
  `education_required` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '学历要求',
  `recruitment_count` int NULL DEFAULT NULL COMMENT '招聘人数',
  `deadline` date NULL DEFAULT NULL COMMENT '截止日期',
  `contact_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `contact_email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用 2已结束）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`job_id`) USING BTREE,
  INDEX `idx_enterprise_id`(`enterprise_id` ASC) USING BTREE,
  INDEX `idx_required_profession`(`required_profession` ASC) USING BTREE,
  INDEX `idx_deadline`(`deadline` ASC) USING BTREE,
  CONSTRAINT `des_job_posting_ibfk_1` FOREIGN KEY (`enterprise_id`) REFERENCES `des_enterprise` (`enterprise_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1933722055128219651 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位招聘表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_job_posting
-- ----------------------------
INSERT INTO `des_job_posting` VALUES (1, 1, '高级交互设计师', '负责腾讯游戏产品的交互设计工作，打造极致的用户体验。\r\n主导设计项目，参与产品需求分析、用户研究、交互设计方案制定与落地。\r\n与产品、开发、视觉等团队紧密合作，推动设计方案的实施与优化。\r\n持续关注用户反馈，不断迭代优化产品体验。\r\n参与建设和完善团队的设计规范与组件库。', '本科及以上学历，设计相关专业，5年以上互联网产品交互设计经验。\r\n精通用户体验设计方法论，能够独立完成用户研究、交互设计、原型设计等工作。\r\n熟练使用 Figma、Sketch、Axure 等设计工具，具备良好的设计表达能力。\r\n对数据敏感，能够基于数据分析进行设计决策。\r\n具备良好的沟通协作能力，能够与多角色团队高效合作。\r\n有游戏行业设计经验者优先。', 'INTERACTION_DESIGNER', '[\"figma\", \"sketch\", \"axure_rp\", \"interaction_design\", \"prototype_design\", \"user_experience\", \"user_research\", \"information_architecture\"]', '5年经验', 25000.00, 35000.00, '深圳·南山区', '全职', '本科及以上', 3, '2025-02-24', 'HR', '0755-86013388', 'hr@tencent.com', '0', NULL, NULL, '2025-01-24 10:00:00', NULL, '2025-01-24 10:00:00');
INSERT INTO `des_job_posting` VALUES (2, 2, '资深视觉设计师', '负责阿里巴巴集团品牌视觉设计工作，提升品牌形象和用户体验。\r\n参与重要产品和营销活动的视觉设计，包括品牌形象、网站设计、移动应用界面等。\r\n与产品、运营、技术团队协作，确保设计方案的有效落地。\r\n建立和维护品牌视觉规范，保证设计的一致性和专业性。\r\n关注行业趋势，持续提升设计水平和创新能力。', '本科及以上学历，设计相关专业，3-5年视觉设计经验。\r\n精通 Photoshop、Illustrator、Sketch 等设计软件。\r\n具备扎实的美术功底和良好的审美能力。\r\n熟悉品牌设计、网页设计、移动端设计等多个设计领域。\r\n有电商或互联网行业经验者优先。\r\n具备良好的沟通能力和团队协作精神。', 'GRAPHIC_DESIGNER', '[\"photoshop\", \"illustrator\", \"sketch\", \"brand_design\", \"visual_system\", \"web_design\"]', '3-5年经验', 30000.00, 45000.00, '杭州·滨江区', '全职', '本科及以上', 5, '2025-02-26', 'HR', '0571-85022088', 'hr@alibaba.com', '0', NULL, NULL, '2025-01-26 09:00:00', NULL, '2025-01-26 09:00:00');
INSERT INTO `des_job_posting` VALUES (3, 3, 'UI设计师', '负责字节跳动旗下产品的用户界面设计工作。\r\n参与产品需求分析，设计符合用户习惯的界面和交互流程。\r\n与产品经理、开发工程师紧密合作，推进设计方案的实现。\r\n维护和优化设计规范，提升产品的一致性和用户体验。\r\n关注用户反馈，持续改进产品设计。', '本科及以上学历，设计相关专业，2-3年UI设计经验。\r\n熟练使用 Sketch、Figma、Adobe Creative Suite 等设计工具。\r\n具备良好的视觉设计能力和用户体验意识。\r\n了解前端开发基础知识，能够与开发团队有效沟通。\r\n有移动端产品设计经验者优先。\r\n具备创新思维和学习能力。', 'UI_DESIGNER', '[\"sketch\", \"figma\", \"ui_design\", \"design_system\", \"mobile_design\"]', '2-3年经验', 18000.00, 25000.00, '北京·朝阳区', '全职', '本科及以上', 2, '2025-02-25', 'HR', '010-82600000', 'hr@bytedance.com', '0', NULL, NULL, '2025-01-25 14:00:00', NULL, '2025-01-25 14:00:00');
INSERT INTO `des_job_posting` VALUES (4, 4, '游戏美术设计师', '负责网易游戏产品的美术设计工作，包括角色设计、场景设计、UI设计等。\r\n参与游戏项目的美术风格制定和视觉表现设计。\r\n与策划、程序团队协作，确保美术资源的高质量产出。\r\n跟进游戏开发流程，优化美术制作效率。\r\n关注游戏行业趋势，提升个人专业技能。', '本科及以上学历，美术或设计相关专业，3年以上游戏美术经验。\r\n精通 3D Max、Maya、Photoshop 等美术制作软件。\r\n具备扎实的美术基础和良好的审美能力。\r\n熟悉游戏美术制作流程和技术要求。\r\n有手游或端游项目经验者优先。\r\n具备团队协作精神和责任心。', 'GRAPHIC_DESIGNER', '[\"3d_max\", \"maya\", \"photoshop\", \"game_art\", \"character_design\", \"scene_design\"]', '3年经验', 20000.00, 30000.00, '广州·天河区', '全职', '本科及以上', 4, '2025-02-22', 'HR', '020-85105163', 'hr@netease.com', '0', NULL, NULL, '2025-01-22 11:00:00', NULL, '2025-01-22 11:00:00');
INSERT INTO `des_job_posting` VALUES (5, 5, '产品设计师', '负责百度产品的用户体验设计工作，提升产品的易用性和用户满意度。\r\n参与产品需求分析和用户研究，制定设计策略和方案。\r\n设计产品原型和交互流程，优化用户体验。\r\n与产品、技术团队协作，推动设计方案的实现。\r\n持续关注用户反馈，迭代优化产品设计。', '本科及以上学历，设计或相关专业，3-5年产品设计经验。\r\n熟练使用 Figma、Sketch、Axure 等设计和原型工具。\r\n具备用户体验设计思维和方法论。\r\n有用户研究经验，能够基于数据进行设计决策。\r\n有AI或搜索产品设计经验者优先。\r\n具备良好的沟通能力和创新思维。', 'PRODUCT_DESIGNER', '[\"figma\", \"sketch\", \"axure_rp\", \"product_design\", \"user_research\", \"prototype_design\"]', '3-5年经验', 22000.00, 35000.00, '北京·海淀区', '全职', '本科及以上', 3, '2025-02-25', 'HR', '010-59928888', 'hr@baidu.com', '0', NULL, NULL, '2025-01-25 16:00:00', NULL, '2025-01-25 16:00:00');
INSERT INTO `des_job_posting` VALUES (6, 6, '动效设计师', '负责小米产品的动效设计工作，提升产品的视觉表现和用户体验。\r\n设计产品界面动效、品牌动画和营销视频等。\r\n与UI设计师、开发工程师协作，确保动效的高质量实现。\r\n建立动效设计规范，保证产品动效的一致性。\r\n关注动效设计趋势，不断提升专业技能。', '本科及以上学历，动画或设计相关专业，2-4年动效设计经验。\r\n精通 After Effects、Cinema 4D、Lottie 等动效制作工具。\r\n具备扎实的动画基础和良好的节奏感。\r\n了解前端动效实现原理，能与开发团队有效沟通。\r\n有移动端产品动效设计经验者优先。\r\n具备创意思维和执行能力。', 'MOTION_DESIGNER', '[\"after_effects\", \"cinema_4d\", \"lottie\", \"motion_design\", \"animation_design\"]', '2-4年经验', 18000.00, 28000.00, '北京·海淀区', '全职', '本科及以上', 2, '2025-02-23', 'HR', '010-60606666', 'hr@xiaomi.com', '0', NULL, NULL, '2025-01-23 13:00:00', NULL, '2025-01-23 13:00:00');

-- ----------------------------
-- Table structure for des_school
-- ----------------------------
DROP TABLE IF EXISTS `des_school`;
CREATE TABLE `des_school`  (
  `school_id` bigint NOT NULL AUTO_INCREMENT COMMENT '院校ID',
  `user_id` bigint NULL DEFAULT NULL COMMENT '关联用户ID',
  `school_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '院校名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '院校简介',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '院校地址',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系邮箱',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '院校网站',
  `school_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '院校类型：COMPREHENSIVE/ART/ENGINEERING/NORMAL/FINANCE',
  `level` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '办学层次：UNDERGRADUATE/GRADUATE/VOCATIONAL',
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '院校LOGO',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `province` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '省份',
  `city` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '城市',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '区域位置',
  `ranking` int NULL DEFAULT NULL COMMENT '院校排名',
  `total_students` int NULL DEFAULT 0 COMMENT '学生总数',
  `total_teachers` int NULL DEFAULT 0 COMMENT '教师总数',
  `faculty_count` int NULL DEFAULT 0 COMMENT '院系数量',
  `major_count` int NULL DEFAULT 0 COMMENT '专业数量',
  `is_key` tinyint(1) NULL DEFAULT 0 COMMENT '是否重点院校',
  `is_985` tinyint(1) NULL DEFAULT 0 COMMENT '是否985院校',
  `is_211` tinyint(1) NULL DEFAULT 0 COMMENT '是否211院校',
  `is_double_first` tinyint(1) NULL DEFAULT 0 COMMENT '是否双一流院校',
  PRIMARY KEY (`school_id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_des_school_province_city`(`province` ASC, `city` ASC) USING BTREE,
  INDEX `idx_des_school_type_level`(`school_type` ASC, `level` ASC) USING BTREE,
  INDEX `idx_des_school_ranking`(`ranking` ASC) USING BTREE,
  INDEX `idx_des_school_flags`(`is_key` ASC, `is_985` ASC, `is_211` ASC, `is_double_first` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1933345376878845954 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '院校信息表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school
-- ----------------------------
INSERT INTO `des_school` VALUES (1, NULL, '清华大学', '清华大学美术学院设计系成立于1984年，是中国最早开设设计专业的院系之一。', '北京市海淀区清华园1号', '010-62782051', 'info@tsinghua.edu.cn', 'https://www.tsinghua.edu.cn', 'COMPREHENSIVE', 'UNDERGRADUATE', NULL, '0', NULL, NULL, '2025-06-10 16:23:31', NULL, '2025-06-28 15:46:54', '北京市', '海淀区', '北京市海淀区', 1, 48000, 3485, 15, 82, 1, 1, 1, 1);
INSERT INTO `des_school` VALUES (2, NULL, '中央美术学院', '中央美术学院是中华人民共和国教育部直属的唯一一所高等美术学校。', '北京市朝阳区花家地南街8号', '010-64771056', 'info@cafa.edu.cn', 'https://www.cafa.edu.cn', 'ART', 'UNDERGRADUATE', NULL, '0', NULL, NULL, '2025-06-10 16:23:31', NULL, '2025-06-28 15:46:54', '北京市', '朝阳区', '北京市朝阳区', 15, 5000, 485, 8, 16, 1, 0, 1, 1);
INSERT INTO `des_school` VALUES (3, NULL, '同济大学', '同济大学设计创意学院是国内最具影响力的设计学院之一。', '浙江省杭州市西湖区转塘街道象山352号', '0571-87164630', 'info@caa.edu.cn', 'https://www.caa.edu.cn', 'ART', 'UNDERGRADUATE', NULL, '0', NULL, NULL, '2025-06-10 16:23:31', NULL, '2025-06-28 15:46:54', '浙江省', '杭州市', '浙江省杭州市', 12, 8500, 625, 15, 28, 1, 0, 1, 1);
INSERT INTO `des_school` VALUES (4, NULL, '中国美术学院', '中国美术学院是中国第一所综合性的国立高等艺术学府。', '上海市杨浦区四平路1239号', '021-65982200', 'info@tongji.edu.cn', 'https://www.tongji.edu.cn', 'COMPREHENSIVE', 'UNDERGRADUATE', '', '0', NULL, 1, '2025-06-28 14:54:27', 1, '2025-06-28 15:46:54', '上海市', '杨浦区', '上海市杨浦区', 8, 52000, 2814, 29, 96, 1, 1, 1, 1);
INSERT INTO `des_school` VALUES (5, NULL, '广州美术学院', '广州美术学院是华南地区唯一一所高等美术学府。', '广东省广州市海珠区昌岗东路257号', '020-84017740', 'info@gzarts.edu.cn', 'https://www.gzarts.edu.cn', 'ART', 'UNDERGRADUATE', '', '0', NULL, 1, '2025-06-28 14:54:27', 1, '2025-06-28 15:46:54', '广东省', '广州市', '广东省广州市', 22, 8000, 700, 12, 25, 1, 0, 0, 0);
INSERT INTO `des_school` VALUES (6, NULL, '江南大学', '江南大学设计学院是国内工业设计教育的重要基地。', '江苏省无锡市蠡湖大道1800号', '0510-85197011', 'info@jiangnan.edu.cn', 'https://www.jiangnan.edu.cn', 'COMPREHENSIVE', 'UNDERGRADUATE', '', '0', NULL, 1, '2025-06-28 14:54:27', 1, '2025-06-28 15:46:54', '江苏省', '无锡市', '江苏省无锡市', 28, 20000, 1564, 18, 55, 1, 0, 1, 1);
INSERT INTO `des_school` VALUES (7, NULL, '北京理工大学', '北京理工大学设计与艺术学院致力于培养具有创新精神的设计人才。', '湖南省长沙市岳麓区麓山南路2号', '0731-88822523', 'info@hnu.edu.cn', 'https://www.hnu.edu.cn', 'COMPREHENSIVE', 'UNDERGRADUATE', '', '0', NULL, 1, '2025-06-28 14:54:27', 1, '2025-06-28 15:46:54', '湖南省', '长沙市', '湖南省长沙市', 35, 36000, 2100, 25, 75, 1, 1, 1, 1);
INSERT INTO `des_school` VALUES (8, NULL, '湖南大学', '湖南大学设计艺术学院是国内最早设立工业设计专业的院校之一。', '北京市海淀区中关村南大街5号', '010-68912114', 'info@bit.edu.cn', 'https://www.bit.edu.cn', 'ENGINEERING', 'UNDERGRADUATE', '', '0', NULL, 1, '2025-06-28 14:54:27', 1, '2025-06-28 15:46:54', '北京市', '海淀区', '北京市海淀区', 18, 32000, 2850, 20, 68, 1, 1, 1, 1);

-- ----------------------------
-- Table structure for des_school_achievement_stats
-- ----------------------------
DROP TABLE IF EXISTS `des_school_achievement_stats`;
CREATE TABLE `des_school_achievement_stats`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `international_awards` int NULL DEFAULT 0 COMMENT '国际奖项数量',
  `national_awards` int NULL DEFAULT 0 COMMENT '国家级奖项数量',
  `provincial_awards` int NULL DEFAULT 0 COMMENT '省级奖项数量',
  `patents` int NULL DEFAULT 0 COMMENT '专利数量',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '成果描述',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `school_id`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_achievement_stats_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校学生成果统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_achievement_stats
-- ----------------------------
INSERT INTO `des_school_achievement_stats` VALUES (9, 1, 126, 287, 453, 192, '清华大学设计系学生在国内外各类设计竞赛中表现突出，近五年来获得红点设计奖、IF设计奖、IDEA设计奖等国际知名设计奖项126项，国家级学科竞赛奖项287项。学生作品多次入选国内外重要设计展览，部分优秀设计成果已实现产业化转化。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_achievement_stats` VALUES (10, 2, 89, 195, 328, 67, '中央美术学院设计学院学生在国际艺术与设计竞赛中屡获殊荣，作品在威尼斯双年展、卡塞尔文献展等重要展览中展出。学生在传统工艺复兴、当代艺术创作等领域表现优异，多项作品被国内外重要美术馆收藏。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_achievement_stats` VALUES (11, 3, 98, 234, 387, 156, '同济大学设计创意学院学生在国际设计竞赛中成绩斐然，特别在可持续设计、城市创新、交通工具设计等领域获得广泛认可。学生作品在米兰设计周、荷兰设计周等国际设计展上频频亮相，体现了学院的国际化教学水平。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_achievement_stats` VALUES (12, 4, 76, 168, 295, 45, '中国美术学院设计艺术学院学生传承学院深厚的艺术传统，在传统工艺创新、当代艺术表达等方面独树一帜。学生作品在国际陶艺双年展、亚洲纤维艺术展等专业展览中获得重要奖项，展现了东方美学的当代价值。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_achievement_stats` VALUES (13, 5, 52, 145, 267, 38, '广州美术学院设计学院学生立足粤港澳大湾区，在商业设计、数字创意等领域表现出色。学生作品在亚洲数字艺术大奖、粤港澳设计展等区域性竞赛中获得优异成绩，体现了岭南文化的创新活力。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_achievement_stats` VALUES (14, 6, 134, 298, 421, 203, '江南大学设计学院学生在工业设计和用户体验设计领域表现卓越，连续多年在国际顶级设计竞赛中获奖。学生作品在红点设计奖、IF设计奖等国际竞赛中屡获殊荣，多项设计成果实现产业化应用，体现了设计的实用价值。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_achievement_stats` VALUES (15, 7, 67, 156, 234, 187, '北京理工大学设计与艺术学院学生凭借强大的技术背景，在高科技设计领域独占鳌头。学生作品在国际工业设计竞赛、科技创新大赛中频获大奖，特别在航空航天设计、军工产品设计等专业领域具有显著优势。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_achievement_stats` VALUES (16, 8, 78, 189, 312, 142, '湖南大学设计艺术学院学生在汽车设计和工业设计领域成绩突出，作品在国际汽车设计竞赛中多次获奖。学生设计作品体现了深厚的工程底蕴和创新思维，多项成果与知名汽车企业建立合作，实现了学术与产业的良性互动。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');

-- ----------------------------
-- Table structure for des_school_award_work
-- ----------------------------
DROP TABLE IF EXISTS `des_school_award_work`;
CREATE TABLE `des_school_award_work`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '作品标题',
  `award` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '奖项名称',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '作品描述',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_award_work_school`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_award_work_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校获奖作品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_award_work
-- ----------------------------
INSERT INTO `des_school_award_work` VALUES (1, 1, '智慧城市数据可视化系统', '国际信息设计协会金奖', '为智慧城市建设设计的大数据可视化系统，通过创新的界面设计提升了城市管理效率', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_award_work` VALUES (2, 1, '传统文化数字化展示平台', '中国设计红星奖', '运用现代数字技术展示传统文化，实现了古典与现代的完美融合', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_award_work` VALUES (3, 1, '可持续发展主题海报设计', '德国红点设计大奖', '以环保为主题的系列海报设计，传达了可持续发展的重要理念', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_award_work` VALUES (4, 2, '新时代主题油画创作', '全国美展金奖', '反映新时代社会变迁的大型油画作品，具有强烈的时代特色和艺术感染力', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_award_work` VALUES (5, 2, '传统工艺现代转化设计', '中国工艺美术大奖', '将传统手工艺与现代设计理念结合，创造出具有当代价值的工艺品', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_award_work` VALUES (6, 2, '公共艺术装置作品', '国际公共艺术大赛银奖', '为城市公共空间设计的大型艺术装置，提升了城市文化品位', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_award_work` VALUES (7, 1, '「循迹」智能导盲系统', '2024 红点设计奖 · 最佳设计奖', '基于计算机视觉和触觉反馈的创新型导盲设备，为视障人士提供更安全、便捷的出行体验。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (8, 1, '「量子」交互界面设计', '2023 IF设计奖 · 交互设计金奖', '面向量子计算时代的用户界面设计，通过创新的视觉语言让复杂的量子概念变得易懂。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (9, 1, '「智链」区块链可视化系统', '2023 IDEA设计奖 · 银奖', '将抽象的区块链技术通过直观的视觉化设计呈现，帮助用户理解去中心化金融概念。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (10, 2, '「古韵新声」传统文化复兴计划', '2024 威尼斯双年展 · 金狮奖', '通过当代艺术手法重新诠释中国传统文化符号，在国际舞台展现东方美学的时代价值。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (11, 2, '「山水间」数字影像装置', '2023 卡塞尔文献展 · 特别提名奖', '融合传统山水画与新媒体技术，创造出诗意而富有哲思的沉浸式艺术体验。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (12, 2, '「器韵」陶瓷艺术系列', '2023 国际陶艺双年展 · 金奖', '在传统陶瓷工艺基础上融入当代设计理念，展现中华文化的深厚底蕴和时代活力。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (13, 3, '「未来出行」可持续交通系统', '2024 米兰设计周 · 最佳概念奖', '整合城市规划、交通工具和服务设计的综合性可持续出行解决方案。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (14, 3, '「绿洲」城市更新设计', '2023 威尼斯建筑双年展 · 金狮奖', '通过生态设计理念改造城市废弃空间，为都市居民创造绿色宜居的生活环境。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (15, 3, '「智慧城市」服务设计平台', '2023 红点设计奖 · 概念设计奖', '运用服务设计思维构建智慧城市生态系统，提升城市管理效率和居民生活质量。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (16, 4, '「丝路印象」纤维艺术作品', '2024 国际纤维艺术三年展 · 大奖', '以丝绸之路为主题的大型纤维装置，展现东西方文化交流的历史脉络和当代意义。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (17, 4, '「水墨新境」数字绘画系统', '2023 亚洲数字艺术奖 · 创新奖', '将传统水墨画技法与数字技术结合，为水墨艺术的传承与发展开辟新的可能性。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (18, 4, '「匠心」传统工艺复兴项目', '2023 联合国教科文组织 · 文化遗产保护奖', '通过设计介入保护和传承濒危传统工艺，让古老技艺在当代社会焕发新的生命力。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (19, 5, '「粤韵」岭南文化品牌设计', '2024 亚洲品牌设计奖 · 金奖', '提取岭南文化精髓，为粤港澳大湾区文化产业打造具有地域特色的品牌形象。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (20, 5, '「次元世界」游戏美术设计', '2023 独立游戏节 · 最佳视觉奖', '融合中华传统文化元素与现代数字艺术，创造出独具特色的游戏视觉体验。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (21, 5, '「潮玩宇宙」文创产品系列', '2023 中国文创产品大赛 · 金奖', '将传统广府文化与潮流文化相结合，设计出深受年轻人喜爱的文创产品。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (22, 6, '「智慧家庭」物联网产品系统', '2024 红点设计奖 · 产品设计奖', '基于用户需求洞察设计的智能家居生态系统，提供无缝连接的智慧生活体验。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (23, 6, '「适老化」无障碍设计解决方案', '2023 IF设计奖 · 社会影响力奖', '关注老龄化社会需求，通过人性化设计提升老年人的生活品质和社会参与度。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (24, 6, '「绿色制造」可持续产品设计', '2023 IDEA设计奖 · 环境责任奖', '贯彻循环经济理念的产品设计，在全生命周期中最大化减少环境影响。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (25, 7, '「天眼」卫星导航系统界面', '2024 国际工业设计大赛 · 特等奖', '为北斗卫星导航系统设计的专业级用户界面，提升了系统的操作效率和用户体验。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (26, 7, '「战鹰」无人机操控系统', '2023 军用装备设计竞赛 · 金奖', '集成先进人机工程学理念的无人机操控界面，显著提升了操作精度和安全性。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (27, 7, '「精工」精密仪器设计', '2023 中国工业设计奖 · 金奖', '运用先进制造工艺设计的高精度测量仪器，在航空航天领域实现重要应用。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (28, 8, '「风驰」电动汽车造型设计', '2024 国际汽车设计大赛 · 最佳造型奖', '融合空气动力学与美学的电动汽车外观设计，体现了新能源时代的设计理念。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (29, 8, '「湘韵」文化创意产品', '2023 中华传统文化设计大赛 · 金奖', '提取湖湘文化元素设计的文创产品系列，传承和弘扬了深厚的地域文化。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_award_work` VALUES (30, 8, '「重器」工程机械设计', '2023 全国机械设计大赛 · 一等奖', '结合人机工程学和工业美学的工程机械设计，提升了操作体验和工作效率。', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');

-- ----------------------------
-- Table structure for des_school_card_stats
-- ----------------------------
DROP TABLE IF EXISTS `des_school_card_stats`;
CREATE TABLE `des_school_card_stats`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `employment_rates` json NULL COMMENT '就业率数组',
  `faculty_strengths` json NULL COMMENT '师资力量评分数组',
  `student_scores` json NULL COMMENT '学生评分数组',
  `advantage_programs` json NULL COMMENT '优势专业按院校类型分类',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `school_id`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_card_stats_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校卡片统计数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_card_stats
-- ----------------------------
INSERT INTO `des_school_card_stats` VALUES (3, 1, '[\"96.8%\"]', '[\"5.0\"]', '[\"4.9\"]', '{\"COMPREHENSIVE\": [\"信息艺术设计\", \"智能产品设计\", \"交互设计\"]}', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_card_stats` VALUES (4, 2, '[\"97.2%\"]', '[\"4.9\"]', '[\"4.8\"]', '{\"COMPREHENSIVE\": [\"工业设计\", \"用户体验设计\", \"智能产品设计\"]}', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 16:26:58');
INSERT INTO `des_school_card_stats` VALUES (5, 3, '[\"95.7%\"]', '[\"4.8\"]', '[\"4.7\"]', '{\"COMPREHENSIVE\": [\"汽车设计\", \"可持续设计\", \"城市设计\"]}', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_card_stats` VALUES (6, 4, '[\"92.1%\"]', '[\"4.8\"]', '[\"4.7\"]', '{\"ART\": [\"陶瓷艺术\", \"纤维艺术\", \"文化创意设计\"]}', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_card_stats` VALUES (7, 5, '[\"93.8%\"]', '[\"4.6\"]', '[\"4.5\"]', '{\"ART\": [\"游戏美术设计\", \"岭南文化设计\", \"商业设计\"]}', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_card_stats` VALUES (8, 6, '[\"97.2%\"]', '[\"4.9\"]', '[\"4.8\"]', '{\"COMPREHENSIVE\": [\"工业设计\", \"用户体验设计\", \"智能产品设计\"]}', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_card_stats` VALUES (9, 7, '[\"96.5%\"]', '[\"4.7\"]', '[\"4.6\"]', '{\"ENGINEERING\": [\"军工设计\", \"精密仪器设计\", \"AI设计\"]}', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_card_stats` VALUES (10, 8, '[\"95.1%\"]', '[\"4.7\"]', '[\"4.6\"]', '{\"COMPREHENSIVE\": [\"汽车造型设计\", \"工程机械设计\", \"文化设计\"]}', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');

-- ----------------------------
-- Table structure for des_school_chart_data
-- ----------------------------
DROP TABLE IF EXISTS `des_school_chart_data`;
CREATE TABLE `des_school_chart_data`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `industry_data` json NULL COMMENT '行业分布数据',
  `salary_data` json NULL COMMENT '薪资分布数据',
  `salary_labels` json NULL COMMENT '薪资区间标签',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `school_id`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_chart_data_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校就业图表数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_chart_data
-- ----------------------------
INSERT INTO `des_school_chart_data` VALUES (3, 1, '[{\"name\": \"互联网科技\", \"value\": 45}, {\"name\": \"设计咨询\", \"value\": 18}, {\"name\": \"高校研究\", \"value\": 15}, {\"name\": \"国际企业\", \"value\": 12}, {\"name\": \"其他行业\", \"value\": 10}]', '[2, 8, 15, 35, 25, 15]', '[\"8K-\", \"8-12K\", \"12-15K\", \"15-20K\", \"20-25K\", \"25K+\"]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_chart_data` VALUES (4, 2, '[{\"name\": \"文化艺术\", \"value\": 35}, {\"name\": \"广告传媒\", \"value\": 25}, {\"name\": \"教育培训\", \"value\": 20}, {\"name\": \"互联网科技\", \"value\": 12}, {\"name\": \"其他行业\", \"value\": 8}]', '[8, 18, 30, 25, 15, 4]', '[\"8K-\", \"8-12K\", \"12-15K\", \"15-20K\", \"20-25K\", \"25K+\"]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_chart_data` VALUES (5, 3, '[{\"name\": \"汽车设计\", \"value\": 30}, {\"name\": \"建筑设计\", \"value\": 25}, {\"name\": \"互联网科技\", \"value\": 20}, {\"name\": \"设计咨询\", \"value\": 15}, {\"name\": \"其他行业\", \"value\": 10}]', '[3, 10, 20, 35, 22, 10]', '[\"8K-\", \"8-12K\", \"12-15K\", \"15-20K\", \"20-25K\", \"25K+\"]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_chart_data` VALUES (6, 4, '[{\"name\": \"文化创意\", \"value\": 40}, {\"name\": \"传统工艺\", \"value\": 22}, {\"name\": \"教育培训\", \"value\": 18}, {\"name\": \"互联网科技\", \"value\": 12}, {\"name\": \"其他行业\", \"value\": 8}]', '[12, 22, 28, 22, 12, 4]', '[\"8K-\", \"8-12K\", \"12-15K\", \"15-20K\", \"20-25K\", \"25K+\"]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_chart_data` VALUES (7, 5, '[{\"name\": \"游戏动漫\", \"value\": 32}, {\"name\": \"商业设计\", \"value\": 28}, {\"name\": \"互联网科技\", \"value\": 20}, {\"name\": \"广告传媒\", \"value\": 12}, {\"name\": \"其他行业\", \"value\": 8}]', '[6, 15, 28, 30, 18, 3]', '[\"8K-\", \"8-12K\", \"12-15K\", \"15-20K\", \"20-25K\", \"25K+\"]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_chart_data` VALUES (8, 6, '[{\"name\": \"制造业设计\", \"value\": 38}, {\"name\": \"互联网科技\", \"value\": 25}, {\"name\": \"消费电子\", \"value\": 18}, {\"name\": \"设计咨询\", \"value\": 12}, {\"name\": \"其他行业\", \"value\": 7}]', '[4, 12, 25, 32, 20, 7]', '[\"8K-\", \"8-12K\", \"12-15K\", \"15-20K\", \"20-25K\", \"25K+\"]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_chart_data` VALUES (9, 7, '[{\"name\": \"科技制造\", \"value\": 35}, {\"name\": \"国防科技\", \"value\": 25}, {\"name\": \"互联网科技\", \"value\": 20}, {\"name\": \"精密仪器\", \"value\": 12}, {\"name\": \"其他行业\", \"value\": 8}]', '[2, 6, 18, 30, 28, 16]', '[\"8K-\", \"8-12K\", \"12-15K\", \"15-20K\", \"20-25K\", \"25K+\"]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_chart_data` VALUES (10, 8, '[{\"name\": \"汽车制造\", \"value\": 40}, {\"name\": \"工程机械\", \"value\": 22}, {\"name\": \"互联网科技\", \"value\": 18}, {\"name\": \"设计咨询\", \"value\": 12}, {\"name\": \"其他行业\", \"value\": 8}]', '[5, 14, 26, 30, 20, 5]', '[\"8K-\", \"8-12K\", \"12-15K\", \"15-20K\", \"20-25K\", \"25K+\"]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');

-- ----------------------------
-- Table structure for des_school_course_group
-- ----------------------------
DROP TABLE IF EXISTS `des_school_course_group`;
CREATE TABLE `des_school_course_group`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '课程组名称',
  `courses` json NULL COMMENT '课程列表',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_course_group_school`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_course_group_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 41 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校课程体系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_course_group
-- ----------------------------
INSERT INTO `des_school_course_group` VALUES (1, 1, '基础理论课程', '[\"设计史论\", \"艺术概论\", \"美学原理\", \"设计心理学\"]', NULL, '2025-06-28 14:54:27', NULL, '2025-06-28 14:54:27');
INSERT INTO `des_school_course_group` VALUES (2, 1, '专业核心课程', '[\"设计方法学\", \"创意思维训练\", \"设计表现技法\", \"数字媒体技术\"]', NULL, '2025-06-28 14:54:27', NULL, '2025-06-28 14:54:27');
INSERT INTO `des_school_course_group` VALUES (3, 1, '实践应用课程', '[\"项目实战\", \"企业合作项目\", \"毕业设计\", \"创新创业实践\"]', NULL, '2025-06-28 14:54:27', NULL, '2025-06-28 14:54:27');
INSERT INTO `des_school_course_group` VALUES (4, 1, '前沿拓展课程', '[\"人工智能设计\", \"可持续设计\", \"跨文化设计\", \"设计管理\"]', NULL, '2025-06-28 14:54:27', NULL, '2025-06-28 14:54:27');
INSERT INTO `des_school_course_group` VALUES (5, 2, '造型基础课程', '[\"素描基础\", \"色彩基础\", \"速写技法\", \"构图原理\"]', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_course_group` VALUES (6, 2, '专业技能课程', '[\"油画技法\", \"版画制作\", \"雕塑实践\", \"装置创作\"]', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_course_group` VALUES (7, 2, '理论研究课程', '[\"美术史\", \"艺术理论\", \"美学概论\", \"批评写作\"]', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_course_group` VALUES (8, 2, '创作实践课程', '[\"主题创作\", \"展览策划\", \"艺术市场\", \"职业规划\"]', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_course_group` VALUES (9, 1, '基础理论', '[\"设计史论\", \"设计美学\", \"人机工程学\", \"设计心理学\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (10, 1, '专业核心', '[\"信息设计基础\", \"交互设计方法\", \"视觉传达设计\", \"产品系统设计\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (11, 1, '技术应用', '[\"数字媒体技术\", \"人工智能应用\", \"虚拟现实技术\", \"数据可视化\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (12, 1, '实践项目', '[\"企业合作项目\", \"创新创业实践\", \"国际交流项目\", \"毕业设计\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (13, 2, '基础理论', '[\"中外美术史\", \"设计史\", \"美学原理\", \"艺术概论\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (14, 2, '专业核心', '[\"视觉传达设计\", \"数字媒体艺术\", \"产品设计\", \"服装设计\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (15, 2, '传统技艺', '[\"书法篆刻\", \"传统工艺\", \"民族艺术\", \"文物保护\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (16, 2, '创作实践', '[\"个人创作\", \"主题创作\", \"社会实践\", \"毕业创作\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (17, 3, '基础理论', '[\"岭南文化史\", \"设计史论\", \"色彩学\", \"构成学\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (18, 3, '专业核心', '[\"视觉传达设计\", \"产品设计\", \"环境设计\", \"数字媒体艺术\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (19, 3, '地域特色', '[\"岭南建筑\", \"粤绣工艺\", \"陶瓷艺术\", \"民间美术\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (20, 3, '产业实践', '[\"企业实习\", \"创意产业实践\", \"文创产品开发\", \"毕业设计\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (21, 4, '基础理论', '[\"设计史论\", \"工程基础\", \"建筑学基础\", \"可持续发展理论\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (22, 4, '专业核心', '[\"工业设计\", \"环境设计\", \"数字媒体艺术\", \"动画设计\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (23, 4, '技术融合', '[\"工程技术\", \"建筑技术\", \"信息技术\", \"新材料技术\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (24, 4, '创新实践', '[\"设计创新项目\", \"跨学科合作\", \"国际工作坊\", \"毕业设计\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (25, 5, '基础理论', '[\"中国美术史\", \"西方美术史\", \"美学哲学\", \"艺术理论\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (26, 5, '专业核心', '[\"视觉传达设计\", \"陶瓷艺术\", \"纤维艺术\", \"综合艺术\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (27, 5, '传统工艺', '[\"传统陶艺\", \"丝绸工艺\", \"金属工艺\", \"漆器工艺\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (28, 5, '当代实践', '[\"当代艺术实践\", \"实验艺术\", \"公共艺术\", \"毕业创作\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (29, 6, '基础理论', '[\"设计学概论\", \"工业设计史\", \"人机工程学\", \"设计管理\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (30, 6, '专业核心', '[\"工业设计\", \"视觉传达设计\", \"环境设计\", \"数字媒体艺术\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (31, 6, '技术应用', '[\"产品开发技术\", \"制造工艺\", \"材料工艺\", \"数字化技术\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (32, 6, '产业实践', '[\"企业实习\", \"产品开发项目\", \"设计竞赛\", \"毕业设计\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (33, 7, '基础理论', '[\"设计学基础\", \"工程基础\", \"军工设计史\", \"技术美学\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (34, 7, '专业核心', '[\"工业设计\", \"视觉传达设计\", \"环境设计\", \"数字媒体艺术\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (35, 7, '技术前沿', '[\"智能制造\", \"航空航天技术\", \"机器人技术\", \"人工智能\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (36, 7, '军工特色', '[\"军工产品设计\", \"国防科技应用\", \"特种环境设计\", \"毕业设计\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (37, 8, '基础理论', '[\"设计史论\", \"工业设计基础\", \"湖湘文化\", \"设计方法学\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (38, 8, '专业核心', '[\"工业设计\", \"视觉传达设计\", \"环境设计\", \"数字媒体艺术\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (39, 8, '技术应用', '[\"汽车设计技术\", \"智能制造\", \"新材料应用\", \"数字化设计\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');
INSERT INTO `des_school_course_group` VALUES (40, 8, '地域实践', '[\"湖湘文化实践\", \"乡村振兴设计\", \"生态设计实践\", \"毕业设计\"]', NULL, '2025-06-28 14:55:16', NULL, '2025-06-28 14:55:16');

-- ----------------------------
-- Table structure for des_school_employer
-- ----------------------------
DROP TABLE IF EXISTS `des_school_employer`;
CREATE TABLE `des_school_employer`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '雇主名称',
  `industry` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '行业类型',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_employer_school`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_employer_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 65 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校代表性雇主表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_employer
-- ----------------------------
INSERT INTO `des_school_employer` VALUES (1, 1, '腾讯', '互联网科技', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (2, 1, '阿里巴巴', '电子商务', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (3, 1, '华为', '通信技术', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (4, 1, '字节跳动', '互联网科技', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (5, 1, '小米', '智能硬件', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (6, 1, '百度', '人工智能', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (7, 1, '蔚来汽车', '新能源汽车', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (8, 1, '故宫博物院', '文化创意', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (9, 2, '中央电视台', '传媒', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (10, 2, '人民美术出版社', '出版', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (11, 2, '中国美术馆', '文化艺术', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (12, 2, '798艺术区', '艺术园区', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (13, 2, '奥美广告', '广告营销', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (14, 2, '东方卫视', '传媒', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (15, 2, '新华社', '新闻媒体', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (16, 2, '国家大剧院', '文化艺术', NULL, '2025-06-28 14:54:57', NULL, '2025-06-28 14:54:57');
INSERT INTO `des_school_employer` VALUES (17, 3, '奔驰设计', '汽车设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (18, 3, '宝马集团', '汽车设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (19, 3, 'IDEO', '设计咨询', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (20, 3, '腾讯', '互联网科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (21, 3, '上海建工', '建筑设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (22, 3, '华建集团', '建筑设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (23, 3, '迪士尼', '娱乐设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (24, 3, '上汽集团', '汽车制造', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (25, 4, '浙江博物馆', '文化机构', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (26, 4, '西湖艺术馆', '艺术机构', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (27, 4, '阿里巴巴', '互联网科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (28, 4, '网易', '互联网科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (29, 4, '朵云轩', '传统工艺', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (30, 4, '景德镇陶瓷', '传统工艺', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (31, 4, '天猫设计', '电商设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (32, 4, '今日头条', '新媒体', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (33, 5, '腾讯游戏', '游戏设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (34, 5, '网易游戏', '游戏设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (35, 5, '奥飞娱乐', '动漫制作', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (36, 5, '美的集团', '家电设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (37, 5, '比亚迪', '汽车设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (38, 5, '华为', '通信科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (39, 5, '字节跳动', '互联网科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (40, 5, '正佳集团', '商业设计', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (41, 6, '海尔集团', '家电制造', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (42, 6, '美的集团', '家电制造', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (43, 6, '小米科技', '消费电子', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (44, 6, '华为', '通信科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (45, 6, '腾讯', '互联网科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (46, 6, '阿里巴巴', '互联网科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (47, 6, 'OPPO', '消费电子', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (48, 6, 'vivo', '消费电子', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (49, 7, '中科院', '科研院所', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (50, 7, '航天科技', '航空航天', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (51, 7, '兵器工业', '军工企业', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (52, 7, '华为', '通信科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (53, 7, '小米', '消费电子', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (54, 7, '字节跳动', '互联网科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (55, 7, '中船重工', '重工制造', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (56, 7, '大疆创新', '无人机', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (57, 8, '上汽集团', '汽车制造', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (58, 8, '一汽集团', '汽车制造', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (59, 8, '广汽集团', '汽车制造', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (60, 8, '比亚迪', '新能源汽车', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (61, 8, '三一重工', '工程机械', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (62, 8, '中联重科', '工程机械', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (63, 8, '华为', '通信科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_employer` VALUES (64, 8, '腾讯', '互联网科技', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');

-- ----------------------------
-- Table structure for des_school_employment_stats
-- ----------------------------
DROP TABLE IF EXISTS `des_school_employment_stats`;
CREATE TABLE `des_school_employment_stats`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `employment_rate` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '就业率',
  `average_salary` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '平均薪资',
  `further_study_rate` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '深造率',
  `overseas_employment_rate` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '海外就业率',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '就业描述',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `school_id`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_employment_stats_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校就业统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_employment_stats
-- ----------------------------
INSERT INTO `des_school_employment_stats` VALUES (17, 1, '96.8%', '18.5K', '38.2%', '22.1%', '清华大学设计系毕业生就业情况良好，就业率常年保持在95%以上。毕业生主要就业方向包括互联网科技公司、设计咨询公司、广告传媒机构、高校及研究机构等。近年来，随着设计与科技的深度融合，越来越多的毕业生选择在科技企业从事用户体验设计、交互设计等工作，也有部分学生选择自主创业。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_employment_stats` VALUES (18, 2, '94.3%', '16.8K', '42.6%', '28.7%', '中央美术学院设计学院毕业生在艺术与设计领域享有极高声誉，就业前景广阔。主要就业去向包括美术馆、画廊、文化创意机构、影视制作公司、出版社等。许多毕业生选择继续深造或海外留学，也有不少成为独立艺术家或设计师，在国内外艺术市场具有重要影响力。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_employment_stats` VALUES (19, 3, '95.7%', '17.2K', '35.4%', '19.8%', '同济大学设计创意学院毕业生凭借扎实的工程背景和创新设计能力，在就业市场上具有独特优势。主要就业领域包括汽车设计、建筑设计、城市规划、工业设计等。许多毕业生进入世界500强企业担任设计职务，也有部分选择在设计咨询公司或自主创业。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_employment_stats` VALUES (20, 4, '92.1%', '15.6K', '45.3%', '31.2%', '中国美术学院设计艺术学院毕业生在传统工艺与当代设计结合方面具有独特优势。主要就业方向包括文化创意产业、工艺美术企业、设计工作室、教育机构等。学院注重培养学生的艺术修养和文化内涵，许多毕业生成为具有影响力的艺术家和设计师。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_employment_stats` VALUES (21, 5, '93.8%', '14.9K', '28.7%', '15.4%', '广州美术学院设计学院毕业生立足粤港澳大湾区，在文化创意产业和商业设计领域具有显著优势。主要就业方向包括游戏公司、动漫制作、广告设计、包装设计、电商平台等。许多毕业生选择在深圳、广州等一线城市发展，也有部分进入港澳地区工作。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_employment_stats` VALUES (22, 6, '97.2%', '16.3K', '31.8%', '17.6%', '江南大学设计学院毕业生在工业设计和用户体验设计领域具有显著优势，就业率连续多年保持在95%以上。主要就业方向包括制造业企业、互联网公司、设计咨询机构等。许多毕业生进入华为、小米、海尔等知名企业担任设计师职务，薪资水平在同类院校中处于领先地位。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_employment_stats` VALUES (23, 7, '96.5%', '17.8K', '33.7%', '16.9%', '北京理工大学设计与艺术学院毕业生凭借强大的工程技术背景，在高科技设计领域具有独特竞争力。主要就业方向包括航空航天企业、军工集团、科技公司、精密仪器制造等。许多毕业生进入中科院、航天科技、兵器工业等国家重点单位，在国防科技设计领域发挥重要作用。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_employment_stats` VALUES (24, 8, '95.1%', '16.7K', '29.3%', '14.2%', '湖南大学设计艺术学院毕业生在汽车设计和工业设计领域享有盛誉，就业前景良好。主要就业方向包括汽车制造企业、工程机械公司、家电制造、设计咨询等。许多毕业生进入上汽、一汽、广汽、三一重工等知名企业，在汽车造型设计和工业产品设计方面具有重要影响力。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');

-- ----------------------------
-- Table structure for des_school_faculty_stats
-- ----------------------------
DROP TABLE IF EXISTS `des_school_faculty_stats`;
CREATE TABLE `des_school_faculty_stats`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `total_faculty` int NULL DEFAULT 0 COMMENT '师资总数',
  `professors` int NULL DEFAULT 0 COMMENT '教授人数',
  `doctor_degree` int NULL DEFAULT 0 COMMENT '博士学位人数',
  `overseas_background` int NULL DEFAULT 0 COMMENT '海外背景人数',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '师资描述',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `school_id`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_faculty_stats_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 25 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校师资统计表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_faculty_stats
-- ----------------------------
INSERT INTO `des_school_faculty_stats` VALUES (17, 1, 68, 42, 53, 35, '清华大学美术学院设计系拥有一支高水平的师资队伍，包括长江学者特聘教授2名，国家杰出青年基金获得者3名，国家级教学名师2名。教师团队中有多位在国际设计领域具有重要影响力的专家学者，以及来自行业一线的兼职教师。学院注重教师的国际交流与合作，定期邀请国际知名设计师和学者来校讲学。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_faculty_stats` VALUES (18, 2, 95, 58, 67, 42, '中央美术学院设计学院汇聚了国内外顶尖的艺术与设计人才，拥有中国美术家协会理事12名，国际平面设计联盟(AGI)会员3名。师资队伍中既有在传统艺术领域造诣深厚的艺术大师，也有活跃在当代设计前沿的青年学者。学院与世界各大美术学院建立了广泛的交流合作关系。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_faculty_stats` VALUES (19, 3, 75, 48, 61, 38, '同济大学设计创意学院师资力量雄厚，拥有国家级教学团队1个，教育部新世纪优秀人才4名。学院注重产学研结合，多位教师担任国际知名企业设计顾问。师资队伍具有深厚的工程背景和国际视野，在可持续设计、智慧城市设计等领域具有重要影响力。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_faculty_stats` VALUES (20, 4, 120, 72, 89, 51, '中国美术学院设计艺术学院拥有深厚的学术传统和卓越的师资力量，包括国务院学科评议组成员、全国艺术专业学位研究生教育指导委员会委员等学术带头人。学院师资在传统工艺传承与当代艺术创新方面具有独特优势，多位教师作品被国内外重要美术馆收藏。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_faculty_stats` VALUES (21, 5, 85, 51, 64, 35, '广州美术学院设计学院立足岭南文化，面向粤港澳大湾区，拥有一支具有地域特色和国际视野的师资队伍。学院与港澳台地区以及海外设计院校建立了密切的合作关系，多位教师具有海外留学或工作背景，在文化创意产业和商业设计领域具有丰富经验。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_faculty_stats` VALUES (22, 6, 92, 56, 71, 48, '江南大学设计学院师资力量雄厚，拥有国家级教学名师1名，教育部新世纪优秀人才5名，江苏省教学名师3名。学院在工业设计领域具有深厚积淀，师资队伍实践经验丰富，与众多知名企业建立了长期合作关系，在用户体验设计和智能产品设计方面处于国内领先地位。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_faculty_stats` VALUES (23, 7, 78, 45, 58, 32, '北京理工大学设计与艺术学院依托学校强大的工程技术背景，形成了独特的\"技术+艺术\"师资特色。学院拥有国防科技创新团队1个，多位教师具有军工企业工作背景。师资队伍在智能装备设计、航空航天设计等高科技领域具有显著优势。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_faculty_stats` VALUES (24, 8, 88, 52, 66, 36, '湖南大学设计艺术学院历史悠久，师资力量深厚，拥有国家级教学团队1个，湖南省芙蓉学者特聘教授2名。学院在汽车造型设计和工业设计领域具有传统优势，与国内外汽车企业建立了广泛合作，师资队伍实践经验丰富，在设计教育和产业应用方面成果显著。', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');

-- ----------------------------
-- Table structure for des_school_major_category
-- ----------------------------
DROP TABLE IF EXISTS `des_school_major_category`;
CREATE TABLE `des_school_major_category`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '专业名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '专业描述',
  `skills` json NULL COMMENT '技能列表',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_major_category_school`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_major_category_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校专业分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_major_category
-- ----------------------------
INSERT INTO `des_school_major_category` VALUES (45, 1, '信息艺术设计', 'ri-computer-line', '结合清华理工科优势，培养具备信息可视化、人机交互等前沿设计能力的复合型人才。', '[\"信息可视化\", \"交互设计\", \"数据艺术\", \"智能界面设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (46, 1, '视觉传达设计', 'ri-palette-line', '传承清华美院深厚底蕴，培养具备国际视野和创新思维的视觉传达设计人才。', '[\"品牌战略设计\", \"文化创意设计\", \"出版物设计\", \"导视系统设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (47, 1, '产品设计', 'ri-lightbulb-line', '依托清华工科背景，注重设计与工程的深度融合，培养具备创新思维的产品设计师。', '[\"智能产品设计\", \"交通工具设计\", \"可持续设计\", \"设计研究\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (48, 1, '环境设计', 'ri-building-line', '结合建筑学科优势，培养具备空间设计和环境营造能力的高端设计人才。', '[\"展示空间设计\", \"公共艺术\", \"景观规划\", \"智慧空间设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (49, 2, '视觉传达设计', 'ri-palette-line', '立足传统文化，面向当代设计，培养具有深厚艺术底蕴和国际视野的设计师。', '[\"文字设计\", \"海报设计\", \"书籍装帧\", \"文化传播设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (50, 2, '数字媒体艺术', 'ri-computer-line', '探索艺术与科技融合，培养具备新媒体创作能力的当代艺术家和设计师。', '[\"新媒体艺术\", \"数字影像\", \"虚拟现实艺术\", \"交互装置\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (51, 2, '产品设计', 'ri-lightbulb-line', '注重设计的文化内涵和艺术表达，培养具有人文关怀的产品设计师。', '[\"生活方式设计\", \"文创产品设计\", \"家居用品设计\", \"艺术衍生品设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (52, 2, '服装与服饰设计', 'ri-shirt-line', '传承中华服饰文化，融合国际时尚趋势，培养具有原创能力的服装设计师。', '[\"时装设计\", \"传统服饰研究\", \"纺织品设计\", \"时尚插画\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (53, 3, '工业设计', 'ri-tools-line', '依托同济工程优势，培养具备系统思维和创新能力的工业设计师。', '[\"交通工具设计\", \"智能制造设计\", \"服务设计\", \"可持续设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (54, 3, '环境设计', 'ri-building-line', '结合建筑学科背景，培养具备空间设计和城市规划视野的环境设计师。', '[\"城市家具设计\", \"景观建筑\", \"展览空间设计\", \"历史建筑改造\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (55, 3, '数字媒体艺术', 'ri-computer-line', '融合技术与艺术，培养能够运用前沿技术进行创意表达的数字艺术家。', '[\"计算机图形学\", \"增强现实\", \"人工智能艺术\", \"数字建造\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (56, 3, '动画设计', 'ri-film-line', '培养具备动画创作和数字影像制作能力的专业人才。', '[\"角色动画\", \"建筑动画\", \"科学可视化\", \"影视后期\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (57, 4, '视觉传达设计', 'ri-palette-line', '传承国美深厚学术传统，培养具有东方美学素养和国际视野的视觉设计师。', '[\"传统图形设计\", \"当代海报设计\", \"书法与字体\", \"文化品牌设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (58, 4, '陶瓷艺术设计', 'ri-goblet-line', '发扬中国陶瓷艺术传统，培养具备现代设计理念的陶瓷艺术家。', '[\"传统陶艺\", \"现代陶瓷设计\", \"釉料研究\", \"陶瓷产品设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (59, 4, '纤维艺术', 'ri-thread-line', '探索纤维材料的艺术表达，培养具备创新精神的纤维艺术家。', '[\"编织艺术\", \"纤维装置\", \"服装艺术\", \"材料创新\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (60, 4, '综合艺术', 'ri-artboard-line', '跨媒介艺术实践，培养具备多元化表达能力的当代艺术家。', '[\"装置艺术\", \"行为艺术\", \"影像艺术\", \"公共艺术\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (61, 5, '视觉传达设计', 'ri-palette-line', '融合岭南文化特色，面向粤港澳大湾区，培养具有区域文化特色的设计师。', '[\"岭南文化设计\", \"粤港澳文创\", \"商业设计\", \"包装设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (62, 5, '产品设计', 'ri-lightbulb-line', '立足制造业发达的珠三角地区，培养具备产业化思维的产品设计师。', '[\"家电产品设计\", \"消费电子设计\", \"玩具设计\", \"文创产品\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (63, 5, '环境设计', 'ri-building-line', '结合岭南建筑文化和现代城市发展需求，培养环境设计专业人才。', '[\"岭南园林设计\", \"商业空间设计\", \"旅游景观设计\", \"文化空间设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (64, 5, '数字媒体艺术', 'ri-computer-line', '面向数字创意产业，培养具备新媒体创作能力的数字艺术人才。', '[\"游戏美术设计\", \"动漫设计\", \"短视频创作\", \"VR/AR艺术\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (65, 6, '工业设计', 'ri-tools-line', '国内工业设计领域领军专业，培养具备系统设计思维的工业设计师。', '[\"产品系统设计\", \"用户研究\", \"设计策略\", \"智能产品设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (66, 6, '视觉传达设计', 'ri-palette-line', '注重设计的功能性和商业价值，培养市场导向的视觉设计师。', '[\"品牌形象设计\", \"包装设计\", \"网页设计\", \"移动界面设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (67, 6, '环境设计', 'ri-building-line', '强调设计的人文关怀和生态理念，培养可持续发展的环境设计师。', '[\"可持续设计\", \"无障碍设计\", \"老龄化设计\", \"绿色建筑设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (68, 6, '服装与服饰设计', 'ri-shirt-line', '结合纺织工程优势，培养具备技术背景的服装设计师。', '[\"功能性服装\", \"智能纺织品\", \"时尚设计\", \"纺织品图案设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (69, 7, '工业设计', 'ri-tools-line', '依托理工科优势，培养具备工程技术背景的工业设计师。', '[\"机械产品设计\", \"军工产品设计\", \"精密仪器设计\", \"智能装备设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (70, 7, '数字媒体技术', 'ri-computer-line', '结合计算机科学与艺术设计，培养技术与艺术兼备的复合型人才。', '[\"计算机图形学\", \"虚拟现实技术\", \"人工智能应用\", \"数字娱乐技术\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (71, 7, '传播设计', 'ri-broadcast-line', '面向信息时代传播需求，培养具备新媒体素养的传播设计师。', '[\"信息设计\", \"数据可视化\", \"交互媒体设计\", \"科技传播设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (72, 7, '文化遗产保护', 'ri-ancient-pavilion-line', '运用现代技术手段保护和传承文化遗产，培养文化科技融合人才。', '[\"数字文保\", \"虚拟博物馆\", \"文物数字化\", \"文化传播技术\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (73, 8, '工业设计', 'ri-tools-line', '历史悠久的工业设计专业，培养具备深厚理论基础和实践能力的设计师。', '[\"汽车造型设计\", \"机械产品设计\", \"智能硬件设计\", \"设计管理\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (74, 8, '视觉传达设计', 'ri-palette-line', '融合湖湘文化特色，培养具有地域特色和时代精神的视觉设计师。', '[\"湖湘文化设计\", \"品牌设计\", \"数字媒体设计\", \"文创产品设计\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (75, 8, '建筑学', 'ri-building-2-line', '依托建筑学科优势，培养具备空间设计能力的建筑师。', '[\"建筑设计\", \"城市设计\", \"历史建筑保护\", \"绿色建筑\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');
INSERT INTO `des_school_major_category` VALUES (76, 8, '环境艺术设计', 'ri-plant-line', '结合环境工程背景，培养生态环境与艺术设计兼备的专业人才。', '[\"景观设计\", \"环境雕塑\", \"生态修复设计\", \"园林艺术\"]', NULL, '2025-06-28 15:46:54', NULL, '2025-06-28 15:46:54');

-- ----------------------------
-- Table structure for des_school_teacher
-- ----------------------------
DROP TABLE IF EXISTS `des_school_teacher`;
CREATE TABLE `des_school_teacher`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '教师姓名',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '职称',
  `expertise` json NULL COMMENT '专业领域',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '教师描述',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_teacher_school`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_teacher_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校代表性教师表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_teacher
-- ----------------------------
INSERT INTO `des_school_teacher` VALUES (1, 1, '王铁军', '教授、博士生导师', '[\"信息设计\", \"交互设计\"]', '清华大学美术学院信息艺术设计系主任，在信息可视化设计领域具有重要影响', NULL, '2025-06-28 14:54:27', NULL, '2025-06-28 14:54:27');
INSERT INTO `des_school_teacher` VALUES (2, 1, '李薇', '教授', '[\"视觉传达\", \"品牌设计\"]', '知名视觉传达设计专家，多项作品获国际设计大奖', NULL, '2025-06-28 14:54:27', NULL, '2025-06-28 14:54:27');
INSERT INTO `des_school_teacher` VALUES (3, 1, '张明', '副教授', '[\"工业设计\", \"可持续设计\"]', '专注于可持续设计研究，主持多项国家级科研项目', NULL, '2025-06-28 14:54:27', NULL, '2025-06-28 14:54:27');
INSERT INTO `des_school_teacher` VALUES (4, 1, '李德华', '教授、博士生导师', '[\"信息设计\", \"交互设计\", \"用户体验\"]', '国际知名信息设计专家，主导多个重要的信息可视化项目。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (5, 1, '王美玲', '副教授、硕士生导师', '[\"视觉传达\", \"品牌设计\", \"文化创意\"]', '在品牌设计和文化创意领域有深入研究，作品多次获得国际奖项。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (6, 1, '张建国', '教授、博士生导师', '[\"产品设计\", \"可持续设计\", \"设计创新\"]', '可持续设计理念倡导者，在绿色设计领域具有重要影响力。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (7, 2, '陈雅琳', '教授、博士生导师', '[\"视觉传达\", \"传统文化\", \"当代艺术\"]', '著名视觉艺术家，在传统文化与当代设计结合方面有突出贡献。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (8, 2, '刘志强', '副教授、硕士生导师', '[\"数字媒体\", \"新媒体艺术\", \"交互装置\"]', '新媒体艺术领域的先锋人物，作品在国内外多次展出。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (9, 2, '马丽华', '教授、博士生导师', '[\"服装设计\", \"纺织艺术\", \"时尚理论\"]', '国际知名服装设计师，在时尚教育领域具有重要地位。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (10, 3, '黄志明', '教授、博士生导师', '[\"岭南文化\", \"文创设计\", \"区域品牌\"]', '岭南文化研究专家，致力于地域文化的现代化表达。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (11, 3, '林秀珍', '副教授、硕士生导师', '[\"产品设计\", \"玩具设计\", \"儿童用品\"]', '在儿童产品设计领域有深入研究，设计作品深受市场认可。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (12, 3, '周建军', '教授、博士生导师', '[\"数字媒体\", \"游戏设计\", \"动漫产业\"]', '数字创意产业专家，在游戏和动漫设计教育方面贡献突出。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (13, 4, '范志华', '教授、博士生导师', '[\"工业设计\", \"交通工具\", \"可持续发展\"]', '国际著名工业设计师，在交通工具设计领域享有盛誉。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (14, 4, '孙美娟', '副教授、硕士生导师', '[\"环境设计\", \"城市规划\", \"景观建筑\"]', '在城市环境设计和景观规划方面有丰富经验。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (15, 4, '吴建国', '教授、博士生导师', '[\"数字建造\", \"参数化设计\", \"智能制造\"]', '数字化设计领域的领军人物，推动设计与技术的深度融合。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (16, 5, '徐志明', '教授、博士生导师', '[\"传统工艺\", \"陶瓷艺术\", \"文化传承\"]', '国家级非物质文化遗产传承人，在传统工艺保护和发展方面贡献卓越。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (17, 5, '赵雅丽', '副教授、硕士生导师', '[\"纤维艺术\", \"材料创新\", \"当代艺术\"]', '当代纤维艺术家，在材料创新和艺术表达方面有独特见解。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (18, 5, '钱建华', '教授、博士生导师', '[\"综合艺术\", \"公共艺术\", \"跨媒介实践\"]', '著名当代艺术家，在公共艺术和跨媒介创作方面影响深远。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (19, 6, '何人可', '教授、博士生导师', '[\"工业设计\", \"设计理论\", \"产品创新\"]', '中国工业设计教育的奠基人之一，在设计理论和实践方面贡献巨大。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (20, 6, '李艳霞', '副教授、硕士生导师', '[\"包装设计\", \"品牌形象\", \"视觉识别\"]', '包装设计专家，在品牌视觉识别系统设计方面经验丰富。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (21, 6, '辛向阳', '教授、博士生导师', '[\"交互设计\", \"服务设计\", \"用户体验\"]', '交互设计领域的权威专家，在用户体验设计方面有深入研究。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (22, 7, '杨建军', '教授、博士生导师', '[\"军工设计\", \"智能装备\", \"国防科技\"]', '军工设计专家，在国防科技产品设计方面有重要贡献。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (23, 7, '王丽萍', '副教授、硕士生导师', '[\"界面设计\", \"人机交互\", \"信息可视化\"]', '人机交互专家，在军用设备界面设计方面有丰富经验。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (24, 7, '陈志强', '教授、博士生导师', '[\"机器人设计\", \"人工智能\", \"智能制造\"]', '智能设计领域的领军人物，在机器人和AI应用方面成果显著。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (25, 8, '何晓佑', '教授、博士生导师', '[\"汽车设计\", \"交通工具\", \"造型设计\"]', '著名汽车设计师，多次参与重要汽车项目的设计工作。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (26, 8, '唐智慧', '副教授、硕士生导师', '[\"湖湘文化\", \"地域设计\", \"文化传承\"]', '湖湘文化研究专家，在地域文化设计方面有深入探索。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');
INSERT INTO `des_school_teacher` VALUES (27, 8, '贺雪梅', '教授、博士生导师', '[\"生态设计\", \"乡村振兴\", \"可持续发展\"]', '生态设计倡导者，在乡村振兴和可持续发展方面贡献突出。', NULL, '2025-06-28 14:58:42', NULL, '2025-06-28 14:58:42');

-- ----------------------------
-- Table structure for des_school_trend_data
-- ----------------------------
DROP TABLE IF EXISTS `des_school_trend_data`;
CREATE TABLE `des_school_trend_data`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `school_id` bigint NOT NULL COMMENT '院校ID',
  `years` json NULL COMMENT '年份数组',
  `international_data` json NULL COMMENT '国际奖项数据',
  `national_data` json NULL COMMENT '国家级奖项数据',
  `provincial_data` json NULL COMMENT '省级奖项数据',
  `create_by` bigint NULL DEFAULT NULL,
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `update_by` bigint NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `school_id`(`school_id` ASC) USING BTREE,
  CONSTRAINT `des_school_trend_data_ibfk_1` FOREIGN KEY (`school_id`) REFERENCES `des_school` (`school_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '院校获奖趋势数据表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_school_trend_data
-- ----------------------------
INSERT INTO `des_school_trend_data` VALUES (3, 1, '[\"2019\", \"2020\", \"2021\", \"2022\", \"2023\", \"2024\"]', '[18, 22, 26, 28, 25, 27]', '[45, 48, 52, 56, 53, 57]', '[72, 78, 84, 82, 78, 85]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_trend_data` VALUES (4, 2, '[\"2019\", \"2020\", \"2021\", \"2022\", \"2023\", \"2024\"]', '[12, 15, 18, 20, 17, 19]', '[28, 32, 36, 39, 35, 38]', '[48, 55, 62, 58, 52, 56]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_trend_data` VALUES (5, 3, '[\"2019\", \"2020\", \"2021\", \"2022\", \"2023\", \"2024\"]', '[14, 17, 21, 24, 22, 24]', '[35, 39, 43, 47, 44, 46]', '[58, 65, 72, 69, 65, 68]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_trend_data` VALUES (6, 4, '[\"2019\", \"2020\", \"2021\", \"2022\", \"2023\", \"2024\"]', '[10, 13, 16, 18, 15, 17]', '[24, 28, 32, 35, 31, 34]', '[42, 48, 55, 52, 47, 51]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_trend_data` VALUES (7, 5, '[\"2019\", \"2020\", \"2021\", \"2022\", \"2023\", \"2024\"]', '[8, 11, 14, 16, 13, 15]', '[22, 26, 30, 33, 29, 32]', '[38, 44, 51, 48, 43, 47]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_trend_data` VALUES (8, 6, '[\"2019\", \"2020\", \"2021\", \"2022\", \"2023\", \"2024\"]', '[20, 24, 28, 31, 28, 30]', '[48, 52, 56, 62, 58, 61]', '[75, 82, 89, 86, 81, 86]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_trend_data` VALUES (9, 7, '[\"2019\", \"2020\", \"2021\", \"2022\", \"2023\", \"2024\"]', '[11, 14, 17, 19, 16, 18]', '[26, 30, 34, 37, 33, 36]', '[38, 44, 48, 45, 41, 44]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');
INSERT INTO `des_school_trend_data` VALUES (10, 8, '[\"2019\", \"2020\", \"2021\", \"2022\", \"2023\", \"2024\"]', '[13, 16, 19, 21, 18, 20]', '[28, 32, 36, 39, 35, 38]', '[45, 52, 58, 55, 50, 54]', NULL, '2025-06-30 10:43:08', NULL, '2025-06-30 10:43:08');

-- ----------------------------
-- Table structure for des_user_binding
-- ----------------------------
DROP TABLE IF EXISTS `des_user_binding`;
CREATE TABLE `des_user_binding`  (
  `binding_id` bigint NOT NULL AUTO_INCREMENT COMMENT '绑定ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `entity_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实体类型（designer/enterprise/school）',
  `entity_id` bigint NOT NULL COMMENT '实体ID',
  `binding_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '绑定状态（0解绑 1绑定）',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  PRIMARY KEY (`binding_id`) USING BTREE,
  UNIQUE INDEX `uk_user_entity`(`user_id` ASC, `entity_type` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_entity`(`entity_type` ASC, `entity_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1933350394109485059 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户实体绑定关系表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_user_binding
-- ----------------------------
INSERT INTO `des_user_binding` VALUES (1933075789029351426, 1933072715447574530, 'enterprise', 1933075788966436865, '1', '2025-06-12 16:15:58', '2025-06-12 16:15:58', 103, 1933072715447574530, 1933072715447574530);
INSERT INTO `des_user_binding` VALUES (1933075905337401345, 1933072715447574530, 'school', 1933075905270292482, '1', '2025-06-12 16:16:25', '2025-06-12 16:16:25', 103, 1933072715447574530, 1933072715447574530);
INSERT INTO `des_user_binding` VALUES (1933092972279123970, 1933082743395094530, 'enterprise', 1933092972216209410, '1', '2025-06-12 17:24:14', '2025-06-12 17:24:14', 103, 1933082743395094530, 1933082743395094530);
INSERT INTO `des_user_binding` VALUES (1933093400651780099, 1933082743395094530, 'school', 1933093400651780098, '1', '2025-06-12 17:25:57', '2025-06-12 17:25:57', 103, 1933082743395094530, 1933082743395094530);
INSERT INTO `des_user_binding` VALUES (1933345376941760513, 1, 'school', 1933345376878845953, '1', '2025-06-13 10:07:12', '2025-06-13 10:07:12', 103, 1, 1);
INSERT INTO `des_user_binding` VALUES (1933345394062909443, 1, 'enterprise', 3, '1', '2025-06-13 10:07:16', '2025-06-13 17:53:30', 103, 1, 1);

-- ----------------------------
-- Table structure for des_user_favorite
-- ----------------------------
DROP TABLE IF EXISTS `des_user_favorite`;
CREATE TABLE `des_user_favorite`  (
  `favorite_id` bigint NOT NULL AUTO_INCREMENT COMMENT '收藏ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `entity_id` bigint NOT NULL COMMENT '实体ID',
  `entity_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '实体类型（SCHOOL/DESIGNER/ENTERPRISE/WORK）',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`favorite_id`) USING BTREE,
  UNIQUE INDEX `uk_user_entity_favorite`(`user_id` ASC, `entity_id` ASC, `entity_type` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_entity`(`entity_type` ASC, `entity_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户收藏表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of des_user_favorite
-- ----------------------------

-- ----------------------------
-- Table structure for des_work
-- ----------------------------
DROP TABLE IF EXISTS `des_work`;
CREATE TABLE `des_work`  (
  `work_id` bigint NOT NULL AUTO_INCREMENT COMMENT '作品ID',
  `designer_id` bigint NOT NULL COMMENT '设计师ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作品标题',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '作品描述',
  `work_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '作品类型（image/video）',
  `file_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文件URL',
  `thumbnail_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '缩略图URL',
  `file_size` bigint NULL DEFAULT NULL COMMENT '文件大小（字节）',
  `tags` json NULL COMMENT '作品标签（JSON数组格式）',
  `like_count` int NULL DEFAULT 0 COMMENT '点赞数',
  `view_count` int NULL DEFAULT 0 COMMENT '浏览数',
  `is_featured` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '是否为代表作品（0否 1是）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`work_id`) USING BTREE,
  INDEX `idx_designer_id`(`designer_id` ASC) USING BTREE,
  INDEX `idx_work_type`(`work_type` ASC) USING BTREE,
  INDEX `idx_is_featured`(`is_featured` ASC) USING BTREE,
  CONSTRAINT `des_work_ibfk_1` FOREIGN KEY (`designer_id`) REFERENCES `des_designer` (`designer_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设计师作品表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_work
-- ----------------------------
INSERT INTO `des_work` VALUES (1, 1, '智慧出行APP界面设计', '专为城市通勤者设计的智能出行应用，整合多种交通方式，提供一站式出行解决方案', 'image', 'https://via.placeholder.com/400x300/6366f1/ffffff?text=Smart+Travel+UI', 'https://via.placeholder.com/200x150/6366f1/ffffff?text=Smart+Travel+UI', NULL, '[\"UI设计\", \"移动应用\", \"交通出行\", \"用户体验\"]', 156, 2340, '1', '0', NULL, NULL, '2023-06-01 00:00:00', NULL, '2023-06-01 00:00:00');
INSERT INTO `des_work` VALUES (2, 1, '数据分析仪表盘重设计', '为企业级数据分析平台设计的新一代仪表盘界面，提升数据可视化效果和用户操作体验', 'image', 'https://via.placeholder.com/400x300/8b5cf6/ffffff?text=Dashboard+UI', NULL, NULL, '[\"Web设计\", \"数据可视化\", \"企业应用\", \"B端产品\"]', 89, 1567, '0', '0', NULL, NULL, '2023-08-01 00:00:00', NULL, '2023-08-01 00:00:00');
INSERT INTO `des_work` VALUES (3, 1, '电商购物应用UI设计', '现代化的电商购物应用界面设计，注重购物流程优化和视觉体验提升', 'image', 'https://via.placeholder.com/400x300/ec4899/ffffff?text=E-commerce+UI', NULL, NULL, '[\"UI设计\", \"电商\", \"移动应用\", \"购物体验\"]', 203, 3210, '1', '0', NULL, NULL, '2023-10-01 00:00:00', NULL, '2023-10-01 00:00:00');
INSERT INTO `des_work` VALUES (4, 2, '绿色科技公司品牌设计', '为新能源科技公司设计的完整品牌形象，包括LOGO、VI系统和品牌应用', 'image', 'https://via.placeholder.com/400x300/10b981/ffffff?text=Green+Tech+Brand', NULL, NULL, '[\"品牌设计\", \"LOGO设计\", \"VI系统\", \"绿色科技\"]', 128, 1890, '1', '0', NULL, NULL, '2023-07-15 00:00:00', NULL, '2023-07-15 00:00:00');
INSERT INTO `des_work` VALUES (5, 2, '咖啡品牌包装设计', '为精品咖啡品牌设计的系列包装，融合现代简约风格与传统咖啡文化', 'image', 'https://via.placeholder.com/400x300/f59e0b/ffffff?text=Coffee+Package', NULL, NULL, '[\"包装设计\", \"品牌设计\", \"咖啡\", \"消费品\"]', 95, 1456, '0', '0', NULL, NULL, '2023-09-20 00:00:00', NULL, '2023-09-20 00:00:00');
INSERT INTO `des_work` VALUES (6, 3, '科幻角色设计系列', '原创科幻题材角色设计，展现未来世界的多元文化和技术融合', 'image', 'https://via.placeholder.com/400x300/8b5cf6/ffffff?text=Sci-Fi+Characters', NULL, NULL, '[\"角色设计\", \"3D建模\", \"科幻\", \"概念设计\"]', 312, 4567, '1', '0', NULL, NULL, '2023-05-10 00:00:00', NULL, '2023-05-10 00:00:00');
INSERT INTO `des_work` VALUES (7, 3, '产品宣传动画', '为智能家居产品制作的3D宣传动画，展示产品功能和使用场景', 'video', 'https://via.placeholder.com/400x300/ef4444/ffffff?text=Product+Animation', NULL, NULL, '[\"3D动画\", \"产品展示\", \"智能家居\", \"宣传片\"]', 178, 2890, '0', '0', NULL, NULL, '2023-11-05 00:00:00', NULL, '2023-11-05 00:00:00');
INSERT INTO `des_work` VALUES (8, 4, '企业管理系统界面设计', '为大型企业设计的管理系统界面，注重信息架构和操作效率', 'image', 'https://via.placeholder.com/400x300/3b82f6/ffffff?text=Enterprise+UI', NULL, NULL, '[\"Web设计\", \"企业应用\", \"B端产品\", \"管理系统\"]', 67, 1234, '0', '0', NULL, NULL, '2023-08-15 00:00:00', NULL, '2023-08-15 00:00:00');
INSERT INTO `des_work` VALUES (9, 5, '移动端交互原型设计', '为金融应用设计的交互原型，展示完整的用户操作流程', 'image', 'https://via.placeholder.com/400x300/10b981/ffffff?text=Mobile+Prototype', NULL, NULL, '[\"交互设计\", \"原型设计\", \"移动应用\", \"金融产品\"]', 145, 2100, '1', '0', NULL, NULL, '2023-09-10 00:00:00', NULL, '2023-09-10 00:00:00');

-- ----------------------------
-- Table structure for des_work_experience
-- ----------------------------
DROP TABLE IF EXISTS `des_work_experience`;
CREATE TABLE `des_work_experience`  (
  `experience_id` bigint NOT NULL AUTO_INCREMENT COMMENT '工作经历ID',
  `designer_id` bigint NOT NULL COMMENT '设计师ID',
  `company` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公司名称',
  `position` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '职位名称',
  `start_date` date NOT NULL COMMENT '开始日期',
  `end_date` date NULL DEFAULT NULL COMMENT '结束日期',
  `is_current` tinyint(1) NULL DEFAULT 0 COMMENT '是否为当前工作',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '工作描述',
  `location` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '工作地点',
  `industry` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '行业类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`experience_id`) USING BTREE,
  INDEX `idx_designer_id`(`designer_id` ASC) USING BTREE,
  INDEX `idx_start_date`(`start_date` ASC) USING BTREE,
  INDEX `idx_is_current`(`is_current` ASC) USING BTREE,
  CONSTRAINT `fk_work_experience_designer` FOREIGN KEY (`designer_id`) REFERENCES `des_designer` (`designer_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '设计师工作经历表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of des_work_experience
-- ----------------------------
INSERT INTO `des_work_experience` VALUES (1, 1, '腾讯科技有限公司', '高级 UI/UX 设计师', '2022-03-01', NULL, 1, '负责腾讯社交产品的用户体验设计，主导产品界面改版与优化，建立设计规范与组件库。参与用户研究与需求分析，提出基于数据的设计解决方案。带领团队完成多个重要项目，包括微信小程序设计规范制定、QQ音乐界面重设计等。', '深圳市南山区', '互联网', '0', NULL, NULL, '2022-03-01 00:00:00', NULL, '2025-06-24 14:46:16');
INSERT INTO `des_work_experience` VALUES (2, 1, '字节跳动', 'UI 设计师', '2020-06-01', '2022-02-28', 0, '参与短视频应用的界面设计工作，负责功能迭代与视觉优化，协助建立设计规范。与产品和开发团队紧密合作，确保设计方案的顺利实现。主要参与抖音、今日头条等产品的设计优化工作。', '北京市朝阳区', '互联网', '0', NULL, NULL, '2020-06-01 00:00:00', NULL, '2022-02-28 00:00:00');
INSERT INTO `des_work_experience` VALUES (3, 1, '美团', '初级 UI 设计师', '2018-07-01', '2020-05-31', 0, '负责美团外卖和美团App的界面设计工作，参与产品功能迭代和视觉优化。学习和掌握了大型互联网产品的设计流程和方法，积累了丰富的移动端设计经验。', '北京市朝阳区', '互联网', '0', NULL, NULL, '2018-07-01 00:00:00', NULL, '2020-05-31 00:00:00');
INSERT INTO `des_work_experience` VALUES (4, 2, '4A广告公司', '资深视觉设计师', '2021-01-01', NULL, 1, '负责品牌视觉设计和广告创意执行，为多个知名品牌提供视觉设计服务。参与品牌策略制定和视觉识别系统构建，擅长整合营销传播设计。主要服务客户包括汽车、快消、金融等行业头部企业。', '上海市静安区', '广告', '0', NULL, NULL, '2021-01-01 00:00:00', NULL, '2025-06-24 14:46:16');
INSERT INTO `des_work_experience` VALUES (5, 2, '设计工作室', '品牌设计师', '2018-03-01', '2020-12-31', 0, '在精品设计工作室负责品牌设计项目，参与从品牌策略到视觉执行的全流程工作。为中小企业和创业公司提供品牌设计服务，积累了丰富的品牌设计经验和客户沟通技巧。', '上海市徐汇区', '设计服务', '0', NULL, NULL, '2018-03-01 00:00:00', NULL, '2020-12-31 00:00:00');
INSERT INTO `des_work_experience` VALUES (6, 3, '游戏公司', '3D美术设计师', '2021-08-01', NULL, 1, '负责手机游戏的3D美术设计工作，包括角色建模、场景设计和动画制作。参与多款热门游戏的美术制作，在角色设计和场景构建方面有丰富经验。', '北京市海淀区', '游戏', '0', NULL, NULL, '2021-08-01 00:00:00', NULL, '2025-06-24 14:46:16');
INSERT INTO `des_work_experience` VALUES (7, 4, '阿里巴巴', '产品设计师', '2020-09-01', NULL, 1, '负责B端产品的用户体验设计，参与阿里云、钉钉等企业级产品的设计工作。专注于复杂业务场景下的用户体验优化，具备丰富的B端产品设计经验。', '杭州市西湖区', '互联网', '0', NULL, NULL, '2020-09-01 00:00:00', NULL, '2025-06-24 14:46:16');
INSERT INTO `des_work_experience` VALUES (8, 5, '腾讯', '交互设计师', '2020-07-15', NULL, 1, '负责腾讯多个产品的交互设计工作，主要参与微信、QQ等社交产品的功能迭代和用户体验优化。在移动端交互设计方面有深入研究，善于通过用户研究和数据分析优化产品体验。', '成都市高新区', '互联网', '0', NULL, NULL, '2020-07-15 00:00:00', NULL, '2025-06-24 14:46:16');

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1906673887579049985, 'chat_config', '配置信息表', NULL, NULL, 'ChatConfig', 'crud', 'org.ruoyi.system', 'system', 'config', '配置信息', 'ageerle', '0', '/', NULL, 103, 1, '2025-03-31 19:36:27', 1, '2025-03-31 19:36:27', NULL);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1906673888229167105, 1906673887579049985, 'id', '主键', 'bigint(20)', 'Long', 'id', '1', '1', '1', NULL, '1', '1', NULL, 'EQ', 'input', '', 1, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167106, 1906673887579049985, 'category', '配置类型', 'varchar(255)', 'String', 'category', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 2, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167107, 1906673887579049985, 'config_name', '配置名称', 'varchar(255)', 'String', 'configName', '0', '0', '1', '1', '1', '1', '1', 'LIKE', 'input', '', 3, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167108, 1906673887579049985, 'config_value', '配置值', 'text', 'String', 'configValue', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'textarea', '', 4, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167109, 1906673887579049985, 'config_dict', '说明', 'varchar(255)', 'String', 'configDict', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 5, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167110, 1906673887579049985, 'create_dept', '创建部门', 'bigint(20)', 'Long', 'createDept', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 6, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167111, 1906673887579049985, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 7, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167112, 1906673887579049985, 'create_by', '创建者', 'varchar(64)', 'String', 'createBy', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 8, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167113, 1906673887579049985, 'update_by', '更新者', 'varchar(64)', 'String', 'updateBy', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 9, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167114, 1906673887579049985, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'datetime', '', 10, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167115, 1906673887579049985, 'remark', '备注', 'varchar(500)', 'String', 'remark', '0', '0', '1', '1', '1', '1', NULL, 'EQ', 'textarea', '', 11, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888229167116, 1906673887579049985, 'version', '版本', 'int(11)', 'Long', 'version', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 12, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888292081665, 1906673887579049985, 'del_flag', '删除标志（0代表存在 1代表删除）', 'char(1)', 'String', 'delFlag', '0', '0', NULL, NULL, NULL, NULL, NULL, 'EQ', 'input', '', 13, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888292081666, 1906673887579049985, 'update_ip', '更新IP', 'varchar(128)', 'String', 'updateIp', '0', '0', '1', '1', '1', '1', '1', 'EQ', 'input', '', 14, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');
INSERT INTO `gen_table_column` VALUES (1906673888292081667, 1906673887579049985, 'tenant_id', '租户Id', 'bigint(20)', 'Long', 'tenantId', '0', '0', '1', NULL, NULL, NULL, NULL, 'EQ', 'input', '', 15, 103, 1, '2025-03-31 19:44:14', 1, '2025-03-31 19:44:14');

-- ----------------------------
-- Table structure for knowledge_attach
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_attach`;
CREATE TABLE `knowledge_attach`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识库ID',
  `doc_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档ID',
  `doc_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文档名称',
  `doc_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档类型',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '文档内容',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '备注',
  `oss_id` bigint NOT NULL COMMENT '对象存储主键',
  `pic_status` tinyint(1) NOT NULL DEFAULT 10 COMMENT '拆解图片状态10未开始，20进行中，30已完成',
  `pic_anys_status` tinyint(1) NOT NULL DEFAULT 10 COMMENT '分析图片状态10未开始，20进行中，30已完成',
  `vector_status` tinyint(1) NOT NULL DEFAULT 10 COMMENT '写入向量数据库状态10未开始，20进行中，30已完成',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_kname`(`kid` ASC, `doc_name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1906640977816494082 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '知识库附件' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of knowledge_attach
-- ----------------------------

-- ----------------------------
-- Table structure for knowledge_fragment
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_fragment`;
CREATE TABLE `knowledge_fragment`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识库ID',
  `doc_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '文档ID',
  `fid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识片段ID',
  `idx` int NOT NULL COMMENT '片段索引下标',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '文档内容',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1906640976134578257 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '知识片段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of knowledge_fragment
-- ----------------------------

-- ----------------------------
-- Table structure for knowledge_info
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_info`;
CREATE TABLE `knowledge_info`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kid` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识库ID',
  `uid` bigint NOT NULL DEFAULT 0 COMMENT '用户ID',
  `kname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '知识库名称',
  `share` tinyint NULL DEFAULT NULL COMMENT '是否公开知识库（0 否 1是）',
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '描述',
  `knowledge_separator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '知识分隔符',
  `question_separator` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '提问分隔符',
  `overlap_char` int NULL DEFAULT NULL COMMENT '重叠字符数',
  `retrieve_limit` int NULL DEFAULT NULL COMMENT '知识库中检索的条数',
  `text_block_size` int NULL DEFAULT NULL COMMENT '文本块大小',
  `vector_model_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '向量库',
  `embedding_model_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '向量模型',
  `system_prompt` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '系统提示词',
  `create_dept` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '部门',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_kid`(`kid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1906589542361899010 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '知识库' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of knowledge_info
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` bigint NOT NULL COMMENT '参数主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '000000', '时间参数', 'skin-purple', 'skin-blue', 'N', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-28 22:30:49', '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow');
INSERT INTO `sys_config` VALUES (2, '000000', '显示方式', 'sys.user.initPassword', '123456', 'N', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-28 10:40:44', '初始化密码 123456');
INSERT INTO `sys_config` VALUES (3, '000000', '回答模板', 'sys.index.sideTheme', 'theme-dark', 'Y', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-28 10:40:50', '深色主题theme-dark，浅色主题theme-light');
INSERT INTO `sys_config` VALUES (5, '000000', '无结果时是否交由其他回答指令模板进行配置处理', 'sys.account.registerUser', 'false', 'Y', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-28 10:40:57', '是否开启注册用户功能（true开启，false关闭）');
INSERT INTO `sys_config` VALUES (11, '000000', 'OSS预览列表资源开关', 'sys.oss.previewListResource', 'true', 'Y', 103, 1, '2023-05-14 15:19:42', NULL, NULL, 'true:开启, false:关闭');
INSERT INTO `sys_config` VALUES (1901957791626854401, '000000', '1', '1', '1', 'N', 103, 1, '2025-03-18 19:24:09', 1, '2025-03-18 19:24:09', NULL);
INSERT INTO `sys_config` VALUES (1902001922927525890, '000000', '111', '111', '111', 'N', 103, 1, '2025-03-18 22:19:31', 1, '2025-03-18 22:19:31', NULL);
INSERT INTO `sys_config` VALUES (1903121770873139202, '000000', '12', '12', '12', 'N', 103, 1, '2025-03-22 00:29:23', 1, '2025-03-22 00:29:23', NULL);
INSERT INTO `sys_config` VALUES (1903148170321637377, '000000', '324', '234', '234', 'N', 103, 1, '2025-03-22 02:14:17', 1, '2025-03-22 02:14:17', NULL);
INSERT INTO `sys_config` VALUES (1903150187299516418, '000000', '1去', '额', '额外', 'N', 103, 1, '2025-03-22 02:22:18', 1, '2025-03-22 02:22:18', NULL);
INSERT INTO `sys_config` VALUES (1903150796597669890, '000000', '1323321', '1321', '1', 'Y', 103, 1, '2025-03-22 02:24:43', 1, '2025-03-22 02:24:43', NULL);
INSERT INTO `sys_config` VALUES (1903977127044497410, '000000', 'aq', 'as', 'sa', 'Y', 103, 1, '2025-03-24 09:08:16', 1, '2025-03-24 09:08:16', 'as');
INSERT INTO `sys_config` VALUES (1903992403639189505, '000000', '12', '12323234', '1', 'N', 103, 1, '2025-03-24 10:08:58', 1, '2025-03-24 10:08:58', '1');
INSERT INTO `sys_config` VALUES (1904348758011060225, '000000', '123', '123', '123', 'N', 103, 1, '2025-03-25 09:45:00', 1, '2025-03-25 09:45:00', NULL);
INSERT INTO `sys_config` VALUES (1904433831695654913, '000000', 'Test01', '1111', '1222', 'N', 103, 1, '2025-03-25 15:23:03', 1, '2025-03-28 22:30:53', '123123');
INSERT INTO `sys_config` VALUES (1904492290667487233, '000000', 'test', 'test', 'test', 'Y', 103, 1, '2025-03-25 19:15:21', 1, '2025-03-25 19:15:21', '阿斯顿发');
INSERT INTO `sys_config` VALUES (1904526572685402114, '000000', 'a', 'k', '123', 'N', 103, 1, '2025-03-25 21:31:34', 1, '2025-03-25 21:31:34', NULL);
INSERT INTO `sys_config` VALUES (1904730931222323202, '000000', '支付111', '支付111', '100', 'N', 103, 1, '2025-03-26 11:03:37', 1, '2025-03-26 11:03:37', '测试');
INSERT INTO `sys_config` VALUES (1904731973473312770, '000000', '积分兑换111', '121', '121', 'N', 103, 1, '2025-03-26 11:07:45', 1, '2025-03-26 11:07:45', '积分兑换');
INSERT INTO `sys_config` VALUES (1904789679236227073, '000000', '2', '2', '2', 'N', 103, 1, '2025-03-26 14:57:03', 1, '2025-03-26 14:57:03', NULL);
INSERT INTO `sys_config` VALUES (1905070856643846146, '000000', '21', '21', '2121', 'N', 103, 1, '2025-03-27 09:34:21', 1, '2025-03-27 09:34:21', '21212');
INSERT INTO `sys_config` VALUES (1905449847099793409, '000000', '指标时间参数配置', '12321', '12321', 'N', 103, 1, '2025-03-28 10:40:20', 1, '2025-03-28 10:40:20', NULL);
INSERT INTO `sys_config` VALUES (1906533795238289409, '000000', '123222', '123222', '123222', 'Y', 103, 1, '2025-03-31 10:27:33', 1, '2025-03-31 10:27:33', NULL);
INSERT INTO `sys_config` VALUES (1906597665071996929, '000000', '什么都参数', '什么都参数', '1', 'Y', 103, 1, '2025-03-31 14:41:21', 1, '2025-03-31 14:41:21', '1');
INSERT INTO `sys_config` VALUES (1906619956543660034, '000000', '测试', '测试', '测试', 'N', 103, 1, '2025-03-31 16:09:56', 1, '2025-03-31 16:09:56', NULL);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '邮箱',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, '000000', 0, '0', '熊猫科技', 0, 'ageerle', '15888888888', 'ageerle@163.com', '0', '0', 103, 1, '2023-05-14 15:19:39', 1, '2023-12-29 11:18:24');
INSERT INTO `sys_dept` VALUES (101, '000000', 100, '0,100', '深圳总公司', 1, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (102, '000000', 100, '0,100', '长沙分公司', 2, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (103, '000000', 101, '0,100,101', '研发部门', 1, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (104, '000000', 101, '0,100,101', '市场部门', 2, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (105, '000000', 101, '0,100,101', '测试部门', 3, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (106, '000000', 101, '0,100,101', '财务部门', 4, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (107, '000000', 101, '0,100,101', '运维部门', 5, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (108, '000000', 102, '0,100,102', '市场部门', 1, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (109, '000000', 102, '0,100,102', '财务部门', 2, '疯狂的狮子Li', '15888888888', 'xxx@qq.com', '0', '2', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_dept` VALUES (1903101865297752066, '000000', 103, '0,100,101,103', 'AA', 1, NULL, '18701676790', '1234@ss.com', '0', '0', 103, 1, '2025-03-21 23:10:17', 1, '2025-03-21 23:10:17');
INSERT INTO `sys_dept` VALUES (1904430886174367746, '000000', 1903101865297752066, '0,100,101,103,1903101865297752066', '测试', 1, NULL, NULL, NULL, '0', '0', 103, 1, '2025-03-25 15:11:21', 1, '2025-03-25 15:11:21');
INSERT INTO `sys_dept` VALUES (1904736932721893377, '000000', 101, '0,100,101', '研发部门2', 100, NULL, NULL, NULL, '0', '0', 103, 1, '2025-03-26 11:27:28', 1, '2025-03-26 11:27:28');
INSERT INTO `sys_dept` VALUES (1905140221372309505, '000000', 1903101865297752066, '0,100,101,103,1903101865297752066', 'test', 1, NULL, NULL, NULL, '0', '0', 103, 1, '2025-03-27 14:09:59', 1, '2025-03-27 14:09:59');
INSERT INTO `sys_dept` VALUES (1905554900431183874, '000000', 103, '0,100,101,103', '部门1', 5, NULL, NULL, NULL, '0', '0', 103, 1, '2025-03-28 17:37:46', 1, '2025-03-28 17:37:46');
INSERT INTO `sys_dept` VALUES (1905849169498906626, '000000', 1903101865297752066, '0,100,101,103,1903101865297752066', '111111', 1, NULL, NULL, NULL, '0', '0', 103, 1, '2025-03-29 13:07:06', 1, '2025-03-29 13:07:06');

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL COMMENT '字典编码',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, '000000', 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '性别男');
INSERT INTO `sys_dict_data` VALUES (2, '000000', 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '性别女');
INSERT INTO `sys_dict_data` VALUES (3, '000000', 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '性别未知');
INSERT INTO `sys_dict_data` VALUES (4, '000000', 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '显示菜单');
INSERT INTO `sys_dict_data` VALUES (5, '000000', 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '隐藏菜单');
INSERT INTO `sys_dict_data` VALUES (6, '000000', 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (7, '000000', 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (12, '000000', 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '系统默认是');
INSERT INTO `sys_dict_data` VALUES (13, '000000', 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '系统默认否');
INSERT INTO `sys_dict_data` VALUES (14, '000000', 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '通知');
INSERT INTO `sys_dict_data` VALUES (15, '000000', 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '公告');
INSERT INTO `sys_dict_data` VALUES (16, '000000', 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (17, '000000', 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '关闭状态');
INSERT INTO `sys_dict_data` VALUES (18, '000000', 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '新增操作');
INSERT INTO `sys_dict_data` VALUES (19, '000000', 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '修改操作');
INSERT INTO `sys_dict_data` VALUES (20, '000000', 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '删除操作');
INSERT INTO `sys_dict_data` VALUES (21, '000000', 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '授权操作');
INSERT INTO `sys_dict_data` VALUES (22, '000000', 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '导出操作');
INSERT INTO `sys_dict_data` VALUES (23, '000000', 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '导入操作');
INSERT INTO `sys_dict_data` VALUES (24, '000000', 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '强退操作');
INSERT INTO `sys_dict_data` VALUES (25, '000000', 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '生成操作');
INSERT INTO `sys_dict_data` VALUES (26, '000000', 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '清空操作');
INSERT INTO `sys_dict_data` VALUES (27, '000000', 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '正常状态');
INSERT INTO `sys_dict_data` VALUES (28, '000000', 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '停用状态');
INSERT INTO `sys_dict_data` VALUES (29, '000000', 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '其他操作');
INSERT INTO `sys_dict_data` VALUES (1775756996568993793, '000000', 1, '免费用户', '0', 'sys_user_grade', '', 'info', 'N', '0', 103, 1, '2024-04-04 13:27:15', 1, '2024-04-04 13:30:09', '');
INSERT INTO `sys_dict_data` VALUES (1775757116970684418, '000000', 2, '高级会员', '1', 'sys_user_grade', '', 'success', 'N', '0', 103, 1, '2024-04-04 13:27:43', 1, '2024-04-04 13:30:15', '');
INSERT INTO `sys_dict_data` VALUES (1776109770934677506, '000000', 0, 'token计费', '1', 'sys_model_billing', '', 'primary', 'N', '0', 103, 1, '2024-04-05 12:49:03', 1, '2024-04-21 00:05:41', '');
INSERT INTO `sys_dict_data` VALUES (1776109853377916929, '000000', 0, '次数计费', '2', 'sys_model_billing', '', 'success', 'N', '0', 103, 1, '2024-04-05 12:49:22', 1, '2024-04-05 12:49:22', '');
INSERT INTO `sys_dict_data` VALUES (1780264338471858177, '000000', 0, '未支付', '1', 'pay_state', '', 'info', 'N', '0', 103, 1, '2024-04-16 23:57:49', 1, '2024-04-16 23:58:29', '');
INSERT INTO `sys_dict_data` VALUES (1780264431589601282, '000000', 2, '已支付', '2', 'pay_state', '', 'success', 'N', '0', 103, 1, '2024-04-16 23:58:11', 1, '2024-04-16 23:58:21', '');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL COMMENT '字典主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `tenant_id`(`tenant_id` ASC, `dict_type` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '000000', '用户性别', 'sys_user_sex', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (2, '000000', '菜单状态', 'sys_show_hide', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (3, '000000', '系统开关', 'sys_normal_disable', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (6, '000000', '系统是否', 'sys_yes_no', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (7, '000000', '通知类型', 'sys_notice_type', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (8, '000000', '通知状态', 'sys_notice_status', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (9, '000000', '操作类型', 'sys_oper_type', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (10, '000000', '系统状态', 'sys_common_status', '0', 103, 1, '2023-05-14 15:19:41', NULL, NULL, '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083714, '911866', '用户性别', 'sys_user_sex', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '用户性别列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083715, '911866', '菜单状态', 'sys_show_hide', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '菜单状态列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083716, '911866', '系统开关', 'sys_normal_disable', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '系统开关列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083717, '911866', '系统是否', 'sys_yes_no', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '系统是否列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083718, '911866', '通知类型', 'sys_notice_type', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '通知类型列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083719, '911866', '通知状态', 'sys_notice_status', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '通知状态列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083720, '911866', '操作类型', 'sys_oper_type', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '操作类型列表');
INSERT INTO `sys_dict_type` VALUES (1729685494468083721, '911866', '系统状态', 'sys_common_status', '0', 103, 1, '2023-05-14 15:19:41', 1, '2023-05-14 15:19:41', '登录状态列表');
INSERT INTO `sys_dict_type` VALUES (1775756736895438849, '000000', '用户等级', 'sys_user_grade', '0', 103, 1, '2024-04-04 13:26:13', 1, '2024-04-04 13:26:13', '');
INSERT INTO `sys_dict_type` VALUES (1776109665045278721, '000000', '模型计费方式', 'sys_model_billing', '0', 103, 1, '2024-04-05 12:48:37', 1, '2024-04-08 11:22:18', '模型计费方式');
INSERT INTO `sys_dict_type` VALUES (1780263881368219649, '000000', '支付状态', 'pay_state', '0', 103, 1, '2024-04-16 23:56:00', 1, '2025-03-29 15:21:57', '支付状态');
INSERT INTO `sys_dict_type` VALUES (1904565568803217409, '000000', '状态类型', 'status_type', '0', 103, 1, '2025-03-26 00:06:31', 1, '2025-03-26 00:06:31', NULL);
INSERT INTO `sys_dict_type` VALUES (1904753371814076417, '000000', '222', 'sadffasd', '0', 103, 1, '2025-03-26 12:32:47', 1, '2025-03-26 12:32:47', '34444');
INSERT INTO `sys_dict_type` VALUES (1905807388002525185, '000000', '11', 'ee', '0', 103, 1, '2025-03-29 10:21:04', 1, '2025-03-29 10:21:04', '11');

-- ----------------------------
-- Table structure for sys_file_info
-- ----------------------------
DROP TABLE IF EXISTS `sys_file_info`;
CREATE TABLE `sys_file_info`  (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '文件id',
  `url` varchar(512) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '文件访问地址',
  `size` bigint NULL DEFAULT NULL COMMENT '文件大小，单位字节',
  `filename` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件名称',
  `original_filename` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '原始文件名',
  `base_path` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '基础存储路径',
  `path` varchar(256) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '存储路径',
  `ext` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件扩展名',
  `user_id` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件所属用户',
  `file_type` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件类型',
  `attr` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '附加属性',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '创建者',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `version` int NULL DEFAULT NULL COMMENT '版本',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 1代表删除）',
  `update_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '更新IP',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户Id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '文件记录表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_file_info
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL COMMENT '访问ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (1906674629019475969, '00000', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2025-03-31 19:47:11');
INSERT INTO `sys_logininfor` VALUES (1906677855705931778, '00000', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', 'Login successful', '2025-03-31 20:00:00');
INSERT INTO `sys_logininfor` VALUES (1924694700216815618, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-20 13:12:30');
INSERT INTO `sys_logininfor` VALUES (1924701249341612033, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2025-05-20 13:38:32');
INSERT INTO `sys_logininfor` VALUES (1924702147883163649, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-20 13:42:06');
INSERT INTO `sys_logininfor` VALUES (1924702199661846529, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-20 13:42:18');
INSERT INTO `sys_logininfor` VALUES (1924709756396756993, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-20 14:12:20');
INSERT INTO `sys_logininfor` VALUES (1924778191268995074, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-20 18:44:16');
INSERT INTO `sys_logininfor` VALUES (1925072527319732225, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-21 14:13:51');
INSERT INTO `sys_logininfor` VALUES (1925120751229308930, '00000', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-21 17:25:29');
INSERT INTO `sys_logininfor` VALUES (1925364051534168066, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 09:32:16');
INSERT INTO `sys_logininfor` VALUES (1925364100473307138, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 09:32:28');
INSERT INTO `sys_logininfor` VALUES (1925364144467361794, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 09:32:38');
INSERT INTO `sys_logininfor` VALUES (1925364226117877762, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 09:32:58');
INSERT INTO `sys_logininfor` VALUES (1925366650299760642, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 09:42:36');
INSERT INTO `sys_logininfor` VALUES (1925366665067905026, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 09:42:39');
INSERT INTO `sys_logininfor` VALUES (1925374060028510209, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:12:02');
INSERT INTO `sys_logininfor` VALUES (1925374112352452610, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:12:15');
INSERT INTO `sys_logininfor` VALUES (1925374137837043714, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:12:21');
INSERT INTO `sys_logininfor` VALUES (1925374141884547073, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:12:22');
INSERT INTO `sys_logininfor` VALUES (1925374171030765569, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:12:29');
INSERT INTO `sys_logininfor` VALUES (1925374259719323650, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:12:50');
INSERT INTO `sys_logininfor` VALUES (1925374970859372545, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:15:39');
INSERT INTO `sys_logininfor` VALUES (1925375013259591681, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:15:50');
INSERT INTO `sys_logininfor` VALUES (1925375146483269634, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:16:21');
INSERT INTO `sys_logininfor` VALUES (1925375196726837249, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:16:33');
INSERT INTO `sys_logininfor` VALUES (1925375279413346305, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:16:53');
INSERT INTO `sys_logininfor` VALUES (1925375388091957249, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:17:19');
INSERT INTO `sys_logininfor` VALUES (1925376127744884738, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:20:15');
INSERT INTO `sys_logininfor` VALUES (1925376181692022785, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:20:28');
INSERT INTO `sys_logininfor` VALUES (1925376547636658178, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:21:55');
INSERT INTO `sys_logininfor` VALUES (1925376601441189889, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:22:08');
INSERT INTO `sys_logininfor` VALUES (1925376951250337793, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:23:32');
INSERT INTO `sys_logininfor` VALUES (1925377508044193794, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:25:44');
INSERT INTO `sys_logininfor` VALUES (1925379845466898434, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:35:02');
INSERT INTO `sys_logininfor` VALUES (1925379854677590017, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:35:04');
INSERT INTO `sys_logininfor` VALUES (1925380330596876290, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:36:57');
INSERT INTO `sys_logininfor` VALUES (1925380334803763201, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:36:58');
INSERT INTO `sys_logininfor` VALUES (1925383348151140353, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 10:48:57');
INSERT INTO `sys_logininfor` VALUES (1925383408398123009, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 10:49:11');
INSERT INTO `sys_logininfor` VALUES (1925399989454913538, '00000', 'admin', '103.151.172.84', '中国|香港', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 11:55:04');
INSERT INTO `sys_logininfor` VALUES (1925402783473745922, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 12:06:10');
INSERT INTO `sys_logininfor` VALUES (1925402799084945410, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 12:06:14');
INSERT INTO `sys_logininfor` VALUES (1925460928313180162, '00000', 'admin', '117.152.219.211', '中国|湖北省|武汉市|移动', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 15:57:13');
INSERT INTO `sys_logininfor` VALUES (1925467127314137089, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-22 16:21:51');
INSERT INTO `sys_logininfor` VALUES (1925467156338720769, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-22 16:21:58');
INSERT INTO `sys_logininfor` VALUES (1925816583209476098, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-23 15:30:28');
INSERT INTO `sys_logininfor` VALUES (1925821612570042370, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-23 15:50:27');
INSERT INTO `sys_logininfor` VALUES (1925822996249878530, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-23 15:55:57');
INSERT INTO `sys_logininfor` VALUES (1925823001962520577, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-23 15:55:58');
INSERT INTO `sys_logininfor` VALUES (1925823009575182337, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-23 15:56:00');
INSERT INTO `sys_logininfor` VALUES (1925836298279555074, '00000', 'a1151386302@gmail.com', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '注册成功', '2025-05-23 16:48:48');
INSERT INTO `sys_logininfor` VALUES (1925836329984299009, '00000', 'a1151386302@gmail.com', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-23 16:48:56');
INSERT INTO `sys_logininfor` VALUES (1925837601634357250, '00000', 'a1151386302@gmail.com', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-23 16:53:59');
INSERT INTO `sys_logininfor` VALUES (1925843050211414018, '00000', 'a1151386302@gmail.com', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '注册成功', '2025-05-23 17:15:38');
INSERT INTO `sys_logininfor` VALUES (1925844220241874946, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-23 17:20:17');
INSERT INTO `sys_logininfor` VALUES (1926089078542012417, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-24 09:33:16');
INSERT INTO `sys_logininfor` VALUES (1926091085038325763, '00000', 'a1151386302@gmail.com', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '注册成功', '2025-05-24 09:41:14');
INSERT INTO `sys_logininfor` VALUES (1927239279138910209, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-05-27 13:43:45');
INSERT INTO `sys_logininfor` VALUES (1927242335834419202, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-05-27 13:55:54');
INSERT INTO `sys_logininfor` VALUES (1932313917820870658, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-10 13:48:33');
INSERT INTO `sys_logininfor` VALUES (1932364599479255041, '00000', 'test', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2025-06-10 17:09:57');
INSERT INTO `sys_logininfor` VALUES (1932364617988718593, '00000', 'test', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '1', '密码输入错误2次', '2025-06-10 17:10:01');
INSERT INTO `sys_logininfor` VALUES (1932364792278827009, '00000', 'test', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '1', '密码输入错误3次', '2025-06-10 17:10:43');
INSERT INTO `sys_logininfor` VALUES (1932364872306147330, '000000', 'test', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-10 17:11:02');
INSERT INTO `sys_logininfor` VALUES (1932741937677328385, '000000', 'test', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-06-11 18:09:21');
INSERT INTO `sys_logininfor` VALUES (1932741967536578561, '000000', 'test', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-11 18:09:28');
INSERT INTO `sys_logininfor` VALUES (1932742460090474497, '000000', 'test', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-11 18:11:26');
INSERT INTO `sys_logininfor` VALUES (1933072794032054273, '000000', 'test', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-12 16:04:04');
INSERT INTO `sys_logininfor` VALUES (1933077209036136449, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-06-12 16:21:36');
INSERT INTO `sys_logininfor` VALUES (1933077269035655169, '00000', 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-12 16:21:50');
INSERT INTO `sys_logininfor` VALUES (1933081672782221313, '00000', 'test', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '密码输入错误1次', '2025-06-12 16:39:20');
INSERT INTO `sys_logininfor` VALUES (1933081724493795330, '00000', 'test', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '密码输入错误2次', '2025-06-12 16:39:33');
INSERT INTO `sys_logininfor` VALUES (1933081737009598465, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-12 16:39:36');
INSERT INTO `sys_logininfor` VALUES (1933081766722048002, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-06-12 16:39:43');
INSERT INTO `sys_logininfor` VALUES (1933082000290254850, '00000', 'test', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '密码输入错误3次', '2025-06-12 16:40:38');
INSERT INTO `sys_logininfor` VALUES (1933082023434424322, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-12 16:40:44');
INSERT INTO `sys_logininfor` VALUES (1933082758150656002, '000000', 'test', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-12 16:43:39');
INSERT INTO `sys_logininfor` VALUES (1933096847933460481, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '退出成功', '2025-06-12 17:39:38');
INSERT INTO `sys_logininfor` VALUES (1933096909178687490, '00000', 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-12 17:39:53');
INSERT INTO `sys_logininfor` VALUES (1933096937494433793, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-12 17:40:00');
INSERT INTO `sys_logininfor` VALUES (1933348426490175489, '000000', 'test', '0:0:0:0:0:0:0:1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-13 10:19:19');
INSERT INTO `sys_logininfor` VALUES (1933721797828640769, '000000', 'test', '0:0:0:0:0:0:0:1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-14 11:02:58');
INSERT INTO `sys_logininfor` VALUES (1933789890151997442, '00000', 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-14 15:33:33');
INSERT INTO `sys_logininfor` VALUES (1933790049334222850, '00000', 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-14 15:34:11');
INSERT INTO `sys_logininfor` VALUES (1933790388657610754, '00000', 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-14 15:35:31');
INSERT INTO `sys_logininfor` VALUES (1933790613753323522, '00000', 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-14 15:36:25');
INSERT INTO `sys_logininfor` VALUES (1933791142982213633, '00000', 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-14 15:38:31');
INSERT INTO `sys_logininfor` VALUES (1933791287425654785, '00000', 'admin', '0:0:0:0:0:0:0:1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-06-14 15:39:06');
INSERT INTO `sys_logininfor` VALUES (1935902574595014658, '00000', 'test', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '1', '密码输入错误1次', '2025-06-20 11:28:36');
INSERT INTO `sys_logininfor` VALUES (1935902589660954626, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-20 11:28:39');
INSERT INTO `sys_logininfor` VALUES (1935945738370543618, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-20 14:20:07');
INSERT INTO `sys_logininfor` VALUES (1935945760659075074, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-20 14:20:12');
INSERT INTO `sys_logininfor` VALUES (1935946154663604225, '00000', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-20 14:21:46');
INSERT INTO `sys_logininfor` VALUES (1938070466291847169, '00000', 'admin', '127.0.0.1', '内网IP', 'MSEdge', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-26 11:03:01');
INSERT INTO `sys_logininfor` VALUES (1938532635525513217, '00000', 'admin', '127.0.0.1', '内网IP', 'Chrome', 'Windows 10 or Windows Server 2016', '0', '登录成功', '2025-06-27 17:39:31');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query_param` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '显示状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 2, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'eos-icons:system-group', 103, 1, '2023-05-14 15:19:39', 1, '2024-10-06 21:08:06', '系统管理目录');
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1775500307898949634, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'ph:user-fill', 103, 1, '2023-05-14 15:19:39', 1, '2024-10-07 21:29:29', '用户管理菜单');
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'ri:user-3-fill', 103, 1, '2023-05-14 15:19:39', 1, '2024-10-07 21:04:59', '角色管理菜单');
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'typcn:th-menu-outline', 103, 1, '2023-05-14 15:19:39', 1, '2024-10-07 21:06:06', '菜单管理菜单');
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '1', '1', 'system:dept:list', 'mdi:company', 103, 1, '2023-05-14 15:19:39', 1, '2024-10-07 21:07:38', '部门管理菜单');
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '1', '1', 'system:post:list', 'post', 103, 1, '2023-05-14 15:19:39', 1, '2024-04-04 22:36:15', '岗位管理菜单');
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'fluent-mdl2:dictionary', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:14:33', '字典管理菜单');
INSERT INTO `sys_menu` VALUES (106, '系统参数', 1, 10, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'tdesign:system-code', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:11:07', '参数设置菜单');
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 14, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'icon-park-solid:volume-notice', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:11:42', '通知公告菜单');
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'icon-park-solid:log', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:10:41', '日志管理菜单');
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 1, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'octicon:cache-24', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:09:44', '缓存监控菜单');
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'icon-park-solid:log', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:13:20', '操作日志菜单');
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'icon-park-solid:log', 103, 1, '2023-05-14 15:19:40', 1, '2024-10-07 21:13:33', '登录日志菜单');
INSERT INTO `sys_menu` VALUES (1001, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1002, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1003, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1004, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1005, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1006, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1007, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1008, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1009, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1010, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1011, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1012, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1013, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1014, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1015, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1016, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1017, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1018, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1019, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1020, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1021, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1022, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1023, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1024, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1025, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1026, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1027, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1028, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1029, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1030, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1031, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1032, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1033, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1034, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1035, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1036, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1037, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1038, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1039, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1040, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1041, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1042, '日志导出', 500, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1043, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1044, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1045, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1050, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 103, 1, '2023-05-14 15:19:40', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1775500307898949634, '运营管理', 0, 0, 'operate', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'icon-park-outline:appointment', 103, 1, '2024-04-03 20:27:15', 1, '2024-10-06 21:10:18', '');
INSERT INTO `sys_menu` VALUES (1775895273104068610, '系统模型', 1775500307898949634, 2, 'model', 'system/model/index', NULL, 1, 0, 'C', '0', '0', 'system:model:list', 'ph:list-fill', 103, 1, '2024-04-05 12:00:38', 1, '2024-10-07 21:36:00', '系统模型菜单');
INSERT INTO `sys_menu` VALUES (1775895273104068611, '系统模型查询', 1775895273104068610, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:query', '#', 103, 1, '2024-04-05 12:00:38', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1775895273104068612, '系统模型新增', 1775895273104068610, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:add', '#', 103, 1, '2024-04-05 12:00:38', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1775895273104068613, '系统模型修改', 1775895273104068610, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:edit', '#', 103, 1, '2024-04-05 12:00:38', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1775895273104068614, '系统模型删除', 1775895273104068610, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:remove', '#', 103, 1, '2024-04-05 12:00:38', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1775895273104068615, '系统模型导出', 1775895273104068610, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:model:export', '#', 103, 1, '2024-04-05 12:00:38', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780240077690507266, '聊天消息', 1775500307898949634, 5, 'chatMessage', 'system/message/index', NULL, 1, 0, 'C', '0', '0', 'system:message:list', 'bx:chat', 103, 1, '2024-04-16 22:24:48', 1, '2024-10-07 21:38:49', '聊天消息菜单');
INSERT INTO `sys_menu` VALUES (1780240077690507267, '聊天消息查询', 1780240077690507266, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:query', '#', 103, 1, '2024-04-16 22:24:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780240077690507268, '聊天消息新增', 1780240077690507266, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:add', '#', 103, 1, '2024-04-16 22:24:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780240077690507269, '聊天消息修改', 1780240077690507266, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:edit', '#', 103, 1, '2024-04-16 22:24:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780240077690507270, '聊天消息删除', 1780240077690507266, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:remove', '#', 103, 1, '2024-04-16 22:24:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780240077690507271, '聊天消息导出', 1780240077690507266, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:message:export', '#', 103, 1, '2024-04-16 22:24:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780255628576018433, '支付订单', 1775500307898949634, 6, 'order', 'system/payOrder/index', NULL, 1, 0, 'C', '0', '0', 'system:order:list', 'material-symbols:order-approve', 103, 1, '2024-04-16 23:32:48', 1, '2025-03-30 21:12:38', '支付订单菜单');
INSERT INTO `sys_menu` VALUES (1780255628576018434, '支付订单查询', 1780255628576018433, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:orders:query', '#', 103, 1, '2024-04-16 23:32:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780255628576018435, '支付订单新增', 1780255628576018433, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:orders:add', '#', 103, 1, '2024-04-16 23:32:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780255628576018436, '支付订单修改', 1780255628576018433, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:orders:edit', '#', 103, 1, '2024-04-16 23:32:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780255628576018437, '支付订单删除', 1780255628576018433, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:orders:remove', '#', 103, 1, '2024-04-16 23:32:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1780255628576018438, '支付订单导出', 1780255628576018433, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:orders:export', '#', 103, 1, '2024-04-16 23:32:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1786379590171156481, '兑换管理', 1775500307898949634, 8, 'voucher', 'system/voucher/index', NULL, 1, 0, 'C', '0', '0', 'system:voucher:list', 'mingcute:exchange-cny-fill', 103, 1, '2024-05-03 20:59:54', 1, '2025-03-30 21:18:22', '用户兑换记录菜单');
INSERT INTO `sys_menu` VALUES (1786379590171156482, '用户兑换记录查询', 1786379590171156481, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:voucher:query', '#', 103, 1, '2024-05-03 20:59:54', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1786379590171156483, '用户兑换记录新增', 1786379590171156481, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:voucher:add', '#', 103, 1, '2024-05-03 20:59:54', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1786379590171156484, '用户兑换记录修改', 1786379590171156481, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:voucher:edit', '#', 103, 1, '2024-05-03 20:59:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1786379590171156485, '用户兑换记录删除', 1786379590171156481, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:voucher:remove', '#', 103, 1, '2024-05-03 20:59:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1786379590171156486, '用户兑换记录导出', 1786379590171156481, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:voucher:export', '#', 103, 1, '2024-05-03 20:59:55', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1787078000285122561, '套餐管理', 1775500307898949634, 3, 'package', 'system/packagePlan/index', NULL, 1, 0, 'C', '0', '0', 'system:package:list', 'lets-icons:order', 103, 1, '2024-05-05 19:13:53', 1, '2025-03-30 21:04:22', '套餐管理菜单');
INSERT INTO `sys_menu` VALUES (1810594719028834305, 'GPTS管理', 1775500307898949634, 4, 'gpts', 'system/gpts/index', NULL, 1, 0, 'C', '1', '0', 'system:gpts:list', 'tdesign:app', 103, 1, '2024-07-09 16:40:18', 1, '2025-03-30 21:29:57', 'gpts管理菜单');
INSERT INTO `sys_menu` VALUES (1810594719028834306, 'gpts管理查询', 1810594719028834305, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:gpts:query', '#', 103, 1, '2024-07-09 16:40:19', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1810594719028834307, 'gpts管理新增', 1810594719028834305, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:gpts:add', '#', 103, 1, '2024-07-09 16:40:19', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1810594719028834308, 'gpts管理修改', 1810594719028834305, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:gpts:edit', '#', 103, 1, '2024-07-09 16:40:19', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1810594719028834309, 'gpts管理删除', 1810594719028834305, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:gpts:remove', '#', 103, 1, '2024-07-09 16:40:19', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1810594719028834310, 'gpts管理导出', 1810594719028834305, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:gpts:export', '#', 103, 1, '2024-07-09 16:40:19', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1843281231381852162, '文件管理', 1775500307898949634, 20, 'file', 'system/oss/index', NULL, 1, 0, 'C', '0', '0', NULL, 'material-symbols-light:folder', 103, 1, '2024-10-07 21:24:27', 1, '2024-12-27 23:03:04', '');
INSERT INTO `sys_menu` VALUES (1860690448695549953, '配置管理123', 1775500307898949634, 9, 'configurationManage', 'system/configurationManage/index', NULL, 1, 0, 'C', '1', '0', NULL, 'mdi:archive-cog-outline', 103, 1, '2024-11-24 22:22:28', 1, '2025-03-31 20:05:34', '');
INSERT INTO `sys_menu` VALUES (1898286496441393153, '知识库管理', 1775500307898949634, 10, 'knowledgeBase', 'system/knowledgeBase/index', NULL, 1, 0, 'C', '0', '0', '', 'garden:knowledge-base-26', 103, 1, '2025-03-08 16:15:44', 1, '2025-03-10 00:21:26', '');
INSERT INTO `sys_menu` VALUES (1900172314827739137, '流程编排', 1775500307898949634, 11, 'processOrchestration', 'system/processOrchestration/index', NULL, 1, 0, 'C', '1', '0', NULL, 'hugeicons:flow-square', 103, 1, '2025-03-13 21:09:18', 1, '2025-03-30 21:21:20', '');
INSERT INTO `sys_menu` VALUES (1902184523796742145, '智能体管理', 1775500307898949634, 11, 'agents', 'system/agents/index', NULL, 1, 0, 'C', '1', '0', NULL, 'icon-park-twotone:robot-two', 103, 1, '2025-03-19 10:25:06', 1, '2025-03-30 21:21:36', '');
INSERT INTO `sys_menu` VALUES (1906199640746344450, '系统工具', 0, 10, 'tool', '', NULL, 1, 0, 'M', '0', '0', NULL, 'carbon:tool-kit', 103, 1, '2025-03-30 12:19:44', 1, '2025-03-30 12:21:56', '');
INSERT INTO `sys_menu` VALUES (1906200030325882882, '代码生成', 1906199640746344450, 2, 'gen', 'tool/gen/index', NULL, 1, 0, 'C', '0', '0', 'tool:gen:list', 'tabler:code', 103, 1, '2025-03-30 12:21:17', 1, '2025-03-30 12:21:17', '');
INSERT INTO `sys_menu` VALUES (1906336170039103490, '应用管理', 1775500307898949634, 10, 'gpts', 'system/gpts/index', NULL, 1, 0, 'C', '0', '0', 'system:gpts:list', 'fe:app-menu', 103, 1, '2025-03-30 21:23:59', 1, '2025-03-30 21:30:08', '应用管理菜单');
INSERT INTO `sys_menu` VALUES (1906336170039103491, '应用管理查询', 1906336170039103490, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:gpts:query', '#', 103, 1, '2025-03-30 21:23:59', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906336170039103492, '应用管理新增', 1906336170039103490, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:gpts:add', '#', 103, 1, '2025-03-30 21:23:59', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906336170039103493, '应用管理修改', 1906336170039103490, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:gpts:edit', '#', 103, 1, '2025-03-30 21:23:59', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906336170039103494, '应用管理删除', 1906336170039103490, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:gpts:remove', '#', 103, 1, '2025-03-30 21:23:59', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906336170039103495, '应用管理导出', 1906336170039103490, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:gpts:export', '#', 103, 1, '2025-03-30 21:23:59', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906358690184294402, '插件管理', 1775500307898949634, 9, 'plugin', 'system/plugin/index', NULL, 1, 0, 'C', '0', '0', 'system:plugin:list', 'mingcute:plugin-line', 103, 1, '2025-03-30 22:53:25', 1, '2025-03-31 19:56:37', '插件管理菜单');
INSERT INTO `sys_menu` VALUES (1906358690184294403, '插件管理查询', 1906358690184294402, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:plugin:query', '#', 103, 1, '2025-03-30 22:53:25', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906358690184294404, '插件管理新增', 1906358690184294402, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:plugin:add', '#', 103, 1, '2025-03-30 22:53:25', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906358690184294405, '插件管理修改', 1906358690184294402, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:plugin:edit', '#', 103, 1, '2025-03-30 22:53:25', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906358690184294406, '插件管理删除', 1906358690184294402, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:plugin:remove', '#', 103, 1, '2025-03-30 22:53:25', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906358690184294407, '插件管理导出', 1906358690184294402, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:plugin:export', '#', 103, 1, '2025-03-30 22:53:25', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906674838461321217, '配置信息', 1775500307898949634, 13, 'configurationManage', 'system/configurationManage/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'mdi:archive-cog-outline', 103, 1, '2025-03-31 19:48:48', 1, '2025-03-31 19:59:58', '配置信息菜单');
INSERT INTO `sys_menu` VALUES (1906674838461321218, '配置信息查询', 1906674838461321217, 1, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:config:query', '#', 103, 1, '2025-03-31 19:48:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906674838461321219, '配置信息新增', 1906674838461321217, 2, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:config:add', '#', 103, 1, '2025-03-31 19:48:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906674838461321220, '配置信息修改', 1906674838461321217, 3, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:config:edit', '#', 103, 1, '2025-03-31 19:48:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906674838461321221, '配置信息删除', 1906674838461321217, 4, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:config:remove', '#', 103, 1, '2025-03-31 19:48:48', NULL, NULL, '');
INSERT INTO `sys_menu` VALUES (1906674838461321222, '配置信息导出', 1906674838461321217, 5, '#', '', NULL, 1, 0, 'F', '0', '0', 'system:config:export', '#', 103, 1, '2025-03-31 19:48:48', NULL, NULL, '');

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1789324923280932865, '000000', '公告', '1', 0x3C703E3C7374726F6E67207374796C653D22636F6C6F723A20236666393930303B223EE69CACE7BD91E7AB99E4B88EE4BBBBE4BD95E585B6E4BB96E585ACE58FB8E68896E59586E6A087E6B2A1E69C89E4BBBBE4BD95E585B3E88194E68896E59088E4BD9CE585B3E7B3BB3C2F7374726F6E673E3C2F703E0A3C703E3C7370616E207374796C653D22636F6C6F723A20236536303030303B223E4149E4B99FE4BC9AE78AAFE99499E38082E8AFB7E58BBFE5B086E585B6E794A8E4BA8EE9878DE8A681E79BAEE79A843C2F7370616E3E3C2F703E0A3C703E3C7370616E207374796C653D22636F6C6F723A20236666393930303B223EE68891E4BBACE79BAEE5898DE6ADA3E59CA8E4BFAEE5A48DE68891E4BBACE7BD91E7AB99E4B88AE79A84E99499E8AFAFE5B9B6E694B9E8BF9BE7BB86E88A82E38082E5A682E69E9CE682A8E69C89E4BBBBE4BD95E79691E997AEEFBC8CE8AFB7E9809AE8BF87E4BBA5E4B88BE696B9E5BC8FE88194E7B3BBE68891E4BBACEFBC9A61676565726C65403136332E636F6D313434343434353535353C2F7370616E3E3C2F703E0A3C703E266E6273703B3C2F703E, '0', 103, 1, '2024-05-12 00:01:20', 1, '2025-03-11 19:31:59', '');

-- ----------------------------
-- Table structure for sys_notice_state
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice_state`;
CREATE TABLE `sys_notice_state`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `notice_id` bigint NOT NULL COMMENT '公告ID',
  `read_status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '阅读状态（0未读 1已读）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户阅读状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice_state
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL COMMENT '日志主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (1906673220559609857, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '', '/system/role', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":2,\"roleName\":\"普通角色\",\"roleKey\":\"common\",\"roleSort\":2,\"dataScope\":null,\"menuCheckStrictly\":null,\"deptCheckStrictly\":null,\"status\":\"0\",\"remark\":\"普通角色\",\"menuIds\":[\"1775500307898949634\",100,\"1775895273104068610\",\"1787078000285122561\",\"1810594719028834305\",\"1780240077690507266\",\"1780255628576018433\",\"1786379590171156481\",\"1860690448695549953\",\"1906358690184294402\",\"1898286496441393153\",\"1906336170039103490\",\"1902184523796742145\",\"1900172314827739137\",\"1843281231381852162\",1001,1002,1003,1004,1005,1006,1007,\"1775895273104068611\",\"1775895273104068612\",\"1775895273104068613\",\"1775895273104068614\",\"1775895273104068615\",\"1810594719028834306\",\"1810594719028834307\",\"1810594719028834308\",\"1810594719028834309\",\"1810594719028834310\",\"1780240077690507267\",\"1780240077690507268\",\"1780240077690507269\",\"1780240077690507270\",\"1780240077690507271\",\"1780255628576018434\",\"1780255628576018435\",\"1780255628576018436\",\"1780255628576018437\",\"1780255628576018438\",\"1786379590171156482\",\"1786379590171156483\",\"1786379590171156484\",\"1786379590171156485\",\"1786379590171156486\",\"1906358690184294403\",\"1906358690184294404\",\"1906358690184294405\",\"1906358690184294406\",\"1906358690184294407\",\"1906336170039103491\",\"1906336170039103492\",\"1906336170039103493\",\"1906336170039103494\",\"1906336170039103495\",1,101,102,103,104,113,105,108,106,107,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1038,1039,500,501,1040,1041,1042,1043,1044,1045,1050,\"1906199640746344450\",\"1906200030325882882\"],\"deptIds\":null,\"superAdmin\":false}', '', 1, '非Web上下文无法获取Request', '2025-03-31 19:41:35', 43);
INSERT INTO `sys_oper_log` VALUES (1906673729755779074, '00000', '菜单管理', 3, 'org.ruoyi.system.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '', '/system/menu/1860690448695549953', '0:0:0:0:0:0:0:1', '内网IP', '{}', '{\"code\":601,\"msg\":\"菜单已分配,不允许删除\",\"data\":null}', 0, '', '2025-03-31 19:43:36', 103);
INSERT INTO `sys_oper_log` VALUES (1906673840489598977, '00000', '代码生成', 3, 'org.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '', '/tool/gen/1661288222902505474,1661288223338713089,1661288223477125122,1661288223586177025,1661288223728783361,1661288223821058050,1661288223925915650,1661288223967858689,1661288385096241154,1680196323445579778', '0:0:0:0:0:0:0:1', '内网IP', '{}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 19:44:03', 287);
INSERT INTO `sys_oper_log` VALUES (1906673868964728834, '00000', '代码生成', 3, 'org.ruoyi.generator.controller.GenController.remove()', 'DELETE', 1, 'admin', '', '/tool/gen/1680196323521077249,1680199147407806465,1680481752850145282,1740573614897897473,1775895242171076610,1785390411861803009,1785390413745045505,1785390414860730369,1786379560181882881,1789155611035381761', '0:0:0:0:0:0:0:1', '内网IP', '{}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 19:44:09', 247);
INSERT INTO `sys_oper_log` VALUES (1906673890963853313, '00000', '代码生成', 6, 'org.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '', '/tool/gen/importTable', '0:0:0:0:0:0:0:1', '内网IP', '\"chat_config\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 19:44:15', 935);
INSERT INTO `sys_oper_log` VALUES (1906674126281084929, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '', '/system/role', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1661661183933177857\",\"roleName\":\"小程序管理员5454\",\"roleKey\":\"xcxadmin\",\"roleSort\":1,\"dataScope\":null,\"menuCheckStrictly\":true,\"deptCheckStrictly\":null,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[\"1775500307898949634\",1036,1037,1038,1039,107,100,\"1775895273104068610\",\"1787078000285122561\",\"1810594719028834305\",\"1780240077690507266\",\"1780255628576018433\",\"1786379590171156481\",\"1906358690184294402\",\"1898286496441393153\",\"1906336170039103490\",\"1902184523796742145\",\"1900172314827739137\",\"1843281231381852162\",1001,1002,1003,1004,1005,1006,1007,\"1775895273104068611\",\"1775895273104068612\",\"1775895273104068613\",\"1775895273104068614\",\"1775895273104068615\",\"1810594719028834306\",\"1810594719028834307\",\"1810594719028834308\",\"1810594719028834309\",\"1810594719028834310\",\"1780240077690507267\",\"1780240077690507268\",\"1780240077690507269\",\"1780240077690507270\",\"1780240077690507271\",\"1780255628576018434\",\"1780255628576018435\",\"1780255628576018436\",\"1780255628576018437\",\"1780255628576018438\",\"1786379590171156482\",\"1786379590171156483\",\"1786379590171156484\",\"1786379590171156485\",\"1786379590171156486\",\"1906358690184294403\",\"1906358690184294404\",\"1906358690184294405\",\"1906358690184294406\",\"1906358690184294407\",\"1906336170039103491\",\"1906336170039103492\",\"1906336170039103493\",\"1906336170039103494\",\"1906336170039103495\",1,101,102,103,104,113,105,108,106,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,500,501,1040,1041,1042,1043,1044,1045,1050,\"1906199640746344450\",\"1906200030325882882\"],\"deptIds\":null,\"superAdmin\":false}', '', 1, '非Web上下文无法获取Request', '2025-03-31 19:45:11', 439);
INSERT INTO `sys_oper_log` VALUES (1906674242551386113, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '', '/system/role', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1661661183933177857\",\"roleName\":\"小程序管理员\",\"roleKey\":\"xcxadmin\",\"roleSort\":1,\"dataScope\":null,\"menuCheckStrictly\":true,\"deptCheckStrictly\":null,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[1,100,101,102,103,104,105,106,107,108,\"1775500307898949634\",\"1775895273104068610\",\"1780240077690507266\",\"1780255628576018433\",\"1786379590171156481\",\"1810594719028834305\",\"1906199640746344450\",\"1906336170039103490\",\"1906358690184294402\",500,501,113,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1038,1039,1040,1041,1042,1043,1044,1045,1050,\"1787078000285122561\",\"1898286496441393153\",\"1900172314827739137\",\"1902184523796742145\",\"1843281231381852162\",\"1775895273104068611\",\"1775895273104068612\",\"1775895273104068613\",\"1775895273104068614\",\"1775895273104068615\",\"1780240077690507267\",\"1780240077690507268\",\"1780240077690507269\",\"1780240077690507270\",\"1780240077690507271\",\"1780255628576018434\",\"1780255628576018435\",\"1780255628576018436\",\"1780255628576018437\",\"1780255628576018438\",\"1786379590171156482\",\"1786379590171156483\",\"1786379590171156484\",\"1786379590171156485\",\"1786379590171156486\",\"1810594719028834306\",\"1810594719028834307\",\"1810594719028834308\",\"1810594719028834309\",\"1810594719028834310\",\"1906200030325882882\",\"1906336170039103491\",\"1906336170039103492\",\"1906336170039103493\",\"1906336170039103494\",\"1906336170039103495\",\"1906358690184294403\",\"1906358690184294404\",\"1906358690184294405\",\"1906358690184294406\",\"1906358690184294407\"],\"deptIds\":null,\"superAdmin\":false}', '', 1, '非Web上下文无法获取Request', '2025-03-31 19:45:38', 386);
INSERT INTO `sys_oper_log` VALUES (1906674566691393538, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1860690448695549953\",\"parentId\":\"1775500307898949634\",\"menuName\":\"配置管理123\",\"orderNum\":9,\"path\":\"configurationManage\",\"component\":\"system/configurationManage/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"mdi:archive-cog-outline\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 19:46:56', 183);
INSERT INTO `sys_oper_log` VALUES (1906674839174352898, '00000', '代码生成', 8, 'org.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '', '/tool/gen/batchGenCode', '0:0:0:0:0:0:0:1', '内网IP', '{\"tableIdStr\":\"1906673887579049985\"}', '', 0, '', '2025-03-31 19:48:01', 239);
INSERT INTO `sys_oper_log` VALUES (1906675243077439490, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1906674838461321217\",\"parentId\":\"1775500307898949634\",\"menuName\":\"配置信息\",\"orderNum\":1,\"path\":\"config\",\"component\":\"system/config/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"system:config:list\",\"icon\":\"#\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 19:49:37', 161);
INSERT INTO `sys_oper_log` VALUES (1906675560401702914, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1906674838461321217\",\"parentId\":\"1775500307898949634\",\"menuName\":\"配置信息\",\"orderNum\":13,\"path\":\"configurationManage\",\"component\":\"system/configurationManage/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"system:config:list\",\"icon\":\"grommet-icons:document-config\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 19:50:53', 148);
INSERT INTO `sys_oper_log` VALUES (1906675637346209793, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1860690448695549953\",\"parentId\":\"1775500307898949634\",\"menuName\":\"配置管理123\",\"orderNum\":9,\"path\":\"configurationManage\",\"component\":\"system/configurationManage/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"0\",\"icon\":\"mdi:archive-cog-outline\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 19:51:11', 155);
INSERT INTO `sys_oper_log` VALUES (1906677004714479617, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1906358690184294402\",\"parentId\":\"1775500307898949634\",\"menuName\":\"插件管理\",\"orderNum\":9,\"path\":\"plugin\",\"component\":\"system/plugin/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"system:plugin:list\",\"icon\":\"mingcute:plugin-line\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 19:56:37', 121);
INSERT INTO `sys_oper_log` VALUES (1906677192501858305, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1860690448695549953\",\"parentId\":\"1775500307898949634\",\"menuName\":\"配置管理123\",\"orderNum\":9,\"path\":\"configurationManage\",\"component\":\"system/configurationManage/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"icon\":\"mdi:archive-cog-outline\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 19:57:22', 143);
INSERT INTO `sys_oper_log` VALUES (1906677849958977538, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1906674838461321217\",\"parentId\":\"1775500307898949634\",\"menuName\":\"配置信息\",\"orderNum\":13,\"path\":\"configurationManage\",\"component\":\"system/configurationManage/index\",\"queryParam\":\"\",\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"0\",\"status\":\"0\",\"perms\":\"system:config:list\",\"icon\":\"mdi:archive-cog-outline\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 19:59:58', 203);
INSERT INTO `sys_oper_log` VALUES (1906679257265422337, '00000', '菜单管理', 2, 'org.ruoyi.system.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '', '/system/menu', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"menuId\":\"1860690448695549953\",\"parentId\":\"1775500307898949634\",\"menuName\":\"配置管理123\",\"orderNum\":9,\"path\":\"configurationManage\",\"component\":\"system/configurationManage/index\",\"queryParam\":null,\"isFrame\":\"1\",\"isCache\":\"0\",\"menuType\":\"C\",\"visible\":\"1\",\"status\":\"0\",\"icon\":\"mdi:archive-cog-outline\",\"remark\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-03-31 20:05:34', 239);
INSERT INTO `sys_oper_log` VALUES (1925837634446397441, '00000', '用户管理', 3, 'org.ruoyi.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '', '/system/user/1925836298162114562', '127.0.0.1', '内网IP', '{}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-05-23 16:54:07', 30);
INSERT INTO `sys_oper_log` VALUES (1925843329489145857, '00000', '用户管理', 3, 'org.ruoyi.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '', '/system/user/1925843050148499458', '127.0.0.1', '内网IP', '{}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-05-23 17:16:45', 12);
INSERT INTO `sys_oper_log` VALUES (1926099797291405313, '00000', '用户管理', 3, 'org.ruoyi.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '', '/system/user/1926091085038325762', '127.0.0.1', '内网IP', '{}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-05-24 10:15:52', 13);
INSERT INTO `sys_oper_log` VALUES (1932319128312352769, '00000', '角色管理', 1, 'org.ruoyi.system.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '', '/system/role', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"roleId\":\"1932319128081666049\",\"roleName\":\"测试\",\"roleKey\":\"test\",\"roleSort\":2,\"dataScope\":null,\"menuCheckStrictly\":false,\"deptCheckStrictly\":null,\"status\":\"0\",\"remark\":\"\",\"menuIds\":[\"1775500307898949634\",100,1001,1002,1003,1004,1005,1006,1007,\"1775895273104068610\",\"1775895273104068611\",\"1775895273104068612\",\"1775895273104068613\",\"1775895273104068614\",\"1775895273104068615\",\"1787078000285122561\",\"1810594719028834305\",\"1810594719028834306\",\"1810594719028834307\",\"1810594719028834308\",\"1810594719028834309\",\"1810594719028834310\",\"1780240077690507266\",\"1780240077690507267\",\"1780240077690507268\",\"1780240077690507269\",\"1780240077690507270\",\"1780240077690507271\",\"1780255628576018433\",\"1780255628576018434\",\"1780255628576018435\",\"1780255628576018436\",\"1780255628576018437\",\"1780255628576018438\",\"1786379590171156481\",\"1786379590171156482\",\"1786379590171156483\",\"1786379590171156484\",\"1786379590171156485\",\"1786379590171156486\",\"1860690448695549953\",\"1906358690184294402\",\"1906358690184294403\",\"1906358690184294404\",\"1906358690184294405\",\"1906358690184294406\",\"1906358690184294407\",\"1898286496441393153\",\"1906336170039103490\",\"1906336170039103491\",\"1906336170039103492\",\"1906336170039103493\",\"1906336170039103494\",\"1906336170039103495\",\"1900172314827739137\",\"1902184523796742145\",\"1906674838461321217\",\"1906674838461321218\",\"1906674838461321219\",\"1906674838461321220\",\"1906674838461321221\",\"1906674838461321222\",\"1843281231381852162\",1,101,1008,1009,1010,1011,1012,102,1013,1014,1015,1016,103,1017,1018,1019,1020,104,1021,1022,1023,1024,1025,113,105,1026,1027,1028,1029,1030,108,500,1040,1041,1042,501,1043,1044,1045,1050,106,1031,1032,1033,1034,1035,107,1036,1037,1038,1039,\"1906199640746344450\",\"1906200030325882882\"],\"deptIds\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-10 14:09:16', 75);
INSERT INTO `sys_oper_log` VALUES (1932364491601756161, '00000', '用户管理', 1, 'org.ruoyi.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1932364491308154881\",\"deptId\":103,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"0\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":null,\"domainName\":null,\"roleIds\":[\"1932319128081666050\"],\"postIds\":[],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-10 17:09:31', 130);
INSERT INTO `sys_oper_log` VALUES (1932364683965120514, '00000', '用户管理', 3, 'org.ruoyi.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '', '/system/user/1932364491308154881', '127.0.0.1', '内网IP', '{}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-10 17:10:17', 13);
INSERT INTO `sys_oper_log` VALUES (1932364765355589634, '00000', '用户管理', 1, 'org.ruoyi.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1932364765288480770\",\"deptId\":103,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"0\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":null,\"domainName\":null,\"roleIds\":[\"1932319128081666050\"],\"postIds\":null,\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-10 17:10:36', 59);
INSERT INTO `sys_oper_log` VALUES (1933072715808284673, '00000', '用户管理', 1, 'org.ruoyi.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1933072715447574530\",\"deptId\":103,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"0\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"123321\",\"domainName\":null,\"roleIds\":[\"1932319128081666050\"],\"postIds\":[4],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:03:45', 155);
INSERT INTO `sys_oper_log` VALUES (1933072972298362881, '000000', '设计师注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerDesigner()', 'POST', 1, 'test', '', '/designer/user/register/designer', '127.0.0.1', '内网IP', '{\"createDept\":103,\"createBy\":\"1933072715447574530\",\"createTime\":\"2025-06-12 16:04:45\",\"updateBy\":\"1933072715447574530\",\"updateTime\":\"2025-06-12 16:04:45\",\"designerId\":\"1933072972164145153\",\"userId\":\"1933072715447574530\",\"designerName\":\"张三\",\"avatar\":null,\"gender\":null,\"birthDate\":null,\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":null,\"profession\":\"UI_DESIGNER\",\"skillTags\":null,\"workYears\":null,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":null,\"socialLinks\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:04:46', 23);
INSERT INTO `sys_oper_log` VALUES (1933073397219106817, '00000', '用户管理', 2, 'org.ruoyi.system.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1933072715447574530\",\"deptId\":null,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"1\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"123321\",\"domainName\":null,\"roleIds\":[\"1932319128081666050\"],\"postIds\":[4],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:06:27', 11);
INSERT INTO `sys_oper_log` VALUES (1933073794419695617, '00000', '用户管理', 2, 'org.ruoyi.system.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1933072715447574530\",\"deptId\":null,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"1\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"123321\",\"domainName\":null,\"roleIds\":[\"1932319128081666050\",\"1932319128081666049\"],\"postIds\":[4],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:08:02', 11);
INSERT INTO `sys_oper_log` VALUES (1933073843505635329, '00000', '用户管理', 2, 'org.ruoyi.system.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1933072715447574530\",\"deptId\":null,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"1\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"123321\",\"domainName\":null,\"roleIds\":[\"1932319128081666049\"],\"postIds\":[4],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:08:14', 11);
INSERT INTO `sys_oper_log` VALUES (1933073910971015170, '00000', '用户管理', 2, 'org.ruoyi.system.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1933072715447574530\",\"deptId\":null,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"1\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"123321\",\"domainName\":null,\"roleIds\":[\"1729685491108446210\"],\"postIds\":[4],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:08:30', 119);
INSERT INTO `sys_oper_log` VALUES (1933075559173103617, '000000', '设计师注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerDesigner()', 'POST', 1, 'test', '', '/designer/user/register/designer', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"designerId\":null,\"userId\":null,\"designerName\":\"张三\",\"avatar\":null,\"gender\":null,\"birthDate\":null,\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":null,\"profession\":\"UI_DESIGNER\",\"skillTags\":null,\"workYears\":null,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":null,\"socialLinks\":null,\"status\":null}', '{\"code\":500,\"msg\":\"用户已绑定设计师身份\",\"data\":null}', 0, '', '2025-06-12 16:15:03', 3);
INSERT INTO `sys_oper_log` VALUES (1933075789092265986, '000000', '企业注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerEnterprise()', 'POST', 1, 'test', '', '/designer/user/register/enterprise', '127.0.0.1', '内网IP', '{\"createDept\":103,\"createBy\":\"1933072715447574530\",\"createTime\":\"2025-06-12 16:15:57\",\"updateBy\":\"1933072715447574530\",\"updateTime\":\"2025-06-12 16:15:57\",\"enterpriseId\":\"1933075788966436865\",\"userId\":\"1933072715447574530\",\"enterpriseName\":\"创新科技有限公司\",\"description\":\"专注于互联网产品设计与开发\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"hr@innovation.com\",\"website\":\"https://www.innovation.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:15:58', 20);
INSERT INTO `sys_oper_log` VALUES (1933075905337401346, '000000', '院校注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerSchool()', 'POST', 1, 'test', '', '/designer/user/register/school', '127.0.0.1', '内网IP', '{\"createDept\":103,\"createBy\":\"1933072715447574530\",\"createTime\":\"2025-06-12 16:16:25\",\"updateBy\":\"1933072715447574530\",\"updateTime\":\"2025-06-12 16:16:25\",\"schoolId\":\"1933075905270292482\",\"userId\":\"1933072715447574530\",\"schoolName\":\"北京设计学院\",\"description\":\"专业的设计教育机构\",\"address\":\"北京市海淀区\",\"phone\":null,\"email\":null,\"website\":null,\"schoolType\":\"UNIVERSITY\",\"level\":\"本科\",\"logo\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:16:25', 20);
INSERT INTO `sys_oper_log` VALUES (1933082202669617153, '00000', '用户管理', 3, 'org.ruoyi.system.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', '', '/system/user/1933072715447574530', '127.0.0.1', '内网IP', '{}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:41:27', 22);
INSERT INTO `sys_oper_log` VALUES (1933082743588032513, '00000', '用户管理', 1, 'org.ruoyi.system.controller.system.SysUserController.add()', 'POST', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"userId\":\"1933082743395094530\",\"deptId\":103,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"1\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"33322\",\"domainName\":null,\"roleIds\":[\"1932319128081666050\"],\"postIds\":[3],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:43:36', 89);
INSERT INTO `sys_oper_log` VALUES (1933082896713682947, '000000', '设计师注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerDesigner()', 'POST', 1, 'test', '', '/designer/user/register/designer', '127.0.0.1', '内网IP', '{\"createDept\":103,\"createBy\":\"1933082743395094530\",\"createTime\":\"2025-06-12 16:44:12\",\"updateBy\":\"1933082743395094530\",\"updateTime\":\"2025-06-12 16:44:12\",\"designerId\":\"1933082896646574081\",\"userId\":\"1933082743395094530\",\"designerName\":\"张三\",\"avatar\":null,\"gender\":null,\"birthDate\":null,\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":null,\"profession\":\"UI_DESIGNER\",\"skillTags\":null,\"workYears\":null,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":null,\"socialLinks\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 16:44:12', 19);
INSERT INTO `sys_oper_log` VALUES (1933087103621607426, '000000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'test', '', '/designer/user/unbind/designer', '127.0.0.1', '内网IP', '\"designer\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 17:00:55', 203);
INSERT INTO `sys_oper_log` VALUES (1933088762418507778, '000000', '设计师注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerDesigner()', 'POST', 1, 'test', '', '/designer/user/register/designer', '127.0.0.1', '内网IP', '{\"createDept\":103,\"createBy\":\"1933082743395094530\",\"createTime\":\"2025-06-12 17:07:30\",\"updateBy\":\"1933082743395094530\",\"updateTime\":\"2025-06-12 17:07:30\",\"designerId\":\"1933088761890025474\",\"userId\":\"1933082743395094530\",\"designerName\":\"张三\",\"avatar\":null,\"gender\":null,\"birthDate\":null,\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\", \\\"VISUAL_DESIGN\\\"]\",\"workYears\":null,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":null,\"socialLinks\":null,\"status\":null}', '', 1, '\r\n### Error updating database.  Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1933082743395094530-designer\' for key \'des_user_binding.uk_user_entity\'\r\n### The error may exist in org/ruoyi/designer/mapper/UserBindingMapper.java (best guess)\r\n### The error may involve org.ruoyi.designer.mapper.UserBindingMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO des_user_binding  ( binding_id, user_id, entity_type, entity_id, binding_status, create_dept, create_by, create_time, update_by, update_time )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?  )\r\n### Cause: java.sql.SQLIntegrityConstraintViolationException: Duplicate entry \'1933082743395094530-designer\' for key \'des_user_binding.uk_user_entity\'\n; Duplicate entry \'1933082743395094530-designer\' for key \'des_user_binding.uk_user_entity\'', '2025-06-12 17:07:31', 127);
INSERT INTO `sys_oper_log` VALUES (1933092004590276609, '000000', '设计师注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerDesigner()', 'POST', 1, 'test', '', '/designer/user/register/designer', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":\"1933082743395094530\",\"updateTime\":\"2025-06-12 17:20:23\",\"designerId\":\"1933082896646574081\",\"userId\":\"1933082743395094530\",\"designerName\":\"张三\",\"avatar\":null,\"gender\":null,\"birthDate\":null,\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\", \\\"VISUAL_DESIGN\\\"]\",\"workYears\":null,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":null,\"socialLinks\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 17:20:24', 47);
INSERT INTO `sys_oper_log` VALUES (1933092742750031874, '000000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'test', '', '/designer/user/unbind/designer', '127.0.0.1', '内网IP', '\"designer\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 17:23:20', 13);
INSERT INTO `sys_oper_log` VALUES (1933092780901421058, '000000', '设计师注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerDesigner()', 'POST', 1, 'test', '', '/designer/user/register/designer', '127.0.0.1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":\"1933082743395094530\",\"updateTime\":\"2025-06-12 17:23:28\",\"designerId\":\"1933082896646574081\",\"userId\":\"1933082743395094530\",\"designerName\":\"张三\",\"avatar\":null,\"gender\":null,\"birthDate\":null,\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\", \\\"VISUAL_DESIGN\\\"]\",\"workYears\":null,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":null,\"socialLinks\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 17:23:29', 23);
INSERT INTO `sys_oper_log` VALUES (1933092972346232833, '000000', '企业注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerEnterprise()', 'POST', 1, 'test', '', '/designer/user/register/enterprise', '127.0.0.1', '内网IP', '{\"createDept\":103,\"createBy\":\"1933082743395094530\",\"createTime\":\"2025-06-12 17:24:14\",\"updateBy\":\"1933082743395094530\",\"updateTime\":\"2025-06-12 17:24:14\",\"enterpriseId\":\"1933092972216209410\",\"userId\":\"1933082743395094530\",\"enterpriseName\":\"创新科技有限公司\",\"description\":\"专注于互联网产品设计与开发\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"hr@innovation.com\",\"website\":\"https://www.innovation.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 17:24:14', 23);
INSERT INTO `sys_oper_log` VALUES (1933093400718888961, '000000', '院校注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerSchool()', 'POST', 1, 'test', '', '/designer/user/register/school', '127.0.0.1', '内网IP', '{\"createDept\":103,\"createBy\":\"1933082743395094530\",\"createTime\":\"2025-06-12 17:25:56\",\"updateBy\":\"1933082743395094530\",\"updateTime\":\"2025-06-12 17:25:56\",\"schoolId\":\"1933093400651780098\",\"userId\":\"1933082743395094530\",\"schoolName\":\"北京设计学院\",\"description\":\"专业的设计教育机构\",\"address\":\"北京市海淀区\",\"phone\":null,\"email\":null,\"website\":null,\"schoolType\":\"UNIVERSITY\",\"level\":\"本科\",\"logo\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 17:25:57', 21);
INSERT INTO `sys_oper_log` VALUES (1933097487254441985, '00000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'admin', '', '/designer/user/unbind/designer', '127.0.0.1', '内网IP', '\"designer\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 17:42:11', 3);
INSERT INTO `sys_oper_log` VALUES (1933097601008160770, '00000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'admin', '', '/designer/user/unbind/designer', '127.0.0.1', '内网IP', '\"designer\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 17:42:38', 3);
INSERT INTO `sys_oper_log` VALUES (1933098076344438786, '00000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'admin', '', '/designer/user/unbind/designer', '127.0.0.1', '内网IP', '\"designer\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 17:44:31', 3);
INSERT INTO `sys_oper_log` VALUES (1933098295823978498, '00000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'admin', '', '/designer/user/unbind/designer', '127.0.0.1', '内网IP', '\"designer\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-12 17:45:24', 3);
INSERT INTO `sys_oper_log` VALUES (1933100314420887553, '00000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'admin', '', '/designer/user/unbind/designer', '127.0.0.1', '内网IP', '\"designer\"', '{\"code\":500,\"msg\":\"用户未绑定该身份，无需解绑\",\"data\":null}', 0, '', '2025-06-12 17:53:25', 222);
INSERT INTO `sys_oper_log` VALUES (1933344649037078530, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":1,\"updateTime\":\"2025-06-13 10:04:18\",\"designerId\":\"1933088761890025474\",\"userId\":null,\"designerName\":\"张三-更新\",\"avatar\":null,\"gender\":null,\"birthDate\":null,\"phone\":\"13800138001\",\"email\":\"zhangsan_new@example.com\",\"description\":null,\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\", \\\"VISUAL_DESIGN\\\", \\\"ANIMATION_DESIGN\\\"]\",\"workYears\":null,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":null,\"socialLinks\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 10:04:19', 20);
INSERT INTO `sys_oper_log` VALUES (1933345217558208514, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":1,\"updateTime\":\"2025-06-13 10:06:34\",\"designerId\":\"1933088761890025474\",\"userId\":null,\"designerName\":\"张三-更新\",\"avatar\":null,\"gender\":null,\"birthDate\":null,\"phone\":\"13800138001\",\"email\":\"zhangsan_new@example.com\",\"description\":\"资深UI设计师，新增动效设计技能\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\", \\\"VISUAL_DESIGN\\\", \\\"ANIMATION_DESIGN\\\"]\",\"workYears\":null,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":null,\"socialLinks\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 10:06:34', 8);
INSERT INTO `sys_oper_log` VALUES (1933345271316602881, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":1,\"updateTime\":\"2025-06-13 10:06:47\",\"designerId\":\"1933088761890025474\",\"userId\":null,\"designerName\":\"张三-更新\",\"avatar\":null,\"gender\":null,\"birthDate\":null,\"phone\":\"13800138001\",\"email\":\"zhangsan_new@example.com\",\"description\":\"资深UI设计师，新增动效设计技能\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\", \\\"VISUAL_DESIGN\\\", \\\"ANIMATION_DESIGN\\\"]\",\"workYears\":null,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":null,\"socialLinks\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 10:06:47', 7);
INSERT INTO `sys_oper_log` VALUES (1933345377004675074, '00000', '院校注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerSchool()', 'POST', 1, 'admin', '', '/designer/user/register/school', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-06-13 10:07:12\",\"updateBy\":1,\"updateTime\":\"2025-06-13 10:07:12\",\"schoolId\":\"1933345376878845953\",\"userId\":1,\"schoolName\":\"北京设计学院\",\"description\":\"专业的设计教育机构\",\"address\":\"北京市海淀区\",\"phone\":null,\"email\":null,\"website\":null,\"schoolType\":\"UNIVERSITY\",\"level\":\"本科\",\"logo\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 10:07:12', 22);
INSERT INTO `sys_oper_log` VALUES (1933345394130018306, '00000', '企业注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerEnterprise()', 'POST', 1, 'admin', '', '/designer/user/register/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-06-13 10:07:16\",\"updateBy\":1,\"updateTime\":\"2025-06-13 10:07:16\",\"enterpriseId\":\"1933345394062909442\",\"userId\":1,\"enterpriseName\":\"创新科技有限公司\",\"description\":\"专注于互联网产品设计与开发\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"hr@innovation.com\",\"website\":\"https://www.innovation.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":null,\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 10:07:16', 18);
INSERT INTO `sys_oper_log` VALUES (1933345645297524737, '00000', '企业注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerEnterprise()', 'POST', 1, 'admin', '', '/designer/user/register/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"enterpriseId\":null,\"userId\":null,\"enterpriseName\":\"创新科技有限公司\",\"description\":\"专注于互联网产品设计与开发\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"hr@innovation.com\",\"website\":\"https://www.innovation.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":null,\"status\":null}', '{\"code\":500,\"msg\":\"用户已绑定企业身份\",\"data\":null}', 0, '', '2025-06-13 10:08:16', 3);
INSERT INTO `sys_oper_log` VALUES (1933346188531195905, '00000', '企业管理', 2, 'org.ruoyi.designer.controller.EnterpriseController.edit()', 'PUT', 1, 'admin', '', '/designer/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":1,\"updateTime\":\"2025-06-13 10:10:25\",\"enterpriseId\":null,\"userId\":null,\"enterpriseName\":\"创22有限公司\",\"description\":\"专注于互联网产品设计与开发\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"hr@innovation.com\",\"website\":\"https://www.innovation.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":null,\"status\":null}', '{\"code\":500,\"msg\":\"操作失败\",\"data\":null}', 0, '', '2025-06-13 10:10:26', 5);
INSERT INTO `sys_oper_log` VALUES (1933350394172399617, '00000', '设计师注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerDesigner()', 'POST', 1, 'admin', '', '/designer/user/register/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":103,\"createBy\":1,\"createTime\":\"2025-06-13 10:27:08\",\"updateBy\":1,\"updateTime\":\"2025-06-13 10:27:08\",\"designerId\":\"1933350394109485057\",\"userId\":1,\"designerName\":\"李四\",\"avatar\":\"https://avatars.githubusercontent.com/u/12345678\",\"gender\":\"女\",\"birthDate\":\"1995-06-15\",\"phone\":\"13900139000\",\"email\":\"lisi@example.com\",\"description\":\"资深交互设计师，专注用户体验设计\",\"profession\":\"INTERACTION_DESIGNER\",\"skillTags\":\"[\\\"USER_RESEARCH\\\", \\\"PROTOTYPE_DESIGN\\\", \\\"INTERACTION_DESIGN\\\"]\",\"workYears\":5,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":\"2018-07-01\",\"joinDate\":null,\"portfolioUrl\":\"https://lisi-portfolio.com\",\"socialLinks\":\"{\\\"dribbble\\\":\\\"https://dribbble.com/lisi\\\",\\\"linkedin\\\":\\\"https://linkedin.com/in/lisi\\\"}\",\"status\":null}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 10:27:09', 22);
INSERT INTO `sys_oper_log` VALUES (1933353454315626498, '00000', '设计师注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerDesigner()', 'POST', 1, 'admin', '', '/designer/user/register/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"createDept\":null,\"createBy\":null,\"createTime\":null,\"updateBy\":null,\"updateTime\":null,\"designerId\":null,\"userId\":null,\"designerName\":\"李四\",\"avatar\":\"https://avatars.githubusercontent.com/u/12345678\",\"gender\":\"女\",\"birthDate\":\"1995-06-15\",\"phone\":\"13900139000\",\"email\":\"lisi@example.com\",\"description\":\"资深交互设计师，专注用户体验设计\",\"profession\":\"INTERACTION_DESIGNER\",\"skillTags\":\"[\\\"USER_RESEARCH\\\", \\\"PROTOTYPE_DESIGN\\\", \\\"INTERACTION_DESIGN\\\"]\",\"workYears\":5,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":\"2018-07-01\",\"joinDate\":null,\"portfolioUrl\":\"https://lisi-portfolio.com\",\"socialLinks\":\"{\\\"dribbble\\\":\\\"https://dribbble.com/lisi\\\",\\\"linkedin\\\":\\\"https://linkedin.com/in/lisi\\\"}\",\"status\":null}', '{\"code\":500,\"msg\":\"用户已绑定设计师身份\",\"data\":null}', 0, '', '2025-06-13 10:39:18', 3);
INSERT INTO `sys_oper_log` VALUES (1933365586599985154, '00000', '企业管理', 2, 'org.ruoyi.designer.controller.EnterpriseController.edit()', 'PUT', 1, 'admin', '', '/designer/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseName\":\"创新科技有限公司\",\"description\":\"专注于互联网产品设计与开发的创新型企业\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"contact@company.com\",\"website\":\"https://www.company.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":\"https://www.company.com/logo.png\",\"status\":\"0\"}', '{\"code\":500,\"msg\":\"操作失败\",\"data\":null}', 0, '', '2025-06-13 11:27:31', 169);
INSERT INTO `sys_oper_log` VALUES (1933365627859353602, '00000', '企业管理', 2, 'org.ruoyi.designer.controller.EnterpriseController.edit()', 'PUT', 1, 'admin', '', '/designer/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseName\":\"创新科技\",\"description\":\"专注于互联网产品设计与开发的创新型企业\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"contact@company.com\",\"website\":\"https://www.company.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":\"https://www.company.com/logo.png\",\"status\":\"0\"}', '{\"code\":500,\"msg\":\"操作失败\",\"data\":null}', 0, '', '2025-06-13 11:27:41', 2);
INSERT INTO `sys_oper_log` VALUES (1933366837970513921, '00000', '企业管理', 2, 'org.ruoyi.designer.controller.EnterpriseController.edit()', 'PUT', 1, 'admin', '', '/designer/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseName\":\"创新科技\",\"description\":\"专注于互联网产品设计与开发的创新型企业\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"contact@company.com\",\"website\":\"https://www.company.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":\"https://www.company.com/logo.png\",\"status\":\"0\"}', '{\"code\":500,\"msg\":\"操作失败\",\"data\":null}', 0, '', '2025-06-13 11:32:29', 161);
INSERT INTO `sys_oper_log` VALUES (1933367201440509953, '00000', '企业管理', 2, 'org.ruoyi.designer.controller.EnterpriseController.edit()', 'PUT', 1, 'admin', '', '/designer/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseName\":\"创新科技\",\"description\":\"专注于互联网产品设计与开发的创新型企业\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"contact@company.com\",\"website\":\"https://www.company.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":\"https://www.company.com/logo.png\",\"status\":\"0\"}', '{\"code\":500,\"msg\":\"操作失败\",\"data\":null}', 0, '', '2025-06-13 11:33:56', 3);
INSERT INTO `sys_oper_log` VALUES (1933369823245393922, '00000', '企业管理', 2, 'org.ruoyi.designer.controller.EnterpriseController.edit()', 'PUT', 1, 'admin', '', '/designer/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseName\":\"创新科技有限公司\",\"description\":\"专注于互联网产品设计与开发的创新型企业\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"contact@company.com\",\"website\":\"https://www.company.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":\"https://www.company.com/logo.png\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 11:44:21', 141);
INSERT INTO `sys_oper_log` VALUES (1933369901913759746, '00000', '企业管理', 2, 'org.ruoyi.designer.controller.EnterpriseController.edit()', 'PUT', 1, 'admin', '', '/designer/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseName\":\"创新\",\"description\":\"专注于互联网产品设计与开发的创新型企业\",\"address\":\"北京市朝阳区\",\"phone\":\"010-12345678\",\"email\":\"contact@company.com\",\"website\":\"https://www.company.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":\"https://www.company.com/logo.png\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 11:44:40', 12);
INSERT INTO `sys_oper_log` VALUES (1933370741626003458, '00000', '岗位招聘', 1, 'org.ruoyi.designer.controller.JobPostingController.add()', 'POST', 1, 'admin', '', '/designer/job', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseId\":1,\"jobTitle\":\"高级UI设计师\",\"description\":\"负责移动端产品UI设计，与产品经理和开发团队紧密合作\",\"requiredProfession\":\"UI_DESIGNER\",\"requiredSkills\":\"PROTOTYPE_DESIGN,VISUAL_DESIGN,USER_INTERFACE_DESIGN\",\"workYearsRequired\":\"3-5年\",\"salaryMin\":\"15000\",\"salaryMax\":\"25000\",\"location\":\"北京市朝阳区\",\"jobType\":\"全职\",\"educationRequired\":\"本科及以上\",\"recruitmentCount\":2,\"deadline\":\"2024-12-31\",\"contactPerson\":\"王经理\",\"contactPhone\":\"010-12345678\",\"contactEmail\":\"hr@company.com\",\"status\":\"0\"}', '', 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_job_posting.required_skills\'.\r\n### The error may exist in org/ruoyi/designer/mapper/JobPostingMapper.java (best guess)\r\n### The error may involve org.ruoyi.designer.mapper.JobPostingMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO des_job_posting  ( job_id, enterprise_id, job_title, description, required_profession, required_skills, work_years_required, salary_min, salary_max, location, job_type, education_required, recruitment_count, deadline, contact_person, contact_phone, contact_email, status, create_dept, create_by, create_time, update_by, update_time )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_job_posting.required_skills\'.\n; Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_job_posting.required_skills\'.', '2025-06-13 11:48:00', 119);
INSERT INTO `sys_oper_log` VALUES (1933371098003431426, '00000', '设计师注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerDesigner()', 'POST', 1, 'admin', '', '/designer/user/register/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"男\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"PROTOTYPE_DESIGN,VISUAL_DESIGN\",\"workYears\":3,\"schoolId\":1,\"enterpriseId\":1,\"graduationDate\":\"2022-06-30\",\"joinDate\":\"2022-07-15\",\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"[object Object]\",\"status\":\"0\"}', '{\"code\":500,\"msg\":\"用户已绑定设计师身份\",\"data\":null}', 0, '', '2025-06-13 11:49:25', 5);
INSERT INTO `sys_oper_log` VALUES (1933403866318004225, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"男\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"PROTOTYPE_DESIGN,VISUAL_DESIGN\",\"workYears\":3,\"schoolId\":1,\"enterpriseId\":1,\"graduationDate\":\"2022-06-30\",\"joinDate\":\"2022-07-15\",\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"[object Object]\",\"status\":\"0\"}', '{\"code\":500,\"msg\":\"操作失败\",\"data\":null}', 0, '', '2025-06-13 13:59:37', 4);
INSERT INTO `sys_oper_log` VALUES (1933407255374405633, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"0\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"PROTOTYPE_DESIGN,VISUAL_DESIGN\",\"workYears\":3,\"schoolId\":1,\"enterpriseId\":1,\"graduationDate\":\"2022-06-30\",\"joinDate\":\"2022-07-15\",\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"{\\\"github\\\":\\\"https://github.com/zhangsan\\\",\\\"behance\\\":\\\"https://behance.net/zhangsan\\\"}\",\"status\":\"0\"}', '', 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_designer.skill_tags\'.\r\n### The error may exist in org/ruoyi/designer/mapper/DesignerMapper.java (best guess)\r\n### The error may involve org.ruoyi.designer.mapper.DesignerMapper.updateById-Inline\r\n### The error occurred while setting parameters\r\n### SQL: UPDATE des_designer  SET user_id=?, designer_name=?, avatar=?, gender=?, birth_date=?, phone=?, email=?, description=?, profession=?, skill_tags=?, work_years=?, school_id=?, enterprise_id=?, graduation_date=?, join_date=?, portfolio_url=?, social_links=?, status=?,    update_by=?, update_time=?  WHERE designer_id=?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_designer.skill_tags\'.\n; Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_designer.skill_tags\'.', '2025-06-13 14:13:05', 395);
INSERT INTO `sys_oper_log` VALUES (1933410048688648193, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"0\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"PROTOTYPE_DESIGN,VISUAL_DESIGN\",\"workYears\":3,\"schoolId\":1,\"enterpriseId\":1,\"graduationDate\":\"2022-06-30\",\"joinDate\":\"2022-07-15\",\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"{\\\"github\\\":\\\"https://github.com/zhangsan\\\",\\\"behance\\\":\\\"https://behance.net/zhangsan\\\"}\",\"status\":\"0\"}', '', 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_designer.skill_tags\'.\r\n### The error may exist in org/ruoyi/designer/mapper/DesignerMapper.java (best guess)\r\n### The error may involve org.ruoyi.designer.mapper.DesignerMapper.updateById-Inline\r\n### The error occurred while setting parameters\r\n### SQL: UPDATE des_designer  SET user_id=?, designer_name=?, avatar=?, gender=?, birth_date=?, phone=?, email=?, description=?, profession=?, skill_tags=?, work_years=?, school_id=?, enterprise_id=?, graduation_date=?, join_date=?, portfolio_url=?, social_links=?, status=?,    update_by=?, update_time=?  WHERE designer_id=?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_designer.skill_tags\'.\n; Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_designer.skill_tags\'.', '2025-06-13 14:24:11', 231);
INSERT INTO `sys_oper_log` VALUES (1933412970092597250, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"0\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\",\\\"VISUAL_DESIGN\\\"]\",\"workYears\":3,\"schoolId\":1,\"enterpriseId\":1,\"graduationDate\":\"2022-06-30\",\"joinDate\":\"2022-07-15\",\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"{\\\"github\\\":\\\"https://github.com/testuser\\\",\\\"behance\\\":\\\"https://behance.net/testuser\\\"}\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 14:35:48', 154);
INSERT INTO `sys_oper_log` VALUES (1933415644112359425, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"0\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\", \\\"VISUAL_DESIGN\\\"]\",\"workYears\":3,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"{\\\"github\\\":\\\"https://github.com/testuser\\\",\\\"behance\\\":\\\"https://behance.net/testuser\\\"}\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 14:46:25', 147);
INSERT INTO `sys_oper_log` VALUES (1933415765264830466, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"0\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"VISUAL_DESIGN\\\"]\",\"workYears\":3,\"schoolId\":null,\"enterpriseId\":null,\"graduationDate\":null,\"joinDate\":null,\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"{\\\"behance\\\":\\\"https://behance.net/testuser\\\"}\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 14:46:54', 12);
INSERT INTO `sys_oper_log` VALUES (1933417762936369153, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"0\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\",\\\"VISUAL_DESIGN\\\"]\",\"workYears\":3,\"schoolId\":1,\"enterpriseId\":1,\"graduationDate\":\"2022-06-30\",\"joinDate\":\"2022-07-15\",\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"{}\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 14:54:51', 151);
INSERT INTO `sys_oper_log` VALUES (1933420385227845634, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"0\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\",\\\"VISUAL_DESIGN\\\"]\",\"workYears\":3,\"schoolId\":1,\"enterpriseId\":1,\"graduationDate\":\"2022-06-30\",\"joinDate\":\"2022-07-15\",\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"{\\\"github\\\":\\\"https://github.com/testuser\\\",\\\"behance\\\":\\\"https://behance.net/testuser\\\"}\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 15:05:16', 142);
INSERT INTO `sys_oper_log` VALUES (1933420562940506114, '00000', '设计师管理', 2, 'org.ruoyi.designer.controller.DesignerController.edit()', 'PUT', 1, 'admin', '', '/designer/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"0\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"[\\\"PROTOTYPE_DESIGN\\\"]\",\"workYears\":3,\"schoolId\":1,\"enterpriseId\":1,\"graduationDate\":\"2022-06-30\",\"joinDate\":\"2022-07-15\",\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"{\\\"github\\\":\\\"https://github.com/testuser\\\",\\\"behance\\\":\\\"https://behance.net/testuser\\\"}\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 15:05:58', 11);
INSERT INTO `sys_oper_log` VALUES (1933421521896812546, '00000', '企业管理', 2, 'org.ruoyi.designer.controller.EnterpriseController.edit()', 'PUT', 1, 'admin', '', '/designer/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseName\":\"创新限公司\",\"description\":\"专注于互联开发的创新型企业\",\"address\":\"北京市区\",\"phone\":\"010\",\"email\":\"t@company.com\",\"website\":\"https://www.pany.com\",\"scale\":\"100-500人\",\"industry\":\"互联网\",\"logo\":\"https://www.company.com/logo.png\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 15:09:47', 11);
INSERT INTO `sys_oper_log` VALUES (1933421769570463745, '00000', '岗位招聘', 1, 'org.ruoyi.designer.controller.JobPostingController.add()', 'POST', 1, 'admin', '', '/designer/job', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseId\":1,\"jobTitle\":\"高级UI设计师\",\"description\":\"负责移动端产品UI设计，与产品经理和开发团队紧密合作\",\"requiredProfession\":\"UI_DESIGNER\",\"requiredSkills\":\"PROTOTYPE_DESIGN,VISUAL_DESIGN,USER_INTERFACE_DESIGN\",\"workYearsRequired\":\"3-5年\",\"salaryMin\":\"15000\",\"salaryMax\":\"25000\",\"location\":\"北京市朝阳区\",\"jobType\":\"全职\",\"educationRequired\":\"本科及以上\",\"recruitmentCount\":2,\"deadline\":\"2024-12-31\",\"contactPerson\":\"王经理\",\"contactPhone\":\"010-12345678\",\"contactEmail\":\"hr@company.com\",\"status\":\"0\"}', '', 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_job_posting.required_skills\'.\r\n### The error may exist in org/ruoyi/designer/mapper/JobPostingMapper.java (best guess)\r\n### The error may involve org.ruoyi.designer.mapper.JobPostingMapper.insert-Inline\r\n### The error occurred while setting parameters\r\n### SQL: INSERT INTO des_job_posting  ( job_id, enterprise_id, job_title, description, required_profession, required_skills, work_years_required, salary_min, salary_max, location, job_type, education_required, recruitment_count, deadline, contact_person, contact_phone, contact_email, status, create_dept, create_by, create_time, update_by, update_time )  VALUES (  ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?  )\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_job_posting.required_skills\'.\n; Data truncation: Invalid JSON text: \"Invalid value.\" at position 0 in value for column \'des_job_posting.required_skills\'.', '2025-06-13 15:10:46', 110);
INSERT INTO `sys_oper_log` VALUES (1933423071146848258, '00000', '岗位招聘', 1, 'org.ruoyi.designer.controller.JobPostingController.add()', 'POST', 1, 'admin', '', '/designer/job', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseId\":1,\"jobTitle\":\"高级UI设计师\",\"description\":\"负责移动端产品UI设计，与产品经理和开发团队紧密合作\",\"requiredProfession\":\"UI_DESIGNER\",\"requiredSkills\":\"[\\\"PROTOTYPE_DESIGN\\\",\\\"VISUAL_DESIGN\\\",\\\"USER_INTERFACE_DESIGN\\\"]\",\"workYearsRequired\":\"3-5年\",\"salaryMin\":\"15000\",\"salaryMax\":\"25000\",\"location\":\"北京市朝阳区\",\"jobType\":\"全职\",\"educationRequired\":\"本科及以上\",\"recruitmentCount\":2,\"deadline\":\"2024-12-31\",\"contactPerson\":\"王经理\",\"contactPhone\":\"010-12345678\",\"contactEmail\":\"hr@company.com\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 15:15:56', 221);
INSERT INTO `sys_oper_log` VALUES (1933424200706469890, '00000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'admin', '', '/designer/user/unbind/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '\"enterprise\"', '{\"code\":200,\"msg\":\"解绑成功\",\"data\":null}', 0, '', '2025-06-13 15:20:25', 16);
INSERT INTO `sys_oper_log` VALUES (1933424210365952001, '00000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'admin', '', '/designer/user/unbind/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '\"enterprise\"', '{\"code\":500,\"msg\":\"用户已经处于解绑状态\",\"data\":null}', 0, '', '2025-06-13 15:20:28', 4);
INSERT INTO `sys_oper_log` VALUES (1933424241185697795, '00000', '岗位招聘', 1, 'org.ruoyi.designer.controller.JobPostingController.add()', 'POST', 1, 'admin', '', '/designer/job', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseId\":1,\"jobTitle\":\"高级UI设计师\",\"description\":\"负责移动端产品UI设计，与产品经理和开发团队紧密合作\",\"requiredProfession\":\"UI_DESIGNER\",\"requiredSkills\":\"[\\\"PROTOTYPE_DESIGN\\\",\\\"VISUAL_DESIGN\\\",\\\"USER_INTERFACE_DESIGN\\\"]\",\"workYearsRequired\":\"3-5年\",\"salaryMin\":\"15000\",\"salaryMax\":\"25000\",\"location\":\"北京市朝阳区\",\"jobType\":\"全职\",\"educationRequired\":\"本科及以上\",\"recruitmentCount\":2,\"deadline\":\"2024-12-31\",\"contactPerson\":\"王经理\",\"contactPhone\":\"010-12345678\",\"contactEmail\":\"hr@company.com\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-13 15:20:35', 7);
INSERT INTO `sys_oper_log` VALUES (1933424344130695169, '00000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'admin', '', '/designer/user/unbind/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '\"enterprise\"', '{\"code\":500,\"msg\":\"用户已经处于解绑状态\",\"data\":null}', 0, '', '2025-06-13 15:21:00', 3);
INSERT INTO `sys_oper_log` VALUES (1933426287842537473, '00000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'admin', '', '/designer/user/unbind/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '\"enterprise\"', '{\"code\":500,\"msg\":\"用户已经处于解绑状态\",\"data\":null}', 0, '', '2025-06-13 15:28:43', 130);
INSERT INTO `sys_oper_log` VALUES (1933426305194373121, '00000', '岗位招聘', 1, 'org.ruoyi.designer.controller.JobPostingController.add()', 'POST', 1, 'admin', '', '/designer/job', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseId\":1,\"jobTitle\":\"高级UI\",\"description\":\"负责移动端产品UI设计，与产品经理和开发团队紧密合作\",\"requiredProfession\":\"UI_DESIGNER\",\"requiredSkills\":\"[\\\"PROTOTYPE_DESIGN\\\",\\\"VISUAL_DESIGN\\\",\\\"USER_INTERFACE_DESIGN\\\"]\",\"workYearsRequired\":\"3-5年\",\"salaryMin\":\"15000\",\"salaryMax\":\"25000\",\"location\":\"北京市朝阳区\",\"jobType\":\"全职\",\"educationRequired\":\"本科及以上\",\"recruitmentCount\":2,\"deadline\":\"2024-12-31\",\"contactPerson\":\"王经理\",\"contactPhone\":\"010-12345678\",\"contactEmail\":\"hr@company.com\",\"status\":\"0\"}', '{\"code\":500,\"msg\":\"只有企业用户才能发布岗位\",\"data\":null}', 0, '', '2025-06-13 15:28:47', 8);
INSERT INTO `sys_oper_log` VALUES (1933428797298823169, '00000', '岗位招聘', 1, 'org.ruoyi.designer.controller.JobPostingController.add()', 'POST', 1, 'admin', '', '/designer/job', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseId\":1,\"jobTitle\":\"高级UI\",\"description\":\"负责移动端产品UI设计，与产品经理和开发团队紧密合作\",\"requiredProfession\":\"UI_DESIGNER\",\"requiredSkills\":\"[\\\"PROTOTYPE_DESIGN\\\",\\\"VISUAL_DESIGN\\\",\\\"USER_INTERFACE_DESIGN\\\"]\",\"workYearsRequired\":\"3-5年\",\"salaryMin\":\"15000\",\"salaryMax\":\"25000\",\"location\":\"北京市朝阳区\",\"jobType\":\"全职\",\"educationRequired\":\"本科及以上\",\"recruitmentCount\":2,\"deadline\":\"2024-12-31\",\"contactPerson\":\"王经理\",\"contactPhone\":\"010-12345678\",\"contactEmail\":\"hr@company.com\",\"status\":\"0\"}', '{\"code\":500,\"msg\":\"只有企业用户才能发布岗位\",\"data\":null}', 0, '', '2025-06-13 15:38:41', 128);
INSERT INTO `sys_oper_log` VALUES (1933462564629483522, '00000', '绑定已有院校', 1, 'org.ruoyi.designer.controller.UserRegistrationController.bindToExistingSchool()', 'POST', 1, 'admin', '', '/designer/user/bind/school', '0:0:0:0:0:0:0:1', '内网IP', '1 \"2020001234\"', '{\"code\":500,\"msg\":\"用户已绑定院校身份，请先解绑后再绑定\",\"data\":null}', 0, '', '2025-06-13 17:52:52', 158);
INSERT INTO `sys_oper_log` VALUES (1933462580605587457, '00000', '绑定已有企业', 1, 'org.ruoyi.designer.controller.UserRegistrationController.bindToExistingEnterprise()', 'POST', 1, 'admin', '', '/designer/user/bind/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '1 \"INVITE123\"', '{\"code\":200,\"msg\":\"绑定企业成功\",\"data\":null}', 0, '', '2025-06-13 17:52:56', 17);
INSERT INTO `sys_oper_log` VALUES (1933462645738934273, '00000', '绑定已有企业', 1, 'org.ruoyi.designer.controller.UserRegistrationController.bindToExistingEnterprise()', 'POST', 1, 'admin', '', '/designer/user/bind/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '\"1933082743395094530\" \"INVITE123\"', '{\"code\":500,\"msg\":\"用户已绑定企业身份，请先解绑后再绑定\",\"data\":null}', 0, '', '2025-06-13 17:53:11', 4);
INSERT INTO `sys_oper_log` VALUES (1933462661270441986, '00000', '解绑用户身份', 2, 'org.ruoyi.designer.controller.UserRegistrationController.unbindUserIdentity()', 'PUT', 1, 'admin', '', '/designer/user/unbind/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '\"enterprise\"', '{\"code\":200,\"msg\":\"解绑成功\",\"data\":null}', 0, '', '2025-06-13 17:53:15', 13);
INSERT INTO `sys_oper_log` VALUES (1933462723761377282, '00000', '绑定已有企业', 1, 'org.ruoyi.designer.controller.UserRegistrationController.bindToExistingEnterprise()', 'POST', 1, 'admin', '', '/designer/user/bind/enterprise', '0:0:0:0:0:0:0:1', '内网IP', '3 \"INVITE123\"', '{\"code\":200,\"msg\":\"绑定企业成功\",\"data\":null}', 0, '', '2025-06-13 17:53:30', 12);
INSERT INTO `sys_oper_log` VALUES (1933716131739090946, '00000', '申请岗位', 1, 'org.ruoyi.designer.controller.JobApplicationController.applyForJob()', 'POST', 1, 'admin', '', '/designer/application/apply', '0:0:0:0:0:0:0:1', '内网IP', '\"1933424241185697794\" \"1933088761890025474\" \"我对这个岗位很感兴趣，希望能加入团队\" \"https://example.com/resume.pdf\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 10:40:27', 175);
INSERT INTO `sys_oper_log` VALUES (1933716411616608257, '00000', '申请岗位', 1, 'org.ruoyi.designer.controller.JobApplicationController.applyForJob()', 'POST', 1, 'admin', '', '/designer/application/apply', '0:0:0:0:0:0:0:1', '内网IP', '\"1933424241185697794\" \"1933088761890025474\" \"我对这个岗位很感兴趣，希望能加入团队\" \"https://example.com/resume.pdf\"', '', 1, '您已经申请过该岗位', '2025-06-14 10:41:34', 2);
INSERT INTO `sys_oper_log` VALUES (1933717402516733953, '00000', '处理申请', 2, 'org.ruoyi.designer.controller.JobApplicationController.processApplication()', 'PUT', 1, 'admin', '', '/designer/application/process', '0:0:0:0:0:0:0:1', '内网IP', '{\"feedback\":\"申请通过，请联系HR安排面试\",\"applicationId\":\"1933716131042836482\",\"status\":\"APPROVED\"}', '', 1, '\r\n### Error updating database.  Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\r\n### The error may exist in org/ruoyi/designer/mapper/JobApplicationMapper.java (best guess)\r\n### The error may involve org.ruoyi.designer.mapper.JobApplicationMapper.updateById-Inline\r\n### The error occurred while setting parameters\r\n### SQL: UPDATE des_job_application  SET job_id=?, designer_id=?, cover_letter=?, resume_url=?, status=?, feedback=?, create_dept=?, create_by=?, create_time=?, update_by=?, update_time=?  WHERE application_id=?\r\n### Cause: com.mysql.cj.jdbc.exceptions.MysqlDataTruncation: Data truncation: Data too long for column \'status\' at row 1\n; Data truncation: Data too long for column \'status\' at row 1', '2025-06-14 10:45:30', 131);
INSERT INTO `sys_oper_log` VALUES (1933718892715216897, '00000', '处理申请', 2, 'org.ruoyi.designer.controller.JobApplicationController.processApplication()', 'PUT', 1, 'admin', '', '/designer/application/process', '0:0:0:0:0:0:0:1', '内网IP', '{\"applicationId\":\"1933716131042836482\",\"status\":\"APPROVED\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 10:51:25', 180);
INSERT INTO `sys_oper_log` VALUES (1933719027121688578, '00000', '处理申请', 2, 'org.ruoyi.designer.controller.JobApplicationController.processApplication()', 'PUT', 1, 'admin', '', '/designer/application/process', '0:0:0:0:0:0:0:1', '内网IP', '{\"applicationId\":\"1933716131042836482\",\"status\":\"REJECTED\"}', '', 1, '该申请已经被处理过', '2025-06-14 10:51:57', 3);
INSERT INTO `sys_oper_log` VALUES (1933720396964659202, '00000', '申请岗位', 1, 'org.ruoyi.designer.controller.JobApplicationController.applyForJob()', 'POST', 1, 'admin', '', '/designer/application/apply', '0:0:0:0:0:0:0:1', '内网IP', '\"1933423070203129857\" \"1933088761890025474\" \"我对这个岗位很感兴趣，希望能加入贵公司团队\" \"https://example.com/resume.pdf\"', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 10:57:24', 168);
INSERT INTO `sys_oper_log` VALUES (1933720514375811073, '00000', '处理申请', 2, 'org.ruoyi.designer.controller.JobApplicationController.processApplication()', 'PUT', 1, 'admin', '', '/designer/application/process', '0:0:0:0:0:0:0:1', '内网IP', '{\"feedback\":\"申请不通过，请联系HR安排面试\",\"applicationId\":\"1933720396339707906\",\"status\":\"REJECTED\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 10:57:52', 14);
INSERT INTO `sys_oper_log` VALUES (1933721059505307649, '00000', '处理申请', 2, 'org.ruoyi.designer.controller.JobApplicationController.processApplication()', 'PUT', 1, 'admin', '', '/designer/application/process', '0:0:0:0:0:0:0:1', '内网IP', '{\"feedback\":\"申请不通过，请联系HR安排面试\",\"applicationId\":\"1933720396339707906\",\"status\":\"REJECTED\"}', '', 1, '该申请已经被处理过', '2025-06-14 11:00:02', 2);
INSERT INTO `sys_oper_log` VALUES (1933721084624994306, '00000', '申请岗位', 1, 'org.ruoyi.designer.controller.JobApplicationController.applyForJob()', 'POST', 1, 'admin', '', '/designer/application/apply', '0:0:0:0:0:0:0:1', '内网IP', '\"1933423070203129857\" \"1933088761890025474\" \"我对这个岗位很感兴趣，希望能加入贵公司团队\" \"https://example.com/resume.pdf\"', '', 1, '您已经申请过该岗位', '2025-06-14 11:00:08', 3);
INSERT INTO `sys_oper_log` VALUES (1933721667788439553, '00000', '设计师注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerDesigner()', 'POST', 1, 'admin', '', '/designer/user/register/designer', '0:0:0:0:0:0:0:1', '内网IP', '{\"designerName\":\"张三\",\"avatar\":\"https://avatars.githubusercontent.com/u/27265998\",\"gender\":\"男\",\"birthDate\":\"1995-06-15\",\"phone\":\"13800138000\",\"email\":\"zhangsan@example.com\",\"description\":\"专业UI设计师，擅长原型设计和视觉设计\",\"profession\":\"UI_DESIGNER\",\"skillTags\":\"PROTOTYPE_DESIGN,VISUAL_DESIGN\",\"workYears\":3,\"schoolId\":1,\"enterpriseId\":1,\"graduationDate\":\"2022-06-30\",\"joinDate\":\"2022-07-15\",\"portfolioUrl\":\"https://portfolio.example.com\",\"socialLinks\":\"[object Object]\",\"status\":\"0\"}', '{\"code\":500,\"msg\":\"用户已绑定设计师身份\",\"data\":null}', 0, '', '2025-06-14 11:02:27', 6);
INSERT INTO `sys_oper_log` VALUES (1933721921837432834, '00000', '院校注册', 1, 'org.ruoyi.designer.controller.UserRegistrationController.registerSchool()', 'POST', 1, 'admin', '', '/designer/user/register/school', '0:0:0:0:0:0:0:1', '内网IP', '{\"schoolName\":\"北京设计学院\",\"description\":\"专业的设计教育机构\",\"address\":\"北京市海淀区\",\"phone\":null,\"email\":null,\"website\":null,\"schoolType\":\"UNIVERSITY\",\"level\":\"本科\",\"logo\":null,\"status\":null}', '{\"code\":500,\"msg\":\"用户已绑定院校身份\",\"data\":null}', 0, '', '2025-06-14 11:03:28', 4);
INSERT INTO `sys_oper_log` VALUES (1933722055195328514, '00000', '岗位招聘', 1, 'org.ruoyi.designer.controller.JobPostingController.add()', 'POST', 1, 'admin', '', '/designer/job', '0:0:0:0:0:0:0:1', '内网IP', '{\"enterpriseId\":3,\"jobTitle\":\"高级UI\",\"description\":\"负责移动端产品UI设计，与产品经理和开发团队紧密合作\",\"requiredProfession\":\"UI_DESIGNER\",\"requiredSkills\":\"[\\\"PROTOTYPE_DESIGN\\\",\\\"VISUAL_DESIGN\\\",\\\"USER_INTERFACE_DESIGN\\\"]\",\"workYearsRequired\":\"3-5年\",\"salaryMin\":\"15000\",\"salaryMax\":\"25000\",\"location\":\"北京市朝阳区\",\"jobType\":\"全职\",\"educationRequired\":\"本科及以上\",\"recruitmentCount\":2,\"deadline\":\"2024-12-31\",\"contactPerson\":\"王经理\",\"contactPhone\":\"010-12345678\",\"contactEmail\":\"hr@company.com\",\"status\":\"0\"}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 11:03:59', 12);
INSERT INTO `sys_oper_log` VALUES (1933723038549901314, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.changeStatus()', 'PUT', 1, 'admin', '', '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\"roleId\":\"1661661183933177857\",\"roleName\":\"小程序管理员\",\"roleKey\":\"xcxadmin\",\"roleSort\":1,\"dataScope\":\"1\",\"menuCheckStrictly\":true,\"deptCheckStrictly\":true,\"status\":\"1\",\"remark\":\"\",\"menuIds\":null,\"deptIds\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 11:07:54', 11);
INSERT INTO `sys_oper_log` VALUES (1933723042211528705, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.changeStatus()', 'PUT', 1, 'admin', '', '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\"roleId\":2,\"roleName\":\"普通角色\",\"roleKey\":\"common\",\"roleSort\":2,\"dataScope\":\"2\",\"menuCheckStrictly\":false,\"deptCheckStrictly\":true,\"status\":\"1\",\"remark\":\"普通角色\",\"menuIds\":null,\"deptIds\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 11:07:55', 8);
INSERT INTO `sys_oper_log` VALUES (1933723046875594753, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.changeStatus()', 'PUT', 1, 'admin', '', '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\"roleId\":\"1932319128081666049\",\"roleName\":\"测试\",\"roleKey\":\"test\",\"roleSort\":2,\"dataScope\":\"1\",\"menuCheckStrictly\":false,\"deptCheckStrictly\":true,\"status\":\"1\",\"remark\":\"\",\"menuIds\":null,\"deptIds\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 11:07:56', 6);
INSERT INTO `sys_oper_log` VALUES (1933723049144713218, '00000', '角色管理', 2, 'org.ruoyi.system.controller.system.SysRoleController.changeStatus()', 'PUT', 1, 'admin', '', '/system/role/changeStatus', '127.0.0.1', '内网IP', '{\"roleId\":3,\"roleName\":\"本部门及以下\",\"roleKey\":\"test1\",\"roleSort\":3,\"dataScope\":\"4\",\"menuCheckStrictly\":true,\"deptCheckStrictly\":true,\"status\":\"1\",\"remark\":null,\"menuIds\":null,\"deptIds\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 11:07:56', 8);
INSERT INTO `sys_oper_log` VALUES (1933729528451006465, '00000', '用户管理', 2, 'org.ruoyi.system.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"userId\":\"1933082743395094530\",\"deptId\":null,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"1\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"33322\",\"domainName\":null,\"roleIds\":[\"1932319128081666052\"],\"postIds\":[3],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 11:33:41', 29);
INSERT INTO `sys_oper_log` VALUES (1933729606704136193, '00000', '用户管理', 2, 'org.ruoyi.system.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"userId\":\"1933082743395094530\",\"deptId\":null,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"1\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"33322\",\"domainName\":null,\"roleIds\":[\"1932319128081666051\"],\"postIds\":[3],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 11:34:00', 9);
INSERT INTO `sys_oper_log` VALUES (1933731542425763842, '00000', '用户管理', 2, 'org.ruoyi.system.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"userId\":\"1933082743395094530\",\"deptId\":null,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"1\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"33322\",\"domainName\":null,\"roleIds\":[\"1932319128081666050\",\"1932319128081666051\"],\"postIds\":[3],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 11:41:41', 11);
INSERT INTO `sys_oper_log` VALUES (1933732424089436162, '00000', '用户管理', 2, 'org.ruoyi.system.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '', '/system/user', '127.0.0.1', '内网IP', '{\"userId\":\"1933082743395094530\",\"deptId\":null,\"userName\":\"test\",\"nickName\":\"肖艺马\",\"userType\":null,\"email\":\"j***@mails.ccnu.edu.cn\",\"phonenumber\":null,\"sex\":\"1\",\"userPlan\":null,\"status\":\"0\",\"avatar\":null,\"remark\":\"33322\",\"domainName\":null,\"roleIds\":[\"1932319128081666052\"],\"postIds\":[3],\"roleId\":null,\"openId\":null,\"userGrade\":null,\"userBalance\":null,\"superAdmin\":false}', '{\"code\":200,\"msg\":\"操作成功\",\"data\":null}', 0, '', '2025-06-14 11:45:12', 7);

-- ----------------------------
-- Table structure for sys_oss
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss`;
CREATE TABLE `sys_oss`  (
  `oss_id` bigint NOT NULL COMMENT '对象存储主键',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件名',
  `original_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '原名',
  `file_suffix` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '文件后缀名',
  `url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT 'URL地址',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `create_by` bigint NULL DEFAULT NULL COMMENT '上传人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新人',
  `service` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'minio' COMMENT '服务商',
  PRIMARY KEY (`oss_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = 'OSS对象存储表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss
-- ----------------------------

-- ----------------------------
-- Table structure for sys_oss_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_oss_config`;
CREATE TABLE `sys_oss_config`  (
  `oss_config_id` bigint NOT NULL COMMENT '主建',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `config_key` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '配置key',
  `access_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'accessKey',
  `secret_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '秘钥',
  `bucket_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '桶名称',
  `prefix` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '前缀',
  `endpoint` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '访问站点',
  `domain` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '自定义域名',
  `is_https` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'N' COMMENT '是否https（Y=是,N=否）',
  `region` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '域',
  `access_policy` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '1' COMMENT '桶权限类型(0=private 1=public 2=custom)',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '是否默认（0=是,1=否）',
  `ext1` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '扩展字段',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`oss_config_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '对象存储配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oss_config
-- ----------------------------
INSERT INTO `sys_oss_config` VALUES (1, '000000', 'minio', 'ruoyi', 'ruoyi123', 'ruoyi', '', '127.0.0.1:9000', '', 'N', '', '1', '1', '', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-26 16:25:55', NULL);
INSERT INTO `sys_oss_config` VALUES (2, '000000', 'qiniu', 'ruoyi', 'ruoyi123', 'ruoyi', '', 's3-cn-north-1.qiniucs.com', '', 'N', '', '1', '0', '', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-26 19:44:56', NULL);
INSERT INTO `sys_oss_config` VALUES (3, '000000', 'aliyun', 'ruoyi', 'ruoyi123', 'ruoyi', '', 'oss-cn-beijing.aliyuncs.com', '', 'N', '', '1', '1', '', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-13 13:13:04', NULL);
INSERT INTO `sys_oss_config` VALUES (4, '000000', 'qcloud', 'ruoyi', 'ruoyi123', 'ruoyi', 'panda', 'cos.ap-guangzhou.myqcloud.com', '', 'N', 'ap-guangzhou', '1', '1', '', 103, 1, '2023-05-14 15:19:42', 1, '2025-03-26 09:23:26', '');

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, '000000', 'ceo', '董事长', 1, '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (2, '000000', 'se', '项目经理', 2, '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (3, '000000', 'hr', '人力资源', 3, '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL, '');
INSERT INTO `sys_post` VALUES (4, '000000', 'user', '普通员工', 4, '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL, '');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '000000', '超级管理员', 'superadmin', 1, '1', 1, 1, '0', '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL, '超级管理员');
INSERT INTO `sys_role` VALUES (2, '000000', '普通角色', 'common', 2, '2', 0, 1, '1', '0', 103, 1, '2023-05-14 15:19:39', 1, '2025-03-31 19:41:35', '普通角色');
INSERT INTO `sys_role` VALUES (3, '000000', '本部门及以下', 'test1', 3, '4', 1, 1, '1', '0', 103, 1, '2023-05-14 15:20:00', 1, '2025-03-17 09:29:25', NULL);
INSERT INTO `sys_role` VALUES (4, '000000', '仅本人', 'test2', 4, '5', 1, 1, '0', '0', 103, 1, '2023-05-14 15:20:00', 1, '2025-03-24 10:56:45', NULL);
INSERT INTO `sys_role` VALUES (1661661183933177857, '000000', '小程序管理员', 'xcxadmin', 1, '1', 1, 1, '1', '0', 103, 1, '2023-05-25 17:11:13', 1, '2025-03-31 19:45:38', '');
INSERT INTO `sys_role` VALUES (1729685491108446210, '911866', '管理员', 'admin', 4, '1', 1, 1, '0', '0', 103, 1, '2023-11-29 10:15:32', 1, '2025-03-26 18:25:07', NULL);
INSERT INTO `sys_role` VALUES (1932319128081666049, '000000', '测试', 'test', 2, '1', 0, 1, '1', '0', 103, 1, '2025-06-10 14:09:16', 1, '2025-06-10 14:09:16', '');
INSERT INTO `sys_role` VALUES (1932319128081666050, '000000', '设计师', 'designer', 4, '5', 1, 1, '0', '0', NULL, NULL, '2025-06-10 16:53:07', NULL, NULL, '设计师角色，管理个人信息和申请岗位');
INSERT INTO `sys_role` VALUES (1932319128081666051, '000000', '企业管理员', 'enterprise', 3, '2', 1, 1, '0', '0', NULL, NULL, '2025-06-10 16:53:07', NULL, NULL, '企业管理员角色，管理企业信息和岗位招聘');
INSERT INTO `sys_role` VALUES (1932319128081666052, '000000', '院校管理员', 'school', 3, '2', 1, 1, '0', '0', NULL, NULL, '2025-06-10 16:53:07', NULL, NULL, '院校管理员角色，管理院校信息和学生数据');

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100);
INSERT INTO `sys_role_dept` VALUES (2, 101);
INSERT INTO `sys_role_dept` VALUES (2, 105);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 102);
INSERT INTO `sys_role_menu` VALUES (2, 103);
INSERT INTO `sys_role_menu` VALUES (2, 104);
INSERT INTO `sys_role_menu` VALUES (2, 105);
INSERT INTO `sys_role_menu` VALUES (2, 106);
INSERT INTO `sys_role_menu` VALUES (2, 107);
INSERT INTO `sys_role_menu` VALUES (2, 108);
INSERT INTO `sys_role_menu` VALUES (2, 113);
INSERT INTO `sys_role_menu` VALUES (2, 500);
INSERT INTO `sys_role_menu` VALUES (2, 501);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1012);
INSERT INTO `sys_role_menu` VALUES (2, 1013);
INSERT INTO `sys_role_menu` VALUES (2, 1014);
INSERT INTO `sys_role_menu` VALUES (2, 1015);
INSERT INTO `sys_role_menu` VALUES (2, 1016);
INSERT INTO `sys_role_menu` VALUES (2, 1017);
INSERT INTO `sys_role_menu` VALUES (2, 1018);
INSERT INTO `sys_role_menu` VALUES (2, 1019);
INSERT INTO `sys_role_menu` VALUES (2, 1020);
INSERT INTO `sys_role_menu` VALUES (2, 1021);
INSERT INTO `sys_role_menu` VALUES (2, 1022);
INSERT INTO `sys_role_menu` VALUES (2, 1023);
INSERT INTO `sys_role_menu` VALUES (2, 1024);
INSERT INTO `sys_role_menu` VALUES (2, 1025);
INSERT INTO `sys_role_menu` VALUES (2, 1026);
INSERT INTO `sys_role_menu` VALUES (2, 1027);
INSERT INTO `sys_role_menu` VALUES (2, 1028);
INSERT INTO `sys_role_menu` VALUES (2, 1029);
INSERT INTO `sys_role_menu` VALUES (2, 1030);
INSERT INTO `sys_role_menu` VALUES (2, 1031);
INSERT INTO `sys_role_menu` VALUES (2, 1032);
INSERT INTO `sys_role_menu` VALUES (2, 1033);
INSERT INTO `sys_role_menu` VALUES (2, 1034);
INSERT INTO `sys_role_menu` VALUES (2, 1035);
INSERT INTO `sys_role_menu` VALUES (2, 1036);
INSERT INTO `sys_role_menu` VALUES (2, 1037);
INSERT INTO `sys_role_menu` VALUES (2, 1038);
INSERT INTO `sys_role_menu` VALUES (2, 1039);
INSERT INTO `sys_role_menu` VALUES (2, 1040);
INSERT INTO `sys_role_menu` VALUES (2, 1041);
INSERT INTO `sys_role_menu` VALUES (2, 1042);
INSERT INTO `sys_role_menu` VALUES (2, 1043);
INSERT INTO `sys_role_menu` VALUES (2, 1044);
INSERT INTO `sys_role_menu` VALUES (2, 1045);
INSERT INTO `sys_role_menu` VALUES (2, 1050);
INSERT INTO `sys_role_menu` VALUES (2, 1775500307898949634);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068610);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068611);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068612);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068613);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068614);
INSERT INTO `sys_role_menu` VALUES (2, 1775895273104068615);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507266);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507267);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507268);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507269);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507270);
INSERT INTO `sys_role_menu` VALUES (2, 1780240077690507271);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018433);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018434);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018435);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018436);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018437);
INSERT INTO `sys_role_menu` VALUES (2, 1780255628576018438);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156481);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156482);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156483);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156484);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156485);
INSERT INTO `sys_role_menu` VALUES (2, 1786379590171156486);
INSERT INTO `sys_role_menu` VALUES (2, 1787078000285122561);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834305);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834306);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834307);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834308);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834309);
INSERT INTO `sys_role_menu` VALUES (2, 1810594719028834310);
INSERT INTO `sys_role_menu` VALUES (2, 1843281231381852162);
INSERT INTO `sys_role_menu` VALUES (2, 1860690448695549953);
INSERT INTO `sys_role_menu` VALUES (2, 1898286496441393153);
INSERT INTO `sys_role_menu` VALUES (2, 1900172314827739137);
INSERT INTO `sys_role_menu` VALUES (2, 1902184523796742145);
INSERT INTO `sys_role_menu` VALUES (2, 1906199640746344450);
INSERT INTO `sys_role_menu` VALUES (2, 1906200030325882882);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103490);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103491);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103492);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103493);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103494);
INSERT INTO `sys_role_menu` VALUES (2, 1906336170039103495);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294402);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294403);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294404);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294405);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294406);
INSERT INTO `sys_role_menu` VALUES (2, 1906358690184294407);
INSERT INTO `sys_role_menu` VALUES (3, 1);
INSERT INTO `sys_role_menu` VALUES (3, 100);
INSERT INTO `sys_role_menu` VALUES (3, 101);
INSERT INTO `sys_role_menu` VALUES (3, 102);
INSERT INTO `sys_role_menu` VALUES (3, 103);
INSERT INTO `sys_role_menu` VALUES (3, 104);
INSERT INTO `sys_role_menu` VALUES (3, 105);
INSERT INTO `sys_role_menu` VALUES (3, 106);
INSERT INTO `sys_role_menu` VALUES (3, 107);
INSERT INTO `sys_role_menu` VALUES (3, 108);
INSERT INTO `sys_role_menu` VALUES (3, 500);
INSERT INTO `sys_role_menu` VALUES (3, 501);
INSERT INTO `sys_role_menu` VALUES (3, 1001);
INSERT INTO `sys_role_menu` VALUES (3, 1002);
INSERT INTO `sys_role_menu` VALUES (3, 1003);
INSERT INTO `sys_role_menu` VALUES (3, 1004);
INSERT INTO `sys_role_menu` VALUES (3, 1005);
INSERT INTO `sys_role_menu` VALUES (3, 1006);
INSERT INTO `sys_role_menu` VALUES (3, 1007);
INSERT INTO `sys_role_menu` VALUES (3, 1008);
INSERT INTO `sys_role_menu` VALUES (3, 1009);
INSERT INTO `sys_role_menu` VALUES (3, 1010);
INSERT INTO `sys_role_menu` VALUES (3, 1011);
INSERT INTO `sys_role_menu` VALUES (3, 1012);
INSERT INTO `sys_role_menu` VALUES (3, 1013);
INSERT INTO `sys_role_menu` VALUES (3, 1014);
INSERT INTO `sys_role_menu` VALUES (3, 1015);
INSERT INTO `sys_role_menu` VALUES (3, 1016);
INSERT INTO `sys_role_menu` VALUES (3, 1017);
INSERT INTO `sys_role_menu` VALUES (3, 1018);
INSERT INTO `sys_role_menu` VALUES (3, 1019);
INSERT INTO `sys_role_menu` VALUES (3, 1020);
INSERT INTO `sys_role_menu` VALUES (3, 1021);
INSERT INTO `sys_role_menu` VALUES (3, 1022);
INSERT INTO `sys_role_menu` VALUES (3, 1023);
INSERT INTO `sys_role_menu` VALUES (3, 1024);
INSERT INTO `sys_role_menu` VALUES (3, 1025);
INSERT INTO `sys_role_menu` VALUES (3, 1026);
INSERT INTO `sys_role_menu` VALUES (3, 1027);
INSERT INTO `sys_role_menu` VALUES (3, 1028);
INSERT INTO `sys_role_menu` VALUES (3, 1029);
INSERT INTO `sys_role_menu` VALUES (3, 1030);
INSERT INTO `sys_role_menu` VALUES (3, 1031);
INSERT INTO `sys_role_menu` VALUES (3, 1032);
INSERT INTO `sys_role_menu` VALUES (3, 1033);
INSERT INTO `sys_role_menu` VALUES (3, 1034);
INSERT INTO `sys_role_menu` VALUES (3, 1035);
INSERT INTO `sys_role_menu` VALUES (3, 1036);
INSERT INTO `sys_role_menu` VALUES (3, 1037);
INSERT INTO `sys_role_menu` VALUES (3, 1038);
INSERT INTO `sys_role_menu` VALUES (3, 1039);
INSERT INTO `sys_role_menu` VALUES (3, 1040);
INSERT INTO `sys_role_menu` VALUES (3, 1041);
INSERT INTO `sys_role_menu` VALUES (3, 1042);
INSERT INTO `sys_role_menu` VALUES (3, 1043);
INSERT INTO `sys_role_menu` VALUES (3, 1044);
INSERT INTO `sys_role_menu` VALUES (3, 1045);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 100);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 101);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 102);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 103);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 104);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 105);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 106);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 107);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 108);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 113);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 500);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 501);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1001);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1002);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1003);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1004);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1005);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1006);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1007);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1008);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1009);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1010);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1011);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1012);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1013);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1014);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1015);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1016);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1017);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1018);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1019);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1020);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1021);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1022);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1023);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1024);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1025);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1026);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1027);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1028);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1029);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1030);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1031);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1032);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1033);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1034);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1035);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1036);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1037);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1038);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1039);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1040);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1041);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1042);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1043);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1044);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1045);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1050);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775500307898949634);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068610);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068611);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068612);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068613);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068614);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1775895273104068615);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507266);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507267);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507268);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507269);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507270);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780240077690507271);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018433);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018434);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018435);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018436);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018437);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1780255628576018438);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156481);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156482);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156483);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156484);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156485);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1786379590171156486);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1787078000285122561);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834305);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834306);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834307);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834308);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834309);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1810594719028834310);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1843281231381852162);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1898286496441393153);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1900172314827739137);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1902184523796742145);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906199640746344450);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906200030325882882);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103490);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103491);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103492);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103493);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103494);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906336170039103495);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294402);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294403);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294404);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294405);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294406);
INSERT INTO `sys_role_menu` VALUES (1661661183933177857, 1906358690184294407);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1689201668374556674);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1689205943360188417);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1689243465037561858);
INSERT INTO `sys_role_menu` VALUES (1729685491108446210, 1689243466220355585);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 100);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1001);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1002);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1003);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1004);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1005);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1006);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1007);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775500307898949634);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068610);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068611);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068612);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068613);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068614);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1775895273104068615);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507266);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507267);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507268);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507269);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507270);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780240077690507271);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018433);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018434);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018435);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018436);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018437);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1780255628576018438);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156481);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156482);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156483);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156484);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156485);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1786379590171156486);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1787078000285122561);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834305);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834306);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834307);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834308);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834309);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1810594719028834310);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1843281231381852162);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1860690448695549953);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1898286496441393153);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1900172314827739137);
INSERT INTO `sys_role_menu` VALUES (1905899651235143681, 1902184523796742145);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 100);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 101);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 102);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 103);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 104);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 105);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 106);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 107);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 108);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 113);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 500);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 501);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1001);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1002);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1003);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1004);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1005);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1006);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1007);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1008);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1009);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1010);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1011);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1012);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1013);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1014);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1015);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1016);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1017);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1018);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1019);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1020);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1021);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1022);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1023);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1024);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1025);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1026);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1027);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1028);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1029);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1030);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1031);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1032);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1033);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1034);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1035);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1036);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1037);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1038);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1039);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1040);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1041);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1042);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1043);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1044);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1045);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1050);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1775500307898949634);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1775895273104068610);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1775895273104068611);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1775895273104068612);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1775895273104068613);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1775895273104068614);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1775895273104068615);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780240077690507266);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780240077690507267);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780240077690507268);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780240077690507269);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780240077690507270);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780240077690507271);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780255628576018433);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780255628576018434);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780255628576018435);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780255628576018436);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780255628576018437);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1780255628576018438);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1786379590171156481);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1786379590171156482);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1786379590171156483);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1786379590171156484);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1786379590171156485);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1786379590171156486);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1787078000285122561);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1810594719028834305);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1810594719028834306);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1810594719028834307);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1810594719028834308);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1810594719028834309);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1810594719028834310);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1843281231381852162);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1860690448695549953);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1898286496441393153);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1900172314827739137);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1902184523796742145);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906199640746344450);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906200030325882882);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906336170039103490);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906336170039103491);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906336170039103492);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906336170039103493);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906336170039103494);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906336170039103495);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906358690184294402);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906358690184294403);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906358690184294404);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906358690184294405);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906358690184294406);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906358690184294407);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906674838461321217);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906674838461321218);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906674838461321219);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906674838461321220);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906674838461321221);
INSERT INTO `sys_role_menu` VALUES (1932319128081666049, 1906674838461321222);

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
  `id` bigint NOT NULL COMMENT 'id',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '租户编号',
  `contact_user_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '联系电话',
  `company_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业名称',
  `license_number` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '统一社会信用代码',
  `address` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '地址',
  `intro` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '企业简介',
  `domain` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '域名',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `package_id` bigint NULL DEFAULT NULL COMMENT '租户套餐编号',
  `expire_time` datetime NULL DEFAULT NULL COMMENT '过期时间',
  `account_count` int NULL DEFAULT -1 COMMENT '用户数量（-1不限制）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '租户状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '租户表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES (1, '000000', '管理组', '15888888888', 'XXX有限公司', NULL, NULL, '多租户通用后台管理管理系统', NULL, NULL, NULL, NULL, -1, '0', '0', 103, 1, '2023-05-14 15:19:39', NULL, NULL);
INSERT INTO `sys_tenant` VALUES (1729685490647072769, '911866', '测试', '11111111111', '5126', '', '', '', '', '', 1729685389795033090, NULL, 1, '0', '2', 103, 1, '2023-11-29 10:15:32', 1, '2023-11-29 10:15:32');

-- ----------------------------
-- Table structure for sys_tenant_package
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant_package`;
CREATE TABLE `sys_tenant_package`  (
  `package_id` bigint NOT NULL COMMENT '租户套餐id',
  `package_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '套餐名称',
  `menu_ids` varchar(3000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '关联菜单id',
  `remark` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`package_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '租户套餐表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenant_package
-- ----------------------------
INSERT INTO `sys_tenant_package` VALUES (1729685389795033090, '测试', '1689205943360188417, 1689243466220355585, 1689201668374556674, 1689243465037561858', '', 1, '0', '2', 103, 1, '2023-11-29 10:15:08', 1, '2023-11-29 10:15:08');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `open_id` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信用户标识',
  `user_grade` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户等级',
  `user_balance` double(20, 2) NULL DEFAULT 0.00 COMMENT '账户余额',
  `tenant_id` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '000000' COMMENT '租户编号',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'sys_user' COMMENT '用户类型（sys_user系统用户）',
  `user_plan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Free' COMMENT '用户套餐',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '头像地址',
  `wx_avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '微信头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `domain_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '注册域名',
  `create_dept` bigint NULL DEFAULT NULL COMMENT '创建部门',
  `create_by` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, NULL, '1', 100.00, '00000', 103, 'admin', '111222333', 'sys_user', 'Free', 'ageerle@163.com', '15888888888', '0', 'http://panda-1253683406.cos.ap-guangzhou.myqcloud.com/panda/2024/10/07/09bd580f55954b50a3093231945123e0.jpg', NULL, '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-06-27 17:39:31', NULL, 103, 1, '2023-05-14 15:19:39', 1, '2025-06-27 17:39:31', '管理员');
INSERT INTO `sys_user` VALUES (1714176194496339970, NULL, '1', 88.88, '00000', NULL, 'pandarobot@163.com', '问答助手', 'sys_user', 'Free', '', '', '0', 'http://panda-1253683406.cos.ap-guangzhou.myqcloud.com/panda/2024/04/28/346796f5c32744c1987bf28d5820325b.jpg', NULL, '$2a$10$u3LIdNBg6kM3iYqHFJe2IOWCMbT2h5NUI.CeXlF5dyBGcy3nwW836', '1', '2', '127.0.0.1', '2025-03-05 17:18:42', NULL, 103, 1713440206715650049, '2023-10-17 15:07:07', 1714176194496339970, '2025-03-05 17:18:42', NULL);
INSERT INTO `sys_user` VALUES (1898270044544028674, NULL, '1', 1.00, '00000', NULL, '1150039659@qq.com', '1150039659@qq.com', 'sys_user', 'Free', '', '', '0', NULL, NULL, '$2a$10$Mw9T.kzBuYqvT14ZDP2VoORLU9WMWdaT/iatJxEtCQCZoBYBNmKw6', '0', '2', '127.0.0.1', '2025-03-09 23:01:03', '192.168.20.162', NULL, NULL, '2025-03-08 15:10:21', 1898270044544028674, '2025-03-09 23:01:03', NULL);
INSERT INTO `sys_user` VALUES (1898283021590552578, NULL, '0', 1.00, '00000', NULL, '1434841024@qq.com', '1434841024@qq.com', 'sys_user', 'Free', '', '', '0', NULL, NULL, '$2a$10$R6rClsJdJK5Ovhp14Xc0w.IITFBDyocgxWqsJ9SS7AhWW6.vCKiAa', '0', '2', '192.168.20.161', '2025-03-08 17:04:37', '127.0.0.1', NULL, NULL, '2025-03-08 16:01:55', 1898283021590552578, '2025-03-08 17:04:37', NULL);
INSERT INTO `sys_user` VALUES (1904371025403224065, NULL, '1', 999999999.00, '000000', 103, 'dddd', 'dddd', 'sys_user', 'Free', '', '', '0', NULL, NULL, '$2a$10$y0IYGL1MY5rvTUEl9Pjg4uIVMpbwwuzIl.8nH2Ie3uK2A9EJor0VK', '1', '2', '127.0.0.1', '2025-03-25 11:15:16', NULL, 103, 1, '2025-03-25 11:13:29', 1904371025403224065, '2025-03-25 11:15:16', NULL);
INSERT INTO `sys_user` VALUES (1905928435494330370, NULL, '0', 100.00, '000000', 103, '熊猫助手', '熊猫助手', 'sys_user', 'Free', 'iii@g545.bo', '', '0', NULL, NULL, '$2a$10$8WO.FFcmu4L/DhzpfM4rbee0HRK6gIYIs2KsRXkc4ckjudbzchvPi', '0', '2', '', NULL, NULL, 103, 1, '2025-03-29 18:22:04', 1, '2025-03-31 10:15:11', NULL);
INSERT INTO `sys_user` VALUES (1925836298162114562, NULL, '0', 1.00, '00000', NULL, 'a1151386302@gmail.com', 'a1151386302@gmail.com', 'sys_user', 'Free', '', '', '0', NULL, NULL, '$2a$10$apCjZSuPOD54VYWn5JTnEehe1adVd1PacFy7Gvio3EGflR2d1Vtwm', '0', '2', '127.0.0.1', '2025-05-23 16:48:56', '127.0.0.1', NULL, NULL, '2025-05-23 16:48:48', 1, '2025-05-23 16:54:07', NULL);
INSERT INTO `sys_user` VALUES (1925843050148499458, NULL, '0', 1.00, '00000', NULL, 'a1151386302@gmail.com', 'a1151386302@gmail.com', 'sys_user', 'Free', '', '', '0', NULL, NULL, '$2a$10$QwaTV8OmGUPokq2FoQgA0O86rNIuIBGiCnu0MidV.0l6BhWg2Ac2a', '0', '2', '', NULL, '127.0.0.1', NULL, NULL, '2025-05-23 17:15:38', 1, '2025-05-23 17:16:45', NULL);
INSERT INTO `sys_user` VALUES (1926091085038325762, NULL, '0', 1.00, '00000', NULL, 'a1151386302@gmail.com', 'a1151386302@gmail.com', 'sys_user', 'Free', '', '', '0', NULL, NULL, '$2a$10$lSTpYGRsF5FHzMicZeEf2.PPtxqXqmETYfPkLl0XT829ak7vBBUXy', '0', '2', '', NULL, '127.0.0.1', NULL, NULL, '2025-05-24 09:41:14', 1, '2025-05-24 10:15:52', NULL);
INSERT INTO `sys_user` VALUES (1932364765288480770, NULL, '0', 0.00, '000000', 103, 'test', '肖艺马', 'sys_user', 'Free', 'jiut@mails.ccnu.edu.cn', '', '0', NULL, NULL, '$2a$10$rZ74l/iBWEBrON8EYMhoOOU1.AJPyZDTTgJ7521QqZjZ4vVJNa6Du', '0', '2', '127.0.0.1', '2025-06-12 14:48:45', NULL, 103, 1, '2025-06-10 17:10:36', 1, '2025-06-12 15:52:44', NULL);
INSERT INTO `sys_user` VALUES (1933072715447574530, NULL, '0', 0.00, '000000', 103, 'test', '肖艺马', 'sys_user', 'Free', 'jiut@mails.ccnu.edu.cn', '', '1', NULL, NULL, 'abcdefg20011116', '0', '2', '127.0.0.1', '2025-06-12 16:04:04', NULL, 103, 1, '2025-06-12 16:03:45', 1, '2025-06-12 16:41:27', '123321');
INSERT INTO `sys_user` VALUES (1933082743395094530, NULL, '0', 0.00, '000000', 103, 'test', '肖艺马', 'sys_user', 'Free', 'jiut@mails.ccnu.edu.cn', '', '1', NULL, NULL, 'abcdefg20011116', '0', '0', '0:0:0:0:0:0:0:1', '2025-06-14 11:02:58', NULL, 103, 1, '2025-06-12 16:43:36', 1, '2025-06-14 11:45:12', '33322');

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2);
INSERT INTO `sys_user_post` VALUES (1661660085084250114, 2);
INSERT INTO `sys_user_post` VALUES (1661660804847788034, 1);
INSERT INTO `sys_user_post` VALUES (1933082743395094530, 3);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (3, 3);
INSERT INTO `sys_user_role` VALUES (4, 4);
INSERT INTO `sys_user_role` VALUES (1661646824293031937, 1661661183933177857);
INSERT INTO `sys_user_role` VALUES (1661660085084250114, 1661661183933177857);
INSERT INTO `sys_user_role` VALUES (1661660804847788034, 2);
INSERT INTO `sys_user_role` VALUES (1713427806956404738, 1);
INSERT INTO `sys_user_role` VALUES (1713439839684689921, 1);
INSERT INTO `sys_user_role` VALUES (1713440206715650049, 1);
INSERT INTO `sys_user_role` VALUES (1714267685998907393, 1);
INSERT INTO `sys_user_role` VALUES (1714269581270667265, 1);
INSERT INTO `sys_user_role` VALUES (1714270420659949569, 1);
INSERT INTO `sys_user_role` VALUES (1714455864827723777, 1);
INSERT INTO `sys_user_role` VALUES (1714536425072115714, 1);
INSERT INTO `sys_user_role` VALUES (1714819715117105153, 1);
INSERT INTO `sys_user_role` VALUES (1714820415783976961, 1);
INSERT INTO `sys_user_role` VALUES (1714820611611836417, 1);
INSERT INTO `sys_user_role` VALUES (1714820755698761729, 1);
INSERT INTO `sys_user_role` VALUES (1714823588305190914, 1);
INSERT INTO `sys_user_role` VALUES (1714829502936530945, 1);
INSERT INTO `sys_user_role` VALUES (1714898663033290754, 1);
INSERT INTO `sys_user_role` VALUES (1714942733206175746, 1);
INSERT INTO `sys_user_role` VALUES (1714943378361434113, 1);
INSERT INTO `sys_user_role` VALUES (1714943388671033346, 1);
INSERT INTO `sys_user_role` VALUES (1714945928464711682, 1);
INSERT INTO `sys_user_role` VALUES (1714946100850606082, 1);
INSERT INTO `sys_user_role` VALUES (1714952355237347329, 1);
INSERT INTO `sys_user_role` VALUES (1714954192279584770, 1);
INSERT INTO `sys_user_role` VALUES (1714960721598758913, 1);
INSERT INTO `sys_user_role` VALUES (1714961357132283906, 1);
INSERT INTO `sys_user_role` VALUES (1714963426656403458, 1);
INSERT INTO `sys_user_role` VALUES (1714980339130318850, 1);
INSERT INTO `sys_user_role` VALUES (1714985002550444034, 1);
INSERT INTO `sys_user_role` VALUES (1714996959085084674, 1);
INSERT INTO `sys_user_role` VALUES (1715000784541990913, 1);
INSERT INTO `sys_user_role` VALUES (1715160830886297602, 1);
INSERT INTO `sys_user_role` VALUES (1715174792021426177, 1);
INSERT INTO `sys_user_role` VALUES (1715176760861278209, 1);
INSERT INTO `sys_user_role` VALUES (1715187418688405506, 1);
INSERT INTO `sys_user_role` VALUES (1715263570077564930, 1);
INSERT INTO `sys_user_role` VALUES (1715273299113820162, 1);
INSERT INTO `sys_user_role` VALUES (1715289765028577281, 1);
INSERT INTO `sys_user_role` VALUES (1715642509052624897, 1);
INSERT INTO `sys_user_role` VALUES (1715645217792868353, 1);
INSERT INTO `sys_user_role` VALUES (1715655140035543041, 1);
INSERT INTO `sys_user_role` VALUES (1715688813166346242, 1);
INSERT INTO `sys_user_role` VALUES (1715695623109623810, 1);
INSERT INTO `sys_user_role` VALUES (1716076523383177217, 1);
INSERT INTO `sys_user_role` VALUES (1716077329079615490, 1);
INSERT INTO `sys_user_role` VALUES (1716316658037178370, 1);
INSERT INTO `sys_user_role` VALUES (1716375479287824386, 1);
INSERT INTO `sys_user_role` VALUES (1716376929359380482, 1);
INSERT INTO `sys_user_role` VALUES (1716449431389487106, 1);
INSERT INTO `sys_user_role` VALUES (1716626232627707906, 1);
INSERT INTO `sys_user_role` VALUES (1716668774639484929, 1);
INSERT INTO `sys_user_role` VALUES (1716723582348050434, 1);
INSERT INTO `sys_user_role` VALUES (1717010625036828674, 1);
INSERT INTO `sys_user_role` VALUES (1717112818712723458, 1);
INSERT INTO `sys_user_role` VALUES (1717171039955599361, 1);
INSERT INTO `sys_user_role` VALUES (1717382776042569730, 1);
INSERT INTO `sys_user_role` VALUES (1717383874597896194, 1);
INSERT INTO `sys_user_role` VALUES (1717463477270102018, 1);
INSERT INTO `sys_user_role` VALUES (1717550755342467074, 1);
INSERT INTO `sys_user_role` VALUES (1718643906618605569, 1);
INSERT INTO `sys_user_role` VALUES (1719357065528623105, 1);
INSERT INTO `sys_user_role` VALUES (1719629669720145921, 1);
INSERT INTO `sys_user_role` VALUES (1719631746265530370, 1);
INSERT INTO `sys_user_role` VALUES (1719969371128086529, 1);
INSERT INTO `sys_user_role` VALUES (1719994192431955970, 1);
INSERT INTO `sys_user_role` VALUES (1720001597920264194, 1);
INSERT INTO `sys_user_role` VALUES (1720054174099718145, 1);
INSERT INTO `sys_user_role` VALUES (1720373256426635265, 1);
INSERT INTO `sys_user_role` VALUES (1720615324298264578, 1);
INSERT INTO `sys_user_role` VALUES (1720966085100191746, 1);
INSERT INTO `sys_user_role` VALUES (1721433118342397954, 1);
INSERT INTO `sys_user_role` VALUES (1721798759096270850, 1);
INSERT INTO `sys_user_role` VALUES (1721869407395332097, 1);
INSERT INTO `sys_user_role` VALUES (1721869952080232450, 1);
INSERT INTO `sys_user_role` VALUES (1722083875718737921, 1);
INSERT INTO `sys_user_role` VALUES (1722126825769185282, 1);
INSERT INTO `sys_user_role` VALUES (1722453238653169665, 1);
INSERT INTO `sys_user_role` VALUES (1722501722198552577, 1);
INSERT INTO `sys_user_role` VALUES (1722546398997819394, 1);
INSERT INTO `sys_user_role` VALUES (1722635856464097281, 1);
INSERT INTO `sys_user_role` VALUES (1722652602847768578, 1);
INSERT INTO `sys_user_role` VALUES (1722787874222682114, 1);
INSERT INTO `sys_user_role` VALUES (1722799180870889473, 1);
INSERT INTO `sys_user_role` VALUES (1722872660475817986, 1);
INSERT INTO `sys_user_role` VALUES (1722874592401600514, 1);
INSERT INTO `sys_user_role` VALUES (1722883137289367554, 1);
INSERT INTO `sys_user_role` VALUES (1722918534182645762, 1);
INSERT INTO `sys_user_role` VALUES (1723173295586848769, 1);
INSERT INTO `sys_user_role` VALUES (1723222687891107841, 1);
INSERT INTO `sys_user_role` VALUES (1723224404040921089, 1);
INSERT INTO `sys_user_role` VALUES (1723225015520112641, 1);
INSERT INTO `sys_user_role` VALUES (1723278284531478529, 1);
INSERT INTO `sys_user_role` VALUES (1723330835209564161, 1);
INSERT INTO `sys_user_role` VALUES (1723708198137147393, 1);
INSERT INTO `sys_user_role` VALUES (1723754683843260417, 1);
INSERT INTO `sys_user_role` VALUES (1723878185250369537, 1);
INSERT INTO `sys_user_role` VALUES (1723940614634254337, 1);
INSERT INTO `sys_user_role` VALUES (1723975861757325314, 1);
INSERT INTO `sys_user_role` VALUES (1724306907803725826, 1);
INSERT INTO `sys_user_role` VALUES (1724308252862492673, 1);
INSERT INTO `sys_user_role` VALUES (1724382895124295681, 1);
INSERT INTO `sys_user_role` VALUES (1724727778758406145, 1);
INSERT INTO `sys_user_role` VALUES (1724815478295425026, 1);
INSERT INTO `sys_user_role` VALUES (1725026071145107458, 1);
INSERT INTO `sys_user_role` VALUES (1725026978817658881, 1);
INSERT INTO `sys_user_role` VALUES (1725043562961457154, 1);
INSERT INTO `sys_user_role` VALUES (1725058936893362178, 1);
INSERT INTO `sys_user_role` VALUES (1725363117009162242, 1);
INSERT INTO `sys_user_role` VALUES (1725538633251049474, 1);
INSERT INTO `sys_user_role` VALUES (1725564937467875329, 1);
INSERT INTO `sys_user_role` VALUES (1725891713243021314, 1);
INSERT INTO `sys_user_role` VALUES (1725905000621932546, 1);
INSERT INTO `sys_user_role` VALUES (1726440708294049793, 1);
INSERT INTO `sys_user_role` VALUES (1726443526979584002, 1);
INSERT INTO `sys_user_role` VALUES (1726445663797116929, 1);
INSERT INTO `sys_user_role` VALUES (1726452867329687553, 1);
INSERT INTO `sys_user_role` VALUES (1726472827451998209, 1);
INSERT INTO `sys_user_role` VALUES (1726479651370696705, 1);
INSERT INTO `sys_user_role` VALUES (1726487492674195458, 1);
INSERT INTO `sys_user_role` VALUES (1726496513055784961, 1);
INSERT INTO `sys_user_role` VALUES (1726498781398302722, 1);
INSERT INTO `sys_user_role` VALUES (1726506873632587778, 1);
INSERT INTO `sys_user_role` VALUES (1726529248394739714, 1);
INSERT INTO `sys_user_role` VALUES (1726578079102664705, 1);
INSERT INTO `sys_user_role` VALUES (1726582181383634946, 1);
INSERT INTO `sys_user_role` VALUES (1726583555672506369, 1);
INSERT INTO `sys_user_role` VALUES (1726596448690372609, 1);
INSERT INTO `sys_user_role` VALUES (1726599361261207553, 1);
INSERT INTO `sys_user_role` VALUES (1726604511749079041, 1);
INSERT INTO `sys_user_role` VALUES (1726606973822304258, 1);
INSERT INTO `sys_user_role` VALUES (1726609379524083713, 1);
INSERT INTO `sys_user_role` VALUES (1726616151265640450, 1);
INSERT INTO `sys_user_role` VALUES (1726775811478126594, 1);
INSERT INTO `sys_user_role` VALUES (1726795490141667329, 1);
INSERT INTO `sys_user_role` VALUES (1726798403169681410, 1);
INSERT INTO `sys_user_role` VALUES (1726830794655399937, 1);
INSERT INTO `sys_user_role` VALUES (1726862038013313026, 1);
INSERT INTO `sys_user_role` VALUES (1726919220696186882, 1);
INSERT INTO `sys_user_role` VALUES (1727140184050630658, 1);
INSERT INTO `sys_user_role` VALUES (1727506163368722433, 1);
INSERT INTO `sys_user_role` VALUES (1727518983086931969, 1);
INSERT INTO `sys_user_role` VALUES (1727580969606840321, 1);
INSERT INTO `sys_user_role` VALUES (1727590505323429890, 1);
INSERT INTO `sys_user_role` VALUES (1727918393172164609, 1);
INSERT INTO `sys_user_role` VALUES (1728249002000121857, 1);
INSERT INTO `sys_user_role` VALUES (1728680561446486017, 1);
INSERT INTO `sys_user_role` VALUES (1728964404182577153, 1);
INSERT INTO `sys_user_role` VALUES (1729020459675611137, 1);
INSERT INTO `sys_user_role` VALUES (1729051002043691009, 1);
INSERT INTO `sys_user_role` VALUES (1729423744832172033, 1);
INSERT INTO `sys_user_role` VALUES (1729429590291050497, 1);
INSERT INTO `sys_user_role` VALUES (1729685493222375426, 1729685491108446210);
INSERT INTO `sys_user_role` VALUES (1730050324466036738, 1);
INSERT INTO `sys_user_role` VALUES (1730102403335254018, 1);
INSERT INTO `sys_user_role` VALUES (1730129923250122754, 1);
INSERT INTO `sys_user_role` VALUES (1730155108925763586, 1);
INSERT INTO `sys_user_role` VALUES (1730273428207366145, 1);
INSERT INTO `sys_user_role` VALUES (1730498722784669697, 1);
INSERT INTO `sys_user_role` VALUES (1730815105229713410, 1);
INSERT INTO `sys_user_role` VALUES (1730858886951923714, 1);
INSERT INTO `sys_user_role` VALUES (1731357405659824130, 1);
INSERT INTO `sys_user_role` VALUES (1731475532557090818, 1);
INSERT INTO `sys_user_role` VALUES (1731480953627901953, 1);
INSERT INTO `sys_user_role` VALUES (1731502381106495490, 1);
INSERT INTO `sys_user_role` VALUES (1731524458442162177, 1);
INSERT INTO `sys_user_role` VALUES (1731524630094053377, 1);
INSERT INTO `sys_user_role` VALUES (1731524650293821441, 1);
INSERT INTO `sys_user_role` VALUES (1731529253710233601, 1);
INSERT INTO `sys_user_role` VALUES (1731559936046432258, 1);
INSERT INTO `sys_user_role` VALUES (1731564032228884482, 1);
INSERT INTO `sys_user_role` VALUES (1731565926737281026, 1);
INSERT INTO `sys_user_role` VALUES (1731566918589513729, 1);
INSERT INTO `sys_user_role` VALUES (1731567740094283778, 1);
INSERT INTO `sys_user_role` VALUES (1731575439263563777, 1);
INSERT INTO `sys_user_role` VALUES (1731583864055824385, 1);
INSERT INTO `sys_user_role` VALUES (1731588155382464513, 1);
INSERT INTO `sys_user_role` VALUES (1731589827840212993, 1);
INSERT INTO `sys_user_role` VALUES (1731635461435719682, 1);
INSERT INTO `sys_user_role` VALUES (1731668049902731266, 1);
INSERT INTO `sys_user_role` VALUES (1731922694168412162, 1);
INSERT INTO `sys_user_role` VALUES (1731944975456305153, 1);
INSERT INTO `sys_user_role` VALUES (1731949019394506753, 1);
INSERT INTO `sys_user_role` VALUES (1731951425054343170, 1);
INSERT INTO `sys_user_role` VALUES (1732000242621513729, 1);
INSERT INTO `sys_user_role` VALUES (1732027163380056066, 1);
INSERT INTO `sys_user_role` VALUES (1732289382269353985, 1);
INSERT INTO `sys_user_role` VALUES (1732289439282528258, 1);
INSERT INTO `sys_user_role` VALUES (1732289699585228801, 1);
INSERT INTO `sys_user_role` VALUES (1732290827173527553, 1);
INSERT INTO `sys_user_role` VALUES (1732291549344595969, 1);
INSERT INTO `sys_user_role` VALUES (1732293265184030721, 1);
INSERT INTO `sys_user_role` VALUES (1732329664117506049, 1);
INSERT INTO `sys_user_role` VALUES (1732334104450990081, 1);
INSERT INTO `sys_user_role` VALUES (1732578671045672962, 1);
INSERT INTO `sys_user_role` VALUES (1732584047426174978, 1);
INSERT INTO `sys_user_role` VALUES (1732608690321129474, 1);
INSERT INTO `sys_user_role` VALUES (1732678147815014401, 1);
INSERT INTO `sys_user_role` VALUES (1732731410102910977, 1);
INSERT INTO `sys_user_role` VALUES (1733005266763939841, 1);
INSERT INTO `sys_user_role` VALUES (1733016149837774850, 1);
INSERT INTO `sys_user_role` VALUES (1733053523871432705, 1);
INSERT INTO `sys_user_role` VALUES (1733061400367497218, 1);
INSERT INTO `sys_user_role` VALUES (1733167090469732353, 1);
INSERT INTO `sys_user_role` VALUES (1733298702729641986, 1);
INSERT INTO `sys_user_role` VALUES (1733488544511983617, 1);
INSERT INTO `sys_user_role` VALUES (1733720554119659521, 1);
INSERT INTO `sys_user_role` VALUES (1733846657777827842, 1);
INSERT INTO `sys_user_role` VALUES (1733859832720031745, 1);
INSERT INTO `sys_user_role` VALUES (1734137817339559938, 1);
INSERT INTO `sys_user_role` VALUES (1734227535762849793, 1);
INSERT INTO `sys_user_role` VALUES (1734492373726560257, 1);
INSERT INTO `sys_user_role` VALUES (1734508040978726914, 1);
INSERT INTO `sys_user_role` VALUES (1734513545461661697, 1);
INSERT INTO `sys_user_role` VALUES (1734581580998451202, 1);
INSERT INTO `sys_user_role` VALUES (1734751884580298754, 1);
INSERT INTO `sys_user_role` VALUES (1734781716483612674, 1);
INSERT INTO `sys_user_role` VALUES (1734833221987278849, 1);
INSERT INTO `sys_user_role` VALUES (1734834063154946050, 1);
INSERT INTO `sys_user_role` VALUES (1734880697666576386, 1);
INSERT INTO `sys_user_role` VALUES (1734891995888427009, 1);
INSERT INTO `sys_user_role` VALUES (1735132534701367297, 1);
INSERT INTO `sys_user_role` VALUES (1735242647239991298, 1);
INSERT INTO `sys_user_role` VALUES (1735486862444273666, 1);
INSERT INTO `sys_user_role` VALUES (1735487912727355394, 1);
INSERT INTO `sys_user_role` VALUES (1735542352767426561, 1);
INSERT INTO `sys_user_role` VALUES (1735551915889598466, 1);
INSERT INTO `sys_user_role` VALUES (1735616653411557377, 1);
INSERT INTO `sys_user_role` VALUES (1735835864146714626, 1);
INSERT INTO `sys_user_role` VALUES (1735953007769100289, 1);
INSERT INTO `sys_user_role` VALUES (1735960189784891393, 1);
INSERT INTO `sys_user_role` VALUES (1736265950381547522, 1);
INSERT INTO `sys_user_role` VALUES (1736577606684844034, 1);
INSERT INTO `sys_user_role` VALUES (1736638822375563266, 1);
INSERT INTO `sys_user_role` VALUES (1736779069306511361, 1);
INSERT INTO `sys_user_role` VALUES (1737028378602053634, 1);
INSERT INTO `sys_user_role` VALUES (1737271234797314050, 1);
INSERT INTO `sys_user_role` VALUES (1737315322405920770, 1);
INSERT INTO `sys_user_role` VALUES (1737445221154234370, 1);
INSERT INTO `sys_user_role` VALUES (1737452907568635906, 1);
INSERT INTO `sys_user_role` VALUES (1737453186955419649, 1);
INSERT INTO `sys_user_role` VALUES (1737717777685880833, 1);
INSERT INTO `sys_user_role` VALUES (1737768515594166274, 1);
INSERT INTO `sys_user_role` VALUES (1738108912170246145, 1);
INSERT INTO `sys_user_role` VALUES (1738118086488825858, 1);
INSERT INTO `sys_user_role` VALUES (1738520430804279297, 1);
INSERT INTO `sys_user_role` VALUES (1738802060248817666, 1);
INSERT INTO `sys_user_role` VALUES (1738812447119712257, 1);
INSERT INTO `sys_user_role` VALUES (1738941480197234689, 1);
INSERT INTO `sys_user_role` VALUES (1738963430776840194, 1);
INSERT INTO `sys_user_role` VALUES (1739121784341995522, 1);
INSERT INTO `sys_user_role` VALUES (1739166931951886338, 1);
INSERT INTO `sys_user_role` VALUES (1739272055240073217, 1);
INSERT INTO `sys_user_role` VALUES (1739451838930427905, 1);
INSERT INTO `sys_user_role` VALUES (1739452037375533057, 1);
INSERT INTO `sys_user_role` VALUES (1739452376946384898, 1);
INSERT INTO `sys_user_role` VALUES (1739484503888961537, 1);
INSERT INTO `sys_user_role` VALUES (1739485282335006722, 1);
INSERT INTO `sys_user_role` VALUES (1739577551431999490, 1);
INSERT INTO `sys_user_role` VALUES (1739825609910591489, 1);
INSERT INTO `sys_user_role` VALUES (1739916453439152130, 1);
INSERT INTO `sys_user_role` VALUES (1740188388454629378, 1);
INSERT INTO `sys_user_role` VALUES (1741339991320580097, 1);
INSERT INTO `sys_user_role` VALUES (1741803737633542145, 1);
INSERT INTO `sys_user_role` VALUES (1741823858229923841, 1);
INSERT INTO `sys_user_role` VALUES (1741845883943227393, 1);
INSERT INTO `sys_user_role` VALUES (1742179775941201921, 1);
INSERT INTO `sys_user_role` VALUES (1742437553771458562, 1);
INSERT INTO `sys_user_role` VALUES (1742451201315254273, 1);
INSERT INTO `sys_user_role` VALUES (1742469913120419841, 1);
INSERT INTO `sys_user_role` VALUES (1742798283280568321, 1);
INSERT INTO `sys_user_role` VALUES (1742798987701342210, 1);
INSERT INTO `sys_user_role` VALUES (1742799476950126594, 1);
INSERT INTO `sys_user_role` VALUES (1742799839619010562, 1);
INSERT INTO `sys_user_role` VALUES (1742801019527057410, 1);
INSERT INTO `sys_user_role` VALUES (1742804073915699202, 1);
INSERT INTO `sys_user_role` VALUES (1742821280687149058, 1);
INSERT INTO `sys_user_role` VALUES (1742821467476283394, 1);
INSERT INTO `sys_user_role` VALUES (1742822775600009217, 1);
INSERT INTO `sys_user_role` VALUES (1742823890928357377, 1);
INSERT INTO `sys_user_role` VALUES (1742838225297821697, 1);
INSERT INTO `sys_user_role` VALUES (1742902317295423490, 1);
INSERT INTO `sys_user_role` VALUES (1742910854243373058, 1);
INSERT INTO `sys_user_role` VALUES (1742961994725150721, 1);
INSERT INTO `sys_user_role` VALUES (1742969861079388161, 1);
INSERT INTO `sys_user_role` VALUES (1743068363130228737, 1);
INSERT INTO `sys_user_role` VALUES (1743075924621479938, 1);
INSERT INTO `sys_user_role` VALUES (1743079200725225474, 1);
INSERT INTO `sys_user_role` VALUES (1743085878682144769, 1);
INSERT INTO `sys_user_role` VALUES (1743110774967586818, 1);
INSERT INTO `sys_user_role` VALUES (1743162481042870274, 1);
INSERT INTO `sys_user_role` VALUES (1743166491284033537, 1);
INSERT INTO `sys_user_role` VALUES (1743251016219447297, 1);
INSERT INTO `sys_user_role` VALUES (1743469820367142914, 1);
INSERT INTO `sys_user_role` VALUES (1743514389280522242, 1);
INSERT INTO `sys_user_role` VALUES (1743519646916083714, 1);
INSERT INTO `sys_user_role` VALUES (1743670356026654722, 1);
INSERT INTO `sys_user_role` VALUES (1743892570516815874, 1);
INSERT INTO `sys_user_role` VALUES (1743952049409146882, 1);
INSERT INTO `sys_user_role` VALUES (1744268693259993089, 1);
INSERT INTO `sys_user_role` VALUES (1744351384550567938, 1);
INSERT INTO `sys_user_role` VALUES (1744561041202278402, 1);
INSERT INTO `sys_user_role` VALUES (1744574752277196801, 1);
INSERT INTO `sys_user_role` VALUES (1744619123995373569, 1);
INSERT INTO `sys_user_role` VALUES (1744627110742913025, 1);
INSERT INTO `sys_user_role` VALUES (1744634408357916673, 1);
INSERT INTO `sys_user_role` VALUES (1744645281965207554, 1);
INSERT INTO `sys_user_role` VALUES (1744724410316156930, 1);
INSERT INTO `sys_user_role` VALUES (1744892307919400962, 1);
INSERT INTO `sys_user_role` VALUES (1744903174606090241, 1);
INSERT INTO `sys_user_role` VALUES (1744904968014983169, 1);
INSERT INTO `sys_user_role` VALUES (1744905787204497410, 1);
INSERT INTO `sys_user_role` VALUES (1744911513595473921, 1);
INSERT INTO `sys_user_role` VALUES (1744912178359103490, 1);
INSERT INTO `sys_user_role` VALUES (1744912486720139266, 1);
INSERT INTO `sys_user_role` VALUES (1744915552240463874, 1);
INSERT INTO `sys_user_role` VALUES (1744923917133869058, 1);
INSERT INTO `sys_user_role` VALUES (1744971513579761666, 1);
INSERT INTO `sys_user_role` VALUES (1744984070818426882, 1);
INSERT INTO `sys_user_role` VALUES (1744984147393835010, 1);
INSERT INTO `sys_user_role` VALUES (1744992401243041793, 1);
INSERT INTO `sys_user_role` VALUES (1745011131444424706, 1);
INSERT INTO `sys_user_role` VALUES (1745061549180514306, 1);
INSERT INTO `sys_user_role` VALUES (1745346479991091201, 1);
INSERT INTO `sys_user_role` VALUES (1745346822607007745, 1);
INSERT INTO `sys_user_role` VALUES (1745368346374217730, 1);
INSERT INTO `sys_user_role` VALUES (1745424741765259266, 1);
INSERT INTO `sys_user_role` VALUES (1745426757090582530, 1);
INSERT INTO `sys_user_role` VALUES (1745620173124575234, 1);
INSERT INTO `sys_user_role` VALUES (1745623876426571777, 1);
INSERT INTO `sys_user_role` VALUES (1745654577691664386, 1);
INSERT INTO `sys_user_role` VALUES (1745663259879972865, 1);
INSERT INTO `sys_user_role` VALUES (1745686038692012034, 1);
INSERT INTO `sys_user_role` VALUES (1745738268480675842, 1);
INSERT INTO `sys_user_role` VALUES (1745790952546017281, 1);
INSERT INTO `sys_user_role` VALUES (1746397384551211009, 1);
INSERT INTO `sys_user_role` VALUES (1746400980533551105, 1);
INSERT INTO `sys_user_role` VALUES (1746522414111039489, 1);
INSERT INTO `sys_user_role` VALUES (1746873386528223234, 1);
INSERT INTO `sys_user_role` VALUES (1747067318369333249, 1);
INSERT INTO `sys_user_role` VALUES (1747071365822361602, 1);
INSERT INTO `sys_user_role` VALUES (1747153912031948801, 1);
INSERT INTO `sys_user_role` VALUES (1747197655195922434, 1);
INSERT INTO `sys_user_role` VALUES (1747519480203390977, 1);
INSERT INTO `sys_user_role` VALUES (1747521265550831618, 1);
INSERT INTO `sys_user_role` VALUES (1747523421662162945, 1);
INSERT INTO `sys_user_role` VALUES (1747797864993075201, 1);
INSERT INTO `sys_user_role` VALUES (1747800427213697025, 1);
INSERT INTO `sys_user_role` VALUES (1747910191046275073, 1);
INSERT INTO `sys_user_role` VALUES (1747923453217419265, 1);
INSERT INTO `sys_user_role` VALUES (1748187110132232193, 1);
INSERT INTO `sys_user_role` VALUES (1748260926648823809, 1);
INSERT INTO `sys_user_role` VALUES (1748276826697445377, 1);
INSERT INTO `sys_user_role` VALUES (1748312313952808962, 1);
INSERT INTO `sys_user_role` VALUES (1748635584837529601, 1);
INSERT INTO `sys_user_role` VALUES (1748642479459610625, 1);
INSERT INTO `sys_user_role` VALUES (1748663294624346114, 1);
INSERT INTO `sys_user_role` VALUES (1748703876608503810, 1);
INSERT INTO `sys_user_role` VALUES (1748704145589219329, 1);
INSERT INTO `sys_user_role` VALUES (1748708285178523649, 1);
INSERT INTO `sys_user_role` VALUES (1748728575929430017, 1);
INSERT INTO `sys_user_role` VALUES (1748761666442047490, 1);
INSERT INTO `sys_user_role` VALUES (1748925826178035713, 1);
INSERT INTO `sys_user_role` VALUES (1749259130492235778, 1);
INSERT INTO `sys_user_role` VALUES (1749280237328871426, 1);
INSERT INTO `sys_user_role` VALUES (1749289400549322754, 1);
INSERT INTO `sys_user_role` VALUES (1749327661225291778, 1);
INSERT INTO `sys_user_role` VALUES (1749365593797636097, 1);
INSERT INTO `sys_user_role` VALUES (1749407786692325378, 1);
INSERT INTO `sys_user_role` VALUES (1749519043344805890, 1);
INSERT INTO `sys_user_role` VALUES (1749683041063219202, 1);
INSERT INTO `sys_user_role` VALUES (1749683546774646786, 1);
INSERT INTO `sys_user_role` VALUES (1749691765567860737, 1);
INSERT INTO `sys_user_role` VALUES (1749705571236917249, 1);
INSERT INTO `sys_user_role` VALUES (1749740828837359618, 1);
INSERT INTO `sys_user_role` VALUES (1749741179162406914, 1);
INSERT INTO `sys_user_role` VALUES (1749741340039131137, 1);
INSERT INTO `sys_user_role` VALUES (1749747618241130497, 1);
INSERT INTO `sys_user_role` VALUES (1749747701439344641, 1);
INSERT INTO `sys_user_role` VALUES (1749786825391157250, 1);
INSERT INTO `sys_user_role` VALUES (1749789665819963394, 1);
INSERT INTO `sys_user_role` VALUES (1749797707705823234, 1);
INSERT INTO `sys_user_role` VALUES (1749974903762210818, 1);
INSERT INTO `sys_user_role` VALUES (1749982777750081537, 1);
INSERT INTO `sys_user_role` VALUES (1749990634667134978, 1);
INSERT INTO `sys_user_role` VALUES (1749991325137653761, 1);
INSERT INTO `sys_user_role` VALUES (1749992779328016386, 1);
INSERT INTO `sys_user_role` VALUES (1749993573204905985, 1);
INSERT INTO `sys_user_role` VALUES (1749994406877351937, 1);
INSERT INTO `sys_user_role` VALUES (1749995279187726337, 1);
INSERT INTO `sys_user_role` VALUES (1749995486029828097, 1);
INSERT INTO `sys_user_role` VALUES (1749995707686211586, 1);
INSERT INTO `sys_user_role` VALUES (1750000406883749890, 1);
INSERT INTO `sys_user_role` VALUES (1750000942706085889, 1);
INSERT INTO `sys_user_role` VALUES (1750005079111913473, 1);
INSERT INTO `sys_user_role` VALUES (1750428606466117633, 1);
INSERT INTO `sys_user_role` VALUES (1750553534423126017, 1);
INSERT INTO `sys_user_role` VALUES (1750690119441469441, 1);
INSERT INTO `sys_user_role` VALUES (1750723725312413698, 1);
INSERT INTO `sys_user_role` VALUES (1750724537434525697, 1);
INSERT INTO `sys_user_role` VALUES (1750743381616119810, 1);
INSERT INTO `sys_user_role` VALUES (1750822931356192769, 1);
INSERT INTO `sys_user_role` VALUES (1750823004563574785, 1);
INSERT INTO `sys_user_role` VALUES (1751548639330177026, 1);
INSERT INTO `sys_user_role` VALUES (1751796140318658561, 1);
INSERT INTO `sys_user_role` VALUES (1751889049818763265, 1);
INSERT INTO `sys_user_role` VALUES (1751896081141600258, 1);
INSERT INTO `sys_user_role` VALUES (1751949653564723201, 1);
INSERT INTO `sys_user_role` VALUES (1751955373517443073, 1);
INSERT INTO `sys_user_role` VALUES (1751980511470292993, 1);
INSERT INTO `sys_user_role` VALUES (1752128867307884546, 1);
INSERT INTO `sys_user_role` VALUES (1752128948195037185, 1);
INSERT INTO `sys_user_role` VALUES (1752138835683708930, 1);
INSERT INTO `sys_user_role` VALUES (1752148500127682561, 1);
INSERT INTO `sys_user_role` VALUES (1752276638077816834, 1);
INSERT INTO `sys_user_role` VALUES (1752299834210521089, 1);
INSERT INTO `sys_user_role` VALUES (1752306117726703618, 1);
INSERT INTO `sys_user_role` VALUES (1752504006021222402, 1);
INSERT INTO `sys_user_role` VALUES (1752602885546840066, 1);
INSERT INTO `sys_user_role` VALUES (1752724639351050242, 1);
INSERT INTO `sys_user_role` VALUES (1753215436756357122, 1);
INSERT INTO `sys_user_role` VALUES (1753402656570216449, 1);
INSERT INTO `sys_user_role` VALUES (1753486557368029185, 1);
INSERT INTO `sys_user_role` VALUES (1753797902466551809, 1);
INSERT INTO `sys_user_role` VALUES (1753967757819908098, 1);
INSERT INTO `sys_user_role` VALUES (1754016754462887938, 1);
INSERT INTO `sys_user_role` VALUES (1754029247868440577, 1);
INSERT INTO `sys_user_role` VALUES (1754413960445562882, 1);
INSERT INTO `sys_user_role` VALUES (1754424078633537538, 1);
INSERT INTO `sys_user_role` VALUES (1754764137119354881, 1);
INSERT INTO `sys_user_role` VALUES (1755042084761899009, 1);
INSERT INTO `sys_user_role` VALUES (1755047141691625473, 1);
INSERT INTO `sys_user_role` VALUES (1756274975479173121, 1);
INSERT INTO `sys_user_role` VALUES (1756308183021260801, 1);
INSERT INTO `sys_user_role` VALUES (1757325877958938626, 1);
INSERT INTO `sys_user_role` VALUES (1758445439802675202, 1);
INSERT INTO `sys_user_role` VALUES (1759032628991234049, 1);
INSERT INTO `sys_user_role` VALUES (1759050804781125634, 1);
INSERT INTO `sys_user_role` VALUES (1759089524834045954, 1);
INSERT INTO `sys_user_role` VALUES (1759092949802029057, 1);
INSERT INTO `sys_user_role` VALUES (1759100324189573121, 1);
INSERT INTO `sys_user_role` VALUES (1759103449889771521, 1);
INSERT INTO `sys_user_role` VALUES (1759147026191749121, 1);
INSERT INTO `sys_user_role` VALUES (1759413482020147202, 1);
INSERT INTO `sys_user_role` VALUES (1759427862430486529, 1);
INSERT INTO `sys_user_role` VALUES (1759428010174844929, 1);
INSERT INTO `sys_user_role` VALUES (1759496088514465794, 1);
INSERT INTO `sys_user_role` VALUES (1759764705965510657, 1);
INSERT INTO `sys_user_role` VALUES (1759777481207320578, 1);
INSERT INTO `sys_user_role` VALUES (1759806155667279873, 1);
INSERT INTO `sys_user_role` VALUES (1759812015655227394, 1);
INSERT INTO `sys_user_role` VALUES (1759815447778693121, 1);
INSERT INTO `sys_user_role` VALUES (1759832486966726658, 1);
INSERT INTO `sys_user_role` VALUES (1759858071113830402, 1);
INSERT INTO `sys_user_role` VALUES (1759863475847827458, 1);
INSERT INTO `sys_user_role` VALUES (1759868018195173378, 1);
INSERT INTO `sys_user_role` VALUES (1759869729374736385, 1);
INSERT INTO `sys_user_role` VALUES (1760186079276175362, 1);
INSERT INTO `sys_user_role` VALUES (1760319626808922114, 1);
INSERT INTO `sys_user_role` VALUES (1760347236137963522, 1);
INSERT INTO `sys_user_role` VALUES (1760358546837868546, 1);
INSERT INTO `sys_user_role` VALUES (1760377107434180609, 1);
INSERT INTO `sys_user_role` VALUES (1760472305161998338, 1);
INSERT INTO `sys_user_role` VALUES (1760472829932343298, 1);
INSERT INTO `sys_user_role` VALUES (1760477732188721153, 1);
INSERT INTO `sys_user_role` VALUES (1760502088176504833, 1);
INSERT INTO `sys_user_role` VALUES (1760508166310203394, 1);
INSERT INTO `sys_user_role` VALUES (1760511294409543681, 1);
INSERT INTO `sys_user_role` VALUES (1760562604135682049, 1);
INSERT INTO `sys_user_role` VALUES (1760841877480280066, 1);
INSERT INTO `sys_user_role` VALUES (1760896840365510658, 1);
INSERT INTO `sys_user_role` VALUES (1760903600501428226, 1);
INSERT INTO `sys_user_role` VALUES (1761404022634844162, 1);
INSERT INTO `sys_user_role` VALUES (1761954868732891138, 1);
INSERT INTO `sys_user_role` VALUES (1761955584197267458, 1);
INSERT INTO `sys_user_role` VALUES (1762003524345401345, 1);
INSERT INTO `sys_user_role` VALUES (1762004833618366465, 1);
INSERT INTO `sys_user_role` VALUES (1762010183880937474, 1);
INSERT INTO `sys_user_role` VALUES (1762298283890839554, 1);
INSERT INTO `sys_user_role` VALUES (1762363188014747649, 1);
INSERT INTO `sys_user_role` VALUES (1762389902388367361, 1);
INSERT INTO `sys_user_role` VALUES (1762401081961746434, 1);
INSERT INTO `sys_user_role` VALUES (1762481911417540610, 1);
INSERT INTO `sys_user_role` VALUES (1762482221645041665, 1);
INSERT INTO `sys_user_role` VALUES (1762482243174404097, 1);
INSERT INTO `sys_user_role` VALUES (1762483838461153282, 1);
INSERT INTO `sys_user_role` VALUES (1762487212380262401, 1);
INSERT INTO `sys_user_role` VALUES (1762498553535008770, 1);
INSERT INTO `sys_user_role` VALUES (1762636163465138177, 1);
INSERT INTO `sys_user_role` VALUES (1762655625413185537, 1);
INSERT INTO `sys_user_role` VALUES (1762656108559257601, 1);
INSERT INTO `sys_user_role` VALUES (1762673833499217922, 1);
INSERT INTO `sys_user_role` VALUES (1762677825344163842, 1);
INSERT INTO `sys_user_role` VALUES (1762677876015550465, 1);
INSERT INTO `sys_user_role` VALUES (1762678082262061057, 1);
INSERT INTO `sys_user_role` VALUES (1762678138012749825, 1);
INSERT INTO `sys_user_role` VALUES (1762678144652333057, 1);
INSERT INTO `sys_user_role` VALUES (1762678174192816129, 1);
INSERT INTO `sys_user_role` VALUES (1762678472563019777, 1);
INSERT INTO `sys_user_role` VALUES (1762678534596775938, 1);
INSERT INTO `sys_user_role` VALUES (1762678534894571521, 1);
INSERT INTO `sys_user_role` VALUES (1762678581635895298, 1);
INSERT INTO `sys_user_role` VALUES (1762678844920745985, 1);
INSERT INTO `sys_user_role` VALUES (1762679194973163522, 1);
INSERT INTO `sys_user_role` VALUES (1762679425299173378, 1);
INSERT INTO `sys_user_role` VALUES (1762679810776682498, 1);
INSERT INTO `sys_user_role` VALUES (1762679862656028674, 1);
INSERT INTO `sys_user_role` VALUES (1762679937360777217, 1);
INSERT INTO `sys_user_role` VALUES (1762680184698884098, 1);
INSERT INTO `sys_user_role` VALUES (1762680290076577794, 1);
INSERT INTO `sys_user_role` VALUES (1762680350055124993, 1);
INSERT INTO `sys_user_role` VALUES (1762681014038614017, 1);
INSERT INTO `sys_user_role` VALUES (1762681042207559681, 1);
INSERT INTO `sys_user_role` VALUES (1762681082732924929, 1);
INSERT INTO `sys_user_role` VALUES (1762681088869191682, 1);
INSERT INTO `sys_user_role` VALUES (1762681283195490306, 1);
INSERT INTO `sys_user_role` VALUES (1762681876752420865, 1);
INSERT INTO `sys_user_role` VALUES (1762681980129431553, 1);
INSERT INTO `sys_user_role` VALUES (1762682038488977410, 1);
INSERT INTO `sys_user_role` VALUES (1762682208211488769, 1);
INSERT INTO `sys_user_role` VALUES (1762683406603833346, 1);
INSERT INTO `sys_user_role` VALUES (1762683500048732162, 1);
INSERT INTO `sys_user_role` VALUES (1762683740843724801, 1);
INSERT INTO `sys_user_role` VALUES (1762683806404890625, 1);
INSERT INTO `sys_user_role` VALUES (1762684131715108865, 1);
INSERT INTO `sys_user_role` VALUES (1762684408442703874, 1);
INSERT INTO `sys_user_role` VALUES (1762684686994821121, 1);
INSERT INTO `sys_user_role` VALUES (1762686405808017409, 1);
INSERT INTO `sys_user_role` VALUES (1762687370061729794, 1);
INSERT INTO `sys_user_role` VALUES (1762687537527705602, 1);
INSERT INTO `sys_user_role` VALUES (1762687814947360769, 1);
INSERT INTO `sys_user_role` VALUES (1762688734347186177, 1);
INSERT INTO `sys_user_role` VALUES (1762690035701305346, 1);
INSERT INTO `sys_user_role` VALUES (1762690104575971330, 1);
INSERT INTO `sys_user_role` VALUES (1762691273243283457, 1);
INSERT INTO `sys_user_role` VALUES (1762691277462753282, 1);
INSERT INTO `sys_user_role` VALUES (1762692468406013954, 1);
INSERT INTO `sys_user_role` VALUES (1762693304498573314, 1);
INSERT INTO `sys_user_role` VALUES (1762693710704332801, 1);
INSERT INTO `sys_user_role` VALUES (1762694382220791809, 1);
INSERT INTO `sys_user_role` VALUES (1762696242545610754, 1);
INSERT INTO `sys_user_role` VALUES (1762696275626086402, 1);
INSERT INTO `sys_user_role` VALUES (1762696945854894082, 1);
INSERT INTO `sys_user_role` VALUES (1762698940057702402, 1);
INSERT INTO `sys_user_role` VALUES (1762699511732948994, 1);
INSERT INTO `sys_user_role` VALUES (1762701338956320769, 1);
INSERT INTO `sys_user_role` VALUES (1762701352860438530, 1);
INSERT INTO `sys_user_role` VALUES (1762703221934575617, 1);
INSERT INTO `sys_user_role` VALUES (1762705239214444546, 1);
INSERT INTO `sys_user_role` VALUES (1762705858788642817, 1);
INSERT INTO `sys_user_role` VALUES (1762706220585111553, 1);
INSERT INTO `sys_user_role` VALUES (1762707979655237633, 1);
INSERT INTO `sys_user_role` VALUES (1762709372369686529, 1);
INSERT INTO `sys_user_role` VALUES (1762717698755186689, 1);
INSERT INTO `sys_user_role` VALUES (1762719280540471297, 1);
INSERT INTO `sys_user_role` VALUES (1762719395619590146, 1);
INSERT INTO `sys_user_role` VALUES (1762721161459322881, 1);
INSERT INTO `sys_user_role` VALUES (1762721300685049857, 1);
INSERT INTO `sys_user_role` VALUES (1762724284441612290, 1);
INSERT INTO `sys_user_role` VALUES (1762728759105474561, 1);
INSERT INTO `sys_user_role` VALUES (1762732886506131458, 1);
INSERT INTO `sys_user_role` VALUES (1762744418904354818, 1);
INSERT INTO `sys_user_role` VALUES (1762749711537188865, 1);
INSERT INTO `sys_user_role` VALUES (1762749741056700418, 1);
INSERT INTO `sys_user_role` VALUES (1762750396991320065, 1);
INSERT INTO `sys_user_role` VALUES (1762752966828797954, 1);
INSERT INTO `sys_user_role` VALUES (1762753464445218817, 1);
INSERT INTO `sys_user_role` VALUES (1762753558548623362, 1);
INSERT INTO `sys_user_role` VALUES (1762755306625478657, 1);
INSERT INTO `sys_user_role` VALUES (1762756726481268737, 1);
INSERT INTO `sys_user_role` VALUES (1762756744172843010, 1);
INSERT INTO `sys_user_role` VALUES (1762760948073410562, 1);
INSERT INTO `sys_user_role` VALUES (1762768424588062721, 1);
INSERT INTO `sys_user_role` VALUES (1762770353779159041, 1);
INSERT INTO `sys_user_role` VALUES (1762770690174922754, 1);
INSERT INTO `sys_user_role` VALUES (1762773352299671554, 1);
INSERT INTO `sys_user_role` VALUES (1762809323107954689, 1);
INSERT INTO `sys_user_role` VALUES (1762839585439133698, 1);
INSERT INTO `sys_user_role` VALUES (1762854389474177026, 1);
INSERT INTO `sys_user_role` VALUES (1762962461110611969, 1);
INSERT INTO `sys_user_role` VALUES (1763011242199920642, 1);
INSERT INTO `sys_user_role` VALUES (1763014994155843586, 1);
INSERT INTO `sys_user_role` VALUES (1763017291741048833, 1);
INSERT INTO `sys_user_role` VALUES (1763021759299760129, 1);
INSERT INTO `sys_user_role` VALUES (1763033286434140162, 1);
INSERT INTO `sys_user_role` VALUES (1763034914528735233, 1);
INSERT INTO `sys_user_role` VALUES (1763039329885138945, 1);
INSERT INTO `sys_user_role` VALUES (1763046791925248001, 1);
INSERT INTO `sys_user_role` VALUES (1763059898533851137, 1);
INSERT INTO `sys_user_role` VALUES (1763074956366229505, 1);
INSERT INTO `sys_user_role` VALUES (1763083906738335746, 1);
INSERT INTO `sys_user_role` VALUES (1763087371808059394, 1);
INSERT INTO `sys_user_role` VALUES (1763110723763351554, 1);
INSERT INTO `sys_user_role` VALUES (1763119583433633794, 1);
INSERT INTO `sys_user_role` VALUES (1763121912195100674, 1);
INSERT INTO `sys_user_role` VALUES (1763150617374142466, 1);
INSERT INTO `sys_user_role` VALUES (1763219512067928065, 1);
INSERT INTO `sys_user_role` VALUES (1763232955600777217, 1);
INSERT INTO `sys_user_role` VALUES (1763234635201425410, 1);
INSERT INTO `sys_user_role` VALUES (1763246126281568257, 1);
INSERT INTO `sys_user_role` VALUES (1763323873230106626, 1);
INSERT INTO `sys_user_role` VALUES (1763384782623387650, 1);
INSERT INTO `sys_user_role` VALUES (1763386804647014401, 1);
INSERT INTO `sys_user_role` VALUES (1763396269777661953, 1);
INSERT INTO `sys_user_role` VALUES (1763405607485353985, 1);
INSERT INTO `sys_user_role` VALUES (1763432831823425537, 1);
INSERT INTO `sys_user_role` VALUES (1763453676952268802, 1);
INSERT INTO `sys_user_role` VALUES (1763456811204653057, 1);
INSERT INTO `sys_user_role` VALUES (1763461579713064962, 1);
INSERT INTO `sys_user_role` VALUES (1763491204732379137, 1);
INSERT INTO `sys_user_role` VALUES (1763497378051612674, 1);
INSERT INTO `sys_user_role` VALUES (1763559058706096130, 1);
INSERT INTO `sys_user_role` VALUES (1763577018824876033, 1);
INSERT INTO `sys_user_role` VALUES (1763633124087521281, 1);
INSERT INTO `sys_user_role` VALUES (1763886812869775362, 1);
INSERT INTO `sys_user_role` VALUES (1763913997563285506, 1);
INSERT INTO `sys_user_role` VALUES (1764173595432013826, 1);
INSERT INTO `sys_user_role` VALUES (1764261292183998465, 1);
INSERT INTO `sys_user_role` VALUES (1764287995094585346, 1);
INSERT INTO `sys_user_role` VALUES (1764461290695774209, 1);
INSERT INTO `sys_user_role` VALUES (1764474718197993473, 1);
INSERT INTO `sys_user_role` VALUES (1764482496870305794, 1);
INSERT INTO `sys_user_role` VALUES (1764495637402439682, 1);
INSERT INTO `sys_user_role` VALUES (1764498159743619073, 1);
INSERT INTO `sys_user_role` VALUES (1764498751559913473, 1);
INSERT INTO `sys_user_role` VALUES (1764514945641828354, 1);
INSERT INTO `sys_user_role` VALUES (1764519088087453698, 1);
INSERT INTO `sys_user_role` VALUES (1764520899728986114, 1);
INSERT INTO `sys_user_role` VALUES (1764525084016988161, 1);
INSERT INTO `sys_user_role` VALUES (1764539443405475842, 1);
INSERT INTO `sys_user_role` VALUES (1764564174649249794, 1);
INSERT INTO `sys_user_role` VALUES (1764583176607977474, 1);
INSERT INTO `sys_user_role` VALUES (1764607755468505089, 1);
INSERT INTO `sys_user_role` VALUES (1764634462757920770, 1);
INSERT INTO `sys_user_role` VALUES (1764827973771915265, 1);
INSERT INTO `sys_user_role` VALUES (1764831906313596929, 1);
INSERT INTO `sys_user_role` VALUES (1764857801929715713, 1);
INSERT INTO `sys_user_role` VALUES (1764882243925913602, 1);
INSERT INTO `sys_user_role` VALUES (1764897874259816449, 1);
INSERT INTO `sys_user_role` VALUES (1764945289142677505, 1);
INSERT INTO `sys_user_role` VALUES (1764973230396354562, 1);
INSERT INTO `sys_user_role` VALUES (1765026702110044161, 1);
INSERT INTO `sys_user_role` VALUES (1765029529888829441, 1);
INSERT INTO `sys_user_role` VALUES (1765032464647532546, 1);
INSERT INTO `sys_user_role` VALUES (1765189908342321154, 1);
INSERT INTO `sys_user_role` VALUES (1765214567611838465, 1);
INSERT INTO `sys_user_role` VALUES (1765219002413035521, 1);
INSERT INTO `sys_user_role` VALUES (1765220951434801153, 1);
INSERT INTO `sys_user_role` VALUES (1765248990147325954, 1);
INSERT INTO `sys_user_role` VALUES (1765249652247572481, 1);
INSERT INTO `sys_user_role` VALUES (1765256689840893953, 1);
INSERT INTO `sys_user_role` VALUES (1765258070287003649, 1);
INSERT INTO `sys_user_role` VALUES (1765276219292069890, 1);
INSERT INTO `sys_user_role` VALUES (1765276256986279938, 1);
INSERT INTO `sys_user_role` VALUES (1765288006737539074, 1);
INSERT INTO `sys_user_role` VALUES (1765312970979094529, 1);
INSERT INTO `sys_user_role` VALUES (1765626857976840193, 1);
INSERT INTO `sys_user_role` VALUES (1765662415604236289, 1);
INSERT INTO `sys_user_role` VALUES (1765673187432546306, 1);
INSERT INTO `sys_user_role` VALUES (1765733893087510530, 1);
INSERT INTO `sys_user_role` VALUES (1765927148689326081, 1);
INSERT INTO `sys_user_role` VALUES (1765946481549279233, 1);
INSERT INTO `sys_user_role` VALUES (1765987575418880002, 1);
INSERT INTO `sys_user_role` VALUES (1765991619675848705, 1);
INSERT INTO `sys_user_role` VALUES (1765997037533822977, 1);
INSERT INTO `sys_user_role` VALUES (1766008273063411714, 1);
INSERT INTO `sys_user_role` VALUES (1766011496348286978, 1);
INSERT INTO `sys_user_role` VALUES (1766017335771561986, 1);
INSERT INTO `sys_user_role` VALUES (1766020112446947329, 1);
INSERT INTO `sys_user_role` VALUES (1766085955713269762, 1);
INSERT INTO `sys_user_role` VALUES (1766102635604639746, 1);
INSERT INTO `sys_user_role` VALUES (1766323008493355009, 1);
INSERT INTO `sys_user_role` VALUES (1766387294112612353, 1);
INSERT INTO `sys_user_role` VALUES (1766842982618136577, 1);
INSERT INTO `sys_user_role` VALUES (1767018925722730497, 1);
INSERT INTO `sys_user_role` VALUES (1767098572703563778, 1);
INSERT INTO `sys_user_role` VALUES (1767193870939488258, 1);
INSERT INTO `sys_user_role` VALUES (1767371461667356673, 1);
INSERT INTO `sys_user_role` VALUES (1767472876167397377, 1);
INSERT INTO `sys_user_role` VALUES (1767484503956684801, 1);
INSERT INTO `sys_user_role` VALUES (1767494435045146626, 1);
INSERT INTO `sys_user_role` VALUES (1767502928200368129, 1);
INSERT INTO `sys_user_role` VALUES (1767790695329333250, 1);
INSERT INTO `sys_user_role` VALUES (1767797421759823874, 1);
INSERT INTO `sys_user_role` VALUES (1767867514107756545, 1);
INSERT INTO `sys_user_role` VALUES (1768123513418842114, 1);
INSERT INTO `sys_user_role` VALUES (1768125846164897794, 1);
INSERT INTO `sys_user_role` VALUES (1768137512021688322, 1);
INSERT INTO `sys_user_role` VALUES (1768172797870768129, 1);
INSERT INTO `sys_user_role` VALUES (1768257272084463617, 1);
INSERT INTO `sys_user_role` VALUES (1768452168263172097, 1);
INSERT INTO `sys_user_role` VALUES (1768487959811096578, 1);
INSERT INTO `sys_user_role` VALUES (1768522172358754306, 1);
INSERT INTO `sys_user_role` VALUES (1768523379651411969, 1);
INSERT INTO `sys_user_role` VALUES (1768528826072596482, 1);
INSERT INTO `sys_user_role` VALUES (1768554562896560130, 1);
INSERT INTO `sys_user_role` VALUES (1768560191165988866, 1);
INSERT INTO `sys_user_role` VALUES (1768560307197214722, 1);
INSERT INTO `sys_user_role` VALUES (1768561334289989633, 1);
INSERT INTO `sys_user_role` VALUES (1768565063735083009, 1);
INSERT INTO `sys_user_role` VALUES (1768570261782167553, 1);
INSERT INTO `sys_user_role` VALUES (1768598711431626753, 1);
INSERT INTO `sys_user_role` VALUES (1768635967806668802, 1);
INSERT INTO `sys_user_role` VALUES (1768887604487946241, 1);
INSERT INTO `sys_user_role` VALUES (1768911351987077122, 1);
INSERT INTO `sys_user_role` VALUES (1769186172289449986, 1);
INSERT INTO `sys_user_role` VALUES (1769408371134857218, 1);
INSERT INTO `sys_user_role` VALUES (1769520576635371521, 1);
INSERT INTO `sys_user_role` VALUES (1769561862704758786, 1);
INSERT INTO `sys_user_role` VALUES (1769569234722521089, 1);
INSERT INTO `sys_user_role` VALUES (1769607528399273986, 1);
INSERT INTO `sys_user_role` VALUES (1769617177890553857, 1);
INSERT INTO `sys_user_role` VALUES (1769663440459694082, 1);
INSERT INTO `sys_user_role` VALUES (1769908456541233154, 1);
INSERT INTO `sys_user_role` VALUES (1769957357877043201, 1);
INSERT INTO `sys_user_role` VALUES (1770021611783168002, 1);
INSERT INTO `sys_user_role` VALUES (1770063295095087106, 1);
INSERT INTO `sys_user_role` VALUES (1770063700436819970, 1);
INSERT INTO `sys_user_role` VALUES (1770281104395837442, 1);
INSERT INTO `sys_user_role` VALUES (1770288338521661441, 1);
INSERT INTO `sys_user_role` VALUES (1770322814056333313, 1);
INSERT INTO `sys_user_role` VALUES (1770338641849679874, 1);
INSERT INTO `sys_user_role` VALUES (1770351581952802817, 1);
INSERT INTO `sys_user_role` VALUES (1770357305466486786, 1);
INSERT INTO `sys_user_role` VALUES (1770364755406028802, 1);
INSERT INTO `sys_user_role` VALUES (1770381062524436482, 1);
INSERT INTO `sys_user_role` VALUES (1770470677998534657, 1);
INSERT INTO `sys_user_role` VALUES (1770642413331218434, 1);
INSERT INTO `sys_user_role` VALUES (1770648858382630914, 1);
INSERT INTO `sys_user_role` VALUES (1770715116272680962, 1);
INSERT INTO `sys_user_role` VALUES (1770720646688997377, 1);
INSERT INTO `sys_user_role` VALUES (1770726609303175170, 1);
INSERT INTO `sys_user_role` VALUES (1770757521378181121, 1);
INSERT INTO `sys_user_role` VALUES (1770759021907214338, 1);
INSERT INTO `sys_user_role` VALUES (1771002145573240833, 1);
INSERT INTO `sys_user_role` VALUES (1771019340902629377, 1);
INSERT INTO `sys_user_role` VALUES (1771085212270788610, 1);
INSERT INTO `sys_user_role` VALUES (1771091102206066689, 1);
INSERT INTO `sys_user_role` VALUES (1771105696307806210, 1);
INSERT INTO `sys_user_role` VALUES (1771529088861274114, 1);
INSERT INTO `sys_user_role` VALUES (1772148936234565634, 1);
INSERT INTO `sys_user_role` VALUES (1772170742823714818, 1);
INSERT INTO `sys_user_role` VALUES (1772173596070313986, 1);
INSERT INTO `sys_user_role` VALUES (1772181791232819201, 1);
INSERT INTO `sys_user_role` VALUES (1772807697592832001, 1);
INSERT INTO `sys_user_role` VALUES (1772821509767254018, 1);
INSERT INTO `sys_user_role` VALUES (1772947270113251330, 1);
INSERT INTO `sys_user_role` VALUES (1773149840576434178, 1);
INSERT INTO `sys_user_role` VALUES (1773180693536919554, 1);
INSERT INTO `sys_user_role` VALUES (1773192472325345282, 1);
INSERT INTO `sys_user_role` VALUES (1773200350612377601, 1);
INSERT INTO `sys_user_role` VALUES (1773307685607395329, 1);
INSERT INTO `sys_user_role` VALUES (1773529379840282625, 1);
INSERT INTO `sys_user_role` VALUES (1773543535003914241, 1);
INSERT INTO `sys_user_role` VALUES (1773615949826052097, 1);
INSERT INTO `sys_user_role` VALUES (1773714968015278082, 1);
INSERT INTO `sys_user_role` VALUES (1773741523022123010, 1);
INSERT INTO `sys_user_role` VALUES (1773774290929848321, 1);
INSERT INTO `sys_user_role` VALUES (1773969452180258818, 1);
INSERT INTO `sys_user_role` VALUES (1774094144111198210, 1);
INSERT INTO `sys_user_role` VALUES (1774326191970926594, 1);
INSERT INTO `sys_user_role` VALUES (1774595110106685441, 1);
INSERT INTO `sys_user_role` VALUES (1774603290157113346, 1);
INSERT INTO `sys_user_role` VALUES (1774671916088287233, 1);
INSERT INTO `sys_user_role` VALUES (1774712059876728833, 1);
INSERT INTO `sys_user_role` VALUES (1775005868787359746, 1);
INSERT INTO `sys_user_role` VALUES (1775039514470637569, 1);
INSERT INTO `sys_user_role` VALUES (1775046202846208002, 1);
INSERT INTO `sys_user_role` VALUES (1775055115012399106, 1);
INSERT INTO `sys_user_role` VALUES (1775058985780371458, 1);
INSERT INTO `sys_user_role` VALUES (1775066829695082497, 1);
INSERT INTO `sys_user_role` VALUES (1775078808497283074, 1);
INSERT INTO `sys_user_role` VALUES (1775109977754427393, 1);
INSERT INTO `sys_user_role` VALUES (1775109977771204609, 1);
INSERT INTO `sys_user_role` VALUES (1775192704981786626, 1);
INSERT INTO `sys_user_role` VALUES (1775421589681987586, 1);
INSERT INTO `sys_user_role` VALUES (1776124571507613697, 1);
INSERT INTO `sys_user_role` VALUES (1776550027549597698, 1);
INSERT INTO `sys_user_role` VALUES (1776815081159254018, 1);
INSERT INTO `sys_user_role` VALUES (1776827459129171969, 1);
INSERT INTO `sys_user_role` VALUES (1776861348769947650, 1);
INSERT INTO `sys_user_role` VALUES (1776864185373548546, 1);
INSERT INTO `sys_user_role` VALUES (1776871215274516482, 1);
INSERT INTO `sys_user_role` VALUES (1776872376396275714, 1);
INSERT INTO `sys_user_role` VALUES (1776889562355589122, 1);
INSERT INTO `sys_user_role` VALUES (1777118704363757570, 1);
INSERT INTO `sys_user_role` VALUES (1777126438664527874, 1);
INSERT INTO `sys_user_role` VALUES (1777157190659727362, 1);
INSERT INTO `sys_user_role` VALUES (1777217669537062914, 1);
INSERT INTO `sys_user_role` VALUES (1777220647320936449, 1);
INSERT INTO `sys_user_role` VALUES (1777252116550508545, 1);
INSERT INTO `sys_user_role` VALUES (1777260896986193921, 1);
INSERT INTO `sys_user_role` VALUES (1777296499484254210, 1);
INSERT INTO `sys_user_role` VALUES (1777301747972038657, 1);
INSERT INTO `sys_user_role` VALUES (1777363539016409089, 1);
INSERT INTO `sys_user_role` VALUES (1777483372982820866, 1);
INSERT INTO `sys_user_role` VALUES (1777537906459402242, 1);
INSERT INTO `sys_user_role` VALUES (1777610641428570114, 1);
INSERT INTO `sys_user_role` VALUES (1777613556604067842, 1);
INSERT INTO `sys_user_role` VALUES (1777718773123244034, 1);
INSERT INTO `sys_user_role` VALUES (1777743939492503554, 1);
INSERT INTO `sys_user_role` VALUES (1777887539056467969, 1);
INSERT INTO `sys_user_role` VALUES (1777887799262699521, 1);
INSERT INTO `sys_user_role` VALUES (1777890253115088897, 1);
INSERT INTO `sys_user_role` VALUES (1777909423068274689, 1);
INSERT INTO `sys_user_role` VALUES (1777930481544585218, 1);
INSERT INTO `sys_user_role` VALUES (1777954050559303681, 1);
INSERT INTO `sys_user_role` VALUES (1778078614597525506, 1);
INSERT INTO `sys_user_role` VALUES (1778307871026307073, 1);
INSERT INTO `sys_user_role` VALUES (1778341191034462209, 1);
INSERT INTO `sys_user_role` VALUES (1778352526686281729, 1);
INSERT INTO `sys_user_role` VALUES (1778591039688138754, 1);
INSERT INTO `sys_user_role` VALUES (1778625241280274433, 1);
INSERT INTO `sys_user_role` VALUES (1778645603636338689, 1);
INSERT INTO `sys_user_role` VALUES (1779329016437530626, 1);
INSERT INTO `sys_user_role` VALUES (1779509451201306625, 1);
INSERT INTO `sys_user_role` VALUES (1781359789389049858, 1);
INSERT INTO `sys_user_role` VALUES (1781463900025450497, 1);
INSERT INTO `sys_user_role` VALUES (1781519961809940482, 1);
INSERT INTO `sys_user_role` VALUES (1781570458679963650, 1);
INSERT INTO `sys_user_role` VALUES (1781679536911609858, 1);
INSERT INTO `sys_user_role` VALUES (1781680345497923586, 1);
INSERT INTO `sys_user_role` VALUES (1781938051479711745, 1);
INSERT INTO `sys_user_role` VALUES (1781979644345659393, 1);
INSERT INTO `sys_user_role` VALUES (1781982608724537345, 1);
INSERT INTO `sys_user_role` VALUES (1782339521316294658, 1);
INSERT INTO `sys_user_role` VALUES (1782584811885596674, 1);
INSERT INTO `sys_user_role` VALUES (1782597966938411009, 1);
INSERT INTO `sys_user_role` VALUES (1782598345608564738, 1);
INSERT INTO `sys_user_role` VALUES (1782599696132509698, 1);
INSERT INTO `sys_user_role` VALUES (1782655923667505153, 1);
INSERT INTO `sys_user_role` VALUES (1782658558470557698, 1);
INSERT INTO `sys_user_role` VALUES (1782697212870037505, 1);
INSERT INTO `sys_user_role` VALUES (1782711689380270082, 1);
INSERT INTO `sys_user_role` VALUES (1782733890905083906, 1);
INSERT INTO `sys_user_role` VALUES (1782734018948796418, 1);
INSERT INTO `sys_user_role` VALUES (1782741134992379906, 1);
INSERT INTO `sys_user_role` VALUES (1782926062560382978, 1);
INSERT INTO `sys_user_role` VALUES (1782941277477834753, 1);
INSERT INTO `sys_user_role` VALUES (1782982532157050881, 1);
INSERT INTO `sys_user_role` VALUES (1783068876598317057, 1);
INSERT INTO `sys_user_role` VALUES (1783086777506107393, 1);
INSERT INTO `sys_user_role` VALUES (1783144268357079041, 1);
INSERT INTO `sys_user_role` VALUES (1783297415947915265, 1);
INSERT INTO `sys_user_role` VALUES (1783310569679523841, 1);
INSERT INTO `sys_user_role` VALUES (1783326930816372738, 1);
INSERT INTO `sys_user_role` VALUES (1783358421143293953, 1);
INSERT INTO `sys_user_role` VALUES (1783421941125910530, 1);
INSERT INTO `sys_user_role` VALUES (1783439451980206081, 1);
INSERT INTO `sys_user_role` VALUES (1783471940098494466, 1);
INSERT INTO `sys_user_role` VALUES (1783777388311777281, 1);
INSERT INTO `sys_user_role` VALUES (1783796572785643521, 1);
INSERT INTO `sys_user_role` VALUES (1783877442208960514, 1);
INSERT INTO `sys_user_role` VALUES (1784199358216048642, 1);
INSERT INTO `sys_user_role` VALUES (1784389326918029313, 1);
INSERT INTO `sys_user_role` VALUES (1784400528377286657, 1);
INSERT INTO `sys_user_role` VALUES (1784435756558880770, 1);
INSERT INTO `sys_user_role` VALUES (1784457537797656577, 1);
INSERT INTO `sys_user_role` VALUES (1784521057603538945, 1);
INSERT INTO `sys_user_role` VALUES (1784522252246724609, 1);
INSERT INTO `sys_user_role` VALUES (1784548227567202306, 1);
INSERT INTO `sys_user_role` VALUES (1784569508068995073, 1);
INSERT INTO `sys_user_role` VALUES (1784777389905162242, 1);
INSERT INTO `sys_user_role` VALUES (1784783910114308097, 1);
INSERT INTO `sys_user_role` VALUES (1784821184902344705, 1);
INSERT INTO `sys_user_role` VALUES (1784838825360633858, 1);
INSERT INTO `sys_user_role` VALUES (1784870260805087233, 1);
INSERT INTO `sys_user_role` VALUES (1784910451020279810, 1);
INSERT INTO `sys_user_role` VALUES (1785130539233193985, 1);
INSERT INTO `sys_user_role` VALUES (1785240710601125890, 1);
INSERT INTO `sys_user_role` VALUES (1785360485289439233, 1);
INSERT INTO `sys_user_role` VALUES (1785588726424023041, 1);
INSERT INTO `sys_user_role` VALUES (1785975035152019458, 1);
INSERT INTO `sys_user_role` VALUES (1786448824117735425, 1);
INSERT INTO `sys_user_role` VALUES (1787036511853850625, 1);
INSERT INTO `sys_user_role` VALUES (1787040098730356738, 1);
INSERT INTO `sys_user_role` VALUES (1787442869522636802, 1);
INSERT INTO `sys_user_role` VALUES (1787802087576530946, 1);
INSERT INTO `sys_user_role` VALUES (1787878100067119105, 1);
INSERT INTO `sys_user_role` VALUES (1788016335816716290, 1);
INSERT INTO `sys_user_role` VALUES (1788135951385718786, 1);
INSERT INTO `sys_user_role` VALUES (1788136924611047425, 1);
INSERT INTO `sys_user_role` VALUES (1788564791958401026, 1);
INSERT INTO `sys_user_role` VALUES (1788861563763126273, 1);
INSERT INTO `sys_user_role` VALUES (1789104577664217090, 1);
INSERT INTO `sys_user_role` VALUES (1789215891946434561, 1);
INSERT INTO `sys_user_role` VALUES (1789891068120231937, 1);
INSERT INTO `sys_user_role` VALUES (1789916787885961218, 1);
INSERT INTO `sys_user_role` VALUES (1790285085844664322, 1);
INSERT INTO `sys_user_role` VALUES (1790395963663413250, 1);
INSERT INTO `sys_user_role` VALUES (1790626495441698817, 1);
INSERT INTO `sys_user_role` VALUES (1790733204311015425, 1);
INSERT INTO `sys_user_role` VALUES (1790747738857832449, 1);
INSERT INTO `sys_user_role` VALUES (1790893072141549570, 1);
INSERT INTO `sys_user_role` VALUES (1790953693902045186, 1);
INSERT INTO `sys_user_role` VALUES (1790986267617689601, 1);
INSERT INTO `sys_user_role` VALUES (1791058271444172801, 1);
INSERT INTO `sys_user_role` VALUES (1791123542645178370, 1);
INSERT INTO `sys_user_role` VALUES (1791170948304764929, 1);
INSERT INTO `sys_user_role` VALUES (1791173160204533762, 1);
INSERT INTO `sys_user_role` VALUES (1791181681805524994, 1);
INSERT INTO `sys_user_role` VALUES (1791184448041287681, 1);
INSERT INTO `sys_user_role` VALUES (1791281872491544578, 1);
INSERT INTO `sys_user_role` VALUES (1791281970680201217, 1);
INSERT INTO `sys_user_role` VALUES (1791283037744693249, 1);
INSERT INTO `sys_user_role` VALUES (1791285337913589762, 1);
INSERT INTO `sys_user_role` VALUES (1791289816255856641, 1);
INSERT INTO `sys_user_role` VALUES (1791296357612683266, 1);
INSERT INTO `sys_user_role` VALUES (1791299213191315457, 1);
INSERT INTO `sys_user_role` VALUES (1791308308178829314, 1);
INSERT INTO `sys_user_role` VALUES (1791318977032781826, 1);
INSERT INTO `sys_user_role` VALUES (1791371260403687425, 1);
INSERT INTO `sys_user_role` VALUES (1791387421707116546, 1);
INSERT INTO `sys_user_role` VALUES (1791447204858470402, 1);
INSERT INTO `sys_user_role` VALUES (1791729117863124993, 1);
INSERT INTO `sys_user_role` VALUES (1793165965818912770, 1);
INSERT INTO `sys_user_role` VALUES (1793568337082740737, 1);
INSERT INTO `sys_user_role` VALUES (1794560044937154561, 1);
INSERT INTO `sys_user_role` VALUES (1794749939555143681, 1);
INSERT INTO `sys_user_role` VALUES (1795107096276410369, 1);
INSERT INTO `sys_user_role` VALUES (1795403915137032194, 1);
INSERT INTO `sys_user_role` VALUES (1795789913440296962, 1);
INSERT INTO `sys_user_role` VALUES (1796141206390349825, 1);
INSERT INTO `sys_user_role` VALUES (1796355287995031553, 1);
INSERT INTO `sys_user_role` VALUES (1796407753490997250, 1);
INSERT INTO `sys_user_role` VALUES (1796463188688412674, 1);
INSERT INTO `sys_user_role` VALUES (1796906411999272961, 1);
INSERT INTO `sys_user_role` VALUES (1797537246867791874, 1);
INSERT INTO `sys_user_role` VALUES (1797817711835127809, 1);
INSERT INTO `sys_user_role` VALUES (1797909973524979713, 1);
INSERT INTO `sys_user_role` VALUES (1798175479586791425, 1);
INSERT INTO `sys_user_role` VALUES (1798235243616313345, 1);
INSERT INTO `sys_user_role` VALUES (1798520237534388226, 1);
INSERT INTO `sys_user_role` VALUES (1798712494199840770, 1);
INSERT INTO `sys_user_role` VALUES (1799280384053518338, 1);
INSERT INTO `sys_user_role` VALUES (1799744018567307266, 1);
INSERT INTO `sys_user_role` VALUES (1800533174780338178, 1);
INSERT INTO `sys_user_role` VALUES (1800536812638609409, 1);
INSERT INTO `sys_user_role` VALUES (1800674959565430786, 1);
INSERT INTO `sys_user_role` VALUES (1801079442480996354, 1);
INSERT INTO `sys_user_role` VALUES (1801092008536088577, 1);
INSERT INTO `sys_user_role` VALUES (1801164484339212289, 1);
INSERT INTO `sys_user_role` VALUES (1801390702451924994, 1);
INSERT INTO `sys_user_role` VALUES (1801448239394103297, 1);
INSERT INTO `sys_user_role` VALUES (1801450423980564482, 1);
INSERT INTO `sys_user_role` VALUES (1801600035647299585, 1);
INSERT INTO `sys_user_role` VALUES (1801917626890756098, 1);
INSERT INTO `sys_user_role` VALUES (1802151483346952194, 1);
INSERT INTO `sys_user_role` VALUES (1802185387541962754, 1);
INSERT INTO `sys_user_role` VALUES (1802352201437716481, 1);
INSERT INTO `sys_user_role` VALUES (1802595299652706305, 1);
INSERT INTO `sys_user_role` VALUES (1802615605641519105, 1);
INSERT INTO `sys_user_role` VALUES (1802884960002416641, 1);
INSERT INTO `sys_user_role` VALUES (1803244799710896130, 1);
INSERT INTO `sys_user_role` VALUES (1803310345022251010, 1);
INSERT INTO `sys_user_role` VALUES (1803350775793360898, 1);
INSERT INTO `sys_user_role` VALUES (1803952381528145922, 1);
INSERT INTO `sys_user_role` VALUES (1804409446046400513, 1);
INSERT INTO `sys_user_role` VALUES (1804412156426616834, 1);
INSERT INTO `sys_user_role` VALUES (1805074712967282689, 1);
INSERT INTO `sys_user_role` VALUES (1806151742303535105, 1);
INSERT INTO `sys_user_role` VALUES (1806589360086482945, 1);
INSERT INTO `sys_user_role` VALUES (1806743654970458113, 1);
INSERT INTO `sys_user_role` VALUES (1807019618258419713, 1);
INSERT INTO `sys_user_role` VALUES (1807670449198628866, 1);
INSERT INTO `sys_user_role` VALUES (1808432476074573826, 1);
INSERT INTO `sys_user_role` VALUES (1809093167261450242, 1);
INSERT INTO `sys_user_role` VALUES (1809123002226606082, 1);
INSERT INTO `sys_user_role` VALUES (1811926844047654913, 1);
INSERT INTO `sys_user_role` VALUES (1813103212164841473, 1);
INSERT INTO `sys_user_role` VALUES (1815634871045087233, 1);
INSERT INTO `sys_user_role` VALUES (1816485229208297473, 1);
INSERT INTO `sys_user_role` VALUES (1821084376519434241, 1);
INSERT INTO `sys_user_role` VALUES (1821169552259833858, 1);
INSERT INTO `sys_user_role` VALUES (1821804728467873793, 1);
INSERT INTO `sys_user_role` VALUES (1822834793930637314, 1);
INSERT INTO `sys_user_role` VALUES (1822959243497914370, 1);
INSERT INTO `sys_user_role` VALUES (1826249520908156930, 1);
INSERT INTO `sys_user_role` VALUES (1829035060720123905, 1);
INSERT INTO `sys_user_role` VALUES (1831211798115991553, 1);
INSERT INTO `sys_user_role` VALUES (1831273555001950210, 1);
INSERT INTO `sys_user_role` VALUES (1834083211252416513, 1);
INSERT INTO `sys_user_role` VALUES (1838475187125043201, 1);
INSERT INTO `sys_user_role` VALUES (1846455089220632577, 1);
INSERT INTO `sys_user_role` VALUES (1847910185208987649, 1);
INSERT INTO `sys_user_role` VALUES (1871910972567822337, 1);
INSERT INTO `sys_user_role` VALUES (1897620177094057985, 1);
INSERT INTO `sys_user_role` VALUES (1933082743395094530, 1932319128081666050);

-- ----------------------------
-- View structure for v_designer_profile
-- ----------------------------
DROP VIEW IF EXISTS `v_designer_profile`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `v_designer_profile` AS select `d`.`designer_id` AS `designer_id`,`d`.`designer_name` AS `designer_name`,`d`.`profession` AS `profession`,`d`.`work_status` AS `work_status`,`d`.`location` AS `location`,`d`.`work_years` AS `work_years`,`e`.`enterprise_name` AS `enterprise_name`,`s`.`school_name` AS `school_name`,count(`we`.`experience_id`) AS `experience_count`,count(`ed`.`education_id`) AS `education_count`,count(`aw`.`award_id`) AS `award_count`,`d`.`create_time` AS `create_time`,`d`.`update_time` AS `update_time` from (((((`des_designer` `d` left join `des_enterprise` `e` on((`d`.`enterprise_id` = `e`.`enterprise_id`))) left join `des_school` `s` on((`d`.`school_id` = `s`.`school_id`))) left join `des_work_experience` `we` on(((`d`.`designer_id` = `we`.`designer_id`) and (`we`.`status` = '0')))) left join `des_education` `ed` on(((`d`.`designer_id` = `ed`.`designer_id`) and (`ed`.`status` = '0')))) left join `des_award` `aw` on(((`d`.`designer_id` = `aw`.`designer_id`) and (`aw`.`status` = '0')))) where (`d`.`status` = '0') group by `d`.`designer_id`,`d`.`designer_name`,`d`.`profession`,`d`.`work_status`,`d`.`location`,`d`.`work_years`,`e`.`enterprise_name`,`s`.`school_name`,`d`.`create_time`,`d`.`update_time`;

-- ----------------------------
-- Function structure for convert_skill_tag
-- ----------------------------
DROP FUNCTION IF EXISTS `convert_skill_tag`;
delimiter ;;
CREATE FUNCTION `convert_skill_tag`(input_tag VARCHAR(100))
 RETURNS varchar(50) CHARSET utf8mb4
  READS SQL DATA 
  DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(50);
    
    -- 设计工具类 (TOOL)
    CASE 
        WHEN input_tag IN ('Figma', 'figma') THEN SET result = 'figma';
        WHEN input_tag IN ('Sketch', 'sketch') THEN SET result = 'sketch';
        WHEN input_tag IN ('Axure RP', 'Axure', 'axure_rp', 'axure') THEN SET result = 'axure_rp';
        WHEN input_tag IN ('Photoshop', 'PS', 'photoshop') THEN SET result = 'photoshop';
        WHEN input_tag IN ('Illustrator', 'AI', 'illustrator') THEN SET result = 'illustrator';
        WHEN input_tag IN ('After Effects', 'AE', 'after_effects') THEN SET result = 'after_effects';
        WHEN input_tag IN ('Cinema 4D', 'C4D', 'cinema_4d') THEN SET result = 'cinema_4d';
        WHEN input_tag IN ('3D Max', '3ds Max', '3d_max', '3dsmax') THEN SET result = '3d_max';
        WHEN input_tag IN ('Maya', 'maya') THEN SET result = 'maya';
        WHEN input_tag IN ('Adobe XD', 'XD', 'adobe_xd') THEN SET result = 'adobe_xd';
        WHEN input_tag IN ('InVision', 'invision') THEN SET result = 'invision';
        WHEN input_tag IN ('Framer', 'framer') THEN SET result = 'framer';
        WHEN input_tag IN ('Principle', 'principle') THEN SET result = 'principle';
        WHEN input_tag IN ('Zeplin', 'zeplin') THEN SET result = 'zeplin';
        WHEN input_tag IN ('Abstract', 'abstract') THEN SET result = 'abstract';
        WHEN input_tag IN ('Blender', 'blender') THEN SET result = 'blender';
        WHEN input_tag IN ('Lottie', 'lottie') THEN SET result = 'lottie';
        
        -- 设计专业领域类 (FIELD)
        WHEN input_tag IN ('交互设计', 'Interaction Design', 'interaction_design', 'IxD') THEN SET result = 'interaction_design';
        WHEN input_tag IN ('UI设计', 'UI Design', 'ui_design', 'Interface Design') THEN SET result = 'ui_design';
        WHEN input_tag IN ('品牌设计', 'Brand Design', 'brand_design', 'Branding') THEN SET result = 'brand_design';
        WHEN input_tag IN ('产品设计', 'Product Design', 'product_design') THEN SET result = 'product_design';
        WHEN input_tag IN ('动效设计', 'Motion Design', 'motion_design', 'Animation Design') THEN SET result = 'motion_design';
        WHEN input_tag IN ('游戏美术', 'Game Art', 'game_art') THEN SET result = 'game_art';
        WHEN input_tag IN ('网页设计', 'Web Design', 'web_design') THEN SET result = 'web_design';
        WHEN input_tag IN ('移动端设计', 'Mobile Design', 'mobile_design', 'App Design') THEN SET result = 'mobile_design';
        WHEN input_tag IN ('平面设计', 'Graphic Design', 'graphic_design') THEN SET result = 'graphic_design';
        WHEN input_tag IN ('LOGO设计', 'Logo Design', 'logo_design') THEN SET result = 'logo_design';
        WHEN input_tag IN ('界面设计', 'Interface Design', 'interface_design') THEN SET result = 'interface_design';
        WHEN input_tag IN ('品牌标识', 'Brand Identity', 'brand_identity') THEN SET result = 'brand_identity';
        WHEN input_tag IN ('动画制作', 'Animation Design', 'animation_design') THEN SET result = 'animation_design';
        
        -- 设计技能/方法类 (SKILL)
        WHEN input_tag IN ('用户体验', 'User Experience', 'user_experience', 'UX') THEN SET result = 'user_experience';
        WHEN input_tag IN ('用户研究', 'User Research', 'user_research', 'UX Research') THEN SET result = 'user_research';
        WHEN input_tag IN ('原型设计', 'Prototype Design', 'prototype_design', 'Prototyping') THEN SET result = 'prototype_design';
        WHEN input_tag IN ('设计系统', 'Design System', 'design_system') THEN SET result = 'design_system';
        WHEN input_tag IN ('信息架构', 'Information Architecture', 'information_architecture', 'IA') THEN SET result = 'information_architecture';
        WHEN input_tag IN ('视觉系统', 'Visual System', 'visual_system') THEN SET result = 'visual_system';
        WHEN input_tag IN ('线框设计', 'Wireframing', 'wireframing') THEN SET result = 'wireframing';
        WHEN input_tag IN ('用户测试', 'User Testing', 'user_testing', 'Usability Testing') THEN SET result = 'user_testing';
        WHEN input_tag IN ('用户画像', 'Persona Design', 'persona_design', 'User Persona') THEN SET result = 'persona_design';
        WHEN input_tag IN ('用户旅程', 'Journey Mapping', 'journey_mapping', 'User Journey') THEN SET result = 'journey_mapping';
        WHEN input_tag IN ('可用性测试', 'Usability Testing', 'usability_testing') THEN SET result = 'usability_testing';
        WHEN input_tag IN ('视觉设计', 'Visual Design', 'visual_design') THEN SET result = 'visual_design';
        WHEN input_tag IN ('字体设计', 'Typography', 'typography') THEN SET result = 'typography';
        WHEN input_tag IN ('色彩理论', 'Color Theory', 'color_theory') THEN SET result = 'color_theory';
        WHEN input_tag IN ('插画', 'Illustration', 'illustration') THEN SET result = 'illustration';
        WHEN input_tag IN ('角色设计', 'Character Design', 'character_design') THEN SET result = 'character_design';
        WHEN input_tag IN ('场景设计', 'Scene Design', 'scene_design') THEN SET result = 'scene_design';
        WHEN input_tag IN ('视觉识别', 'Visual Identity', 'visual_identity') THEN SET result = 'visual_identity';
        WHEN input_tag IN ('动画', 'Animation', 'animation') THEN SET result = 'animation';
        WHEN input_tag IN ('动效', 'Effects', 'effects') THEN SET result = 'effects';
        WHEN input_tag IN ('3D建模', '3D Modeling', '3d_modeling') THEN SET result = '3d_modeling';
        WHEN input_tag IN ('摄影', 'Photography', 'photography') THEN SET result = 'photography';
        WHEN input_tag IN ('视频剪辑', 'Video Editing', 'video_editing') THEN SET result = 'video_editing';
        
        -- 如果没有匹配，返回原值（转为小写并替换空格为下划线）
        ELSE SET result = LOWER(REPLACE(input_tag, ' ', '_'));
    END CASE;
    
    RETURN result;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
