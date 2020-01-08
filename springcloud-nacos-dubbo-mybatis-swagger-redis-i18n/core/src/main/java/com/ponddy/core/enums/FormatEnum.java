/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.core.enums;

/**
 * 内容格式枚举
 * [枚举编号：1005](/resources/enum/1005)
 * Created by borong on 2019/7/15.
 */
public enum FormatEnum {
    account("字母+数字组合，且字母开头；长度保持在5-16位"),
    language_key("字母+数字+下划线组合，且字母开头；长度保持在1-64位"),
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
        return null;
    }
}