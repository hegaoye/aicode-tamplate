/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

/**
* 权限系统-角色对应权限关系 的实体类的状态
*
* @author borong
*/
public enum RbacRolePermissionRelationState implements java.io.Serializable {
    //枚举定义在此
    ;

    public String val;
    RbacRolePermissionRelationState(String val) {
        this.val=val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param name
     * @return
     */
    public static RbacRolePermissionRelationState getEnum(String name) {
        for (RbacRolePermissionRelationState enums : RbacRolePermissionRelationState.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        return null;
    }

    @Override
    public String toString() {
         return this.name();
    }
}