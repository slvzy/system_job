/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50717
Source Host           : localhost:3306
Source Database       : system_job

Target Server Type    : MYSQL
Target Server Version : 50717
File Encoding         : 65001

Date: 2019-04-26 17:06:27
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for system_config_info
-- ----------------------------
DROP TABLE IF EXISTS `system_config_info`;
CREATE TABLE `system_config_info` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `category_id` bigint(32) NOT NULL COMMENT '配置项类别 默认other',
  `category_name` varchar(255) DEFAULT NULL COMMENT '类别名称',
  `name` varchar(128) NOT NULL COMMENT '配置项',
  `value` varchar(5000) DEFAULT NULL COMMENT '取值',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  `status` int(10) DEFAULT '1' COMMENT '状态 1：有效 0：无需',
  `create_time` bigint(20) DEFAULT '0' COMMENT '添加时间, unix时间戳（毫秒）',
  `create_id` bigint(20) DEFAULT '0' COMMENT '添加用户ID',
  `update_time` bigint(20) DEFAULT '0' COMMENT '更新时间, unix时间戳（毫秒）,修改任何字段(除本字段外)都应更新此字段.',
  `update_id` bigint(20) DEFAULT '0' COMMENT '更新用户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_name_category` (`category_id`,`name`) USING BTREE,
  KEY `index_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='常量配置表';

-- ----------------------------
-- Records of system_config_info
-- ----------------------------
INSERT INTO `system_config_info` VALUES ('2', '1', '信审', 'test', '111', 'tests', '1', '1556262409', '1', '1556262409', '0');
INSERT INTO `system_config_info` VALUES ('3', '4', '财务', 'test2', 'ssss', 'ssss', '1', '1556262568', '1', '1556262895', '1');
INSERT INTO `system_config_info` VALUES ('4', '5', '征信', 'fffff', '11', '11', '1', '1556262619', '1', '1556262877', '1');
INSERT INTO `system_config_info` VALUES ('5', '6', '用户资料额度', 'bank', '150', '银行卡额度', '1', '1556263895', '1', '1556263895', '0');
INSERT INTO `system_config_info` VALUES ('6', '6', '用户资料额度', 'contract', '300', '联系人', '1', '1556264132', '1', '1556264132', '0');

-- ----------------------------
-- Table structure for system_config_type
-- ----------------------------
DROP TABLE IF EXISTS `system_config_type`;
CREATE TABLE `system_config_type` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(128) NOT NULL COMMENT '配置项',
  `code` varchar(256) NOT NULL COMMENT '取值',
  `remark` varchar(2000) DEFAULT NULL COMMENT '备注',
  `status` int(10) DEFAULT '1' COMMENT '状态 1：有效 0：无效',
  `create_time` bigint(20) DEFAULT '0' COMMENT '添加时间, unix时间戳（毫秒）',
  `create_id` bigint(20) DEFAULT '0' COMMENT '添加用户ID',
  `update_time` bigint(20) DEFAULT '0' COMMENT '更新时间, unix时间戳（毫秒）,修改任何字段(除本字段外)都应更新此字段.',
  `update_id` bigint(20) DEFAULT '0' COMMENT '更新用户ID',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_name` (`name`) USING BTREE,
  UNIQUE KEY `index_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='常量配置类别表';

-- ----------------------------
-- Records of system_config_type
-- ----------------------------
INSERT INTO `system_config_type` VALUES ('3', '信审', 'approve', '增加信审类别', '1', '1556260743', '1', '1556260797', '1');
INSERT INTO `system_config_type` VALUES ('4', '财务', 'finance', '增加财务类别', '1', '1556261281', '1', '1556261281', '0');
INSERT INTO `system_config_type` VALUES ('5', '征信', 'credit', '增加征信类别', '1', '1556261357', '1', '1556261357', '0');
INSERT INTO `system_config_type` VALUES ('6', '用户资料额度', 'infoAmount', '用户资料额度', '1', '1556263869', '1', '1556263869', '0');

-- ----------------------------
-- Table structure for system_notify_tpl
-- ----------------------------
DROP TABLE IF EXISTS `system_notify_tpl`;
CREATE TABLE `system_notify_tpl` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '模板id',
  `type` enum('system','default') NOT NULL DEFAULT 'default',
  `tpl_name` varchar(20) NOT NULL COMMENT '模板名称',
  `tpl_type` tinyint(1) NOT NULL COMMENT '模板类型 0:邮件;1:信息;2:钉钉;3:微信;',
  `title` varchar(64) DEFAULT NULL COMMENT '标题',
  `content` text NOT NULL COMMENT '模板内容',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态 0:禁用;1:启用;',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `create_id` int(11) NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '最后一次编辑时间',
  `update_id` int(11) NOT NULL DEFAULT '0' COMMENT '最后一次编辑者ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='通知模板';

-- ----------------------------
-- Records of system_notify_tpl
-- ----------------------------
INSERT INTO `system_notify_tpl` VALUES ('1', 'system', '默认邮箱通知模板', '0', '定时任务异常：{{TaskName}}', 'Hello,定时任务出问题了：\r\n<p style=\"font-size:16px;\">任务执行详情：</p>\r\n<p style=\"display:block; padding:10px; background:#efefef;border:1px solid #e4e4e4\">\r\n任务 ID：{{TaskId}}<br/>\r\n任务名称：{{TaskName}}<br/>\r\n执行命令：{{ExecuteCommand}}<br/>\r\n执行时间：{{ExecuteTime}}<br/>\r\n执行耗时：{{ProcessTime}}秒<br/>\r\n执行状态：{{ExecuteStatus}}\r\n</p>\r\n<p style=\"font-size:16px;\">任务执行输出</p>\r\n<p style=\"display:block; padding:10px; background:#efefef;border:1px solid #e4e4e4\">\r\n{{TaskOutput}}\r\n</p>\r\n<p style=\"font-size:16px;\">错误输出</p>\r\n<p style=\"display:block; padding:10px; background:#efefef;border:1px solid #e4e4e4\">\r\n{{ErrorOutput}}\r\n</p>', '1', '1550255030', '1', '1553282382', '1');
INSERT INTO `system_notify_tpl` VALUES ('2', 'system', '默认短信通知模板', '1', '', '{\r\n    \"task_id\": \"{{TaskId}}\",\r\n    \"task_name\": \"{{TaskName}}\",\r\n    \"execute_command\": \"{{ExecuteCommand}}\",\r\n    \"execute_status\": \"{{ExecuteStatus}}\"\r\n}', '1', '1550255030', '1', '1550338215', '1');
INSERT INTO `system_notify_tpl` VALUES ('3', 'system', '默认钉钉通知模板', '2', '', '{\r\n    \"msgtype\": \"text\",\r\n    \"text\": {\r\n        \"content\": \"任务执行异常详情：\\n任务 ID：{{TaskId}}\\n任务名称：{{TaskName}}\\n执行命令：{{ExecuteCommand}}\\n执行时间：{{ExecuteTime}}\\n执行耗时：{{ProcessTime}}秒\\n执行状态：{{ExecuteStatus}}\\n任务执行输出：\\n{{TaskOutput}}\\n错误输出：\\n{{ErrorOutput}}\"\r\n    }\r\n}', '1', '1550255030', '1', '1553282245', '1');
INSERT INTO `system_notify_tpl` VALUES ('4', 'system', '默认微信通知模板', '3', '', '{\r\n    \"task_id\": \"{{TaskId}}\",\r\n    \"task_name\": \"{{TaskName}}\",\r\n    \"execute_command\": \"{{ExecuteCommand}}\",\r\n    \"execute_status\": \"{{ExecuteStatus}}\"\r\n}', '1', '1550347183', '1', '1550347201', '1');

-- ----------------------------
-- Table structure for system_task
-- ----------------------------
DROP TABLE IF EXISTS `system_task`;
CREATE TABLE `system_task` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '分组ID',
  `server_ids` varchar(200) NOT NULL DEFAULT '0' COMMENT '服务器id字符串，英文都好隔开',
  `task_name` varchar(50) NOT NULL DEFAULT '' COMMENT '任务名称',
  `description` varchar(200) NOT NULL DEFAULT '' COMMENT '任务描述',
  `cron_spec` varchar(100) NOT NULL DEFAULT '' COMMENT '时间表达式',
  `concurrent` tinyint(4) unsigned NOT NULL DEFAULT '0' COMMENT '是否只允许一个实例',
  `command` text NOT NULL COMMENT '命令详情',
  `timeout` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '超时设置 s',
  `execute_times` int(11) NOT NULL DEFAULT '0' COMMENT '累计执行次数',
  `prev_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '上次执行时间',
  `is_notify` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-不通知，1-通知',
  `notify_type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-邮件通知，1-信息通知，2-钉钉通知，3-微信通知，',
  `notify_tpl_id` int(11) NOT NULL DEFAULT '0' COMMENT '通知模板id',
  `notify_user_ids` varchar(200) NOT NULL DEFAULT '0' COMMENT '通知用户ID字符串，1,2,3',
  `status` tinyint(4) NOT NULL DEFAULT '2' COMMENT '-1删除，0停用 1启用 2审核中,3不通过',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `create_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次编辑时间',
  `update_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '最后一次编辑者ID',
  PRIMARY KEY (`id`),
  KEY `idx_group_id` (`group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_task
