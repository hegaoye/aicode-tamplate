/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/9 17:34
 * @Description: 功能操作类型
 */
public enum ActionTypeEnum {
    // 新增
    add("新增"),
    // 修改
    edit("修改"),
    // 删除
    del("删除"),
    // 查询
    query("查询"),
    // 登录
    login("登录"),
    // 下载
    download("下载"),
    // 上传
    upload("上传"),
    ;

    /**
     * 枚举描述
     */
    private String description;
    ActionTypeEnum() {
    }

    ActionTypeEnum(String description) {
        this.description = description;
    }

    /**
     * 通过枚举名，获取枚举
     * @param name
     * @return
     */
    public static ActionTypeEnum getEnum(String name) {
        for (ActionTypeEnum enums : ActionTypeEnum.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        throw new BaseException(BaseException.ExceptionEnums.enumUndefined(name));
    }

    /**
     * 检查枚举类是否在预设参数中
     *
     * @param checkbox
     * @param sets
     * @return
     */
    public static boolean isInSet(ActionTypeEnum checkbox, ActionTypeEnum... sets) {
        if (sets.length == 0) {
            return false;
        }
        for (ActionTypeEnum set : sets) {
            if (set.equals(checkbox)) {
                return true;
            }
        }
        return false;
    }
}