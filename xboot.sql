/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : xboot

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 27/04/2020 20:00:17
*/

-- ----------------------------
-- Table structure for app_member
-- ----------------------------
DROP TABLE IF EXISTS `app_member`;
CREATE TABLE `app_member` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `platform` tinyint(1) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `username` varchar(255) NOT NULL,
  `vip_end_time` datetime(6) DEFAULT NULL,
  `vip_start_time` datetime(6) DEFAULT NULL,
  `permissions` varchar(255) DEFAULT NULL,
  `vip_status` tinyint(1) DEFAULT NULL,
  `birth` datetime(6) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `invite_code` varchar(255) DEFAULT NULL,
  `grade` int(11) unsigned DEFAULT NULL,
  `position` varchar(255) DEFAULT NULL,
  `invite_by` varchar(255) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `mobile` (`mobile`) USING BTREE,
  UNIQUE KEY `invite_code` (`invite_code`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of app_member
-- ----------------------------
BEGIN;
INSERT INTO `app_member` VALUES (255227305549369344, '', '2020-03-25 21:14:32.000000', 0, 'admin', '2020-04-27 17:20:45.307000', 'https://ooo.0o0.ooo/2020/04/18/NmF3IP4TOoVbLf5.png', '', '18782059031', '187****9031', NULL, -1, '', 0, 1, '1251014922381430800', '2030-04-30 00:00:00.000000', '2020-04-01 00:00:00.000000', 'MEMBER', 1, NULL, '?????? ????????? ????????? ????????? ???????????? 3??? ??????????????????????????????', '12N3VE6CK440G', 0, '30.5681733200,104.0666198700', '', NULL);
INSERT INTO `app_member` VALUES (1251783645962833920, 'admin', '2020-04-19 16:04:12.000000', 0, 'admin', '2020-04-27 17:24:23.091000', 'https://ooo.0o0.ooo/2020/04/18/NmF3IP4TOoVbLf5.png', '', '18782059092', '187****9092', NULL, 1, '', 0, 1, '1251783646004776960', '2020-04-07 00:00:00.000000', '2020-04-01 00:00:00.000000', 'MEMBER', 2, NULL, '?????? ????????? ????????? ????????? ???????????? 3??? ??????????????????????????????', '12NPQJ01S4400', 0, '30.5681733200,104.0666198700', '1251014922381430800', NULL);
INSERT INTO `app_member` VALUES (1251783729291071489, 'admin', '2020-04-19 16:04:32.000000', 0, 'admin', '2020-04-27 22:03:48.509000', 'https://ooo.0o0.ooo/2020/04/18/NmF3IP4TOoVbLf5.png', '', '18782059033', '187****9093', NULL, 2, '', 0, 0, '1251783729303654400', NULL, NULL, 'MEMBER', 0, NULL, '?????? ????????? ????????? ????????? ???????????? 3??? ??????????????????????????????', '12NPQLDKC4400', 0, '30.5681733200,104.0666198700', '1251014922381430800', NULL);
COMMIT;

-- ----------------------------
-- Table structure for t_act_business
-- ----------------------------
DROP TABLE IF EXISTS `t_act_business`;
CREATE TABLE `t_act_business` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `proc_def_id` varchar(255) DEFAULT NULL,
  `proc_inst_id` varchar(255) DEFAULT NULL,
  `result` tinyint(1) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `table_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `apply_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_act_category
-- ----------------------------
DROP TABLE IF EXISTS `t_act_category`;
CREATE TABLE `t_act_category` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  `parent_id` bigint(20) unsigned NOT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_act_model
-- ----------------------------
DROP TABLE IF EXISTS `t_act_model`;
CREATE TABLE `t_act_model` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `model_key` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `version` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_act_node
-- ----------------------------
DROP TABLE IF EXISTS `t_act_node`;
CREATE TABLE `t_act_node` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `node_id` varchar(255) DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `relate_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_act_process
-- ----------------------------
DROP TABLE IF EXISTS `t_act_process`;
CREATE TABLE `t_act_process` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `deployment_id` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `diagram_name` varchar(255) DEFAULT NULL,
  `latest` bit(1) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `process_key` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `xml_name` varchar(255) DEFAULT NULL,
  `business_table` varchar(255) DEFAULT NULL,
  `route_name` varchar(255) DEFAULT NULL,
  `all_user` bit(1) DEFAULT NULL,
  `category_title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_client
-- ----------------------------
DROP TABLE IF EXISTS `t_client`;
CREATE TABLE `t_client` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `client_secret` varchar(255) DEFAULT NULL,
  `home_uri` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `redirect_uri` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_department
-- ----------------------------
DROP TABLE IF EXISTS `t_department`;
CREATE TABLE `t_department` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `parent_id` bigint(20) unsigned NOT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_department
-- ----------------------------
BEGIN;
INSERT INTO `t_department` VALUES (40322777781112832, '', '2018-08-10 20:40:40', 0, '', '2018-08-11 00:03:06', 0, 1.00, 0, '??????', b'1');
INSERT INTO `t_department` VALUES (40322811096469504, '', '2018-08-10 20:40:48', 0, '', '2018-08-11 00:27:05', 40322777781112832, 1.00, 0, '?????????', b'1');
INSERT INTO `t_department` VALUES (40322852833988608, '', '2018-08-10 20:40:58', 0, '', '2018-08-11 01:29:42', 40322811096469504, 1.00, 0, '????????????', NULL);
INSERT INTO `t_department` VALUES (40327204755738624, '', '2018-08-10 20:58:15', 0, '', '2018-08-10 22:02:15', 40322811096469504, 2.00, 0, '?????????', NULL);
INSERT INTO `t_department` VALUES (40327253309001728, '', '2018-08-10 20:58:27', 0, '', '2018-08-11 17:26:38', 40322811096469504, 3.00, -1, '????????????', NULL);
INSERT INTO `t_department` VALUES (40343262766043136, '', '2018-08-10 22:02:04', 0, '', '2018-08-11 00:02:53', 0, 2.00, 0, '????????????', b'1');
INSERT INTO `t_department` VALUES (40344005342400512, '', '2018-08-10 22:05:01', 0, '', '2018-08-11 17:48:44', 40343262766043136, 2.00, 0, 'Vue', NULL);
INSERT INTO `t_department` VALUES (40389030113710080, '', '2018-08-11 01:03:56', 0, '', '2018-08-11 17:50:04', 40343262766043136, 1.00, 0, 'JAVA', b'0');
INSERT INTO `t_department` VALUES (40652270295060480, '', '2018-08-11 18:29:57', 0, '', '2018-08-12 18:45:01', 0, 3.00, 0, '?????????', b'1');
INSERT INTO `t_department` VALUES (40652338142121984, NULL, '2018-08-11 18:30:13', 0, NULL, '2018-08-11 18:30:13', 40652270295060480, 1.00, 0, '??????', b'0');
INSERT INTO `t_department` VALUES (40681289119961088, '', '2018-08-11 20:25:16', 0, '', '2018-08-11 22:47:48', 40652270295060480, 2.00, 0, 'VIP', b'0');
COMMIT;

-- ----------------------------
-- Table structure for t_department_header
-- ----------------------------
DROP TABLE IF EXISTS `t_department_header`;
CREATE TABLE `t_department_header` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_department_header
-- ----------------------------
BEGIN;
INSERT INTO `t_department_header` VALUES (1254427833757995008, 'admin', '2020-04-26 23:11:16', 0, 'admin', '2020-04-26 23:11:16', 40322777781112832, 0, 682265633886208);
INSERT INTO `t_department_header` VALUES (1254427833757995009, 'admin', '2020-04-26 23:11:16', 0, 'admin', '2020-04-26 23:11:16', 40322777781112832, 0, 16739222421508096);
INSERT INTO `t_department_header` VALUES (1254427833757995010, 'admin', '2020-04-26 23:11:16', 0, 'admin', '2020-04-26 23:11:16', 40322777781112832, 1, 16739222421508096);
COMMIT;

-- ----------------------------
-- Table structure for t_dict
-- ----------------------------
DROP TABLE IF EXISTS `t_dict`;
CREATE TABLE `t_dict` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dict
-- ----------------------------
BEGIN;
INSERT INTO `t_dict` VALUES (75135930788220928, 'admin', '2018-11-14 22:15:43', 0, 'admin', '2018-11-27 01:39:06', '', '??????', 'sex', 0.00);
INSERT INTO `t_dict` VALUES (75383353938808832, 'admin', '2018-11-15 14:38:53', 0, 'admin', '2018-11-27 01:39:15', '', '????????????', 'message_type', 1.00);
INSERT INTO `t_dict` VALUES (75388696739713024, 'admin', '2018-11-15 15:00:07', 0, 'admin', '2018-11-27 01:39:22', '', '??????????????????', 'permission_type', 2.00);
INSERT INTO `t_dict` VALUES (75392985935646720, 'admin', '2018-11-15 15:17:10', 0, 'admin', '2018-11-27 01:39:29', '', '???????????????????????????', 'tencent_bucket_region', 3.00);
INSERT INTO `t_dict` VALUES (79717732567748608, 'admin', '2018-11-27 13:42:10', 0, 'admin', '2018-11-27 13:42:10', '', '??????????????????', 'process_node_type', 4.00);
INSERT INTO `t_dict` VALUES (81843858882695168, 'admin', '2018-12-03 10:30:38', 0, 'admin', '2018-12-03 10:30:49', '', '?????????', 'priority', 5.00);
INSERT INTO `t_dict` VALUES (82236987314016256, 'admin', '2018-12-04 12:32:47', 0, 'admin', '2018-12-04 12:32:47', '', '?????????', 'business_table', 6.00);
INSERT INTO `t_dict` VALUES (82236987314016257, 'admin', '2018-12-04 12:32:47', 0, 'admin', '2018-12-04 12:32:47', '', '??????????????????', 'business_form', 7.00);
INSERT INTO `t_dict` VALUES (99020862912466944, 'admin', '2019-01-19 20:05:54', 0, 'admin', '2019-01-19 20:06:10', '', '????????????', 'leave_type', 8.00);
COMMIT;

-- ----------------------------
-- Table structure for t_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `t_dict_data`;
CREATE TABLE `t_dict_data` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `dict_id` bigint(20) unsigned DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sort_order` (`sort_order`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_dict_data
-- ----------------------------
BEGIN;
INSERT INTO `t_dict_data` VALUES (75158227712479232, 'admin', '2018-11-14 23:44:19', 0, 'admin', '2019-04-01 23:53:13', '', 75135930788220928, 0.00, 0, '???', '???');
INSERT INTO `t_dict_data` VALUES (75159254272577536, 'admin', '2018-11-14 23:48:24', 0, 'admin', '2019-04-01 23:53:17', '', 75135930788220928, 1.00, 0, '???', '???');
INSERT INTO `t_dict_data` VALUES (75159898425397248, 'admin', '2018-11-14 23:50:57', 0, 'admin', '2019-04-01 23:53:22', '', 75135930788220928, 2.00, -1, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (75385648017575936, 'admin', '2018-11-15 14:48:00', 0, 'admin', '2019-04-02 00:10:36', '', 75383353938808832, 0.00, 0, '????????????', '????????????');
INSERT INTO `t_dict_data` VALUES (75385706913992704, 'admin', '2018-11-15 14:48:14', 0, 'admin', '2019-04-02 00:10:32', '', 75383353938808832, 1.00, 0, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (75385774274514944, 'admin', '2018-11-15 14:48:30', 0, 'admin', '2019-04-02 00:10:28', '', 75383353938808832, 2.00, 0, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (75390787835138048, 'admin', '2018-11-15 15:08:26', 0, 'admin', '2018-11-15 15:08:26', '', 75388696739713024, 0.00, 0, '????????????(view)', 'view');
INSERT INTO `t_dict_data` VALUES (75390886501945344, 'admin', '2018-11-15 15:08:49', 0, 'admin', '2018-11-15 15:08:57', '', 75388696739713024, 1.00, 0, '????????????(add)', 'add');
INSERT INTO `t_dict_data` VALUES (75390993939042304, 'admin', '2018-11-15 15:09:15', 0, 'admin', '2018-11-15 15:09:15', '', 75388696739713024, 2.00, 0, '????????????(edit)', 'edit');
INSERT INTO `t_dict_data` VALUES (75391067532300288, 'admin', '2018-11-15 15:09:32', 0, 'admin', '2018-11-15 15:09:32', '', 75388696739713024, 3.00, 0, '????????????(delete)', 'delete');
INSERT INTO `t_dict_data` VALUES (75391126902673408, 'admin', '2018-11-15 15:09:46', 0, 'admin', '2018-11-15 15:09:46', '', 75388696739713024, 4.00, 0, '????????????(clear)', 'clear');
INSERT INTO `t_dict_data` VALUES (75391192883269632, 'admin', '2018-11-15 15:10:02', 0, 'admin', '2018-11-15 15:10:02', '', 75388696739713024, 5.00, 0, '????????????(enable)', 'enable');
INSERT INTO `t_dict_data` VALUES (75391251024711680, 'admin', '2018-11-15 15:10:16', 0, 'admin', '2018-11-15 15:10:16', '', 75388696739713024, 6.00, 0, '????????????(disable)', 'disable');
INSERT INTO `t_dict_data` VALUES (75391297124306944, 'admin', '2018-11-15 15:10:27', 0, 'admin', '2018-11-15 15:10:27', '', 75388696739713024, 7.00, 0, '????????????(search)', 'search');
INSERT INTO `t_dict_data` VALUES (75391343379091456, 'admin', '2018-11-15 15:10:38', 0, 'admin', '2018-11-15 15:10:38', '', 75388696739713024, 8.00, 0, '????????????(upload)', 'upload');
INSERT INTO `t_dict_data` VALUES (75391407526776832, 'admin', '2018-11-15 15:10:53', 0, 'admin', '2018-11-15 15:10:53', '', 75388696739713024, 9.00, 0, '????????????(output)', 'output');
INSERT INTO `t_dict_data` VALUES (75391475042488320, 'admin', '2018-11-15 15:11:09', 0, 'admin', '2018-11-15 15:11:09', '', 75388696739713024, 10.00, 0, '????????????(input)', 'input');
INSERT INTO `t_dict_data` VALUES (75391522182270976, 'admin', '2018-11-15 15:11:21', 0, 'admin', '2018-11-15 15:11:21', '', 75388696739713024, 11.00, 0, '????????????(editPerm)', 'editPerm');
INSERT INTO `t_dict_data` VALUES (75391576364290048, 'admin', '2018-11-15 15:11:34', 0, 'admin', '2018-11-15 15:11:34', '', 75388696739713024, 12.00, 0, '????????????(setDefault)', 'setDefault');
INSERT INTO `t_dict_data` VALUES (75391798033256448, 'admin', '2018-11-15 15:12:26', 0, 'admin', '2018-11-15 15:12:26', '', 75388696739713024, 13.00, 0, '????????????(other)', 'other');
INSERT INTO `t_dict_data` VALUES (75393605291741184, 'admin', '2018-11-15 15:19:37', 0, 'admin', '2018-11-15 15:19:37', '', 75392985935646720, 0.00, 0, '????????????????????????', 'ap-beijing-1');
INSERT INTO `t_dict_data` VALUES (75393681254780928, 'admin', '2018-11-15 15:19:55', 0, 'admin', '2018-11-15 15:19:55', '', 75392985935646720, 1.00, 0, '??????', 'ap-beijing');
INSERT INTO `t_dict_data` VALUES (75393767619694592, 'admin', '2018-11-15 15:20:16', 0, 'admin', '2018-11-15 15:20:16', '', 75392985935646720, 2.00, 0, '??????????????????', 'ap-shanghai');
INSERT INTO `t_dict_data` VALUES (75393851484803072, 'admin', '2018-11-15 15:20:36', 0, 'admin', '2018-11-15 15:20:36', '', 75392985935646720, 3.00, 0, '??????????????????', 'ap-guangzhou');
INSERT INTO `t_dict_data` VALUES (75393961887272960, 'admin', '2018-11-15 15:21:02', 0, 'admin', '2018-11-15 15:21:02', '', 75392985935646720, 4.00, 0, '??????????????????', 'ap-chengdu');
INSERT INTO `t_dict_data` VALUES (75394053969022976, 'admin', '2018-11-15 15:21:24', 0, 'admin', '2018-11-15 15:21:24', '', 75392985935646720, 5.00, 0, '??????', 'ap-chongqing');
INSERT INTO `t_dict_data` VALUES (75394122474590208, 'admin', '2018-11-15 15:21:41', 0, 'admin', '2018-11-15 15:21:41', '', 75392985935646720, 6.00, 0, '?????????', 'ap-singapore');
INSERT INTO `t_dict_data` VALUES (75394186202845184, 'admin', '2018-11-15 15:21:56', 0, 'admin', '2018-11-15 15:21:56', '', 75392985935646720, 7.00, 0, '??????', 'ap-hongkong');
INSERT INTO `t_dict_data` VALUES (75394254255427584, 'admin', '2018-11-15 15:22:12', 0, 'admin', '2018-11-15 15:22:12', '', 75392985935646720, 8.00, 0, '?????????', 'na-toronto');
INSERT INTO `t_dict_data` VALUES (75394309125312512, 'admin', '2018-11-15 15:22:25', 0, 'admin', '2018-11-15 15:22:25', '', 75392985935646720, 9.00, 0, '????????????', 'eu-frankfurt');
INSERT INTO `t_dict_data` VALUES (75394367044456448, 'admin', '2018-11-15 15:22:39', 0, 'admin', '2018-11-15 15:22:39', '', 75392985935646720, 10.00, 0, '??????', 'ap-mumbai');
INSERT INTO `t_dict_data` VALUES (75394448523005952, 'admin', '2018-11-15 15:22:58', 0, 'admin', '2018-11-15 15:22:58', '', 75392985935646720, 11.00, 0, '??????', 'ap-seoul');
INSERT INTO `t_dict_data` VALUES (75394604765024256, 'admin', '2018-11-15 15:23:36', 0, 'admin', '2018-11-15 15:23:36', '', 75392985935646720, 12.00, 0, '??????', 'na-siliconvalley');
INSERT INTO `t_dict_data` VALUES (75394659299364864, 'admin', '2018-11-15 15:23:49', 0, 'admin', '2018-11-15 15:23:49', '', 75392985935646720, 13.00, 0, '????????????', 'na-ashburn');
INSERT INTO `t_dict_data` VALUES (75394705700950016, 'admin', '2018-11-15 15:24:00', 0, 'admin', '2018-11-15 15:24:00', '', 75392985935646720, 14.00, 0, '??????', 'ap-bangkok');
INSERT INTO `t_dict_data` VALUES (75394759287377920, 'admin', '2018-11-15 15:24:12', 0, 'admin', '2018-11-15 15:24:12', '', 75392985935646720, 15.00, 0, '?????????', 'eu-moscow');
INSERT INTO `t_dict_data` VALUES (79717808262352896, 'admin', '2018-11-27 13:42:28', 0, 'admin', '2018-11-27 13:42:28', '', 79717732567748608, 0.00, 0, '????????????', '0');
INSERT INTO `t_dict_data` VALUES (79717858308788224, 'admin', '2018-11-27 13:42:40', 0, 'admin', '2018-11-27 13:42:40', '', 79717732567748608, 1.00, 0, '????????????', '1');
INSERT INTO `t_dict_data` VALUES (79717920061526016, 'admin', '2018-11-27 13:42:54', 0, 'admin', '2018-12-08 20:35:39', '', 79717732567748608, 2.00, 0, '????????????', '2');
INSERT INTO `t_dict_data` VALUES (81843987719131136, 'admin', '2018-12-03 10:31:08', 0, 'admin', '2018-12-03 10:31:08', '', 81843858882695168, 0.00, 0, '??????', '0');
INSERT INTO `t_dict_data` VALUES (81844044015079424, 'admin', '2018-12-03 10:31:22', 0, 'admin', '2018-12-03 10:31:22', '', 81843858882695168, 1.00, 0, '??????', '1');
INSERT INTO `t_dict_data` VALUES (81844100705292288, 'admin', '2018-12-03 10:31:35', 0, 'admin', '2018-12-03 10:31:35', '', 81843858882695168, 2.00, 0, '??????', '2');
INSERT INTO `t_dict_data` VALUES (82237106587439104, 'admin', '2018-12-04 12:33:15', 0, 'admin', '2018-12-04 12:33:15', '', 82236987314016256, 0.00, 0, '???????????????', 't_leave');
INSERT INTO `t_dict_data` VALUES (82237106587439105, 'admin', '2018-12-04 12:33:15', 0, 'admin', '2018-12-04 12:33:15', '', 82236987314016257, 0.00, 0, '???????????????', 'leave');
INSERT INTO `t_dict_data` VALUES (99020985985929216, 'admin', '2019-01-19 20:06:23', 0, 'admin', '2019-04-01 23:55:48', '', 99020862912466944, 0.00, 0, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (99021020739932160, 'admin', '2019-01-19 20:06:32', 0, 'admin', '2019-04-01 23:55:52', '', 99020862912466944, 1.00, 0, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (99021195566911488, 'admin', '2019-01-19 20:07:13', 0, 'admin', '2019-04-01 23:55:56', '', 99020862912466944, 2.00, 0, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (99021242476007424, 'admin', '2019-01-19 20:07:24', 0, 'admin', '2019-04-01 23:56:01', '', 99020862912466944, 3.00, 0, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (99021300730695680, 'admin', '2019-01-19 20:07:38', 0, 'admin', '2019-04-01 23:56:05', '', 99020862912466944, 4.00, 0, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (99021341889400832, 'admin', '2019-01-19 20:07:48', 0, 'admin', '2019-04-01 23:56:10', '', 99020862912466944, 5.00, 0, '?????????', '?????????');
INSERT INTO `t_dict_data` VALUES (99021382393794560, 'admin', '2019-01-19 20:07:58', 0, 'admin', '2019-04-01 23:56:14', '', 99020862912466944, 6.00, 0, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (99021437171404800, 'admin', '2019-01-19 20:08:11', 0, 'admin', '2019-04-01 23:56:18', '', 99020862912466944, 7.00, 0, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (99021497724571648, 'admin', '2019-01-19 20:08:25', 0, 'admin', '2019-04-01 23:56:23', '', 99020862912466944, 8.00, 0, '??????', '??????');
INSERT INTO `t_dict_data` VALUES (99021556704874496, 'admin', '2019-01-19 20:08:39', 0, 'admin', '2019-04-01 23:56:27', '', 99020862912466944, 9.00, 0, '?????????', '?????????');
INSERT INTO `t_dict_data` VALUES (125170157323554816, 'admin', '2019-04-01 23:53:52', 0, 'admin', '2019-04-01 23:53:52', '', 75383353938808832, 3.00, 0, '?????????', '?????????');
COMMIT;

-- ----------------------------
-- Table structure for t_file
-- ----------------------------
DROP TABLE IF EXISTS `t_file`;
CREATE TABLE `t_file` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `f_key` varchar(255) DEFAULT NULL,
  `location` tinyint(1) DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `is_collect` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_file_category
-- ----------------------------
DROP TABLE IF EXISTS `t_file_category`;
CREATE TABLE `t_file_category` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  `parent_id` bigint(20) unsigned NOT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `is_collect` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_leave
-- ----------------------------
DROP TABLE IF EXISTS `t_leave`;
CREATE TABLE `t_leave` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `start_date` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `duration` int(11) unsigned DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_log
-- ----------------------------
DROP TABLE IF EXISTS `t_log`;
CREATE TABLE `t_log` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `cost_time` int(11) unsigned DEFAULT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `ip_info` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `request_param` longtext,
  `request_type` varchar(255) DEFAULT NULL,
  `request_url` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `log_type` tinyint(1) DEFAULT NULL,
  `device` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_message
-- ----------------------------
DROP TABLE IF EXISTS `t_message`;
CREATE TABLE `t_message` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `create_send` bit(1) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `content` longtext CHARACTER SET utf8mb4,
  `is_template` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message
-- ----------------------------
BEGIN;
INSERT INTO `t_message` VALUES (43615268366192640, 'admin', '2018-08-19 22:43:51', 0, 'admin', '2021-01-01 14:49:39', b'1', '???????????????????????????XBoot ????????????????????????', '????????????', '<p style=\"text-align: center;\">XBoot????????????Web???????????????????????????????????????????????????GPL v3.0??????????????????????????????????????????????????????????????????????????????</p><p style=\"text-align: center;\">????????????????????????<a href=\"http://xpay.exrick.cn/pay?xboot\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">?????????????????????</a></p><p style=\"text-align: center;\"><img src=\"https://i.loli.net/2018/08/24/5b801c8652227.png\" style=\"max-width:150px;\"><br></p><p style=\"text-align: center;\">?????????????????????</p><p style=\"text-align: center;\">?????????????????????<a href=\"http://wpa.qq.com/msgrd?v=3&amp;uin=1012139570&amp;site=qq&amp;menu=yes\" target=\"_blank\" style=\"background-color: rgb(255, 255, 255);\">????????????????????????????????????</a></p>', b'0');
INSERT INTO `t_message` VALUES (1352138048674074624, 'admin', '2021-01-21 14:16:47', 0, 'admin', '2021-01-22 01:35:38', b'0', '??????????????????????????????????????????${processName}????????????????????????${applyer}', '?????????', '<p>${nickname}?????????<span style=\"font-size: 1em;\">????????????????????????</span>??????????????????${processName}????????????????????????${nickname}?????????????????????????????????-????????????????????????????????????</p>', b'1');
INSERT INTO `t_message` VALUES (1352243408286126080, 'admin', '2021-01-21 21:15:27', 0, 'admin', '2021-01-22 01:35:21', b'0', '???????????????????????????${processName}??????????????????????????????${applyer}', '?????????', '<p>${nickname}????????????????????????????????????${processName}??????????????????????????????${applyer}???????????????????????????-??????????????????????????????<br></p>', b'1');
INSERT INTO `t_message` VALUES (1352244242726129664, 'admin', '2021-01-21 21:18:46', 0, 'admin', '2021-01-22 01:34:57', b'0', '???????????????${processName}????????????????????????', '?????????', '<p>${nickname}????????????????????????${processName}???????????????????????????????????????????????????-??????????????????????????????<br></p>', b'1');
INSERT INTO `t_message` VALUES (1352304101387538432, 'admin', '2021-01-22 01:16:37', 0, 'admin', '2021-01-22 01:33:48', b'0', '${nickname}????????????????????????${processName}?????????????????????', '?????????', '<p>${nickname}????????????????????????${processName}????????????????????????????????????????????????-??????????????????????????????<br></p>', b'1');
COMMIT;

-- ----------------------------
-- Table structure for t_message_send
-- ----------------------------
DROP TABLE IF EXISTS `t_message_send`;
CREATE TABLE `t_message_send` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `message_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_message_send
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for t_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_permission`;
CREATE TABLE `t_permission` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `parent_id` bigint(20) unsigned NOT NULL,
  `type` tinyint(1) DEFAULT NULL,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `component` varchar(255) DEFAULT NULL,
  `path` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `level` int(11) unsigned DEFAULT NULL,
  `button_type` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `show_always` bit(1) DEFAULT NULL,
  `is_menu` bit(1) DEFAULT NULL,
  `is_parent` bit(1) DEFAULT NULL,
  `i18n` varchar(255) DEFAULT NULL,
  `localize` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_permission
-- ----------------------------
BEGIN;
INSERT INTO `t_permission` VALUES (5129710648430592, '', '2018-06-04 19:02:29', 0, 'admin', '2021-01-11 01:00:01', '', 'sys', 125909152017944576, 0, 1.00, 'Main', '/sys', '????????????', 'ios-settings', 1, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (5129710648430593, '', '2018-06-04 19:02:32', 0, 'admin', '2022-02-21 01:19:08', '', 'user-manage', 5129710648430592, 0, 1.10, 'sys/user-manage/userManage', 'user-manage', '????????????', 'md-person', 2, '', 0, '', b'1', NULL, b'1', '', b'0');
INSERT INTO `t_permission` VALUES (5129710648430594, '', '2018-06-04 19:02:35', 0, '', '2018-10-13 13:51:36', '', 'role-manage', 5129710648430592, 0, 1.60, 'sys/role-manage/roleManage', 'role-manage', '??????????????????', 'md-contacts', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (5129710648430595, '', '2018-06-04 19:02:37', 0, '', '2018-09-23 23:32:02', '', 'menu-manage', 5129710648430592, 0, 1.70, 'sys/menu-manage/menuManage', 'menu-manage', '??????????????????', 'md-menu', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (15701400130424832, '', '2018-06-03 22:04:06', 0, '', '2018-09-19 22:16:44', '', '', 5129710648430593, 1, 1.11, '', '/xboot/user/admin/add*', '????????????', '', 3, 'add', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (15701915807518720, '', '2018-06-03 22:06:09', 0, '', '2018-06-06 14:46:51', '', '', 5129710648430593, 1, 1.13, '', '/xboot/user/admin/disable/**', '????????????', '', 3, 'disable', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (15708892205944832, '', '2018-06-03 22:33:52', 0, '', '2018-06-28 16:44:48', '', '', 5129710648430593, 1, 1.14, '', '/xboot/user/admin/enable/**', '????????????', '', 3, 'enable', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (16392452747300864, '', '2018-06-05 19:50:06', 0, 'admin', '2021-12-29 00:29:12', '', 'access', 125909152017944576, 0, 7.00, 'Main', '/access', '???????????????', 'md-lock', 1, '', 0, '', b'0', NULL, b'1', '', b'0');
INSERT INTO `t_permission` VALUES (16392767785668608, '', '2018-06-05 19:51:21', 0, 'admin', '2021-12-28 00:46:21', '', 'access_index', 16392452747300864, 0, 5.10, 'access/access', 'index', '?????????????????????', 'md-lock', 2, '', 0, '', b'1', NULL, b'1', 'permTestPage', b'1');
INSERT INTO `t_permission` VALUES (16438800255291392, '', '2018-06-05 22:54:18', 0, 'admin', '2022-02-21 01:17:23', '', '', 16392767785668608, 1, 5.11, '', '', '??????????????????', '', 3, 'add', 0, '', b'1', NULL, NULL, '', b'0');
INSERT INTO `t_permission` VALUES (16438962738434048, '', '2018-06-05 22:54:55', 0, 'admin', '2022-02-21 01:18:51', '', '', 16392767785668608, 1, 5.12, '', '', '??????????????????', '', 3, 'edit', 0, '', b'1', NULL, NULL, '', b'0');
INSERT INTO `t_permission` VALUES (16439068543946752, '', '2018-06-05 22:55:20', 0, 'admin', '2022-02-21 01:18:56', '', '', 16392767785668608, 1, 5.13, '', '', '??????????????????', '', 3, 'delete', 0, '', b'1', NULL, NULL, '', b'0');
INSERT INTO `t_permission` VALUES (16678126574637056, '', '2018-06-06 14:45:16', 0, '', '2018-09-19 22:16:48', '', '', 5129710648430593, 1, 1.12, '', '/xboot/user/admin/edit*', '????????????', '', 3, 'edit', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (16678447719911424, '', '2018-06-06 14:46:32', 0, '', '2018-08-10 21:41:16', '', '', 5129710648430593, 1, 1.15, '', '/xboot/user/delByIds/**', '????????????', '', 3, 'delete', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (16687383932047360, '', '2018-06-06 15:22:03', 0, '', '2018-09-19 22:07:34', '', '', 5129710648430594, 1, 1.21, '', '/xboot/role/save*', '????????????', '', 3, 'add', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (16689632049631232, '', '2018-06-06 15:30:59', 0, '', '2018-09-19 22:07:37', '', '', 5129710648430594, 1, 1.22, '', '/xboot/role/edit*', '????????????', '', 3, 'edit', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (16689745006432256, '', '2018-06-06 15:31:26', 0, '', '2018-08-10 21:41:23', '', '', 5129710648430594, 1, 1.23, '', '/xboot/role/delAllByIds/**', '????????????', '', 3, 'delete', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (16689883993083904, NULL, '2018-06-06 15:31:59', 0, NULL, '2018-06-06 15:31:59', NULL, NULL, 5129710648430594, 1, 1.24, NULL, '/xboot/role/editRolePerm**', '????????????', NULL, 3, 'editPerm', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (16690313745666048, '', '2018-06-06 15:33:41', 0, '', '2018-09-19 22:07:46', '', '', 5129710648430594, 1, 1.25, '', '/xboot/role/setDefault*', '??????????????????', '', 3, 'setDefault', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (16694861252005888, '', '2018-06-06 15:51:46', 0, '', '2018-09-19 22:07:52', '', '', 5129710648430595, 1, 1.31, '', '/xboot/permission/add*', '????????????', '', 3, 'add', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (16695107491205120, '', '2018-06-06 15:52:44', 0, '', '2018-09-19 22:07:57', '', '', 5129710648430595, 1, 1.32, '', '/xboot/permission/edit*', '????????????', '', 3, 'edit', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (16695243126607872, '', '2018-06-06 15:53:17', 0, '', '2018-08-10 21:41:33', '', '', 5129710648430595, 1, 1.33, '', '/xboot/permission/delByIds/**', '????????????', '', 3, 'delete', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (25014528525733888, '', '2018-06-29 14:51:09', 0, '', '2018-10-08 11:13:27', '', '', 5129710648430593, 1, 1.16, '', '???', '????????????', '', 3, 'upload', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (39915540965232640, NULL, '2018-08-09 17:42:28', 0, NULL, '2018-08-09 17:42:28', NULL, 'monitor', 125909152017944576, 0, 2.00, 'Main', '/monitor', '????????????', 'ios-analytics', 1, NULL, 0, NULL, b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (39916171171991552, '', '2018-08-09 17:44:57', 0, 'admin', '2019-01-20 00:37:29', '', 'druid', 39915540965232640, 0, 2.40, 'sys/monitor/monitor', 'druid', 'SQL??????', 'md-analytics', 2, '', 0, 'http://127.0.0.1:8888/druid/login.html', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (39918482854252544, '', '2018-08-09 17:54:08', 0, 'admin', '2020-11-19 16:23:56', '', 'swagger', 39915540965232640, 0, 2.50, 'sys/monitor/monitor', 'swagger', '????????????', 'md-document', 2, '', 0, 'http://127.0.0.1:8888/doc.html', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (40238597734928384, '', '2018-08-10 15:06:10', 0, 'admin', '2020-12-10 02:21:33', '', 'department-manage', 5129710648430592, 0, 1.20, 'sys/department-manage/departmentManage', 'department-manage', '????????????', 'md-git-branch', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (41363147411427328, '', '2018-08-13 17:34:43', 0, 'admin', '2020-03-25 20:31:16', '', 'log-manage', 39915540965232640, 0, 2.20, 'sys/log-manage/logManage', 'log-manage', '????????????', 'md-list-box', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (41363537456533504, '', '2018-08-13 17:36:16', 0, '', '2018-08-13 17:56:11', '', '', 41363147411427328, 1, 2.11, '', '/xboot/log/delByIds/**', '????????????', '', 3, 'delete', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (41364927394353152, '', '2018-08-13 17:41:48', 0, 'admin', '2020-12-11 16:32:40', '', '', 41363147411427328, 1, 2.12, '', '/xboot/log/delAll*', '????????????', '', 3, 'clear', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (41370251991977984, NULL, '2018-08-13 18:02:57', 0, NULL, '2018-08-13 18:02:57', NULL, 'quartz-job', 39915540965232640, 0, 2.10, 'sys/quartz-manage/quartzManage', 'quartz-job', '????????????', 'md-time', 2, '', 0, NULL, b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (41371711400054784, '', '2018-08-13 18:08:45', 0, '', '2019-07-07 21:24:26', '', 'actuator', 39915540965232640, 0, 2.30, 'sys/actuator/actuator', 'actuator', 'Actuator??????', 'logo-angular', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (41373430515240960, '', '2018-08-13 18:15:35', 0, 'admin', '2019-11-22 11:47:07', '', 'vue-template', 125909152017944576, 0, 3.10, 'Main', '/vue-template', '??????Vue??????', 'ios-albums', 1, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (41375330996326400, '', '2018-08-13 18:23:08', 0, 'admin', '2020-03-21 20:41:28', '', 'simple-table', 41373430515240960, 0, 3.10, 'xboot-vue-template/simple-table/simpleTable', 'simple-table', '????????????+?????????', 'ios-grid-outline', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (41376192166629376, '', '2018-08-13 18:26:33', 0, 'admin', '2018-10-20 22:47:26', '', 'search-table', 41373430515240960, 0, 3.40, 'xboot-vue-template/search-table/searchTable', 'search-table', '????????????[??????]', 'md-grid', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (41377034236071936, '', '2018-08-13 18:29:54', 0, 'admin', '2018-10-20 22:47:33', '', 'complex-table', 41373430515240960, 0, 3.50, 'xboot-vue-template/complex-table/complexTable', 'complex-table', '????????????[??????]', 'ios-grid', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (41378916912336896, '', '2018-08-13 18:37:23', 0, 'admin', '2019-04-12 15:38:08', '', 'tree', 41373430515240960, 0, 3.22, 'xboot-vue-template/tree/tree', 'tree', '????????????', 'ios-git-network', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (41469219249852416, NULL, '2018-08-14 00:36:13', 0, NULL, '2018-08-14 00:36:13', NULL, '', 41371711400054784, 1, 2.31, '', '???', '????????????', '', 3, 'view', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (42082442672082944, '', '2018-08-15 17:12:57', 0, 'admin', '2019-04-12 15:48:50', '', 'new-window', 41373430515240960, 0, 3.21, 'xboot-vue-template/new-window/newWindow', 'new-window', '???????????????', 'ios-browsers', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (43117268627886080, '', '2018-08-18 13:44:58', 0, '', '2018-08-18 20:55:04', '', 'message-manage', 5129710648430592, 0, 1.30, 'sys/message-manage/messageManage', 'message-manage', '????????????[??????]', 'md-mail', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (44986029924421632, '', '2018-08-23 17:30:46', 0, '', '2018-09-23 23:26:53', '', 'social-manage', 5129710648430592, 0, 1.50, 'sys/social-manage/socialManage', 'social-manage', '??????????????????[??????]', 'md-share', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (45069342940860416, '', '2018-08-23 23:01:49', 0, '', '2018-08-24 10:01:09', '', '', 44986029924421632, 1, 1.42, '', '???', '????????????????????????', '', 3, 'view', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45235228800716800, '', '2018-08-24 10:01:00', 0, '', '2018-09-19 22:07:23', '', '', 44986029924421632, 1, 1.41, '', '/xboot/relate/delByIds*', '????????????', '', 3, 'delete', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45235621697949696, '', '2018-08-24 10:02:33', 0, '', '2018-09-19 22:06:57', '', '', 40238597734928384, 1, 1.21, '', '/xboot/department/add*', '????????????', '', 3, 'add', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45235787867885568, '', '2018-08-24 10:03:13', 0, '', '2018-09-19 22:07:02', '', '', 40238597734928384, 1, 1.22, '', '/xboot/department/edit*', '????????????', '', 3, 'edit', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45235939278065664, NULL, '2018-08-24 10:03:49', 0, NULL, '2018-08-24 10:03:49', NULL, '', 40238597734928384, 1, 1.23, '', '/xboot/department/delByIds/*', '????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45236734832676864, '', '2018-08-24 10:06:59', 0, '', '2018-09-19 22:07:07', '', '', 43117268627886080, 1, 1.31, '', '/xboot/message/add*', '????????????', '', 3, 'add', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45237010692050944, '', '2018-08-24 10:08:04', 0, '', '2018-09-19 22:07:12', '', '', 43117268627886080, 1, 1.32, '', '/xboot/message/edit*', '????????????', '', 3, 'edit', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45237170029465600, NULL, '2018-08-24 10:08:42', 0, NULL, '2018-08-24 10:08:42', NULL, '', 43117268627886080, 1, 1.33, '', '/xboot/message/delByIds/*', '????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45264987354042368, '', '2018-08-24 11:59:14', 0, '', '2018-09-19 22:08:11', '', '', 41370251991977984, 1, 2.11, '', '/xboot/quartzJob/add*', '??????????????????', '', 3, 'add', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45265487029866496, '', '2018-08-24 12:01:14', 0, '', '2018-09-19 22:08:17', '', '', 41370251991977984, 1, 2.12, '', '/xboot/quartzJob/edit*', '??????????????????', '', 3, 'edit', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45265762415284224, '', '2018-08-24 12:02:19', 0, '', '2018-09-19 22:08:24', '', '', 41370251991977984, 1, 2.13, '', '/xboot/quartzJob/pause*', '??????????????????', '', 3, 'disable', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45265886315024384, '', '2018-08-24 12:02:49', 0, '', '2018-09-19 22:09:13', '', '', 41370251991977984, 1, 2.14, '', '/xboot/quartzJob/resume*', '??????????????????', '', 3, 'enable', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (45266070000373760, NULL, '2018-08-24 12:03:33', 0, NULL, '2018-08-24 12:03:33', NULL, '', 41370251991977984, 1, 2.15, '', '/xboot/quartzJob/delByIds/*', '??????????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (56309618086776832, '', '2018-09-23 23:26:40', 0, 'admin', '2018-11-15 15:17:43', '', 'oss-manage', 5129710648430592, 0, 1.40, 'sys/oss-manage/ossManage', 'oss-manage', '??????????????????[??????]', 'ios-folder', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (56898976661639168, '', '2018-09-25 14:28:34', 0, '', '2018-09-25 15:12:46', '', '', 5129710648430593, 1, 1.17, '', '/xboot/user/importData*', '????????????', '', 3, 'input', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (56911328312299520, '', '2018-09-25 15:17:39', 0, 'admin', '2018-10-20 22:47:36', '', 'excel', 41373430515240960, 0, 3.60, 'xboot-vue-template/excel/excel', 'excel', 'Excel????????????[??????]', 'md-exit', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (57009544286441472, NULL, '2018-09-25 21:47:55', 0, NULL, '2018-09-25 21:47:55', NULL, '', 43117268627886080, 1, 1.40, '', '/xboot/messageSend/save*', '?????????????????????', '', 3, 'add', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (57009744761589760, NULL, '2018-09-25 21:48:43', 0, NULL, '2018-09-25 21:48:43', NULL, '', 43117268627886080, 1, 1.50, '', '/xboot/messageSend/update*', '?????????????????????', '', 3, 'edit', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (57009981228060672, NULL, '2018-09-25 21:49:39', 0, NULL, '2018-09-25 21:49:39', NULL, '', 43117268627886080, 1, 1.60, '', '/xboot/messageSend/delByIds/*', '?????????????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (57212882168844288, '', '2018-09-26 11:15:55', 0, '', '2018-10-08 11:10:05', '', '', 56309618086776832, 1, 1.41, '', '???', '????????????', '', 3, 'upload', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (58480609315524608, '', '2018-09-29 23:13:24', 0, 'admin', '2018-11-14 13:24:26', '', 'setting', 5129710648430592, 0, 1.90, 'sys/setting-manage/settingManage', 'setting', '????????????[??????]', 'ios-settings-outline', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (61394706252173312, NULL, '2018-10-08 00:12:59', 0, NULL, '2018-10-08 00:12:59', NULL, '', 58480609315524608, 1, 1.81, '', '/xboot/setting/seeSecret/**', '??????????????????', '', 3, 'view', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (61417744146370560, '', '2018-10-08 01:44:32', 0, '', '2018-10-08 01:50:03', '', '', 58480609315524608, 1, 1.82, '', '/xboot/setting/*/set*', '????????????', '', 3, 'edit', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (61560041605435392, NULL, '2018-10-08 11:09:58', 0, NULL, '2018-10-08 11:09:58', NULL, '', 56309618086776832, 1, 1.42, '', '/xboot/file/rename*', '???????????????', '', 3, 'edit', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (61560275261722624, NULL, '2018-10-08 11:10:54', 0, NULL, '2018-10-08 11:10:54', NULL, '', 56309618086776832, 1, 1.43, '', '/xboot/file/copy*', '????????????', '', 3, 'edit', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (61560480518377472, NULL, '2018-10-08 11:11:43', 0, NULL, '2018-10-08 11:11:43', NULL, '', 56309618086776832, 1, 1.44, '', '/xboot/file/delete/*', '????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (63482475359244288, '', '2018-10-13 18:29:02', 0, 'admin', '2018-10-20 22:47:45', '', 'custom-tree', 41373430515240960, 0, 3.80, 'xboot-vue-template/custom-tree/customTree', 'custom-tree', '????????????[??????]', 'md-git-network', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (63741744973352960, '', '2018-10-14 11:39:17', 0, 'admin', '2019-02-04 17:03:07', '', 'render', 41373430515240960, 0, 3.30, 'xboot-vue-template/render/render', 'render', 'Render????????????[??????]', 'md-aperture', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (64290663792906240, '', '2018-10-16 00:00:29', 0, 'admin', '2018-10-20 22:47:49', '', 'tree&table', 41373430515240960, 0, 3.90, 'xboot-vue-template/tree&table/tree&table', 'tree&table', '???+??????[??????]', 'md-list', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (66790433014943744, 'admin', '2018-10-22 21:33:42', 0, 'admin', '2018-10-22 21:37:12', '', 'card-list', 41373430515240960, 0, 3.91, 'xboot-vue-template/card-list/cardList', 'card-list', '????????????[??????]', 'md-card', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (75002207560273920, 'admin', '2018-11-14 13:24:21', 0, 'admin', '2018-11-20 20:06:22', '', 'dict', 5129710648430592, 0, 1.80, 'sys/dict-manage/dictManage', 'dict', '??????????????????', 'md-bookmarks', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (76215889006956544, 'admin', '2018-11-17 21:47:05', 0, 'admin', '2018-11-17 21:47:53', '', '', 75002207560273920, 1, 1.81, '', '/xboot/dict/add*', '????????????', '', 3, 'add', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (76216071333351424, 'admin', '2018-11-17 21:47:48', 0, 'admin', '2018-11-17 21:47:48', NULL, '', 75002207560273920, 1, 1.82, '', '/xboot/dict/edit*', '????????????', '', 3, 'edit', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (76216264070008832, 'admin', '2018-11-17 21:48:34', 0, 'admin', '2018-11-17 21:48:34', NULL, '', 75002207560273920, 1, 1.83, '', '/xboot/dict/delByIds/**', '????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (76216459709124608, 'admin', '2018-11-17 21:49:21', 0, 'admin', '2018-11-17 21:49:21', NULL, '', 75002207560273920, 1, 1.84, '', '/xboot/dictData/add*', '??????????????????', '', 3, 'add', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (76216594207870976, 'admin', '2018-11-17 21:49:53', 0, 'admin', '2018-11-17 21:49:53', NULL, '', 75002207560273920, 1, 1.85, '', '/xboot/dictData/edit*', '??????????????????', '', 3, 'edit', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (76216702639017984, 'admin', '2018-11-17 21:50:18', 0, 'admin', '2018-11-17 21:50:18', NULL, '', 75002207560273920, 1, 1.86, '', '/xboot/dictData/delByIds/**', '??????????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (76606430504816640, 'admin', '2018-11-18 23:38:57', 0, 'admin', '2018-11-18 23:39:12', '', 'activiti', 125909152017944576, 0, 1.10, 'Main', '/activiti', '????????????', 'md-git-compare', 1, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (76607201262702592, 'admin', '2018-11-18 23:42:01', 0, 'admin', '2018-11-20 19:41:58', '', 'model-manage', 76606430504816640, 0, 1.00, 'activiti/model-manage/modelManage', 'model-manage', '????????????[??????]', 'md-cube', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (76914082455752704, 'admin', '2018-11-19 20:01:28', 0, 'admin', '2018-11-20 19:41:50', '', 'process-manage', 76606430504816640, 0, 0.90, 'activiti/process-manage/processManage', 'process-manage', '????????????[??????]', 'md-calendar', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (80539147005071360, 'admin', '2018-11-29 20:06:10', 0, 'admin', '2018-12-04 14:14:41', '', 'category-manage', 76606430504816640, 0, 2.00, 'activiti/category-manage/categoryManage', 'category-manage', '??????????????????[??????]', 'md-bookmark', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (81319435670917120, 'admin', '2018-12-01 23:46:45', 0, 'admin', '2018-12-02 15:37:03', '', 'process-ins-manage', 76606430504816640, 0, 0.70, 'activiti/process-ins-manage/processInsManage', 'process-ins-manage', '??????????????????[??????]', 'md-fastforward', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (81558529864896512, 'admin', '2018-12-02 15:36:50', 0, 'admin', '2018-12-08 14:50:38', '', 'apply-manage', 76606430504816640, 0, 0.00, 'activiti/apply-manage/applyManage', 'apply-manage', '????????????[??????]', 'md-clipboard', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (81716172680073216, 'admin', '2018-12-03 02:03:15', 0, 'admin', '2018-12-03 02:03:15', NULL, 'todo-manage', 76606430504816640, 0, 0.10, 'activiti/todo-manage/todoManage', 'todo-manage', '????????????[??????]', 'ios-pricetag', 2, '', 0, NULL, b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (82269650301227008, 'admin', '2018-12-04 14:42:34', 0, 'admin', '2018-12-04 14:42:34', NULL, 'done-manage', 76606430504816640, 0, 0.20, 'activiti/done-manage/doneManage', 'done-manage', '????????????[??????]', 'ios-pricetag-outline', 2, '', 0, NULL, b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (84082369492946944, 'admin', '2018-12-09 14:45:40', 0, 'admin', '2018-12-09 14:46:59', '', '', 81558529864896512, 1, 0.00, '', '/xboot/leave/add*', '??????????????????', '', 3, 'add', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84082920431554560, 'admin', '2018-12-09 14:47:51', 0, 'admin', '2020-12-11 01:18:01', '', '', 81558529864896512, 1, 4.00, '', '/xboot/actBusiness/delByIds/**', '??????????????????', '', 3, 'delete', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84083562503999488, 'admin', '2018-12-09 14:50:25', 0, 'admin', '2018-12-09 14:50:25', NULL, '', 81716172680073216, 1, 0.00, '', '/xboot/actTask/pass**', '????????????', '', 3, 'enable', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84083641302388736, 'admin', '2018-12-09 14:50:43', 0, 'admin', '2018-12-09 14:50:43', NULL, '', 81716172680073216, 1, 1.00, '', '/xboot/actTask/back**', '????????????', '', 3, 'disable', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84084404707659776, 'admin', '2018-12-09 14:53:45', 0, 'admin', '2018-12-09 14:53:45', NULL, '', 81716172680073216, 1, 3.00, '', '/xboot/actTask/delegate**', '????????????', '', 3, 'other', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84084724590448640, 'admin', '2018-12-09 14:55:02', 0, 'admin', '2018-12-09 14:55:02', NULL, '', 82269650301227008, 1, 0.00, '', '/xboot/actTask/deleteHistoric/**', '??????????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84084965817454592, 'admin', '2018-12-09 14:55:59', 0, 'admin', '2018-12-09 14:55:59', NULL, '', 81319435670917120, 1, 0.00, '', '/xboot/actProcess/delInsByIds/**', '??????????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84085542324539392, 'admin', '2018-12-09 14:58:17', 0, 'admin', '2018-12-09 14:58:17', NULL, '', 76914082455752704, 1, 0.00, '', '/xboot/actProcess/updateInfo/**', '??????????????????', '', 3, 'edit', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84085810797744128, 'admin', '2018-12-09 14:59:21', 0, 'admin', '2018-12-09 14:59:21', NULL, '', 76914082455752704, 1, 1.00, '', '/xboot/actProcess/editNodeUser**', '??????????????????', '', 3, 'edit', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84085980943880192, 'admin', '2018-12-09 15:00:01', 0, 'admin', '2018-12-09 15:00:01', NULL, '', 76914082455752704, 1, 2.00, '', '/xboot/actProcess/convertToModel/**', '???????????????', '', 3, 'other', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84086163001839616, 'admin', '2018-12-09 15:00:45', 0, 'admin', '2018-12-09 15:01:37', '', '', 76914082455752704, 1, 3.00, '', '/xboot/actProcess/delByIds/**', '??????????????????', '', 3, 'delete', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84086362248056832, 'admin', '2018-12-09 15:01:32', 0, 'admin', '2018-12-09 15:01:32', NULL, '', 76914082455752704, 1, 4.00, '', '/xboot/actModel/deployByFile**', '??????????????????', '', 3, 'other', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84086882907983872, 'admin', '2018-12-09 15:03:36', 0, 'admin', '2018-12-09 15:03:36', NULL, '', 76607201262702592, 1, 0.00, '', '/xboot/actModel/add**', '????????????', '', 3, 'add', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84087009940869120, 'admin', '2018-12-09 15:04:06', 0, 'admin', '2018-12-09 15:04:06', NULL, '', 76607201262702592, 1, 1.00, '', '/xboot/actModel/delByIds/**', '????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84087154040377344, 'admin', '2018-12-09 15:04:41', 0, 'admin', '2018-12-09 15:04:41', NULL, '', 76607201262702592, 1, 2.00, '', '/xboot/actModel/deploy/**', '????????????', '', 3, 'other', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84087344352727040, 'admin', '2018-12-09 15:05:26', 0, 'admin', '2018-12-09 15:05:33', '', '', 80539147005071360, 1, 0.00, '', '/xboot/actCategory/add**', '??????????????????', '', 3, 'add', 0, '', b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84087480852156416, 'admin', '2018-12-09 15:05:59', 0, 'admin', '2018-12-09 15:05:59', NULL, '', 80539147005071360, 1, 1.00, '', '/xboot/actCategory/edit**', '??????????????????', '', 3, 'edit', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (84087593041399808, 'admin', '2018-12-09 15:06:25', 0, 'admin', '2018-12-09 15:06:25', NULL, '', 80539147005071360, 1, 2.00, '', '/xboot/actCategory/delByIds/**', '??????????????????', '', 3, 'delete', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (102235632889237504, 'admin', '2019-01-28 17:00:15', 0, 'admin', '2019-11-22 11:47:14', '', 'vue-generator', 125909152017944576, 0, 3.00, 'Main', '/vue-generator', 'Vue????????????', 'md-send', 1, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (102237605176807424, 'admin', '2019-01-28 17:08:06', 0, 'admin', '2019-02-01 20:41:31', '', 'table-generator', 102235632889237504, 0, 0.00, 'xboot-vue-generator/tableGenerator', 'table', '?????????????????????[??????]', 'md-grid', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (102240052523831296, 'admin', '2019-01-28 17:17:49', 0, 'admin', '2019-02-01 20:41:38', '', 'tree-generator', 102235632889237504, 0, 1.00, 'xboot-vue-generator/treeGenerator', 'tree', '??????????????????[??????]', 'md-git-branch', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (103658022701633536, 'admin', '2019-02-01 15:12:20', 0, 'admin', '2019-02-01 18:38:29', '', 'test', 102235632889237504, 0, 3.00, 'xboot-vue-generator/test', 'test', '?????????????????????', 'ios-bug', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (103658022701633537, 'admin', '2022-05-09 15:12:20', 0, 'admin', '2022-05-09 18:38:29', '', 'test2', 102235632889237504, 0, 3.00, 'xboot-vue-generator/test2', 'test2', '?????????????????????2', 'ios-bug', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (113601631450304512, 'admin', '2019-03-01 01:44:41', 0, 'admin', '2019-03-01 01:44:41', NULL, '', 81716172680073216, 1, 2.00, '', '/xboot/actTask/backAll/**', '????????????????????????', '', 3, 'disable', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (113602149589454848, 'admin', '2019-03-01 01:46:44', 0, 'admin', '2021-05-20 23:49:35', '', 'components', 125909152017944576, 0, 5.00, 'Main', '/components', 'XBoot????????????', 'md-cube', 1, '', 0, '', b'0', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (113602342657462272, 'admin', '2019-03-01 01:47:30', 0, 'admin', '2021-05-20 23:49:28', '', 'components', 113602149589454848, 0, 0.00, 'xboot-components/xboot-components', 'components', 'XBoot????????????', 'md-cube', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (113603512293658624, 'admin', '2019-03-01 01:52:09', 0, 'admin', '2019-06-26 20:38:47', '', 'library', 125909152017944576, 0, 6.00, 'Main', '/library', '?????????????????????/??????', 'ios-link', 1, '', 0, '', b'0', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (113603617897844736, 'admin', '2019-03-01 01:52:34', 0, 'admin', '2019-03-01 02:03:15', '', 'library', 113603512293658624, 0, 0.00, 'xboot-library/xboot-library', 'library', '?????????????????????/??????', 'ios-link', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (117806106536841216, 'admin', '2019-03-12 16:11:46', 0, 'admin', '2019-03-12 16:11:46', NULL, 'process-finish-manage', 76606430504816640, 0, 0.80, 'activiti/process-finish-manage/processFinishManage', 'process-finish-manage', '???????????????[??????]', 'md-power', 2, '', 0, NULL, b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (121426317022334976, 'admin', '2019-03-22 15:57:11', 0, 'admin', '2019-03-22 15:57:11', NULL, 'redis', 39915540965232640, 0, 2.21, 'sys/redis/redis', 'redis', 'Redis????????????', 'md-barcode', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (125909152017944576, 'admin', '2019-04-04 00:50:22', 0, 'admin', '2021-12-28 00:49:52', 'undefined', 'xboot', 0, -1, 0.00, 'normal', '', 'XBoot????????????', 'md-home', 0, '', 0, '', b'1', b'1', b'1', 'xbootAdmin', b'1');
INSERT INTO `t_permission` VALUES (127995258721013760, 'admin', '2019-04-09 18:59:49', 0, 'admin', '2021-12-28 00:50:36', 'window', 'doc', 0, -1, 2.00, 'normal', '', '????????????', 'md-document', 0, '', 0, 'https://www.kancloud.cn/exrick/xboot/content', b'1', b'0', b'0', 'devDocs', b'1');
INSERT INTO `t_permission` VALUES (127996320085446656, 'admin', '2019-04-09 19:04:02', 0, 'admin', '2021-12-28 00:49:34', '', 'app', 0, -1, 1.00, 'normal', '', 'App?????????toC???', 'md-phone-portrait', 0, '', 0, '', b'1', b'1', b'1', 'appAdmin', b'1');
INSERT INTO `t_permission` VALUES (127996726786134016, 'admin', '2019-04-09 19:05:39', 0, 'admin', '2020-05-24 20:08:26', 'window', 'xpay', 0, -1, 3.00, 'normal', '', 'XPay????????????', 'md-cash', 0, '', 0, 'http://xpay.exrick.cn', b'1', b'0', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (127997001756315648, 'admin', '2019-04-09 19:06:44', 0, 'admin', '2021-04-15 23:14:55', 'window', 'xmall', 0, -1, 4.00, 'normal', '', 'XMall??????', 'md-cart', 0, '', 0, 'http://xmall.exrick.cn', b'1', b'0', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (128364633437245440, 'admin', '2019-04-10 19:27:35', 0, 'admin', '2021-01-02 17:21:23', 'window', 'xboot-show', 0, -1, 2.10, 'normal', '', 'XBoot????????????', 'md-paper-plane', 0, '', 0, 'http://xb.exrick.cn', b'1', b'0', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (128366789653434368, 'admin', '2019-04-10 19:36:09', 0, 'admin', '2022-02-22 01:06:53', '', 'app', 127996320085446656, 0, 1.00, 'Main', '/app', 'App??????', 'md-phone-portrait', 1, '', 0, '', b'0', NULL, b'1', '', b'0');
INSERT INTO `t_permission` VALUES (128368112335589376, 'admin', '2019-04-10 19:41:24', 0, 'admin', '2022-02-22 01:07:24', '', 'uniapp', 128366789653434368, 0, 0.00, 'uniapp/uniapp', 'uniapp', 'App????????????', 'md-phone-portrait', 2, '', 0, '', b'1', NULL, b'0', '', b'0');
INSERT INTO `t_permission` VALUES (129033675403694080, 'admin', '2019-04-12 15:46:07', 0, 'admin', '2019-11-25 17:33:43', '', 'single-window', 41373430515240960, 0, 1.00, 'xboot-vue-template/single-window/singleWindow', 'single-window', '????????????????????????', 'md-easel', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (149452775095275520, 'admin', '2019-06-08 00:04:19', 0, 'admin', '2020-12-13 17:01:58', '', 'admin', 39915540965232640, 0, 2.29, 'sys/monitor/monitor', '/admin', 'Admin??????', 'md-speedometer', 2, '', 0, 'http://127.0.0.1:8888/xboot/admin/wallboard', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (156365156580855808, 'admin', '2019-06-27 01:51:39', 0, 'admin', '2019-06-27 01:51:39', NULL, '', 5129710648430593, 1, 1.18, '', '/xboot/user/resetPass', '????????????', '', 3, 'other', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (160509731956330496, 'admin', '2019-07-08 12:20:43', 0, 'admin', '2019-07-08 12:22:13', '', 'weapp', 127996320085446656, 0, 0.00, 'Main', '/weapp', '???????????????', 'ios-appstore', 1, '', 0, '', b'0', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (160509918166650881, 'admin', '2019-07-08 12:21:28', 0, 'admin', '2020-04-27 11:10:54', '', 'weapp', 160509731956330496, 0, 0.00, 'weapp/weapp', 'weapp', '???????????????', 'md-phone-portrait', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (175808753877127169, 'admin', '2019-08-19 17:33:34', 0, 'admin', '2020-08-14 14:34:16', '', 'sso', 125909152017944576, 0, 8.00, 'Main', '/sso', '?????????????????????', 'md-log-in', 1, '', 0, '', b'0', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (175808922710446081, 'admin', '2019-08-19 17:34:15', 0, 'admin', '2021-12-28 00:47:10', '', 'sso', 175808753877127169, 0, 0.00, 'sso/sso', 'sso', '?????????????????????', 'md-log-in', 2, '', 0, '', b'1', NULL, b'0', 'ssoTestPage', b'1');
INSERT INTO `t_permission` VALUES (210154306362413056, 'admin', '2019-11-22 12:10:32', 0, 'admin', '2021-01-15 21:53:12', '', 'charts', 125909152017944576, 0, 3.10, 'Main', '/charts', '??????????????????', 'md-analytics', 1, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (210155258859491329, 'admin', '2019-11-22 12:14:19', 0, 'admin', '2019-11-22 12:20:50', '', 'dashboard1', 210154306362413056, 0, 0.00, 'xboot-charts/dashboard1/dashboard1', 'dashboard1', 'Dashboard1[??????]', 'md-speedometer', 2, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (210156371755143168, 'admin', '2019-11-22 12:18:45', 0, 'admin', '2019-11-22 12:18:45', NULL, 'dashboard2', 210154306362413056, 0, 1.00, 'xboot-charts/dashboard2/dashboard2', 'dashboard2', 'Dashboard2[??????]', 'ios-speedometer', 2, '', 0, NULL, b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (211251162815401984, 'admin', '2019-11-25 12:49:03', 0, 'admin', '2019-11-25 12:49:12', '', 'open', 125909152017944576, 0, 1.20, 'Main', '/open', '????????????', 'ios-apps', 1, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (211251678651879424, 'admin', '2019-11-25 12:51:06', 0, 'admin', '2020-12-10 12:16:22', '', 'client', 211251162815401984, 0, 0.00, 'open/client/client', 'client', '??????????????????', 'md-browsers', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (211652331387752448, 'admin', '2019-11-26 15:23:09', 0, 'admin', '2020-12-10 12:16:35', '', 'doc', 211251162815401984, 0, 1.00, 'sys/monitor/monitor', 'doc', '??????????????????', 'md-document', 2, '', 0, 'https://www.kancloud.cn/exrick/xboot/1399478', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1251152298521006080, 'admin', '2020-04-17 22:15:28', 0, 'admin', '2020-04-27 18:30:59', '', 'member', 127996320085446656, 0, 2.00, 'Main', '/member', '????????????', 'md-contact', 1, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (1251153074307862528, 'admin', '2020-04-17 22:18:33', 0, 'admin', '2021-11-14 20:35:56', '', 'member', 1251152298521006080, 0, 0.00, 'app-toC/member/member', 'member', '??????????????????[??????]', 'md-contacts', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (1251760630449442816, 'admin', '2020-04-19 14:32:46', 0, 'admin', '2020-04-27 18:31:03', '', 'member-log', 127996320085446656, 0, 3.00, 'Main', '/member-log', '????????????', 'md-list-box', 1, '', 0, '', b'1', NULL, b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1251761480286736384, 'admin', '2020-04-19 14:36:08', 0, 'admin', '2020-04-27 18:31:22', '', 'member-log', 1251760630449442816, 0, 0.00, 'sys/log-manage/logManage', 'member-log', '????????????[??????]', 'md-list-box', 2, '', 0, '', b'1', NULL, b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (1254739560500432897, 'admin', '2020-04-27 19:49:58', 0, 'admin', '2020-04-27 19:49:58', NULL, '', 81716172680073216, 1, 0.00, '', '/xboot/actTask/passAll/**', '????????????', '', 3, 'other', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (1254739666461134848, 'admin', '2020-04-27 19:50:23', 0, 'admin', '2020-04-27 19:50:23', NULL, '', 81716172680073216, 1, 0.00, '', '/xboot/actTask/back**', '????????????', '', 3, 'disable', 0, NULL, b'1', NULL, NULL, NULL, b'0');
INSERT INTO `t_permission` VALUES (1337084109473845248, 'admin', '2020-12-11 01:17:48', 0, 'admin', '2020-12-11 01:17:48', NULL, '', 81558529864896512, 1, 3.00, '', '/xboot/actBusiness/apply*', '????????????', '', 3, 'enable', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337084263631294465, 'admin', '2020-12-11 01:18:25', 0, 'admin', '2020-12-11 01:18:32', '', '', 81558529864896512, 1, 3.00, '', '/xboot/actBusiness/cancel*', '????????????', '', 3, 'disable', 0, '', b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337084380564295681, 'admin', '2020-12-11 01:18:53', 0, 'admin', '2020-12-11 01:18:53', NULL, '', 117806106536841216, 1, 1.00, '', '/xboot/actProcess/delHistoricInsByIds**', '??????????????????', '', 3, 'delete', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337087041741131777, 'admin', '2020-12-11 01:29:27', 0, 'admin', '2020-12-11 01:29:27', NULL, '', 76914082455752704, 1, 0.00, '', '/xboot/actProcess/editStartUser**', '?????????????????????', '', 3, 'edit', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337087257902977024, 'admin', '2020-12-11 01:30:19', 0, 'admin', '2020-12-11 01:30:19', NULL, '', 211251678651879424, 1, 1.00, '', '/xboot/client/save**', '????????????', '', 3, 'add', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337087364513796097, 'admin', '2020-12-11 01:30:44', 0, 'admin', '2020-12-11 01:31:28', '', '', 211251678651879424, 1, 3.00, '', '/xboot/client/delByIds**', '????????????', '', 3, 'delete', 0, '', b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337087482155634689, 'admin', '2020-12-11 01:31:12', 0, 'admin', '2020-12-11 01:31:32', '', '', 211251678651879424, 1, 2.00, '', '/xboot/client/update**', '????????????', '', 3, 'edit', 0, '', b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337087799127576577, 'admin', '2020-12-11 01:32:28', 0, 'admin', '2020-12-11 01:32:28', NULL, '', 121426317022334976, 1, 1.00, '', '/xboot/redis/getAllByPage**', '??????Redis', '', 3, 'view', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337087867276627969, 'admin', '2020-12-11 01:32:44', 0, 'admin', '2020-12-11 01:32:44', NULL, '', 121426317022334976, 1, 2.00, '', '/xboot/redis/save', '??????Redis', '', 3, 'add', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337087940756639745, 'admin', '2020-12-11 01:33:02', 0, 'admin', '2020-12-11 01:33:02', NULL, '', 121426317022334976, 1, 2.00, '', '/xboot/redis/delByKeys**', '??????Redis', '', 3, 'delete', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337088037640867841, 'admin', '2020-12-11 01:33:25', 0, 'admin', '2020-12-11 01:33:25', NULL, '', 121426317022334976, 1, 2.00, '', '/xboot/redis/delAll', '??????Redis', '', 3, 'clear', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337088390826430465, 'admin', '2020-12-11 01:34:49', 0, 'admin', '2020-12-11 01:34:49', NULL, '', 1251153074307862528, 1, 1.00, '', '/xboot/app/member/admin/add**', '????????????', '', 3, 'add', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337088472535666689, 'admin', '2020-12-11 01:35:08', 0, 'admin', '2020-12-11 01:35:08', NULL, '', 1251153074307862528, 1, 2.00, '', '/xboot/app/member/admin/edit**', '????????????', '', 3, 'edit', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1337088563610783745, 'admin', '2020-12-11 01:35:30', 0, 'admin', '2020-12-11 01:35:30', NULL, '', 1251153074307862528, 1, 3.00, '', '/xboot/app/member/delByIds**', '????????????', '', 3, 'delete', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1347151276110123008, 'admin', '2021-01-07 20:01:08', 0, 'admin', '2021-01-07 20:16:04', '', 'auto-chat', 125909152017944576, 0, 1.30, 'Main', '/auto-chat', '??????????????????', 'logo-twitch', 1, '', 0, '', b'1', b'1', b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (1347154151167102977, 'admin', '2021-01-07 20:12:33', 0, 'admin', '2021-01-19 18:51:15', '', 'chat-setting', 1347151276110123008, 0, 1.00, 'auto-chat/setting/setting', 'chat-setting', '??????????????????[??????]', 'md-desktop', 2, '', 0, '', b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1347154848814075905, 'admin', '2021-01-07 20:15:20', 0, 'admin', '2021-01-29 02:07:55', '', 'chat-reply', 1347151276110123008, 0, 2.00, 'auto-chat/reply/reply', 'chat-reply', '??????????????????[??????]', 'ios-chatboxes', 2, '', 0, '', b'1', b'1', b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (1348946449513189376, 'admin', '2021-01-12 18:54:30', 0, 'admin', '2021-01-12 18:54:30', NULL, 'dashboard3', 210154306362413056, 0, 3.00, 'xboot-charts/dashboard3/dashboard3', 'dashboard3', 'Dashboard3[??????]', 'ios-stats', 2, '', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1348954596869017600, 'admin', '2021-01-12 19:26:53', 0, 'admin', '2021-01-12 19:26:53', NULL, 'dashboard4', 210154306362413056, 0, 4.00, 'xboot-charts/dashboard4/dashboard4', 'dashboard4', 'Dashboard4[??????]', 'md-timer', 2, '', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1354853724400521217, 'admin', '2021-01-29 02:07:55', 0, 'admin', '2021-01-29 02:08:58', '', '', 1347154848814075905, 1, 1.00, '', '/xboot/autoChat/save**', '????????????', '', 3, 'add', 0, '', b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1354853977182834688, 'admin', '2021-01-29 02:08:55', 0, 'admin', '2021-01-29 02:08:55', NULL, '', 1347154848814075905, 1, 2.00, '', '/xboot/autoChat/update**', '????????????', '', 3, 'edit', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1354854134687338496, 'admin', '2021-01-29 02:09:32', 0, 'admin', '2021-01-29 02:09:32', NULL, '', 1347154848814075905, 1, 3.00, '', '/xboot/autoChat/delByIds**', '????????????', '', 3, 'delete', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1398216161723813889, 'admin', '2021-05-28 17:54:45', 0, 'admin', '2021-12-28 00:50:08', 'window', 'material', 0, -1, 1.10, 'hot', '', 'XBoot????????????', 'ios-apps', 0, '', 0, 'http://material.exrick.cn', b'1', b'0', b'0', 'xbootMaterial', b'1');
INSERT INTO `t_permission` VALUES (1459830387986534400, 'admin', '2021-11-14 18:27:41', 0, 'admin', '2021-11-14 20:26:37', NULL, 'app-toB', 125909152017944576, 0, 0.00, 'Main', '/app-toB', 'App?????????toB???', 'md-phone-portrait', 1, '', 0, NULL, b'1', b'1', b'1', NULL, b'0');
INSERT INTO `t_permission` VALUES (1459860315381567488, 'admin', '2021-11-14 20:26:37', 0, 'admin', '2021-11-14 20:26:37', NULL, 'preview-app-toB', 1459830387986534400, 0, 1.00, 'app-toB/preview/preview', 'preview', 'App????????????', 'md-phone-portrait', 2, '', 0, NULL, b'1', b'1', b'0', NULL, b'0');
INSERT INTO `t_permission` VALUES (1459862052989440000, 'admin', '2021-11-14 20:33:31', 0, 'admin', '2021-11-14 20:33:49', '', 'file', 1459830387986534400, 0, 2.00, 'app-toB/file/file', 'file', '?????????[??????]', 'md-folder', 2, '', 0, '', b'1', b'1', b'0', NULL, b'0');
COMMIT;

-- ----------------------------
-- Table structure for t_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `t_role_permission`;
CREATE TABLE `t_role_permission` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `permission_id` bigint(20) unsigned DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_permission
-- ----------------------------
BEGIN;
INSERT INTO `t_role_permission` VALUES (175877432572645376, NULL, '2019-08-19 22:06:29', 0, NULL, '2019-08-19 22:06:29', 125909152017944576, 16457350655250432);
INSERT INTO `t_role_permission` VALUES (175877432576839680, NULL, '2019-08-19 22:06:29', 0, NULL, '2019-08-19 22:06:29', 5129710648430592, 16457350655250432);
INSERT INTO `t_role_permission` VALUES (175877432581033985, NULL, '2019-08-19 22:06:29', 0, NULL, '2019-08-19 22:06:29', 5129710648430593, 16457350655250432);
INSERT INTO `t_role_permission` VALUES (175877432585228289, NULL, '2019-08-19 22:06:29', 0, NULL, '2019-08-19 22:06:29', 40238597734928384, 16457350655250432);
INSERT INTO `t_role_permission` VALUES (175877432589422593, NULL, '2019-08-19 22:06:29', 0, NULL, '2019-08-19 22:06:29', 57009744761589760, 16457350655250432);
INSERT INTO `t_role_permission` VALUES (175877432593616897, NULL, '2019-08-19 22:06:29', 0, NULL, '2019-08-19 22:06:29', 16392452747300864, 16457350655250432);
INSERT INTO `t_role_permission` VALUES (175877432602005504, NULL, '2019-08-19 22:06:29', 0, NULL, '2019-08-19 22:06:29', 16392767785668608, 16457350655250432);
INSERT INTO `t_role_permission` VALUES (175877432606199808, NULL, '2019-08-19 22:06:29', 0, NULL, '2019-08-19 22:06:29', 16439068543946752, 16457350655250432);
INSERT INTO `t_role_permission` VALUES (175877432610394113, NULL, '2019-08-19 22:06:29', 0, NULL, '2019-08-19 22:06:29', 175808753877127169, 16457350655250432);
INSERT INTO `t_role_permission` VALUES (175877432614588417, NULL, '2019-08-19 22:06:29', 0, NULL, '2019-08-19 22:06:29', 175808922710446081, 16457350655250432);
INSERT INTO `t_role_permission` VALUES (1410479889630498816, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 125909152017944576, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498817, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 5129710648430592, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498818, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 5129710648430593, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498819, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 40238597734928384, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498820, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 43117268627886080, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498821, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 57009744761589760, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498822, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 56309618086776832, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498823, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 44986029924421632, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498824, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 5129710648430594, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498825, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 5129710648430595, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498826, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 75002207560273920, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498827, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 58480609315524608, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498828, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 76606430504816640, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498829, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 81558529864896512, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498830, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 84082369492946944, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498831, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 1337084109473845248, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498832, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 81716172680073216, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498833, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 84083562503999488, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498834, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 82269650301227008, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498835, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 81319435670917120, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498836, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 117806106536841216, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498837, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 76914082455752704, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498838, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 76607201262702592, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498839, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 80539147005071360, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498840, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 211251162815401984, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498841, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 211251678651879424, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498842, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 211652331387752448, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498843, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 39915540965232640, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498844, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 41370251991977984, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498845, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 41363147411427328, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498846, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 121426317022334976, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498847, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 149452775095275520, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498848, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 41371711400054784, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498849, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 39916171171991552, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498850, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 39918482854252544, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498851, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 102235632889237504, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498852, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 102237605176807424, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498853, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 102240052523831296, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498854, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 103658022701633536, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498855, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 41373430515240960, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498856, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 129033675403694080, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498857, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 41375330996326400, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498858, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 42082442672082944, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498859, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 41378916912336896, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498860, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 63741744973352960, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498861, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 41376192166629376, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498862, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 41377034236071936, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498863, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 56911328312299520, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498864, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 63482475359244288, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498865, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 64290663792906240, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498866, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 66790433014943744, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498867, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 210154306362413056, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498868, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 210155258859491329, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498869, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 210156371755143168, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498870, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 1348946449513189376, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498871, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 1348954596869017600, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498872, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 113602149589454848, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498873, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 113602342657462272, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498874, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 113603512293658624, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498875, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 113603617897844736, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498876, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 16392452747300864, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498877, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 16392767785668608, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498878, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 16438800255291392, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498879, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 16438962738434048, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498880, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 16439068543946752, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498881, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 175808753877127169, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498882, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 175808922710446081, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498883, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 127996320085446656, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498884, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 160509731956330496, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498885, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 160509918166650881, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498886, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 128366789653434368, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498887, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 128368112335589376, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498888, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 1251152298521006080, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498889, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 1251153074307862528, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498890, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 1251760630449442816, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498891, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 1251761480286736384, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498892, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 127995258721013760, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498893, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 128364633437245440, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498894, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 127996726786134016, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1410479889630498895, 'admin', '2021-07-01 14:06:26', 0, 'admin', '2021-07-01 14:06:26', 127997001756315648, 496138616573953);
INSERT INTO `t_role_permission` VALUES (1459863419535626240, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 125909152017944576, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626241, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1459830387986534400, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626242, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1459860315381567488, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626243, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1459862052989440000, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626244, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 5129710648430592, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626245, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 5129710648430593, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626246, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 15701400130424832, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626247, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16678126574637056, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626248, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 15701915807518720, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626249, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 15708892205944832, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626250, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16678447719911424, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626251, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 25014528525733888, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626252, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 56898976661639168, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626253, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 156365156580855808, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626254, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 40238597734928384, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626255, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45235621697949696, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626256, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45235787867885568, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626257, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45235939278065664, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626258, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 43117268627886080, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626259, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45236734832676864, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626260, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45237010692050944, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626261, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45237170029465600, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626262, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 57009544286441472, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626263, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 57009744761589760, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626264, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 57009981228060672, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626265, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 56309618086776832, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626266, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 57212882168844288, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626267, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 61560041605435392, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626268, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 61560275261722624, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626269, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 61560480518377472, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626270, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 44986029924421632, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626271, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45235228800716800, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626272, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45069342940860416, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626273, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 5129710648430594, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626274, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16687383932047360, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626275, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16689632049631232, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626276, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16689745006432256, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626277, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16689883993083904, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626278, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16690313745666048, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626279, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 5129710648430595, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626280, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16694861252005888, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626281, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16695107491205120, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626282, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16695243126607872, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626283, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 75002207560273920, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626284, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 76215889006956544, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626285, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 76216071333351424, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626286, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 76216264070008832, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626287, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 76216459709124608, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626288, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 76216594207870976, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626289, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 76216702639017984, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626290, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 58480609315524608, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626291, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 61394706252173312, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626292, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 61417744146370560, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626293, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 76606430504816640, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626294, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 81558529864896512, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626295, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84082369492946944, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626296, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337084109473845248, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626297, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337084263631294465, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626298, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84082920431554560, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626299, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 81716172680073216, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626300, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84083562503999488, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626301, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1254739560500432897, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626302, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1254739666461134848, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626303, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84083641302388736, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626304, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 113601631450304512, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626305, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84084404707659776, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626306, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 82269650301227008, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626307, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84084724590448640, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626308, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 81319435670917120, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626309, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84084965817454592, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626310, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 117806106536841216, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626311, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337084380564295681, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626312, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 76914082455752704, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626313, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84085542324539392, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626314, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337087041741131777, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626315, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84085810797744128, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626316, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84085980943880192, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626317, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84086163001839616, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626318, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84086362248056832, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626319, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 76607201262702592, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626320, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84086882907983872, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626321, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84087009940869120, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626322, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84087154040377344, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626323, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 80539147005071360, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626324, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84087344352727040, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626325, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84087480852156416, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626326, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 84087593041399808, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626327, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 211251162815401984, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626328, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 211251678651879424, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626329, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337087257902977024, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626330, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337087482155634689, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626331, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337087364513796097, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626332, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 211652331387752448, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626333, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1347151276110123008, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626334, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1347154151167102977, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626335, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1347154848814075905, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626336, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1354853724400521217, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626337, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1354853977182834688, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626338, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1354854134687338496, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626339, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 39915540965232640, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626340, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41370251991977984, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626341, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45264987354042368, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626342, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45265487029866496, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626343, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45265762415284224, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626344, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45265886315024384, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626345, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 45266070000373760, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626346, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41363147411427328, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626347, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41363537456533504, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626348, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41364927394353152, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626349, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 121426317022334976, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626350, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337087799127576577, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626351, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337087867276627969, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626352, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337087940756639745, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626353, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337088037640867841, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626354, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 149452775095275520, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626355, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41371711400054784, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626356, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41469219249852416, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626357, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 39916171171991552, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626358, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 39918482854252544, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626359, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 102235632889237504, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626360, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 102237605176807424, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626361, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 102240052523831296, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626362, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 103658022701633536, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626363, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41373430515240960, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626364, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 129033675403694080, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626365, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41375330996326400, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626366, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 42082442672082944, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626367, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41378916912336896, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626368, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 63741744973352960, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626369, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41376192166629376, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626370, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 41377034236071936, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626371, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 56911328312299520, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626372, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 63482475359244288, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626373, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 64290663792906240, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626374, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 66790433014943744, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626375, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 210154306362413056, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626376, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 210155258859491329, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626377, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 210156371755143168, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626378, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1348946449513189376, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626379, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1348954596869017600, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626380, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 113602149589454848, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626381, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 113602342657462272, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626382, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 113603512293658624, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626383, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 113603617897844736, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626384, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16392452747300864, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626385, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16392767785668608, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626386, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16438800255291392, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626387, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16438962738434048, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626388, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 16439068543946752, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626389, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 175808753877127169, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626390, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 175808922710446081, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626391, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 127996320085446656, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626392, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 160509731956330496, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626393, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 160509918166650881, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626394, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 128366789653434368, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626395, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 128368112335589376, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626396, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1251152298521006080, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626397, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1251153074307862528, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626398, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337088390826430465, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626399, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337088472535666689, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626400, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1337088563610783745, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626401, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1251760630449442816, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626402, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1251761480286736384, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626403, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 1398216161723813889, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626404, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 127995258721013760, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626405, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 128364633437245440, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626406, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 127996726786134016, 496138616573952);
INSERT INTO `t_role_permission` VALUES (1459863419535626407, 'admin', '2021-11-14 20:38:57', 0, 'admin', '2021-11-14 20:38:57', 127997001756315648, 496138616573952);
COMMIT;

-- ----------------------------
-- Table structure for t_quartz_job
-- ----------------------------
DROP TABLE IF EXISTS `t_quartz_job`;
CREATE TABLE `t_quartz_job` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `cron_expression` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `job_class_name` varchar(255) DEFAULT NULL,
  `parameter` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `default_role` bit(1) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `data_type` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role
-- ----------------------------
BEGIN;
INSERT INTO `t_role` VALUES (496138616573952, '', '2018-04-22 23:03:49', 'admin', '2018-11-15 23:02:59', 'ROLE_ADMIN', 0, NULL, '??????????????? ??????????????????', 0);
INSERT INTO `t_role` VALUES (496138616573953, '', '2018-05-02 21:40:03', 'admin', '2018-11-01 22:59:48', 'ROLE_USER', 0, b'1', '?????????????????? ????????????', 0);
INSERT INTO `t_role` VALUES (16457350655250432, '', '2018-06-06 00:08:00', 'admin', '2018-11-02 20:42:24', 'ROLE_TEST', 0, NULL, '????????????????????????', 1);
COMMIT;

-- ----------------------------
-- Table structure for t_role_department
-- ----------------------------
DROP TABLE IF EXISTS `t_role_department`;
CREATE TABLE `t_role_department` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_role_department
-- ----------------------------
BEGIN;
INSERT INTO `t_role_department` VALUES (70763874256687105, 'admin', '2018-11-02 20:42:43', 0, 'admin', '2018-11-02 20:42:43', 40322777781112832, 16457350655250432);
INSERT INTO `t_role_department` VALUES (70763874265075712, 'admin', '2018-11-02 20:42:43', 0, 'admin', '2018-11-02 20:42:43', 40322811096469504, 16457350655250432);
INSERT INTO `t_role_department` VALUES (70763874277658624, 'admin', '2018-11-02 20:42:43', 0, 'admin', '2018-11-02 20:42:43', 40322852833988608, 16457350655250432);
COMMIT;

-- ----------------------------
-- Table structure for t_setting
-- ----------------------------
DROP TABLE IF EXISTS `t_setting`;
CREATE TABLE `t_setting` (
  `id` varchar(255) NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `value` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_setting
-- ----------------------------

-- ----------------------------
-- Table structure for t_social
-- ----------------------------
DROP TABLE IF EXISTS `t_social`;
CREATE TABLE `t_social` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `open_id` varchar(255) DEFAULT NULL,
  `platform` tinyint(1) unsigned DEFAULT NULL,
  `relate_username` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `relate_open_id` (`open_id`,`platform`) USING BTREE,
  UNIQUE KEY `relate_username` (`relate_username`,`platform`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for t_user
-- ----------------------------
DROP TABLE IF EXISTS `t_user`;
CREATE TABLE `t_user` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobile` varchar(255) DEFAULT NULL,
  `nickname` varchar(255) CHARACTER SET utf8mb4 DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `sex` varchar(255) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `pass_strength` varchar(2) DEFAULT NULL,
  `department_title` varchar(255) DEFAULT NULL,
  `birth` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE,
  UNIQUE KEY `email` (`email`) USING BTREE,
  UNIQUE KEY `mobile` (`mobile`) USING BTREE,
  KEY `create_time` (`create_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user
-- ----------------------------
BEGIN;
INSERT INTO `t_user` VALUES (682265633886208, '', '2018-05-01 16:13:51', 'admin', '2020-04-12 22:03:47', '?????????,?????????,?????????', 'https://ooo.0o0.ooo/2019/04/28/5cc5a71a6e3b6.png', '???????????????', 'admin@exrick.cn', '18782059031', '?????????', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '???', 0, 1, 'admin', 0, 40322777781112832, '??????1???', '???', '??????', '2020-04-15 00:00:00.000000');
INSERT INTO `t_user` VALUES (682265633886209, '', '2018-04-30 23:28:42', 'admin', '2020-04-12 13:57:08', '?????????,?????????,?????????', 'https://ooo.0o0.ooo/2019/04/28/5cc5a71a6e3b6.png', '', 'Exrick@exrick.cn', '18782059032', 'exrick', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '???', -1, 0, 'Exrick', 0, 40343262766043136, '', '???', '????????????', '2020-04-13 00:00:00.000000');
INSERT INTO `t_user` VALUES (4363087427670016, '', '2018-05-03 15:09:42', 'admin', '2020-04-18 22:24:08', '?????????,?????????,?????????', 'https://ooo.0o0.ooo/2019/04/28/5cc5a71a6e3b6.png', '', 'test@exrick.cn', '18782059033', '??????1', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '???', 0, 0, 'test', 0, 40343262766043136, '', '???', '????????????', '2020-04-28 00:00:00.000000');
INSERT INTO `t_user` VALUES (16739222421508096, '', '2018-06-06 18:48:02', 'admin', '2020-04-27 22:01:24', '?????????,?????????,?????????', 'https://ooo.0o0.ooo/2019/04/28/5cc5a71a6e3b6.png', '', 'test2@exrick.cn', '18782059034', '??????2', '$2a$10$PS04ecXfknNd3V8d.ymLTObQciapMU4xU8.GADBZZsuTZr7ymnagy', '???', 0, 0, 'test2', 0, 40322777781112832, '', '???', '??????', '2020-04-23 00:00:00.000000');
COMMIT;

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role` (
  `id` bigint(20) unsigned NOT NULL,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL,
  `del_flag` tinyint(1) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
BEGIN;
INSERT INTO `t_user_role` VALUES (1251516834239352832, 'admin', '2020-04-18 22:24:00', 0, 'admin', '2020-04-18 22:24:00', 496138616573952, 682265633886209);
INSERT INTO `t_user_role` VALUES (1251516834239352833, 'admin', '2020-04-18 22:24:00', 0, 'admin', '2020-04-18 22:24:00', 496138616573953, 682265633886209);
INSERT INTO `t_user_role` VALUES (1251516869526032384, 'admin', '2020-04-18 22:24:08', 0, 'admin', '2020-04-18 22:24:08', 496138616573953, 4363087427670016);
INSERT INTO `t_user_role` VALUES (1254427593457930240, 'admin', '2020-04-26 23:10:19', 0, 'admin', '2020-04-26 23:10:19', 496138616573952, 682265633886208);
INSERT INTO `t_user_role` VALUES (1254772636383318016, 'admin', '2020-04-27 22:01:24', 0, 'admin', '2020-04-27 22:01:24', 16457350655250432, 16739222421508096);
COMMIT;

-- ----------------------------
-- Table structure for t_auto_chat
-- ----------------------------
DROP TABLE IF EXISTS `t_auto_chat`;
CREATE TABLE `t_auto_chat` (
  `id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` text,
  `create_by` varchar(255) DEFAULT NULL,
  `create_time` datetime(6) DEFAULT NULL,
  `del_flag` int(11) DEFAULT NULL,
  `update_by` varchar(255) DEFAULT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `bad` int(11) DEFAULT NULL,
  `good` int(11) DEFAULT NULL,
  `content` text,
  `sort_order` decimal(10,2) DEFAULT NULL,
  `evaluable` bit(1) DEFAULT NULL,
  `hot` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  FULLTEXT KEY `search` (`title`,`keywords`) /*!50100 WITH PARSER `ngram` */ 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of t_auto_chat
-- ----------------------------
BEGIN;
COMMIT;

DROP TABLE IF EXISTS QRTZ_FIRED_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_PAUSED_TRIGGER_GRPS;
DROP TABLE IF EXISTS QRTZ_SCHEDULER_STATE;
DROP TABLE IF EXISTS QRTZ_LOCKS;
DROP TABLE IF EXISTS QRTZ_SIMPLE_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_SIMPROP_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_CRON_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_BLOB_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_TRIGGERS;
DROP TABLE IF EXISTS QRTZ_JOB_DETAILS;
DROP TABLE IF EXISTS QRTZ_CALENDARS;


CREATE TABLE QRTZ_JOB_DETAILS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    JOB_CLASS_NAME   VARCHAR(250) NOT NULL,
    IS_DURABLE VARCHAR(1) NOT NULL,
    IS_NONCONCURRENT VARCHAR(1) NOT NULL,
    IS_UPDATE_DATA VARCHAR(1) NOT NULL,
    REQUESTS_RECOVERY VARCHAR(1) NOT NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    JOB_NAME  VARCHAR(200) NOT NULL,
    JOB_GROUP VARCHAR(200) NOT NULL,
    DESCRIPTION VARCHAR(250) NULL,
    NEXT_FIRE_TIME BIGINT(13) NULL,
    PREV_FIRE_TIME BIGINT(13) NULL,
    PRIORITY INTEGER NULL,
    TRIGGER_STATE VARCHAR(16) NOT NULL,
    TRIGGER_TYPE VARCHAR(8) NOT NULL,
    START_TIME BIGINT(13) NOT NULL,
    END_TIME BIGINT(13) NULL,
    CALENDAR_NAME VARCHAR(200) NULL,
    MISFIRE_INSTR SMALLINT(2) NULL,
    JOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,JOB_NAME,JOB_GROUP)
        REFERENCES QRTZ_JOB_DETAILS(SCHED_NAME,JOB_NAME,JOB_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SIMPLE_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    REPEAT_COUNT BIGINT(7) NOT NULL,
    REPEAT_INTERVAL BIGINT(12) NOT NULL,
    TIMES_TRIGGERED BIGINT(10) NOT NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_CRON_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    CRON_EXPRESSION VARCHAR(200) NOT NULL,
    TIME_ZONE_ID VARCHAR(80),
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SIMPROP_TRIGGERS
  (          
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    STR_PROP_1 VARCHAR(512) NULL,
    STR_PROP_2 VARCHAR(512) NULL,
    STR_PROP_3 VARCHAR(512) NULL,
    INT_PROP_1 INT NULL,
    INT_PROP_2 INT NULL,
    LONG_PROP_1 BIGINT NULL,
    LONG_PROP_2 BIGINT NULL,
    DEC_PROP_1 NUMERIC(13,4) NULL,
    DEC_PROP_2 NUMERIC(13,4) NULL,
    BOOL_PROP_1 VARCHAR(1) NULL,
    BOOL_PROP_2 VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP) 
    REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_BLOB_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    BLOB_DATA BLOB NULL,
    PRIMARY KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP),
    FOREIGN KEY (SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
        REFERENCES QRTZ_TRIGGERS(SCHED_NAME,TRIGGER_NAME,TRIGGER_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_CALENDARS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    CALENDAR_NAME  VARCHAR(200) NOT NULL,
    CALENDAR BLOB NOT NULL,
    PRIMARY KEY (SCHED_NAME,CALENDAR_NAME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_PAUSED_TRIGGER_GRPS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    TRIGGER_GROUP  VARCHAR(200) NOT NULL, 
    PRIMARY KEY (SCHED_NAME,TRIGGER_GROUP)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_FIRED_TRIGGERS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    ENTRY_ID VARCHAR(95) NOT NULL,
    TRIGGER_NAME VARCHAR(200) NOT NULL,
    TRIGGER_GROUP VARCHAR(200) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    FIRED_TIME BIGINT(13) NOT NULL,
    SCHED_TIME BIGINT(13) NOT NULL,
    PRIORITY INTEGER NOT NULL,
    STATE VARCHAR(16) NOT NULL,
    JOB_NAME VARCHAR(200) NULL,
    JOB_GROUP VARCHAR(200) NULL,
    IS_NONCONCURRENT VARCHAR(1) NULL,
    REQUESTS_RECOVERY VARCHAR(1) NULL,
    PRIMARY KEY (SCHED_NAME,ENTRY_ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_SCHEDULER_STATE
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    INSTANCE_NAME VARCHAR(200) NOT NULL,
    LAST_CHECKIN_TIME BIGINT(13) NOT NULL,
    CHECKIN_INTERVAL BIGINT(13) NOT NULL,
    PRIMARY KEY (SCHED_NAME,INSTANCE_NAME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE QRTZ_LOCKS
  (
    SCHED_NAME VARCHAR(120) NOT NULL,
    LOCK_NAME  VARCHAR(40) NOT NULL, 
    PRIMARY KEY (SCHED_NAME,LOCK_NAME)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;