-- ----------------------------
INSERT INTO `system_task` VALUES ('1', '3', '2', '打印服务器内存', '2秒钟一次', '*/2 * * * *', '0', 'free -G', '0', '336', '1556162490', '0', '0', '0', '0', '0', '1497855526', '0', '1531644960', '1');
INSERT INTO `system_task` VALUES ('2', '2', '1', '外部测试服务器', '8秒钟一次', '*/8 * * * * *', '0', 'echo \"hello world \\n\" >> /tmp/ppgo.log&& echo \"Hello world\"', '0', '230', '1556172144', '0', '0', '0', '0', '0', '1502876155', '0', '1556162576', '1');
INSERT INTO `system_task` VALUES ('3', '1', '1', '审核不通过的任务测试', '2s执行一次', '*/2 *  *  *  *', '0', '/webroot/server/php/bin/php /webroot/www/default/test2.php', '0', '27', '1556171071', '0', '0', '0', '0', '0', '1502936077', '0', '1556162576', '1');
INSERT INTO `system_task` VALUES ('4', '2', '0', '输出错误', '5秒执行一次', '*/5 * * * *', '0', 'tthh', '0', '77', '1556162490', '0', '0', '0', '0', '0', '1502945973', '0', '1531645619', '1');
INSERT INTO `system_task` VALUES ('5', '1', '0', '密码验证任务112', '5秒执行一次', '*/5 * * * *', '0', '/webroot/server/php/bin/php /webroot/www/default/test2.php', '0', '64', '1556171370', '0', '0', '0', '0', '0', '1503991581', '0', '1556161766', '1');
INSERT INTO `system_task` VALUES ('6', '1', '0', '打印并输出', '10秒一次，打印 hello ppgo_job', '*/10 * * * *', '0', 'echo \"hello ppgo_job\\n\" >> /tmp/test_ppgo.log', '0', '165', '1556162490', '0', '0', '0', '0', '0', '1530599445', '1', '1531644960', '1');
INSERT INTO `system_task` VALUES ('7', '3', '1', '打印ppgo', '5秒一次', '*/5 * * * * *', '0', 'echo \"hello ppgo\\n\" >> /tmp/ppgo.log&&echo \"yes\\n\"', '0', '114', '1556162490', '0', '0', '0', '0', '0', '1530761019', '1', '1531645347', '1');
INSERT INTO `system_task` VALUES ('8', '3', '3', '查看网络情况', '5秒一次', '*/5 * * * * *', '0', 'ifconfig', '0', '60', '1556162470', '0', '0', '0', '0', '0', '1531468119', '1', '1531645083', '1');
INSERT INTO `system_task` VALUES ('9', '1', '0', '查看磁盘情况-短信', '5秒一次', '*/5 * * * * *', '0', 'df -h', '0', '51', '1556162490', '1', '1', '0', '5,3,2', '0', '1531468712', '1', '1533702062', '1');
INSERT INTO `system_task` VALUES ('10', '1', '0', '测试通知通知的任务', '用于测试通知邮件的任务', '0 */5 * * *', '0', 'sleep 1s & lsss', '1', '22', '1533783831', '1', '0', '0', '2', '0', '1533697794', '1', '1533781696', '1');
INSERT INTO `system_task` VALUES ('11', '3', '0', '测试订单定时任务', '测试订单定时任务', '0 0/1 * * ?', '0', 'curl http://ci2:8080/finance/', '10', '681', '1556179980', '0', '0', '0', '', '0', '1556172057', '1', '1556179377', '1');

-- ----------------------------
-- Table structure for system_task_ban
-- ----------------------------
DROP TABLE IF EXISTS `system_task_ban`;
CREATE TABLE `system_task_ban` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(64) NOT NULL DEFAULT '0' COMMENT '命令',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '0-正常，1-删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='权限和角色关系表';

