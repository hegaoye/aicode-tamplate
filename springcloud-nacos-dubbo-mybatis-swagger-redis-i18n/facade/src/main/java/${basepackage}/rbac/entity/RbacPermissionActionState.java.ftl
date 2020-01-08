/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

/**
* 权限系统-功能操作权限 的实体类的状态
*
* @author borong
*/
public enum RbacPermissionActionState implements java.io.Serializable {
    //枚举定义在此
    ;

    public String val;
    RbacPermissionActionState(String val) {
        this.val=val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param name
     * @return
     */
    public static RbacPermissionActionState getEnum(String name) {
        for (RbacPermissionActionState enums : RbacPermissionActionState.values()) {
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