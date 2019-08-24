/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;

/**
 * 内容格式枚举
 * [枚举编号：1005](/resources/enum/1005)
 * Created by borong on 2019/7/15.
 */
public enum FormatEnum {
    account("字母+数字组合，且字母开头；长度保持在5-16位"),
    password("字母+数字组合；长度保持在6-20位"),
    json("JSON"),
    phone("11位手机号"),
    email("email地址"),
    upload_limit_suffix_file("jpg,jpeg,png,gif,bmp,rar,zip,doc,docx,xls,xlsx,ppt,pptx,flv,swf,txt,json"),
    ;
    public String val;

    FormatEnum(String val) {
        this.val = val;
    }

    //通过值获得内容格式
    public static FormatEnum getEnum(String name) {
        for (FormatEnum enums : FormatEnum.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        throw new BaseException(BaseException.ExceptionEnums.enumUndefined(name));
    }
}