-- ----------------------------
-- Records of system_task_ban
-- ----------------------------
INSERT INTO `system_task_ban` VALUES ('1', 'rm -rf', '1528639322', '1528639692', '0');
INSERT INTO `system_task_ban` VALUES ('2', 'dd if=/dev/random of=/dev/sda', '1528639322', '1528639588', '0');
INSERT INTO `system_task_ban` VALUES ('3', 'mkfs.ext3 /dev/sda', '1528639445', '0', '0');

-- ----------------------------
-- Table structure for system_task_group
-- ----------------------------
DROP TABLE IF EXISTS `system_task_group`;
CREATE TABLE `system_task_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) NOT NULL DEFAULT '' COMMENT '组名',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '说明',
  `create_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改者Id',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态：1-正常，0-删除',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`create_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_task_group
-- ----------------------------
INSERT INTO `system_task_group` VALUES ('1', '任务分组甲', '任务分组甲', '1', '1531643000', '1', '1531643000', '1');
INSERT INTO `system_task_group` VALUES ('2', '任务分组乙', '任务分组乙', '1', '1531643030', '1', '1531643030', '1');
INSERT INTO `system_task_group` VALUES ('3', '任务分组丙', '任务分组丙', '1', '1531643070', '1', '1531643070', '1');

-- ----------------------------
-- Table structure for system_task_log
-- ----------------------------
DROP TABLE IF EXISTS `system_task_log`;
CREATE TABLE `system_task_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `task_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '任务ID',
  `server_id` int(11) NOT NULL DEFAULT '-1' COMMENT '服务器ID，-1，异常',
  `server_name` varchar(60) NOT NULL DEFAULT '""' COMMENT '服务器名称',
  `output` mediumtext NOT NULL COMMENT '任务输出',
  `error` text NOT NULL COMMENT '错误信息',
  `status` tinyint(4) NOT NULL COMMENT '状态',
  `process_time` int(11) NOT NULL DEFAULT '0' COMMENT '消耗时间/毫秒',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_task_id` (`task_id`,`create_time`)
) ENGINE=InnoDB AUTO_INCREMENT=1228 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_task_log
-- ----------------------------

-- ----------------------------
-- Table structure for system_task_server
-- ----------------------------
DROP TABLE IF EXISTS `system_task_server`;
CREATE TABLE `system_task_server` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `group_id` int(64) NOT NULL,
  `connection_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '连接类型 0:SSH;1:Telnet;',
  `server_name` varchar(64) NOT NULL DEFAULT '0' COMMENT '服务器名称',
  `server_account` varchar(32) NOT NULL DEFAULT 'root' COMMENT '账户名称',
  `server_outer_ip` varchar(20) NOT NULL DEFAULT '0' COMMENT '外网IP',
  `server_ip` varchar(20) NOT NULL DEFAULT '0' COMMENT '服务器内网IP',
  `port` int(4) unsigned NOT NULL DEFAULT '22' COMMENT '服务器端口',
  `password` varchar(64) NOT NULL DEFAULT '0' COMMENT '服务器密码',
  `private_key_src` varchar(128) NOT NULL DEFAULT '0' COMMENT '私钥文件地址',
  `public_key_src` varchar(128) NOT NULL DEFAULT '0' COMMENT '公钥地址',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '登录类型：0-密码登录，1-私钥登录',
  `detail` varchar(255) NOT NULL DEFAULT '0' COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态：0-正常，1-删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COMMENT='服务器列表';

-- ----------------------------
-- Records of system_task_server
-- ----------------------------
INSERT INTO `system_task_server` VALUES ('1', '2', '0', '密钥验证服务器', 'root', '0', '172.16.210.168', '22', '', '/Users/haodaquan/.ssh/my_service', '/Users/haodaquan/.ssh/my_service.pub', '1', '远程服务器示例', '1531642563', '1531642563', '0');
INSERT INTO `system_task_server` VALUES ('2', '1', '0', '密码验证服务器', 'root', '0', '172.16.210.153', '22', 'haodaquan2008', '', '', '0', '这是密码验证服务器', '1502945869', '1531618335', '0');
INSERT INTO `system_task_server` VALUES ('3', '3', '0', '测试服务器', 'root', '0', '172.16.210.153', '22', 'haodaquan2008', '', '', '0', '测试服务器', '1531641591', '1531641591', '0');

-- ----------------------------
-- Table structure for system_task_server_group
-- ----------------------------
DROP TABLE IF EXISTS `system_task_server_group`;
CREATE TABLE `system_task_server_group` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `group_name` varchar(50) NOT NULL DEFAULT '0' COMMENT '组名',
  `description` varchar(255) NOT NULL DEFAULT '' COMMENT '说明',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '1-正常，0-删除',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `create_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `update_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新id',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`create_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of system_task_server_group
-- ----------------------------
INSERT INTO `system_task_server_group` VALUES ('1', '资源A组', '服务器A组', '1', '1531617485', '1531617485', '1', '1');
INSERT INTO `system_task_server_group` VALUES ('2', '资源B组', '服务器B组', '1', '1531617507', '1531617507', '1', '1');
INSERT INTO `system_task_server_group` VALUES ('3', '资源C组', '资源C组', '1', '1531617530', '1531617530', '1', '1');

