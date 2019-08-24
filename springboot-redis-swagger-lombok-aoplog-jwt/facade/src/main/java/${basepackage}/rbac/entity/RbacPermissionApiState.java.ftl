/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

/**
* 权限系统-权限授权API；每一个权限对应多个授权API请求路径 的实体类的状态
*
* @author borong
*/
public enum RbacPermissionApiState implements java.io.Serializable {
    //枚举定义在此
    ;

    public String val;
    RbacPermissionApiState(String val) {
        this.val=val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param name
     * @return
     */
    public static RbacPermissionApiState getEnum(String name) {
        for (RbacPermissionApiState enums : RbacPermissionApiState.values()) {
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