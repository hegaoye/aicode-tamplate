/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.core.enums;

import java.io.Serializable;

/**
 * 复选框选择状态枚举
 * [枚举编号：1009](/resources/enum/1009)
 * Created by borong on 2019/8/21.
 */
public enum CheckboxEnum implements Serializable {
    // 选中状态
    all("全选"),
    // 选中状态
    part("部分"),
    // 未选状态
    none("全不选"),
    ;
    public String val;

    CheckboxEnum(String val) {
        this.val = val;
    }

    //通过值获得性别
    public static CheckboxEnum getEnum(String name) {
        for (CheckboxEnum enums : CheckboxEnum.values()) {
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
    public static boolean isInSet(CheckboxEnum checkbox, CheckboxEnum... sets) {
        if (sets.length == 0) {
            return false;
        }
        for (CheckboxEnum set : sets) {
            if (set.equals(checkbox)) {
                return true;
            }
        }
        return false;
    }
}
