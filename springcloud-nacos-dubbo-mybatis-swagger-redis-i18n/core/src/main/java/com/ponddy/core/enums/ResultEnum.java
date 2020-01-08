package com.ponddy.core.enums;

/**
 * Copyright 2020 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2020/1/7 20:33
 * @Description:
 */
public enum ResultEnum {
    UNKNOWN_ERROR(-1, "o(╥﹏╥)o~~系统出异常啦!,请联系管理员!!!"),
    SUCCESS(200, "success");

    public Integer code;

    public String msg;

    ResultEnum(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}