/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

/**
* 权限系统-权限资源 的实体类的状态
*
* @author borong
*/
public enum RbacPermissionState implements java.io.Serializable {
    //枚举定义在此
    ;

    public String val;
    RbacPermissionState(String val) {
        this.val=val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param name
     * @return
     */
    public static RbacPermissionState getEnum(String name) {
        for (RbacPermissionState enums : RbacPermissionState.values()) {
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