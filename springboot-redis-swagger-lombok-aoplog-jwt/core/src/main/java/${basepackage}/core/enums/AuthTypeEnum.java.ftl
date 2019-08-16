/*
 * ${copyright}
 */ package ${basePackage}.core.enums;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/5/13 22:17
 *
 * @Description: 认证类别（personal 个人，corporate 企业）
 * [枚举编号：2001](/resources/enum/2001)
 */
public enum AuthTypeEnum {
    personal("个人"),
    corporate("企业");

    public String val;

    AuthTypeEnum(String val) {
        this.val = val;
    }

    //通过值获得枚举对象
    public static AuthTypeEnum getEnum(String name) {
        for (AuthTypeEnum enums : AuthTypeEnum.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        return null;
    }
}

