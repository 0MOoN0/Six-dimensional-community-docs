/*
 Navicat Premium Data Transfer

 Source Server         : Localhost
 Source Server Type    : MySQL
 Source Server Version : 50725
 Source Host           : localhost:3306
 Source Schema         : sdcommunity_qa

 Target Server Type    : MySQL
 Target Server Version : 50725
 File Encoding         : 65001

 Date: 12/12/2019 14:44:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for tb_pl
-- ----------------------------
DROP TABLE IF EXISTS `tb_pl`;
CREATE TABLE `tb_pl`  (
  `problemid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '问题ID',
  `labelid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`problemid`, `labelid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_pl
-- ----------------------------
INSERT INTO `tb_pl` VALUES ('1', '1');

-- ----------------------------
-- Table structure for tb_problem
-- ----------------------------
DROP TABLE IF EXISTS `tb_problem`;
CREATE TABLE `tb_problem`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT 'ID',
  `title` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '内容',
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `updatetime` datetime(0) NULL DEFAULT NULL COMMENT '修改日期',
  `userid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '用户ID',
  `nickname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '昵称',
  `visits` bigint(20) NULL DEFAULT NULL COMMENT '浏览量',
  `thumbup` bigint(20) NULL DEFAULT NULL COMMENT '点赞数',
  `reply` bigint(20) NULL DEFAULT NULL COMMENT '回复数',
  `solve` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '是否解决',
  `replyname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回复人昵称',
  `replytime` datetime(0) NULL DEFAULT NULL COMMENT '回复日期',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '问题' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_problem
-- ----------------------------
INSERT INTO `tb_problem` VALUES ('1', '这是个问题', '代码调试不通咋办？', '2018-01-08 11:50:50', '2018-01-09 11:50:54', '2', NULL, 101, NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for tb_reply
-- ----------------------------
DROP TABLE IF EXISTS `tb_reply`;
CREATE TABLE `tb_reply`  (
  `id` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '编号',
  `problemid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '问题ID',
  `content` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL COMMENT '回答内容',
  `createtime` datetime(0) NULL DEFAULT NULL COMMENT '创建日期',
  `updatetime` datetime(0) NULL DEFAULT NULL COMMENT '更新日期',
  `userid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回答人ID',
  `nickname` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '回答人昵称',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '回答' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_reply
-- ----------------------------
INSERT INTO `tb_reply` VALUES ('', '1', NULL, NULL, NULL, NULL, NULL);
INSERT INTO `tb_reply` VALUES ('2', '1', '问老师呗', '2018-01-10 14:14:06', NULL, '1', NULL);
INSERT INTO `tb_reply` VALUES ('3', '2', '明天再调', '2018-01-07 14:14:13', NULL, '1', NULL);

-- ----------------------------
-- Table structure for tb_ul
-- ----------------------------
DROP TABLE IF EXISTS `tb_ul`;
CREATE TABLE `tb_ul`  (
  `uid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '用户ID',
  `lid` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`uid`, `lid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
