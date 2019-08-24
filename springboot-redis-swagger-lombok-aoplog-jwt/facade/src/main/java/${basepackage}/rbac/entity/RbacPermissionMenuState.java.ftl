/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

/**
* 权限系统-菜单权限 的实体类的状态
*
* @author borong
*/
public enum RbacPermissionMenuState implements java.io.Serializable {
    //枚举定义在此
    ;

    public String val;
    RbacPermissionMenuState(String val) {
        this.val=val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param name
     * @return
     */
    public static RbacPermissionMenuState getEnum(String name) {
        for (RbacPermissionMenuState enums : RbacPermissionMenuState.values()) {
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