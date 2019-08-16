/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

/**
 * 用户状态
 * [枚举编号：2000](/resources/enum/2000)
 * @author borong
 */
public enum UserState implements java.io.Serializable {
    //枚举定义在此
    normal("正常"),
    abnormal("不正常");

    public String val;

    UserState(String val) {
        this.val = val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param stateName
     * @return
     */
    public static UserState getEnum(String stateName) {
        for (UserState userState : UserState.values()) {
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
