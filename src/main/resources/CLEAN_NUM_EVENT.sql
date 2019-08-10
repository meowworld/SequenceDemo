/*
 Navicat Premium Data Transfer

 Source Server         : test
 Source Server Type    : MySQL
 Source Server Version : 50549
 Source Host           : localhost:3306
 Source Schema         : test

 Target Server Type    : MySQL
 Target Server Version : 50549
 File Encoding         : 65001

 Date: 10/08/2019 14:51:51
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for sequence_no
-- ----------------------------
DROP TABLE IF EXISTS `sequence_no`;
CREATE TABLE `sequence_no`  (
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '序列名',
  `value` int(11) NULL DEFAULT NULL COMMENT '序列当前值，从0开始',
  `step` int(1) NULL DEFAULT NULL COMMENT '每次增加的值',
  PRIMARY KEY (`name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of sequence_no
-- ----------------------------
INSERT INTO `sequence_no` VALUES ('trans_no', 25, 1);

-- ----------------------------
-- Function structure for get_trans_num
-- ----------------------------
DROP FUNCTION IF EXISTS `get_trans_num`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_trans_num`() RETURNS varchar(24) CHARSET utf8
BEGIN
	DECLARE getval VARCHAR(24);
	SET getval = (SELECT CONCAT('xx_', LPAD((SELECT next_trans_num()), 4, '0')));
RETURN getval;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for next_trans_num
-- ----------------------------
DROP FUNCTION IF EXISTS `next_trans_num`;
delimiter ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `next_trans_num`() RETURNS int(11)
BEGIN
	UPDATE sequence_no SET value=LAST_INSERT_ID( (SELECT value FROM (SELECT value from sequence_no WHERE name='trans_no') tmp) + 1) WHERE name='trans_no';
	RETURN LAST_INSERT_ID();
END
;;
delimiter ;

-- ----------------------------
-- Event structure for CLEAN_NUM_EVENT
-- ----------------------------
DROP EVENT IF EXISTS `CLEAN_NUM_EVENT`;
delimiter ;;
CREATE DEFINER = `root`@`localhost` EVENT `CLEAN_NUM_EVENT`
ON SCHEDULE
EVERY '1' DAY STARTS '2019-08-09 22:37:00'
DO UPDATE sequence_no SET value=0 WHERE name='trans_no'
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
