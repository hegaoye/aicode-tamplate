/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

import lombok.Data;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

    import ${basePackage}.rbac.entity.RbacRole;
    import ${basePackage}.rbac.entity.RbacPermission;

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
    private java.lang.Long id;

    /**
     * 数据库字段:role_id  属性显示:角色id
     */
    private java.lang.Long roleId;

    /**
     * 数据库字段:permission_id  属性显示:权限id；权限汇总表id
     */
    private java.lang.Long permissionId;

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