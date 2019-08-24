/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

import lombok.Data;

import java.util.Date;
import java.util.List;

    import ${basePackage}.rbac.entity.RbacAdmin;
    import ${basePackage}.rbac.entity.RbacRole;

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
    private java.lang.Long id;

    /**
     * 数据库字段:admin_code  属性显示:管理员（被授权用户）编码
     */
    private java.lang.String adminCode;

    /**
     * 数据库字段:role_id  属性显示:授权角色id
     */
    private java.lang.Long roleId;

    /**
     * 数据库字段:to_auth_admin_code  属性显示:授权人编码
     */
    private java.lang.String toAuthAdminCode;

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