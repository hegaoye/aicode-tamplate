/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2019/8/14 10:23:30                           */
/*==============================================================*/
drop table if exists rbac_admin;

drop table if exists rbac_admin_role_relation;

drop table if exists rbac_permission;

drop table if exists rbac_permission_action;

drop table if exists rbac_permission_api;

drop table if exists rbac_permission_menu;

drop table if exists rbac_role;

drop table if exists rbac_role_permission_relation;

drop table if exists system_log;

drop table if exists worker_node;

/*==============================================================*/
/* Table: rbac_admin                                            */
/*==============================================================*/
create table rbac_admin
(
   id                   int unsigned not null auto_increment comment '主键ID',
   code                 char(32) not null comment '管理员（授权用户）编码',
   account              char(32) not null comment '自定义登录账号 (长度限制5-16位，字母开头+数字)',
   phone                char(11) not null comment '手机号码（仅支持11位手机号）',
   email                varchar(64) not null comment '邮箱账号',
   idcard               char(18) not null comment '身份证号',
   password             char(32) not null comment '加密的登录密码 (MD5加密32位)',
   name                 varchar(64) not null comment '管理员名称',
   whether_auth         enum('Y','N') not null comment '是否拥有授权权限',
   state                enum('enable','disable') not null default 'enable' comment '状态（enable 启用，disable 禁用）',
   type                 enum('super','normal') not null default 'normal' comment '管理员类型（super 超级管理员，normal 普通管理员）',
   creator_code         char(32) not null comment '创建者编码',
   create_time          datetime not null comment '创建时间',
   update_time          datetime not null comment '更新时间',
   primary key (id),
   unique key AK_uk_code (code),
   key AK_uk_account (account),
   key AK_uk_phone (phone),
   key AK_uk_email (email),
   key AK_uk_idcard (idcard)
);

alter table rbac_admin comment '权限系统-管理员（授权用户）';

-- 初始化超级管理员
INSERT INTO `rbac_admin`
(`code`, `account`, `phone`, `email`, `idcard`, `password`, `name`, `whether_auth`, `state`, `type`, `creator_code`, `create_time`, `update_time`)
VALUES
('123456789', 'admin', '', '', '', 'e10adc3949ba59abbe56e057f20f883e', '超管', 'N', 'enable', 'super', '', now(), now());


/*==============================================================*/
/* Table: rbac_admin_role_relation                              */
/*==============================================================*/
create table rbac_admin_role_relation
(
   id                   int unsigned not null auto_increment comment '关系记录ID',
   admin_code           char(32) not null comment '管理员（被授权用户）编码',
   role_id              int unsigned not null comment '授权角色id',
   to_auth_admin_code   char(32) not null comment '授权人编码',
   create_time          datetime not null comment '创建时间',
   primary key (id),
   key AK_idx_admin_code (admin_code),
   key AK_idx_role_id (role_id)
);

alter table rbac_admin_role_relation comment '权限系统-授权用户与角色关系';

/*==============================================================*/
/* Table: rbac_permission                                       */
/*==============================================================*/
create table rbac_permission
(
   id                   int unsigned not null auto_increment comment '权限id',
   menu_id              int unsigned not null comment '菜单id',
   action_code          varchar(128) not null comment '功能权限的唯一识别码（同菜单编码下的功能识别码唯一）',
   name                 varchar(32) not null comment '权限名称',
   type                 enum('menu','action') not null comment '权限类型（menu 菜单，action 功能操作）',
   state                enum('enable','disable') not null default 'enable' comment '状态（enable 启用，disable 禁用）',
   description          varchar(256) not null comment '描述',
   sort                 int unsigned not null default 1 comment '排序；相对于同一菜单下的功能权限排序',
   create_time          datetime not null comment '创建时间',
   update_time          datetime not null comment '更新时间',
   primary key (id),
   key AK_idx_menu_id (menu_id),
   unique key AK_uk_menu_and_action (menu_id, action_code),
   key AK_idx_type (type)
);

alter table rbac_permission comment '权限系统-权限资源';

/*==============================================================*/
/* Table: rbac_permission_action                                */
/*==============================================================*/
create table rbac_permission_action
(
   id                   int unsigned not null auto_increment comment '主键ID',
   action_code          varchar(64) not null comment '功能权限的唯一识别码（同菜单编码下的功能识别码唯一）',
   action_name          varchar(128) not null comment '功能名称',
   action_icon          varchar(128) not null comment '功能图标',
   description          varchar(256) not null comment '描述',
   create_time          datetime not null comment '创建时间',
   update_time          datetime not null comment '更新时间',
   primary key (id),
   unique key AK_uk_action_code (action_code)
);

