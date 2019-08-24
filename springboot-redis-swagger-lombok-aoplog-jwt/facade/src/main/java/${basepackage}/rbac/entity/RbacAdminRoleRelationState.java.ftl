/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

/**
* 权限系统-授权用户与角色关系 的实体类的状态
*
* @author borong
*/
public enum RbacAdminRoleRelationState implements java.io.Serializable {
    //枚举定义在此
    ;

    public String val;
    RbacAdminRoleRelationState(String val) {
        this.val=val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param name
     * @return
     */
    public static RbacAdminRoleRelationState getEnum(String name) {
        for (RbacAdminRoleRelationState enums : RbacAdminRoleRelationState.values()) {
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