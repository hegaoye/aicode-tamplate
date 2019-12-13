/*
 * Copyright (c) 2017. 郑州仁中和科技有限公司.保留所有权利.
 *                       http://www.rzhkj.com/
 *      郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系.
 *      代码遵循Apache License2.0开源协议,可放心使用.
 *
 */
package ${basePackage}.core.entity;


import ${basePackage}.core.exceptions.BaseException;
import lombok.Data;

import java.io.Serializable;

@Data
public class BeanRet implements Serializable {
    private boolean success = false;
    private String info = BaseException.ExceptionEnums.server_error.codeEnum.description;
    private Object data = null;
    private int code = BaseException.ExceptionEnums.server_error.codeEnum.code;


    public static BeanRet create() {
        return new BeanRet();
    }

    public static BeanRet create(String info) {
        return new BeanRet(false, info);
    }

    public static BeanRet create(BaseException.ExceptionEnums exceptionEnums) {
        return new BeanRet(false, exceptionEnums.codeEnum.code, exceptionEnums.codeEnum.description);
    }

    public static BeanRet create(boolean success, BaseException.ExceptionEnums exceptionEnums) {
        return new BeanRet(success, exceptionEnums.codeEnum.code, exceptionEnums.codeEnum.description);
    }

    public static BeanRet create(boolean success, BaseException.ExceptionEnums exceptionEnums, String info) {
        return new BeanRet(success, exceptionEnums.codeEnum.code, exceptionEnums.codeEnum.description, info);
    }

    public static BeanRet create(boolean success, BaseException.ExceptionEnums exceptionEnums, Object data) {
        return new BeanRet(success, exceptionEnums.codeEnum.code, exceptionEnums.codeEnum.description, data);
    }

    public static BeanRet create(boolean success, String info) {
        return new BeanRet(success, info);
    }

    public static BeanRet create(boolean success, int code, String info) {
        return new BeanRet(success, code, info);
    }

    public static BeanRet create(boolean success, String info, Object data) {
        return new BeanRet(success, info, data);
    }

    public static BeanRet create(boolean success, int code, String info, Object data) {
        return new BeanRet(success, code, info, data);
    }

    public static BeanRet create(boolean success, BaseException.ExceptionEnums exceptionEnums, String info, Object data) {
        return new BeanRet(success, exceptionEnums.codeEnum.code, info, data);
    }


    private BeanRet() {

    }

    private BeanRet(boolean success, String info) {
        this.success = success;
        this.info = info;
        if (success) {
            this.code = BaseException.ExceptionEnums.success.codeEnum.code;
        }
    }


    public BeanRet(boolean success, int code, String info) {
        this.success = success;
        this.code = code;
        this.info = info;
    }

    private BeanRet(boolean success, String info, Object data) {
        this.success = success;
        this.info = info;
        this.data = data;
        if (success) {
            this.code = BaseException.ExceptionEnums.success.codeEnum.code;
        }
    }

    public BeanRet(boolean success, int code, String info, Object data) {
        this.success = success;
        this.info = info;
        this.data = data;
        this.code = code;
    }
}