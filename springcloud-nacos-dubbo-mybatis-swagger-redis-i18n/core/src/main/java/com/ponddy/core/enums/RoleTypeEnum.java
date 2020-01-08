/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.core.enums;


/**
 * 角色（token）类型枚举
 * [枚举编号：1003](/resources/enum/1003)
 * Created by borong on 2019/4/30.
 */
public enum RoleTypeEnum {
    User("用户账号"),
    Tutor("教师账号"),
    Corporate("企业账号"),
    Admin("管理员账号"),
    Tourist("游客"),
    ;
    public String val;

    RoleTypeEnum(String val) {
        this.val = val;
    }

    public static RoleTypeEnum getEnum(String name) {
        for (RoleTypeEnum enums : RoleTypeEnum.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        return null;
    }
}