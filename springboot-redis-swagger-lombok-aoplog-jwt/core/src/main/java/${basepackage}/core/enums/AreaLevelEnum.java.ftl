/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;

/**
 * 区域级别枚举
 * [枚举编号：1003](/resources/enum/1003)
 * Created by borong on 2019/4/30.
 */
public enum AreaLevelEnum {
    level_1(1, "province"),
    level_2(2, "city"),
    level_3(3, "county"),
    level_4(4, "town"),
    ;
    public int level;
    //级别对应区域表的列名，也是级别名称
    public String columnName;

    AreaLevelEnum(int level, String columnName) {
        this.level = level;
        this.columnName = columnName;
    }

    public static AreaLevelEnum getEnum(String name) {
        for (AreaLevelEnum enums : AreaLevelEnum.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        throw new BaseException(BaseException.ExceptionEnums.enums_undefined);
    }

    /**
     * 获取传入区域级别的枚举
     *
     * @param level
     * @return
     */
    public static AreaLevelEnum getEnum(int level) {
        for (AreaLevelEnum enums : AreaLevelEnum.values()) {
            if (enums.level - level == 0) {
                return enums;
            }
        }
        return null;
    }

    /**
     * 获取传入区域级别的下一级
     *
     * @param level
     * @return
     */
    public static AreaLevelEnum getLowerLevelEnum(int level) {
        for (AreaLevelEnum enums : AreaLevelEnum.values()) {
            if (enums.level - level == 1) {
                return enums;
            }
        }
        return null;
    }


}
