package com.my.core.entity;

import com.my.core.exceptions.BaseException;
import lombok.Data;

import java.io.Serializable;

/**
 * 结果返回类
 */
@Data
public final class R implements Serializable {
    private boolean success = false;
    private String info = BaseException.BaseExceptionEnum.Server_Error.msg;
    private Object data = null;
    private String code = BaseException.BaseExceptionEnum.Server_Error.code;

    /**
     * 失败 false 自定义提示信息
     *
     * @param info 自定义提示信息
     */
    public static R failed(String info) {
        return new R(false, info, null);
    }

    public static R failed(String info, Object data) {
        return new R(false, info, data);
    }

    /**
     * 成功 true 自定义提示信息
     *
     * @param info 自定义提示信息
     */
    public static R success(String info) {
        return new R(false, info, null);
    }

    public static R success(String info, Object data) {
        return new R(false, info, data);
    }

    /**
     * 失败 false  传递 异常枚举对象
     *
     * @param baseExceptionEnum 异常枚举对象
     */
    public static R failed(BaseException.BaseExceptionEnum baseExceptionEnum) {
        return new R(false, baseExceptionEnum.code, baseExceptionEnum.msg);
    }

    public static R failed(BaseException.BaseExceptionEnum baseExceptionEnum, Object data) {
        return new R(false, baseExceptionEnum.code, baseExceptionEnum.msg, data);
    }

    /**
     * 成功 true 成功 “异常” 对象信息
     *
     * @param baseExceptionEnum 成功 “异常” 对象信息
     */
    public static R success(BaseException.BaseExceptionEnum baseExceptionEnum) {
        return new R(true, baseExceptionEnum.code, baseExceptionEnum.msg);
    }

    public static R success(BaseException.BaseExceptionEnum baseExceptionEnum, Object data) {
        return new R(true, baseExceptionEnum.code, baseExceptionEnum.msg, data);
    }


    private R() {
    }

    private R(boolean success, String info, Object data) {
        this.success = success;
        this.info = info;
        this.data = data;
        if (success) {
            this.code = BaseException.BaseExceptionEnum.Success.code;
        }
    }

    public R(boolean success, String code, String info, Object data) {
        this.success = success;
        this.info = info;
        this.data = data;
        this.code = code;
    }
}
