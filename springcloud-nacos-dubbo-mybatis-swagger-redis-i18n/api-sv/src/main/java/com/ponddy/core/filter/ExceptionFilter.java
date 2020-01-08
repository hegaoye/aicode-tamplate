package com.ponddy.core.filter;

import com.alibaba.dubbo.common.Constants;
import com.alibaba.dubbo.common.extension.Activate;
import com.alibaba.dubbo.common.utils.ReflectUtils;
import com.alibaba.dubbo.common.utils.StringUtils;
import com.alibaba.dubbo.rpc.*;
import com.alibaba.dubbo.rpc.service.GenericService;
import com.alibaba.fastjson.JSON;
import com.ponddy.core.exceptions.BaseException;
import lombok.extern.slf4j.Slf4j;

import java.lang.reflect.Method;

/**
 * Copyright 2020 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2020/1/6 18:56
 * @Description:
 * 功能：
 * <ol>
 * <li>不期望的异常打ERROR日志（Provider端）<br>
 *     不期望的日志即是，没有的接口上声明的Unchecked异常。
 * <li>异常不在API包中，则Wrap一层RuntimeException。<br>
 *     RPC对于第一层异常会直接序列化传输(Cause异常会String化)，避免异常在Client出不能反序列化问题。
 * </ol>
 */
@Slf4j
@Activate(group = Constants.PROVIDER)
public class ExceptionFilter implements Filter {

    @Override
    public Result invoke(Invoker<?> invoker, Invocation invocation) throws RpcException {
        if (log.isDebugEnabled()) {
            log.debug(">>> 进入 自定义的 ExceptionFilter [{}] >>>", invoker);
        }
        try {
            Result result = invoker.invoke(invocation);
            try {
                Throwable exception = result.getException();
                if (null == exception) {
                    return result;
                }

                // 如果是checked异常，直接抛出
                if (result.hasException() && GenericService.class != invoker.getInterface()) {
                    if (log.isDebugEnabled()) {
                        log.debug(">>> 匹配到异常类名 exception.getClass().getName()： [{}] >>>", exception.getClass().getName());
                    }
                    if (exception instanceof BaseException) {
                        if (log.isDebugEnabled()) {
                            log.debug(">>> 自定义运行时异常 BaseException [{}] >>>", JSON.toJSONString(exception));
                            log.debug(">>> 待返回结果 result [{}] >>>", JSON.toJSONString(result));
                        }
                        return result;
                    }

                    if (exception instanceof RuntimeException && exception instanceof Exception) {
                        return result;
                    }
                }

                // 在方法签名上有声明，直接抛出
                try {
                    Method method = invoker.getInterface().getMethod(invocation.getMethodName(), invocation.getParameterTypes());
                    Class<?>[] exceptionClasses = method.getExceptionTypes();
                    for (Class<?> exceptionClass : exceptionClasses) {
                        if (exception.getClass().equals(exceptionClass)) {
                            return result;
                        }
                    }
                } catch (NoSuchMethodException e) {
                    return result;
                }

                // 未在方法签名上定义的异常，在服务器端打印ERROR日志
                if (log.isErrorEnabled()) {
                    log.error("Got unchecked and undeclared exception which called by: {}" + RpcContext.getContext().getRemoteHost());
                    log.error("service: {}", invoker.getInterface().getName());
                    log.error("method: {}", invocation.getMethodName());
                    if (null != exception) {
                        log.error("exception: {}", exception);
                        log.error("exceptionClassName: {}", exception.getClass().getName());
                        log.error("message: {}", exception.getMessage());
                    }
                }

                // 异常类和接口类在同一jar包里，直接抛出
                String serviceFile = ReflectUtils.getCodeBase(invoker.getInterface());
                String exceptionFile = ReflectUtils.getCodeBase(exception.getClass());

                if (null == serviceFile || null == exceptionFile || serviceFile.equals(exceptionFile)) {
                    return result;
                }

                // 是 JDK 自带的异常，直接抛出
                String className = exception.getClass().getName();
                if (className.startsWith("java.") || className.startsWith("javax.")) {
                    return result;
                }

                // 是 Dubbo本身的异常，直接抛出
                if (exception instanceof RpcException) {
                    return result;
                }

                // 否则，包装成 RuntimeException 抛给客户端
                return new RpcResult(new RuntimeException(StringUtils.toString(exception)));
            } catch (Throwable e) {
                log.warn("Fail to ExceptionFilter when called by " + RpcContext.getContext().getRemoteHost()
                        + ". service: " + invoker.getInterface().getName() + ", method: " + invocation.getMethodName()
                        + ", exception: " + e.getClass().getName() + ": " + e.getMessage(), e);
                return result;
            }
        } catch (RuntimeException e) {
            log.error("Got unchecked and undeclared exception which called by " + RpcContext.getContext().getRemoteHost()
                    + ". service: " + invoker.getInterface().getName() + ", method: " + invocation.getMethodName()
                    + ", exception: " + e.getClass().getName() + ": " + e.getMessage(), e);
            throw e;
        }
    }
}