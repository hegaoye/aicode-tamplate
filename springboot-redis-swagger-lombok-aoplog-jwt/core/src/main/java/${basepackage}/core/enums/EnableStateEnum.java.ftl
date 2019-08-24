/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

/**
 * 启用状态
 * [枚举编号：1007](/resources/enum/1007)
 * @author borong
 */
public enum EnableStateEnum implements java.io.Serializable {
    //枚举定义在此
    enable("启用"),
    disable("禁用");

    public String val;

    EnableStateEnum(String val) {
        this.val = val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param stateName
     * @return
     */
    public static EnableStateEnum getEnum(String stateName) {
        for (EnableStateEnum userState : EnableStateEnum.values()) {
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
