/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.core.enums;


import com.ponddy.core.config.Env;

/**
 * 项目运行的环境 枚举类
 * [枚举编号：1000](/resources/enum/1000)
 * Created by borong on 2019/5/12 16:50
 *
 * @author borong
 */
public enum EnvEnums {

    //生产
    PROD("★★★PRODUCT[生产环境]★★★"),
    //沙箱测试
    SANDBOX("✧✧✧SANDBOX[沙箱环境]✧✧✧"),
    //开发
    DEV("▷▷▷DEVELOP[开发环境]◁◁◁");

    //运行环境文字描述
    public String desc;

    /**
     * 构造器
     *
     * @param desc
     */
    EnvEnums(String desc) {
        this.desc = desc;
    }

    /**
     * 获得当前运行环境
     *
     * @return
     */
    public static EnvEnums getCurrent() {
        return getEnum(Env.getActive());
    }

    /**
     * 通过枚举名 获得 枚举对象
     *
     * @param name
     * @return
     */
    public static EnvEnums getEnum(String name) {
        for (EnvEnums enums : EnvEnums.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        return null;
    }
}
