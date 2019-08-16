/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;

/**
 * 性别枚举
 * [枚举编号：1002](/resources/enum/1002)
 * Created by borong on 2019/7/15.
 */
public enum SexEnum {
    MALE("男"), FEMALE("女"), OTHER("无");
    public String val;

    SexEnum(String val) {
        this.val = val;
    }

    //通过值获得性别
    public static SexEnum getEnum(String name) {
        for (SexEnum enums : SexEnum.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        throw new BaseException(BaseException.ExceptionEnums.enums_undefined);
    }


}
