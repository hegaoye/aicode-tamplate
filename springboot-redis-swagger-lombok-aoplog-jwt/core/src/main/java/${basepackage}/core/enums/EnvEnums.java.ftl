/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.config.Env;
import ${basePackage}.core.exceptions.BaseException;

import java.io.Serializable;

/**
 * 项目运行的环境 枚举类
 * [枚举编号：1000](/resources/enum/1000)
 * Created by borong on 2019/5/12 16:50
 * @author borong
 */
public enum EnvEnums {

    //生产
    PROD("▶▶▶PRODUCT[生产环境]◀◀◀"),
    //沙箱测试
    SANDBOX("▶▶▶SANDBOX[沙箱环境]◀◀◀"),
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
        throw new BaseException(BaseException.ExceptionEnums.enums_undefined.codeEnum.descs + name);
    }
}
