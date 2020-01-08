package com.ponddy.core.tools;

import com.ponddy.core.entity.BaseResult;
import com.ponddy.core.enums.ResultEnum;
import com.ponddy.core.exceptions.BaseException;
import lombok.extern.slf4j.Slf4j;

/**
 * Copyright 2020 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2020/1/7 20:31
 * @Description:
 */
@Slf4j
public class ResultUtil {

    /**
     * 访问成功时调用 包含data
     *
     * @param object
     * @return
     */
    public static BaseResult success(Object object) {
        return new BaseResult(ResultEnum.SUCCESS, object);
    }

    /**
     * 访问成功时调用 不包含data
     * @return
     */
    public static BaseResult success(){
        return success(null);
    }

    /**
     * 返回异常情况 不包含data
     * @param code
     * @param msg
     * @return
     */
    public static BaseResult error(Integer code, String msg){
        BaseResult result = new BaseResult();
        result.setCode(code);
        result.setMsg(msg);
        return result;
    }

    /**
     * 返回异常情况 包含data
     * @param resultEnum 结果枚举类&emsp;统一管理&emsp;code msg
     * @param object
     * @return
     */
    public static BaseResult error(ResultEnum resultEnum, Object object){
        BaseResult result = error(resultEnum);
        result.setData(object);
        return result;
    }

    /**
     * 全局基类自定义异常 异常处理
     * @param e
     * @return
     */
    public static BaseResult error(BaseException e){
        return error(e.getCode(),e.getMessage());
    }

    /**
     * 返回异常情况 不包含data
     * @param resultEnum 结果枚举类&emsp;统一管理&emsp;code msg
     * @return
     */
    public static BaseResult error(ResultEnum resultEnum){
        return error(resultEnum.code, resultEnum.msg);
    }
}