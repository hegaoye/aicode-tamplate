-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` char(32) NOT NULL COMMENT '管理员编码',
  `name` varchar(64) DEFAULT NULL COMMENT '管理员名称',
  `loginAccount` varchar(32) NOT NULL COMMENT '登录账户(长度限制4-16)',
  `password` char(32) NOT NULL COMMENT '密码(MD5加密32位)',
  `phone` char(11) DEFAULT NULL COMMENT '手机号码',
  `idcard` char(18) DEFAULT NULL COMMENT '身份证号',
  `role` varchar(8) DEFAULT 'NORMAL' COMMENT '角色（SUPER 超级，SENIOR 高级管理，FINACE 财务，EXPRESS 配货员）',
  `permissions` varchar(2048) DEFAULT NULL COMMENT '菜单权限[json存储]',
  `state` char(16) DEFAULT 'OPEN' COMMENT '状态（OPEN 开启，DEL 删除）',
  `operatorCode` char(32) DEFAULT NULL COMMENT '操作管理员编码',
  `operatorName` varchar(64) DEFAULT NULL COMMENT '操作管理员名称',
  `createTime` datetime NOT NULL COMMENT '创建时间',
  `updateTime` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `AK_index_login_account` (`loginAccount`),
  UNIQUE KEY `AK_index_code` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='管理员表';

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES ('1', '1234567890', '超级管理员', 'admin', 'e10adc3949ba59abbe56e057f20f883e', null, null, 'NORMAL', null, 'OPEN', null, null, '2019-05-06 20:00:43', '2019-05-06 20:00:45');


-- ----------------------------
-- Table structure for system_logs
-- ----------------------------
DROP TABLE IF EXISTS `system_logs`;
CREATE TABLE `system_logs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_type` enum('user','admin','Tourist') NOT NULL COMMENT '操作人类型',
  `role_code` varchar(128) NOT NULL COMMENT '操作人编码；当为游客时，保存请求操作的sessionid',
  `type` enum('insert','update','delete','select','login') NOT NULL COMMENT '操作类型(insert,update,delete,select,login)',
  `response_state` smallint(6) NOT NULL COMMENT '响应状态码',
  `ip_address` int(10) unsigned NOT NULL COMMENT 'ip地址（二进制）',
  `system` varchar(128) NOT NULL COMMENT '操作系统',
  `browser` varchar(128) NOT NULL COMMENT '浏览器',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `description` varchar(1024) NOT NULL COMMENT '详细描述',
  PRIMARY KEY (`id`),
  KEY `idx_role` (`role_type`,`role_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统操作日志; 为方便查询 统计IP，通过mysql的 inet_aton("127.0.0.1") 函数转换ip地址为';

-- ----------------------------
-- Table structure for worker_node
-- ----------------------------
DROP TABLE IF EXISTS `worker_node`;
CREATE TABLE `worker_node` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'auto increment id',
  `HOST_NAME` varchar(64) NOT NULL COMMENT 'host name',
  `PORT` varchar(64) NOT NULL COMMENT 'port',
  `TYPE` int(11) NOT NULL COMMENT 'node type: ACTUAL or CONTAINER',
  `LAUNCH_DATE` date NOT NULL COMMENT 'launch date',
  `MODIFIED` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'modified time',
  `CREATED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'created time',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='DB WorkerID Assigner for UID Generator';