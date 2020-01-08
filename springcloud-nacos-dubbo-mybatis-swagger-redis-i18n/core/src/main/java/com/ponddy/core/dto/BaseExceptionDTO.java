/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.core.dto;

import com.alibaba.fastjson.JSON;
import com.ponddy.core.enums.ApiI18nKeyEnum;
import com.ponddy.core.enums.HttpCodeEnum;
import com.ponddy.core.exceptions.BaseException;
import lombok.Data;

import java.io.Serializable;

/**
 * 异常结果对象
 * Created by borong on 2019/5/8 20:31
 * @author borong
 */
@Data
public class BaseExceptionDTO implements Serializable {

    private static final long serialVersionUID = -3943854279691998661L;

    /**
     * 单例模式
     */
    private static BaseExceptionDTO instance;

    public static BaseExceptionDTO getInstance() {
        if (instance == null) {
            instance = new BaseExceptionDTO();
        }
        return instance;
    }

    /**
     * 代号
     */
    private int code;

    /**
     * i18n项目 键代码
     */
    public Long i18nKeyCode;

    /**
     * 信息
     */
    private String info;

    /**
     * 扩展参数，用于替换国际化模板中参数变量
     */
    private String[] params;

    /**
     * 扩展参数，用于替换国际化模板中参数变量
     */
    private ApiI18nKeyEnum[] apiI18nKeyEnums;

    /**
     * 扩展参数，通过参数 i18nKeyCode 获取
     */
    private ApiI18nKeyEnum apiI18nKeyEnum;


    public BaseExceptionDTO() {
    }

    public BaseExceptionDTO(int code, String info) {
        this.code = code;
        this.info = info;
    }

    public BaseExceptionDTO(int code, String[] params) {
        this.code = code;
        this.params = params;
    }

    public BaseExceptionDTO(int code, Long i18nKeyCode, String[] params) {
        this.code = code;
        this.i18nKeyCode = i18nKeyCode;
        this.params = params;
        if (null != i18nKeyCode) {
            apiI18nKeyEnum = ApiI18nKeyEnum.getByI18nKeyCode(i18nKeyCode);
        }
    }

    public BaseExceptionDTO(int code, Long i18nKeyCode, String info) {
        this.code = code;
        this.i18nKeyCode = i18nKeyCode;
        this.info = info;

        if (null != i18nKeyCode) {
            apiI18nKeyEnum = ApiI18nKeyEnum.getByI18nKeyCode(i18nKeyCode);
        }
    }

    public static BaseExceptionDTO toObj(BaseException.ExceptionEnums exceptionEnums) {
        return toObj(exceptionEnums.codeEnum);
    }

    public static BaseExceptionDTO toObj(BaseException.ExceptionEnums exceptionEnums, String info) {
        return toObj(exceptionEnums.codeEnum, info);
    }

    public static String toString(HttpCodeEnum httpCodeEnum, String info) {
        return JSON.toJSONString(toObj(httpCodeEnum, info));
    }

    public static String toString(HttpCodeEnum httpCodeEnum, String... params) {
        return JSON.toJSONString(toObj(httpCodeEnum, params));
    }

    public static String toString(HttpCodeEnum httpCodeEnum) {
        return JSON.toJSONString(toObj(httpCodeEnum));
    }

    public static BaseExceptionDTO toObj(HttpCodeEnum httpCode) {
        if (null != httpCode.i18nKeyCode) {
            return new BaseExceptionDTO(httpCode.code, httpCode.i18nKeyCode, httpCode.zhName);
        }
        else {
            return new BaseExceptionDTO(httpCode.code, httpCode.zhName);
        }
    }

    public static BaseExceptionDTO toObj(HttpCodeEnum httpCode, String info) {
        if (null != httpCode.i18nKeyCode) {
            return new BaseExceptionDTO(httpCode.code, httpCode.i18nKeyCode, info);
        }
        else {
            return new BaseExceptionDTO(httpCode.code, info);
        }
    }

    private static BaseExceptionDTO toObj(HttpCodeEnum httpCode, String[] params) {
        if (null != httpCode.i18nKeyCode) {
            return new BaseExceptionDTO(httpCode.code, httpCode.i18nKeyCode, params);
        }
        else {
            return new BaseExceptionDTO(httpCode.code, params);
        }
    }
}
