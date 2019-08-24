/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

/**
 * 管理员类型
 * [枚举编号：1010](/resources/enum/1010)
 * @author borong
 */
public enum AdminTypeEnum implements java.io.Serializable {
    //枚举定义在此
    NORMAL("普通管理员"),
    SUPER("超级管理员");

    public String val;

    AdminTypeEnum(String val) {
        this.val = val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param stateName
     * @return
     */
    public static AdminTypeEnum getEnum(String stateName) {
        for (AdminTypeEnum userState : AdminTypeEnum.values()) {
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
