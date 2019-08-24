/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;

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
        throw new BaseException(BaseException.ExceptionEnums.enumUndefined(name));
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
