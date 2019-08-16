/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;

/**
 * true/false 枚举
 * [枚举编号：1001] (/resources/enum/1001)
 * Created by borong on 2019/7/15.
 */
public enum YNEnum {
    Y(true), N(false);
    public boolean val;

    YNEnum(boolean val) {
        this.val = val;
    }

    //通过值获得性别
    public static YNEnum getEnum(String name) {
        for (YNEnum enums : YNEnum.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        throw new BaseException(BaseException.ExceptionEnums.enums_undefined);
    }


}
