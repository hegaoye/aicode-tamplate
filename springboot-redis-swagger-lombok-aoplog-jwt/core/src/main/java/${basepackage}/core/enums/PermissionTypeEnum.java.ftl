/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

/**
 * 权限类型
 * [枚举编号：1008](/resources/enum/1008)
 * @author borong
 */
public enum PermissionTypeEnum implements java.io.Serializable {
    //枚举定义在此
    menu("菜单"),
    action("功能操作");

    public String val;

    PermissionTypeEnum(String val) {
        this.val = val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param stateName
     * @return
     */
    public static PermissionTypeEnum getEnum(String stateName) {
        for (PermissionTypeEnum userState : PermissionTypeEnum.values()) {
            if (userState.name().equalsIgnoreCase(stateName)) {
                return userState;
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return this.name();
    }

}
