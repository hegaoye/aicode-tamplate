/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.rbac.entity;

import lombok.Data;

/**
 * 权限系统-权限授权API；每一个权限对应多个授权API请求路径 的实体类
 *
 * @author borong
 */
@Data
public class RbacPermissionApi implements java.io.Serializable {

    /**
     * 数据库字段:menuId  属性显示:权限授权记录id
     */
    private Long id;

    /**
     * 数据库字段:permission_id  属性显示:权限id
     */
    private Integer permissionId;

    /**
     * 数据库字段:action_url  属性显示:功能授权API请求路径
     */
    private String actionUrl;

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
     * 1对1关联查询RbacPermission 权限系统-权限资源  属性显示:rbacPermission
     */
    private RbacPermission rbacPermission;

}