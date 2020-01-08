/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.rbac.entity;

import lombok.Data;
import java.util.List;

/**
 * 权限系统-功能操作权限 的实体类
 *
 * @author borong
 */
@Data
public class RbacPermissionAction implements java.io.Serializable {

    /**
     * 数据库字段:menuId  属性显示:主键ID
     */
    private Long id;

    /**
     * 数据库字段:action_code  属性显示:功能权限的唯一识别码（同菜单编码下的功能识别码唯一）
     */
    private String actionCode;

    /**
     * 数据库字段:action_name  属性显示:功能名称
     */
    private String actionName;

    /**
     * 数据库字段:action_icon  属性显示:功能图标
     */
    private String actionIcon;

    /**
     * 数据库字段:description  属性显示:描述
     */
    private String description;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private java.util.Date createTime;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private java.util.Date createTimeBegin;
    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private java.util.Date createTimeEnd;
    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private java.util.Date updateTime;

    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private java.util.Date updateTimeBegin;
    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private java.util.Date updateTimeEnd;


    /**
     * 1对多关联查询RbacPermission 权限系统-权限资源  属性显示:rbacPermission
     */
    private List<RbacPermission> rbacPermissionList;
}