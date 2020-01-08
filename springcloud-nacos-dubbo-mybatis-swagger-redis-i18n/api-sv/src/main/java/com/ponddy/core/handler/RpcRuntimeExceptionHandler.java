package com.ponddy.core.handler;

import com.ponddy.core.exceptions.BaseException;
import lombok.extern.slf4j.Slf4j;

/**
 * Copyright 2020 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2020/1/7 18:27
 * @Description:
 */
@Slf4j
//@Aspect
//@Component
public class RpcRuntimeExceptionHandler {

//    @AfterThrowing(throwing = "exception", pointcut = "execution(* com.ponddy.*.service.*(..))")
    public void afterThrow(Throwable exception) {
        if (exception instanceof RuntimeException) {
            throw new BaseException(exception);
        }
        exception.printStackTrace();
    }
}
