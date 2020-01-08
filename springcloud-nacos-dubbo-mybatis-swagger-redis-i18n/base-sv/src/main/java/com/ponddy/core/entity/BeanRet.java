/*
 * Copyright (c) 2017. 郑州仁中和科技有限公司.保留所有权利.
 *                       http://www.rzhkj.com/
 *      郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系.
 *      代码遵循Apache License2.0开源协议,可放心使用.
 *
 */
package com.ponddy.core.entity;


import com.ponddy.core.dto.BaseExceptionDTO;
import com.ponddy.core.enums.ApiI18nKeyEnum;
import com.ponddy.core.exceptions.BaseException;
import lombok.Data;

import java.io.Serializable;

@Data
public class BeanRet implements Serializable {
    private boolean success = false;
    private String info = BaseException.ExceptionEnums.server_error.codeEnum.zhName;
    private Object data = null;
    private int code = BaseException.ExceptionEnums.server_error.codeEnum.code;

    public static BeanRet success(Object obj) {
        return create(true, BaseException.ExceptionEnums.success, obj);
    }

    public static BeanRet error(BaseException.ExceptionEnums exceptionEnums) {
        return create(false, exceptionEnums);
    }

    public static BeanRet error(BaseExceptionDTO exceptionDTO) {
        return create(false, exceptionDTO.getCode(), exceptionDTO.getInfo());
    }

    public static BeanRet error(BaseExceptionDTO exceptionDTO, String info) {
        return create(false, exceptionDTO.getCode(), info);
    }

    public static BeanRet create(BaseException.ExceptionEnums exceptionEnums) {
        return new BeanRet(false, exceptionEnums.codeEnum.code, exceptionEnums.codeEnum.zhName);
    }

    public static BeanRet create(boolean success, BaseException.ExceptionEnums exceptionEnums) {
        return new BeanRet(success, exceptionEnums.codeEnum.code, exceptionEnums.codeEnum.zhName);
    }

    public static BeanRet create(boolean success, BaseException.ExceptionEnums exceptionEnums, String info) {
        return new BeanRet(success, exceptionEnums.codeEnum.code, exceptionEnums.codeEnum.zhName, info);
    }

    public static BeanRet create(boolean success, BaseException.ExceptionEnums exceptionEnums, Object data) {
        return new BeanRet(success, exceptionEnums.codeEnum.code, exceptionEnums.codeEnum.zhName, data);
    }

    /**
     * 多语言返回结果
     *
     * @param success
     * @param apiI18NKeyEnum
     * @return
     */
    public static BeanRet create(boolean success, ApiI18nKeyEnum apiI18NKeyEnum) {
        return new BeanRet(success, apiI18NKeyEnum.code, apiI18NKeyEnum.defaultValue);
    }

    public static BeanRet create(boolean success, int code, String info) {
        return new BeanRet(success, code, info);
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