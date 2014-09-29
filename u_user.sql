/*
Navicat SQLite Data Transfer

Source Server         : feel1000_user
Source Server Version : 30623
Source Host           : localhost:0

Target Server Type    : SQLite
Target Server Version : 30623
File Encoding         : 65001

Date: 2014-09-29 16:26:03
*/

PRAGMA foreign_keys = OFF;

-- ----------------------------
-- Table structure for "main"."u_user"
-- ----------------------------
DROP TABLE "main"."u_user";
CREATE TABLE "u_user" (
"ID"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"NickName"  TEXT NOT NULL,
"Phone"  TEXT NOT NULL,
"Password"  TEXT NOT NULL,
"CreateDate"  TEXT NOT NULL,
"Sex"  INTEGER NOT NULL
);

-- ----------------------------
-- Records of u_user
-- ----------------------------
INSERT INTO ""."u_user" VALUES (147, 'å§è', 13928979001, 'e10adc3949ba59abbe56e057f20f883e', '2014-09-29 16:24:44', 0);
INSERT INTO ""."u_user" VALUES (148, 'å§è', 13928979001, 'e10adc3949ba59abbe56e057f20f883e', '2014-09-29 16:24:48', 0);
