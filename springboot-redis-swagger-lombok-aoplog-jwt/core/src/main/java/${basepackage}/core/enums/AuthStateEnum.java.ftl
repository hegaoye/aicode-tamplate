/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/5/13 22:27
 * @Description: 认证状态（unapply 未申请，wait 待审核，pass 审核通过，unpass 审核未通过）
 * [枚举编号：2002](/resources/enum/2002)
 */
public enum AuthStateEnum {
    unapply("未申请"),
    wait("待审核"),
    pass("审核通过"),
    unpass("审核未通过");

    public String val;

    AuthStateEnum(String val) {
        this.val = val;
    }

    //通过值获得枚举对象
    public static AuthStateEnum getEnum(String name) {
        for (AuthStateEnum enums : AuthStateEnum.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        return null;
    }
}
