/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.rbac.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 权限系统-角色对应权限关系 的实体类
 *
 * @author borong
 */
@Data
public class RbacRolePermissionRelation implements java.io.Serializable {

    /**
     * 数据库字段:menuId  属性显示:关系记录id
     */
    private Long id;

    /**
     * 数据库字段:role_id  属性显示:角色id
     */
    private Long roleId;

    /**
     * 数据库字段:permission_id  属性显示:权限id；权限汇总表id
     */
    private Long permissionId;

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
     * 1对1关联查询RbacRole 权限系统-角色  属性显示:rbacRole
     */
    private RbacRole rbacRole;
    /**
     * 1对1关联查询RbacPermission 权限系统-权限资源  属性显示:rbacPermission
     */
    private RbacPermission rbacPermission;

    public RbacRolePermissionRelation() {
    }

    public RbacRolePermissionRelation(Long roleId, Long permissionId, Date createTime) {
        this.roleId = roleId;
        this.permissionId = permissionId;
        this.createTime = createTime;
    }

    /**
     * 角色绑定的权限集合 转 权限集合
     * @param relations
     * @return
     */
    public static List<RbacPermission> relationList2PermissionList(List<RbacRolePermissionRelation> relations) {
        if (null == relations || relations.size() == 0) {
            return null;
        }
        List<RbacPermission> rbacPermissions = new ArrayList<>();

        relations.forEach(relation -> {
            rbacPermissions.add(relation.getRbacPermission());
        });

        return rbacPermissions;
    }
}