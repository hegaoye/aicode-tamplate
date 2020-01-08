/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.core.enums;

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