alter table rbac_permission_action comment '权限系统-功能操作权限';

/*==============================================================*/
/* Table: rbac_permission_api                                   */
/*==============================================================*/
create table rbac_permission_api
(
   id                   int unsigned not null auto_increment comment '权限授权记录id',
   permission_id        int unsigned not null comment '权限id',
   action_url           varchar(2048) not null comment '功能授权API请求路径',
   create_time          datetime not null comment '创建时间',
   update_time          datetime not null comment '更新时间',
   primary key (id),
   key AK_idx_permission_id (permission_id)
);

alter table rbac_permission_api comment '权限系统-权限授权API；每一个权限对应多个授权API请求路径';

/*==============================================================*/
/* Table: rbac_permission_menu                                  */
/*==============================================================*/
create table rbac_permission_menu
(
   id                   int unsigned not null auto_increment comment '菜单ID',
   id_pre               int unsigned not null default 0 comment '上级菜单id；为空时设为0',
   menu_name            varchar(32) not null comment '菜单名称',
   menu_href            varchar(128) not null comment '菜单路径',
   menu_icon            varchar(128) not null comment '菜单图标',
   state                enum('enable','disable') not null default 'enable' comment '状态（enable 启用，disable 禁用）',
   is_leaf              enum('Y','N') not null default 'Y' comment '是否是叶子节点（Y 是，N 否）',
   description          varchar(256) not null comment '描述',
   sort                 int unsigned not null default 1 comment '排序',
   create_time          datetime not null comment '创建时间',
   update_time          datetime not null comment '更新时间',
   primary key (id),
   key AK_idx_id_pre (id_pre)
);

alter table rbac_permission_menu comment '权限系统-菜单权限';

/*==============================================================*/
/* Table: rbac_role                                             */
/*==============================================================*/
create table rbac_role
(
   id                   int unsigned not null auto_increment comment '角色id',
   id_pre               int unsigned not null default 0 comment '上级角色id；无上级时，设为0',
   role_name            varchar(64) not null comment '角色名称',
   state                enum('enable','disable') not null default 'enable' comment '状态（enable 启用，disable 禁用）',
   is_leaf              enum('Y','N') not null default 'Y' comment '是否是叶子节点（Y 是，N 否）',
   description          varchar(256) not null comment '描述',
   create_time          datetime not null comment '创建时间',
   update_time          datetime not null comment '更新时间',
   primary key (id),
   key AK_idx_id_pre (id_pre)
);

alter table rbac_role comment '权限系统-角色';

/*==============================================================*/
/* Table: rbac_role_permission_relation                         */
/*==============================================================*/
create table rbac_role_permission_relation
(
   id                   int unsigned not null auto_increment comment '关系记录id',
   role_id              int unsigned not null comment '角色id',
   permission_id        int unsigned not null comment '权限id；权限资源id',
   create_time          datetime not null comment '创建时间',
   primary key (id),
   key AK_idx_role_id (role_id)
);

alter table rbac_role_permission_relation comment '权限系统-角色对应权限关系';

/*==============================================================*/
/* Table: system_log                                            */
/*==============================================================*/
create table system_log
(
   id                   int unsigned not null auto_increment comment '主键id',
   role_type            enum('user','admin','Tourist') not null comment '操作人类型',
   role_code            varchar(128) not null comment '操作人编码；当为游客时，保存请求操作的sessionid',
   type                 enum('add','edit','del','query','login') not null comment '操作类型(add,edit,del,query,login)',
   response_state       SMALLINT not null comment '响应状态码',
   ip_address           int unsigned not null comment 'ip地址（二进制）',
   system               varchar(128) not null comment '操作系统',
   browser              varchar(128) not null comment '浏览器',
   class_name           varchar(128) not null comment '类(包.类)',
   class_method         varchar(128) not null comment '类方法',
   create_time          datetime not null comment '创建时间',
   description          varchar(1024) not null comment '详细描述',
   primary key (id),
   key AK_idx_role (role_type, role_code)
);

alter table system_log comment '系统操作日志; 为方便查询 统计IP，通过mysql的 inet_aton("127.0.0.1") 函数转换ip地址为';


CREATE TABLE `worker_node` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'auto increment menuId',
  `HOST_NAME` varchar(64) NOT NULL COMMENT 'host name',
  `PORT` varchar(64) NOT NULL COMMENT 'port',
  `TYPE` int(11) NOT NULL COMMENT 'node type: ACTUAL or CONTAINER',
  `LAUNCH_DATE` date NOT NULL COMMENT 'launch date',
  `MODIFIED` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'modified time',
  `CREATED` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT 'created time',
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COMMENT='DB WorkerID Assigner for UID Generator';