-- ----------------------------
-- Table structure for system_user_admin
-- ----------------------------
DROP TABLE IF EXISTS `system_user_admin`;
CREATE TABLE `system_user_admin` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `login_name` varchar(20) NOT NULL DEFAULT '' COMMENT '用户名',
  `real_name` varchar(32) NOT NULL DEFAULT '0' COMMENT '真实姓名',
  `password` char(32) NOT NULL DEFAULT '' COMMENT '密码',
  `role_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT '角色id字符串，如：2,3,4',
  `phone` varchar(20) NOT NULL DEFAULT '0' COMMENT '手机号码',
  `email` varchar(50) NOT NULL DEFAULT '' COMMENT '邮箱',
  `dingtalk` varchar(64) DEFAULT NULL COMMENT '钉钉',
  `wechat` varchar(64) DEFAULT NULL COMMENT '微信',
  `salt` char(10) NOT NULL DEFAULT '' COMMENT '密码盐',
  `last_login` int(11) NOT NULL DEFAULT '0' COMMENT '最后登录时间',
  `last_ip` char(15) NOT NULL DEFAULT '' COMMENT '最后登录IP',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态，1-正常 0禁用',
  `create_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `update_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_user_name` (`login_name`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

-- ----------------------------
-- Records of system_user_admin
-- ----------------------------
INSERT INTO `system_job`.`system_user_admin` (`id`, `login_name`, `real_name`, `password`, `role_ids`, `phone`, `email`, `dingtalk`, `wechat`, `salt`, `last_login`, `last_ip`, `status`, `create_id`, `update_id`, `create_time`, `update_time`) VALUES ('1', 'admin', '超级管理员', 'abfcf6dcedfb4b5b1505d41a8b4c77e8', '0', '13811551087', 'system2019@163.com', '', '', 'aYk4Q1P83v', '1556412957', '[', '1', '0', '1', '0', '1556168550');
INSERT INTO `system_job`.`system_user_admin` (`id`, `login_name`, `real_name`, `password`, `role_ids`, `phone`, `email`, `dingtalk`, `wechat`, `salt`, `last_login`, `last_ip`, `status`, `create_id`, `update_id`, `create_time`, `update_time`) VALUES ('2', 'test_1', 'pipi', 'b937149452da9f7a36f304dc00149edc', '1', '13811551087', 'system2019@163.com', NULL, NULL, '1Uep', '1531645875', '[', '1', '1', '1', '1528459479', '1533703722');
INSERT INTO `system_job`.`system_user_admin` (`id`, `login_name`, `real_name`, `password`, `role_ids`, `phone`, `email`, `dingtalk`, `wechat`, `salt`, `last_login`, `last_ip`, `status`, `create_id`, `update_id`, `create_time`, `update_time`) VALUES ('3', 'test_2', 'test2', '5fc38807c6740436407bf80015a7cf06', '2', '13811889999', '333@123.com', NULL, NULL, 'Qph1', '0', '', '1', '1', '1', '1531645748', '1531645748');
INSERT INTO `system_job`.`system_user_admin` (`id`, `login_name`, `real_name`, `password`, `role_ids`, `phone`, `email`, `dingtalk`, `wechat`, `salt`, `last_login`, `last_ip`, `status`, `create_id`, `update_id`, `create_time`, `update_time`) VALUES ('4', 'test_3', 'test3', '548a12147d443ea5a99a65ad4dd1ed30', '3', '13999990000', '222@123.com', NULL, NULL, '9Xta', '1531645939', '[', '1', '1', '1', '1531645785', '1531645785');
INSERT INTO `system_job`.`system_user_admin` (`id`, `login_name`, `real_name`, `password`, `role_ids`, `phone`, `email`, `dingtalk`, `wechat`, `salt`, `last_login`, `last_ip`, `status`, `create_id`, `update_id`, `create_time`, `update_time`) VALUES ('5', 'test_4', 'test4', '3225f516ea8a1c27d695084e0b67b651', '2,1', '13777777999', '44@qq.com', NULL, NULL, '7QmD', '1531705759', '[', '1', '1', '1', '1531645832', '1531645832');
INSERT INTO `system_job`.`system_user_admin` (`id`, `login_name`, `real_name`, `password`, `role_ids`, `phone`, `email`, `dingtalk`, `wechat`, `salt`, `last_login`, `last_ip`, `status`, `create_id`, `update_id`, `create_time`, `update_time`) VALUES ('6', 'wangzong', '王总', '32b94ac96e94bba1e6da2f305f1c9925', '4', '13812345678', '13812345678@qq.com', '', '', '9pJD', '1556168914', '[', '1', '1', '1', '1556168873', '1556168873');
INSERT INTO `system_job`.`system_user_admin` (`id`, `login_name`, `real_name`, `password`, `role_ids`, `phone`, `email`, `dingtalk`, `wechat`, `salt`, `last_login`, `last_ip`, `status`, `create_id`, `update_id`, `create_time`, `update_time`) VALUES ('7', 'zhaoliu', '赵六', 'bb604b2c17e5691ddc3bdb0dbb20155e', ',6', '13666666666', '13666666666@163.com', '', '', 'ZNSP', '1556265303', '[', '1', '1', '1', '1556265214', '1556265228');

-- ----------------------------
-- Table structure for system_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `system_user_auth`;
CREATE TABLE `system_user_auth` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增ID',
  `pid` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '上级ID，0为顶级',
  `auth_name` varchar(64) NOT NULL DEFAULT '0' COMMENT '权限名称',
  `auth_url` varchar(255) NOT NULL DEFAULT '0' COMMENT 'URL地址',
  `sort` int(1) unsigned NOT NULL DEFAULT '999' COMMENT '排序，越小越前',
  `icon` varchar(255) NOT NULL,
  `is_show` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '是否显示，0-隐藏，1-显示',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '操作者ID',
  `create_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `update_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改者ID',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态，1-正常，0-删除',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=77 DEFAULT CHARSET=utf8mb4 COMMENT='权限因子';

-- ----------------------------
-- Records of system_user_auth
-- ----------------------------
INSERT INTO `system_user_auth` VALUES ('1', '0', '所有权限', '/', '1', '', '0', '1', '1', '1', '1', '1505620970', '1505620970');
INSERT INTO `system_user_auth` VALUES ('2', '1', '权限管理', '/', '999', 'fa-id-card', '1', '1', '0', '1', '1', '0', '1505622360');
INSERT INTO `system_user_auth` VALUES ('3', '2', '用户管理', '/admin/list', '1', 'fa-user-o', '1', '0', '0', '0', '1', '0', '1528385411');
INSERT INTO `system_user_auth` VALUES ('4', '2', '角色管理', '/role/list', '2', 'fa-user-circle-o', '1', '1', '0', '1', '1', '0', '1505621852');
INSERT INTO `system_user_auth` VALUES ('5', '3', '新增', '/admin/add', '1', '', '0', '1', '0', '1', '1', '0', '1505621685');
INSERT INTO `system_user_auth` VALUES ('6', '3', '修改', '/admin/edit', '2', '', '0', '1', '0', '1', '1', '0', '1505621697');
INSERT INTO `system_user_auth` VALUES ('7', '3', '删除', '/admin/ajaxdel', '3', '', '0', '1', '1', '1', '1', '1505621756', '1505621756');
INSERT INTO `system_user_auth` VALUES ('8', '4', '新增', '/role/add', '1', '', '1', '1', '0', '1', '1', '0', '1505698716');
INSERT INTO `system_user_auth` VALUES ('9', '4', '修改', '/role/edit', '2', '', '0', '1', '1', '1', '1', '1505621912', '1505621912');
INSERT INTO `system_user_auth` VALUES ('10', '4', '删除', '/role/ajaxdel', '3', '', '0', '1', '1', '1', '1', '1505621951', '1505621951');
INSERT INTO `system_user_auth` VALUES ('11', '2', '权限配置', '/auth/list', '3', 'fa-list', '1', '1', '0', '1', '1', '0', '1556269038');
INSERT INTO `system_user_auth` VALUES ('12', '11', '新增', '/auth/add', '1', '', '0', '1', '1', '1', '1', '1505622009', '1505622009');
INSERT INTO `system_user_auth` VALUES ('13', '11', '修改', '/auth/edit', '2', '', '0', '1', '1', '1', '1', '1505622047', '1505622047');
INSERT INTO `system_user_auth` VALUES ('14', '11', '删除', '/auth/ajaxdel', '3', '', '0', '1', '1', '1', '1', '1505622111', '1505622111');
INSERT INTO `system_user_auth` VALUES ('15', '1', '个人中心', 'profile/edit', '1001', 'fa-user-circle-o', '1', '1', '0', '1', '1', '0', '1506001114');
INSERT INTO `system_user_auth` VALUES ('16', '15', '资料修改', '/user/edit', '1', 'fa-edit', '1', '1', '0', '0', '1', '1528385551', '1528385551');
INSERT INTO `system_user_auth` VALUES ('17', '1', '基本设置', '/', '2', 'fa-cogs', '1', '1', '0', '1', '1', '0', '1528464467');
INSERT INTO `system_user_auth` VALUES ('18', '17', '资源分组', '/servergroup/list', '2', 'fa-cubes', '1', '1', '0', '1', '1', '0', '1528466663');
INSERT INTO `system_user_auth` VALUES ('19', '17', '资源管理', '/server/list', '1', 'fa-cube', '1', '1', '0', '1', '1', '0', '1528464498');
INSERT INTO `system_user_auth` VALUES ('20', '17', '禁用命令', '/ban/list', '3', 'fa-exclamation-triangle', '1', '1', '0', '1', '1', '0', '1528464656');
INSERT INTO `system_user_auth` VALUES ('21', '18', '新增', '/servergroup/add', '1', '', '0', '1', '0', '1', '1', '0', '1528466669');
INSERT INTO `system_user_auth` VALUES ('22', '18', '修改', '/servergroup/edit', '2', '', '0', '1', '0', '1', '1', '0', '1528466675');
INSERT INTO `system_user_auth` VALUES ('23', '18', '删除', '/servergroup/ajaxdel', '3', '', '0', '1', '0', '1', '1', '0', '1528466684');
INSERT INTO `system_user_auth` VALUES ('24', '19', '新增', '/server/add', '1', '', '0', '1', '1', '1', '1', '1528464882', '1528464882');
INSERT INTO `system_user_auth` VALUES ('25', '19', '修改', '/server/edit', '2', '', '0', '1', '1', '1', '1', '1528464904', '1528464904');
INSERT INTO `system_user_auth` VALUES ('26', '19', '删除', '/server/ajaxdel', '3', '', '0', '1', '1', '1', '1', '1528464937', '1528464937');
INSERT INTO `system_user_auth` VALUES ('27', '20', '新增', '/ban/add', '1', '', '0', '1', '1', '1', '1', '1528464977', '1528464977');
INSERT INTO `system_user_auth` VALUES ('28', '20', '修改', '/ban/edit', '2', '', '0', '1', '1', '1', '1', '1528465005', '1528465005');
INSERT INTO `system_user_auth` VALUES ('29', '20', '删除', '/ban/ajaxdel', '3', '', '0', '1', '1', '1', '1', '1528465036', '1528465036');
INSERT INTO `system_user_auth` VALUES ('30', '1', '任务管理', '/job/list', '1', 'fa fa-blind', '1', '1', '0', '1', '1', '0', '1556269239');
INSERT INTO `system_user_auth` VALUES ('31', '30', '任务列表', '/task/list', '1', 'fa fa-desktop', '1', '1', '0', '1', '1', '0', '1556269167');
INSERT INTO `system_user_auth` VALUES ('32', '30', '任务分组', '/group/list', '3', 'fa fa-refresh', '1', '1', '0', '1', '1', '0', '1556269111');
INSERT INTO `system_user_auth` VALUES ('33', '32', '新增', '/group/add', '1', '', '0', '1', '1', '1', '1', '1528640546', '1528640546');
INSERT INTO `system_user_auth` VALUES ('34', '32', '编辑', '/group/edit', '2', '', '0', '1', '1', '1', '1', '1528640572', '1528640572');
INSERT INTO `system_user_auth` VALUES ('35', '32', '删除', '/group/ajaxdel', '3', '', '0', '1', '1', '1', '1', '1528640604', '1528640604');
INSERT INTO `system_user_auth` VALUES ('36', '31', '新增', '/task/add', '1', '', '0', '1', '1', '1', '1', '1528728220', '1528728220');
INSERT INTO `system_user_auth` VALUES ('37', '31', '编辑', '/task/edit', '2', '', '0', '1', '1', '1', '1', '1528728251', '1528728251');
INSERT INTO `system_user_auth` VALUES ('38', '42', '删除', '/task/ajaxdel', '3', '', '0', '1', '0', '1', '1', '0', '1531279999');
INSERT INTO `system_user_auth` VALUES ('39', '31', '查看', '/task/detail', '3', '', '0', '1', '0', '1', '1', '0', '1531279407');
INSERT INTO `system_user_auth` VALUES ('40', '42', '审核通过', '/task/ajaxaudit', '5', '', '0', '1', '0', '1', '1', '0', '1531466535');
INSERT INTO `system_user_auth` VALUES ('41', '31', '复制', '/task/copy', '5', '', '0', '1', '0', '1', '1', '0', '1531286150');
INSERT INTO `system_user_auth` VALUES ('42', '30', '任务审核', '/task/auditlist', '2', 'fa-gavel', '1', '1', '0', '1', '1', '0', '1531212806');
INSERT INTO `system_user_auth` VALUES ('43', '42', '批量审核通过', '/task/ajaxbatchaudit', '1', '', '0', '1', '0', '1', '1', '0', '1531466506');
INSERT INTO `system_user_auth` VALUES ('44', '42', '批量审核不通过', '/task/ajaxbatchnopass', '2', '', '0', '1', '0', '1', '1', '0', '1531466513');
INSERT INTO `system_user_auth` VALUES ('45', '31', '测试执行', '/task/ajaxrun', '4', '', '0', '1', '0', '1', '1', '0', '1531446085');
INSERT INTO `system_user_auth` VALUES ('46', '31', '批量暂停', '/task/ajaxbatchpause', '9', '', '0', '1', '0', '1', '1', '0', '1531466394');
INSERT INTO `system_user_auth` VALUES ('47', '31', '批量开启', '/task/ajaxbatchstart', '6', '', '0', '1', '0', '1', '1', '0', '1531466385');
INSERT INTO `system_user_auth` VALUES ('48', '31', '开启', '/task/ajaxstart', '7', '', '0', '1', '0', '1', '1', '0', '1531466404');
INSERT INTO `system_user_auth` VALUES ('49', '31', '暂停', '/task/ajaxpause', '8', '', '0', '1', '0', '1', '1', '0', '1531466411');
INSERT INTO `system_user_auth` VALUES ('50', '42', '审核不通过', '/task/ajaxnopass', '6', '', '0', '1', '0', '1', '1', '0', '1531466546');
INSERT INTO `system_user_auth` VALUES ('51', '42', '批量删除', '/task/ajaxbatchdel', '4', '', '0', '1', '0', '1', '1', '0', '1531466528');
INSERT INTO `system_user_auth` VALUES ('52', '19', '复制', '/server/copy', '3', '', '0', '1', '1', '1', '1', '1531383393', '1531383393');
INSERT INTO `system_user_auth` VALUES ('53', '19', '测试', '/server/ajaxtestserver', '5', '', '0', '1', '0', '1', '1', '0', '1531466851');
INSERT INTO `system_user_auth` VALUES ('54', '1', '日志管理', '/tasklog/list', '10', 'fa-file-text-o', '0', '1', '0', '1', '1', '0', '1556168656');
INSERT INTO `system_user_auth` VALUES ('55', '54', '详情', '/tasklog/detail', '1', '', '0', '1', '1', '1', '1', '1531389347', '1531389347');
INSERT INTO `system_user_auth` VALUES ('56', '54', '删除', '/tasklog/ajaxdel', '2', '', '0', '1', '0', '1', '1', '0', '1531466707');
INSERT INTO `system_user_auth` VALUES ('57', '17', '提醒设置', '/remind/list', '4', 'fa-bell-o', '1', '1', '1', '1', '0', '1533607960', '1533607960');
INSERT INTO `system_user_auth` VALUES ('58', '57', '新增', '/remind/add', '1', '', '0', '1', '1', '1', '1', '1533608257', '1533608257');
INSERT INTO `system_user_auth` VALUES ('59', '57', '编辑', '/remind/edit', '2', '', '0', '1', '1', '1', '1', '1533608298', '1533608298');
INSERT INTO `system_user_auth` VALUES ('60', '57', '删除', '/remind/ajaxdel', '3', '', '0', '1', '1', '1', '1', '1533608395', '1533608395');
INSERT INTO `system_user_auth` VALUES ('61', '17', '通知模板', '/notifytpl/list', '5', 'fa-file-o', '1', '1', '0', '1', '1', '0', '1550237874');
INSERT INTO `system_user_auth` VALUES ('62', '61', '新增', '/notifytpl/add', '1', '', '0', '1', '0', '1', '1', '0', '1550237919');
INSERT INTO `system_user_auth` VALUES ('63', '61', '编辑', '/notifytpl/edit', '2', '', '0', '1', '1', '1', '1', '1550237957', '1550237957');
INSERT INTO `system_user_auth` VALUES ('64', '61', '删除', '/notifytpl/ajaxdel', '3', '', '0', '1', '1', '1', '1', '1550237987', '1550237987');
INSERT INTO `system_user_auth` VALUES ('65', '31', '通知类型', '/task/ajaxnotifytype', '10', '', '0', '1', '1', '1', '1', '1550258380', '1550258380');
INSERT INTO `system_user_auth` VALUES ('67', '1', '配置管理', '/', '1000', 'fa fa-cog', '1', '1', '0', '1', '1', '0', '1556183692');
INSERT INTO `system_user_auth` VALUES ('68', '67', '配置列表', '/configinfo/list', '2', 'fa fa-clone', '1', '1', '0', '1', '1', '0', '1556183602');
INSERT INTO `system_user_auth` VALUES ('69', '68', '新增', '/configinfo/add', '2', 'fa fa-clone', '0', '1', '1', '1', '0', '1556250263', '1556250263');
INSERT INTO `system_user_auth` VALUES ('70', '68', '修改', '/configinfo/edit', '2', 'fa fa-clone', '0', '1', '1', '1', '1', '1556250310', '1556250310');
INSERT INTO `system_user_auth` VALUES ('71', '68', '新增', '/configinfo/add', '1', 'fa fa-clone', '0', '1', '1', '1', '1', '1556250316', '1556250316');
INSERT INTO `system_user_auth` VALUES ('72', '68', '删除', '/configinfo/ajaxdel', '3', 'fa fa-clone', '0', '1', '1', '1', '1', '1556250369', '1556250369');
INSERT INTO `system_user_auth` VALUES ('73', '67', '类别列表', '/configtype/list', '1', 'fa fa-snowflake-o', '1', '1', '0', '1', '1', '0', '1556268249');
INSERT INTO `system_user_auth` VALUES ('74', '73', '新增', '/configtype/add', '1', '', '0', '1', '1', '1', '1', '1556259899', '1556259899');
INSERT INTO `system_user_auth` VALUES ('75', '73', '编辑', '/configtype/edit', '2', '', '0', '1', '1', '1', '1', '1556259920', '1556259920');
INSERT INTO `system_user_auth` VALUES ('76', '73', '删除', '/configtype/ajaxdel', '3', '', '0', '1', '1', '1', '1', '1556259949', '1556259949');

-- ----------------------------
-- Table structure for system_user_role
-- ----------------------------
DROP TABLE IF EXISTS `system_user_role`;
CREATE TABLE `system_user_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `role_name` varchar(32) NOT NULL DEFAULT '0' COMMENT '角色名称',
  `detail` varchar(255) NOT NULL DEFAULT '0' COMMENT '备注',
  `server_group_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT '服务器分组权限ids,1,2,3',
  `task_group_ids` varchar(255) NOT NULL DEFAULT '0' COMMENT '任务分组权限ids ,1,2,32',
  `create_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建者ID',
  `update_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改这ID',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态1-正常，0-删除',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='角色表';

-- ----------------------------
-- Records of system_user_role
-- ----------------------------
INSERT INTO `system_user_role` VALUES ('1', '普通管理员', '可以运行和关闭任务', '10,1', '4,1', '0', '1', '1', '1531705962', '1531705962');
INSERT INTO `system_user_role` VALUES ('2', '高级管理员', '可以批量操作任务，创建任务，创建任务分组，审核任务等', ',10,1,2', '4,6,1,2', '0', '1', '1', '1533607237', '1533607237');
INSERT INTO `system_user_role` VALUES ('3', '资深管理员', '系统配置，任务管理等', '1,2,3', '2,1,3', '0', '1', '1', '1531644877', '1531644877');
INSERT INTO `system_user_role` VALUES ('4', '超级管理员', '超级管理员', '2,1,3', '1,2,3', '1', '1', '1', '1556168737', '1556168737');
INSERT INTO `system_user_role` VALUES ('6', '配置管理员', '可以批量操作配置及类型，创建配置，删除，更新等', '', '1', '0', '1', '1', '1556265287', '1556265287');

-- ----------------------------
-- Table structure for system_user_role_auth
-- ----------------------------
DROP TABLE IF EXISTS `system_user_role_auth`;
CREATE TABLE `system_user_role_auth` (
  `role_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '角色ID',
  `auth_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '权限ID',
  PRIMARY KEY (`role_id`,`auth_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='权限和角色关系表';

-- ----------------------------
-- Records of system_user_role_auth
-- ----------------------------
INSERT INTO `system_user_role_auth` VALUES ('1', '1');
INSERT INTO `system_user_role_auth` VALUES ('1', '15');
INSERT INTO `system_user_role_auth` VALUES ('1', '16');
INSERT INTO `system_user_role_auth` VALUES ('1', '30');
INSERT INTO `system_user_role_auth` VALUES ('1', '31');
INSERT INTO `system_user_role_auth` VALUES ('1', '36');
INSERT INTO `system_user_role_auth` VALUES ('1', '37');
INSERT INTO `system_user_role_auth` VALUES ('1', '39');
INSERT INTO `system_user_role_auth` VALUES ('1', '41');
INSERT INTO `system_user_role_auth` VALUES ('1', '46');
INSERT INTO `system_user_role_auth` VALUES ('1', '47');
INSERT INTO `system_user_role_auth` VALUES ('1', '48');
INSERT INTO `system_user_role_auth` VALUES ('1', '49');
INSERT INTO `system_user_role_auth` VALUES ('1', '54');
INSERT INTO `system_user_role_auth` VALUES ('1', '55');
INSERT INTO `system_user_role_auth` VALUES ('1', '56');
INSERT INTO `system_user_role_auth` VALUES ('2', '0');
INSERT INTO `system_user_role_auth` VALUES ('2', '17');
INSERT INTO `system_user_role_auth` VALUES ('2', '18');
INSERT INTO `system_user_role_auth` VALUES ('2', '19');
INSERT INTO `system_user_role_auth` VALUES ('2', '20');
INSERT INTO `system_user_role_auth` VALUES ('2', '21');
INSERT INTO `system_user_role_auth` VALUES ('2', '22');
INSERT INTO `system_user_role_auth` VALUES ('2', '23');
INSERT INTO `system_user_role_auth` VALUES ('2', '24');
INSERT INTO `system_user_role_auth` VALUES ('2', '25');
INSERT INTO `system_user_role_auth` VALUES ('2', '26');
INSERT INTO `system_user_role_auth` VALUES ('2', '27');
INSERT INTO `system_user_role_auth` VALUES ('2', '28');
INSERT INTO `system_user_role_auth` VALUES ('2', '29');
INSERT INTO `system_user_role_auth` VALUES ('2', '32');
INSERT INTO `system_user_role_auth` VALUES ('2', '33');
INSERT INTO `system_user_role_auth` VALUES ('2', '34');
INSERT INTO `system_user_role_auth` VALUES ('2', '35');
INSERT INTO `system_user_role_auth` VALUES ('2', '38');
INSERT INTO `system_user_role_auth` VALUES ('2', '40');
INSERT INTO `system_user_role_auth` VALUES ('2', '42');
INSERT INTO `system_user_role_auth` VALUES ('2', '43');
INSERT INTO `system_user_role_auth` VALUES ('2', '44');
INSERT INTO `system_user_role_auth` VALUES ('2', '45');
INSERT INTO `system_user_role_auth` VALUES ('2', '50');
INSERT INTO `system_user_role_auth` VALUES ('2', '51');
INSERT INTO `system_user_role_auth` VALUES ('2', '52');
INSERT INTO `system_user_role_auth` VALUES ('2', '53');
INSERT INTO `system_user_role_auth` VALUES ('4', '0');
INSERT INTO `system_user_role_auth` VALUES ('4', '1');
INSERT INTO `system_user_role_auth` VALUES ('4', '2');
INSERT INTO `system_user_role_auth` VALUES ('4', '3');
INSERT INTO `system_user_role_auth` VALUES ('4', '4');
INSERT INTO `system_user_role_auth` VALUES ('4', '5');
INSERT INTO `system_user_role_auth` VALUES ('4', '6');
INSERT INTO `system_user_role_auth` VALUES ('4', '7');
INSERT INTO `system_user_role_auth` VALUES ('4', '8');
INSERT INTO `system_user_role_auth` VALUES ('4', '9');
INSERT INTO `system_user_role_auth` VALUES ('4', '10');
INSERT INTO `system_user_role_auth` VALUES ('4', '11');
INSERT INTO `system_user_role_auth` VALUES ('4', '12');
INSERT INTO `system_user_role_auth` VALUES ('4', '13');
INSERT INTO `system_user_role_auth` VALUES ('4', '14');
INSERT INTO `system_user_role_auth` VALUES ('4', '15');
INSERT INTO `system_user_role_auth` VALUES ('4', '16');
INSERT INTO `system_user_role_auth` VALUES ('4', '17');
INSERT INTO `system_user_role_auth` VALUES ('4', '18');
INSERT INTO `system_user_role_auth` VALUES ('4', '19');
INSERT INTO `system_user_role_auth` VALUES ('4', '20');
INSERT INTO `system_user_role_auth` VALUES ('4', '21');
INSERT INTO `system_user_role_auth` VALUES ('4', '22');
INSERT INTO `system_user_role_auth` VALUES ('4', '23');
INSERT INTO `system_user_role_auth` VALUES ('4', '24');
INSERT INTO `system_user_role_auth` VALUES ('4', '25');
INSERT INTO `system_user_role_auth` VALUES ('4', '26');
INSERT INTO `system_user_role_auth` VALUES ('4', '27');
INSERT INTO `system_user_role_auth` VALUES ('4', '28');
INSERT INTO `system_user_role_auth` VALUES ('4', '29');
INSERT INTO `system_user_role_auth` VALUES ('4', '30');
INSERT INTO `system_user_role_auth` VALUES ('4', '31');
INSERT INTO `system_user_role_auth` VALUES ('4', '32');
INSERT INTO `system_user_role_auth` VALUES ('4', '33');
INSERT INTO `system_user_role_auth` VALUES ('4', '34');
INSERT INTO `system_user_role_auth` VALUES ('4', '35');
INSERT INTO `system_user_role_auth` VALUES ('4', '36');
INSERT INTO `system_user_role_auth` VALUES ('4', '37');
INSERT INTO `system_user_role_auth` VALUES ('4', '38');
INSERT INTO `system_user_role_auth` VALUES ('4', '39');
INSERT INTO `system_user_role_auth` VALUES ('4', '40');
INSERT INTO `system_user_role_auth` VALUES ('4', '41');
INSERT INTO `system_user_role_auth` VALUES ('4', '42');
INSERT INTO `system_user_role_auth` VALUES ('4', '43');
INSERT INTO `system_user_role_auth` VALUES ('4', '44');
INSERT INTO `system_user_role_auth` VALUES ('4', '45');
INSERT INTO `system_user_role_auth` VALUES ('4', '46');
INSERT INTO `system_user_role_auth` VALUES ('4', '47');
INSERT INTO `system_user_role_auth` VALUES ('4', '48');
INSERT INTO `system_user_role_auth` VALUES ('4', '49');
INSERT INTO `system_user_role_auth` VALUES ('4', '50');
INSERT INTO `system_user_role_auth` VALUES ('4', '51');
INSERT INTO `system_user_role_auth` VALUES ('4', '52');
INSERT INTO `system_user_role_auth` VALUES ('4', '53');
INSERT INTO `system_user_role_auth` VALUES ('4', '54');
INSERT INTO `system_user_role_auth` VALUES ('4', '55');
INSERT INTO `system_user_role_auth` VALUES ('4', '56');
INSERT INTO `system_user_role_auth` VALUES ('4', '61');
INSERT INTO `system_user_role_auth` VALUES ('4', '62');
INSERT INTO `system_user_role_auth` VALUES ('4', '63');
INSERT INTO `system_user_role_auth` VALUES ('4', '64');
INSERT INTO `system_user_role_auth` VALUES ('4', '65');
INSERT INTO `system_user_role_auth` VALUES ('5', '0');
INSERT INTO `system_user_role_auth` VALUES ('5', '1');
INSERT INTO `system_user_role_auth` VALUES ('5', '2');
INSERT INTO `system_user_role_auth` VALUES ('5', '3');
INSERT INTO `system_user_role_auth` VALUES ('5', '4');
INSERT INTO `system_user_role_auth` VALUES ('5', '5');
INSERT INTO `system_user_role_auth` VALUES ('5', '6');
INSERT INTO `system_user_role_auth` VALUES ('5', '7');
INSERT INTO `system_user_role_auth` VALUES ('5', '8');
INSERT INTO `system_user_role_auth` VALUES ('5', '9');
INSERT INTO `system_user_role_auth` VALUES ('5', '10');
INSERT INTO `system_user_role_auth` VALUES ('5', '11');
INSERT INTO `system_user_role_auth` VALUES ('5', '12');
INSERT INTO `system_user_role_auth` VALUES ('5', '13');
INSERT INTO `system_user_role_auth` VALUES ('5', '14');
INSERT INTO `system_user_role_auth` VALUES ('5', '15');
INSERT INTO `system_user_role_auth` VALUES ('5', '16');
INSERT INTO `system_user_role_auth` VALUES ('5', '17');
INSERT INTO `system_user_role_auth` VALUES ('5', '18');
INSERT INTO `system_user_role_auth` VALUES ('5', '19');
INSERT INTO `system_user_role_auth` VALUES ('5', '20');
INSERT INTO `system_user_role_auth` VALUES ('5', '21');
INSERT INTO `system_user_role_auth` VALUES ('5', '22');
INSERT INTO `system_user_role_auth` VALUES ('5', '23');
INSERT INTO `system_user_role_auth` VALUES ('5', '24');
INSERT INTO `system_user_role_auth` VALUES ('5', '25');
INSERT INTO `system_user_role_auth` VALUES ('5', '26');
INSERT INTO `system_user_role_auth` VALUES ('5', '27');
INSERT INTO `system_user_role_auth` VALUES ('5', '28');
INSERT INTO `system_user_role_auth` VALUES ('5', '29');
INSERT INTO `system_user_role_auth` VALUES ('5', '30');
INSERT INTO `system_user_role_auth` VALUES ('5', '31');
INSERT INTO `system_user_role_auth` VALUES ('5', '32');
INSERT INTO `system_user_role_auth` VALUES ('5', '33');
INSERT INTO `system_user_role_auth` VALUES ('5', '34');
INSERT INTO `system_user_role_auth` VALUES ('5', '35');
INSERT INTO `system_user_role_auth` VALUES ('5', '36');
INSERT INTO `system_user_role_auth` VALUES ('5', '37');
INSERT INTO `system_user_role_auth` VALUES ('5', '38');
INSERT INTO `system_user_role_auth` VALUES ('5', '39');
INSERT INTO `system_user_role_auth` VALUES ('5', '40');
INSERT INTO `system_user_role_auth` VALUES ('5', '41');
INSERT INTO `system_user_role_auth` VALUES ('5', '42');
INSERT INTO `system_user_role_auth` VALUES ('5', '43');
INSERT INTO `system_user_role_auth` VALUES ('5', '44');
INSERT INTO `system_user_role_auth` VALUES ('5', '45');
INSERT INTO `system_user_role_auth` VALUES ('5', '46');
INSERT INTO `system_user_role_auth` VALUES ('5', '47');
INSERT INTO `system_user_role_auth` VALUES ('5', '48');
INSERT INTO `system_user_role_auth` VALUES ('5', '49');
INSERT INTO `system_user_role_auth` VALUES ('5', '50');
INSERT INTO `system_user_role_auth` VALUES ('5', '51');
INSERT INTO `system_user_role_auth` VALUES ('5', '52');
INSERT INTO `system_user_role_auth` VALUES ('5', '53');
INSERT INTO `system_user_role_auth` VALUES ('5', '54');
INSERT INTO `system_user_role_auth` VALUES ('5', '55');
INSERT INTO `system_user_role_auth` VALUES ('5', '56');
INSERT INTO `system_user_role_auth` VALUES ('5', '61');
INSERT INTO `system_user_role_auth` VALUES ('5', '62');
INSERT INTO `system_user_role_auth` VALUES ('5', '63');
INSERT INTO `system_user_role_auth` VALUES ('5', '64');
INSERT INTO `system_user_role_auth` VALUES ('5', '65');
INSERT INTO `system_user_role_auth` VALUES ('6', '0');
INSERT INTO `system_user_role_auth` VALUES ('6', '1');
INSERT INTO `system_user_role_auth` VALUES ('6', '15');
INSERT INTO `system_user_role_auth` VALUES ('6', '16');
INSERT INTO `system_user_role_auth` VALUES ('6', '67');
INSERT INTO `system_user_role_auth` VALUES ('6', '68');
INSERT INTO `system_user_role_auth` VALUES ('6', '70');
INSERT INTO `system_user_role_auth` VALUES ('6', '71');
INSERT INTO `system_user_role_auth` VALUES ('6', '72');
INSERT INTO `system_user_role_auth` VALUES ('6', '73');
INSERT INTO `system_user_role_auth` VALUES ('6', '74');
INSERT INTO `system_user_role_auth` VALUES ('6', '75');
INSERT INTO `system_user_role_auth` VALUES ('6', '76');
