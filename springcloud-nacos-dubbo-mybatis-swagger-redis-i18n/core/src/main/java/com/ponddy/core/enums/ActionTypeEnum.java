/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.core.enums;

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
        return null;
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