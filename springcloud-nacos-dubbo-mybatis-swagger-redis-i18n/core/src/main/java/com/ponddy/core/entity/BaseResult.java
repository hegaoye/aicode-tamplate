package com.ponddy.core.entity;

import com.ponddy.core.enums.ResultEnum;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.io.Serializable;

/**
 * Copyright 2020 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2020/1/7 20:23
 * @Description:
 */
@Data
@Slf4j
public class BaseResult<T> implements Serializable {
    private static final long serialVersionUID = 7893493397619939493L;

    /**
     * 状态码：200 成功，其它为失败
     */
    public Integer code;

    /**
     * 成功为 success，其它为失败原因
     */
    public String msg;

    /**
     * 具体内容
     */
    public T data;

    public BaseResult() {
    }

    public BaseResult(ResultEnum resultEnum, T data) {
        this.code = resultEnum.code;
        this.msg = resultEnum.msg;
        this.data = data;
    }

    public BaseResult(Integer code, String msg, T data) {
        this.code = code;
        this.msg = msg;
        this.data = data;
    }
}
