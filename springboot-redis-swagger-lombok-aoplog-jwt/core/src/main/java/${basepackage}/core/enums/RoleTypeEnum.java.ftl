/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;

/**
 * 角色（token）类型枚举
 * [枚举编号：1003](/resources/enum/1003)
 * Created by borong on 2019/4/30.
 */
public enum RoleTypeEnum {
    User("用户账号"),
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
        throw new BaseException(BaseException.ExceptionEnums.enumUndefined(name, RoleTypeEnum.class));
    }
}