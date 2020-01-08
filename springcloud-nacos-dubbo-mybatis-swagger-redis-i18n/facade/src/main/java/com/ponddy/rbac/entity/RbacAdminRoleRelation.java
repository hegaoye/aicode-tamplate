/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.rbac.entity;

import lombok.Data;

import java.util.Date;

/**
 * 权限系统-授权用户与角色关系 的实体类
 *
 * @author borong
 */
@Data
public class RbacAdminRoleRelation implements java.io.Serializable {

    /**
     * 数据库字段:menuId  属性显示:关系记录ID
     */
    private Long id;

    /**
     * 数据库字段:admin_code  属性显示:管理员（被授权用户）编码
     */
    private String adminCode;

    /**
     * 数据库字段:role_id  属性显示:授权角色id
     */
    private Long roleId;

    /**
     * 数据库字段:to_auth_admin_code  属性显示:授权人编码
     */
    private String toAuthAdminCode;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private Date createTime;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private Date createTimeBegin;
    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private Date createTimeEnd;

    /**
     * 1对1关联查询RbacAdmin 权限系统-管理员（授权用户）  属性显示:rbacAdmin
     */
    private RbacAdmin rbacAdmin;
    /**
     * 1对1关联查询RbacRole 权限系统-角色  属性显示:rbacRole
     */
    private RbacRole rbacRole;

    public RbacAdminRoleRelation() {
    }

    public RbacAdminRoleRelation(String adminCode, Long roleId, String toAuthAdminCode, Date createTime) {
        this.adminCode = adminCode;
        this.roleId = roleId;
        this.toAuthAdminCode = toAuthAdminCode;
        this.createTime = createTime;
    }
}