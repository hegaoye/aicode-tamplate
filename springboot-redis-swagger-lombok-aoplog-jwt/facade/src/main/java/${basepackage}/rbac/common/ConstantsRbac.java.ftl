/*
 * ${copyright}
 */
package ${basePackage}.rbac.common;

import java.io.Serializable;

/**
 * @Author borong
 * @Date 2019/8/20 17:56
 * @Description: 权限系统中常量
 */
public class ConstantsRbac implements Serializable {

    /**
     * 默认排序号 999
     */
    public final static int SORT = 999;

    /**
     * 上级id预设 0
     */
    public final static int ID_PRE_PRESET = 0;

    /**
     * 菜单 唯一标识码 的前缀；后面跟上 菜单权限的id
     */
    public final static String MENU_UNIQUE_CODE_HEADER = "menu_";
}
