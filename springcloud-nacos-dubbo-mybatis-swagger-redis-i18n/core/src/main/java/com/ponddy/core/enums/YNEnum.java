/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.core.enums;

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
        return null;
    }
}