/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.rbac.common;

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
