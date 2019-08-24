/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

/**
* 权限系统-管理员（授权用户） 的实体类的状态
*
* @author borong
*/
public enum RbacAdminState implements java.io.Serializable {
    //枚举定义在此
    ;

    public String val;
    RbacAdminState(String val) {
        this.val=val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param name
     * @return
     */
    public static RbacAdminState getEnum(String name) {
        for (RbacAdminState enums : RbacAdminState.values()) {
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