package com.ponddy.core.base.handler;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.ponddy.cache.redis.RedisKey;
import com.ponddy.cache.redis.RedisUtils;
import com.ponddy.core.config.Env;
import com.ponddy.core.dto.BaseExceptionDTO;
import com.ponddy.core.entity.BeanRet;
import com.ponddy.core.enums.ApiI18nKeyEnum;
import com.ponddy.core.exceptions.BaseException;
import com.ponddy.core.tools.StringTools;
import com.ponddy.language.utils.LanguageLocaleUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import javax.annotation.Resource;
import java.lang.ClassCastException;
import java.lang.NullPointerException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.UndeclaredThrowableException;
import java.sql.SQLSyntaxErrorException;

import static com.ponddy.core.exceptions.BaseException.ExceptionEnums.*;
import static com.ponddy.core.exceptions.BaseException.ExceptionEnums.ClassCastException;
import static com.ponddy.core.exceptions.BaseException.ExceptionEnums.NullPointerException;

/**
 * Copyright 2020 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2020/1/6 11:32
 * @Description:
 */
@Slf4j
@ControllerAdvice
public class CustomExceptionHandler {

    @Resource
    private RedisUtils redisUtils;

    @Resource
    private LanguageLocaleUtil languageLocaleUtil;

    /**
     * 拦截异常：UndeclaredThrowableException
     *
     * @param exception
     * @return
     */
    @ExceptionHandler(value = UndeclaredThrowableException.class)
    @ResponseBody
    public BeanRet catchException(UndeclaredThrowableException exception) {

        Throwable serviceException;
        InvocationTargetException undeclaredThrowable = (InvocationTargetException) exception.getUndeclaredThrowable();
        serviceException = undeclaredThrowable.getTargetException();

        String exceptionToString = serviceException.toString();
        if (log.isDebugEnabled()) {
            log.debug(">>> exceptionToString [{}] >>>", exceptionToString);
        }
        if (exceptionToString.indexOf("com.ponddy.core.exceptions.BaseException") >= 0) {
            BaseExceptionDTO exceptionDTO = JSON.parseObject(serviceException.getMessage(), BaseExceptionDTO.class);
            if (log.isDebugEnabled()) {
                log.debug(">>> exceptionDTO [{}] >>>", JSON.toJSONString(exceptionDTO));
            }
            if (null != exceptionDTO.getI18nKeyCode()) {
                String redisKey = RedisKey.genI18nKeyValue(exceptionDTO.getApiI18nKeyEnum(), languageLocaleUtil.getDefault());
                String keyValue = getValueFromRedis(redisKey);
                if (null == keyValue) {
                    keyValue = exceptionDTO.getInfo();
                }
                else {
                    keyValue = replaceParams(keyValue, exceptionDTO.getParams());
                }
                return BeanRet.error(exceptionDTO, keyValue);
            }
        }

        return BeanRet.error(BaseException.ExceptionEnums.server_error);
    }

    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public BeanRet catchException(Exception exception) {
        //创建异常数据结果对象
        BaseExceptionDTO baseExceptionDTO = null;
        if (exception == null) {
            return BeanRet.create(false, ApiI18nKeyEnum.server_unknow_error);
        }

        if (log.isDebugEnabled()) {
            log.debug(">>> exception.getClass().getName() >>> " + exception.getClass().getName());
        }

        if (log.isDebugEnabled()) {
            log.debug(">>> exception instanceof [{}] >>>", (exception instanceof BaseException));
        }

        if (exception instanceof UndeclaredThrowableException) {
            if (log.isDebugEnabled()) {
                log.debug(">>> UndeclaredThrowableException >>>");
            }
            Throwable apiException;
            try {
                InvocationTargetException undeclaredThrowable = (InvocationTargetException) ((UndeclaredThrowableException) exception).getUndeclaredThrowable();
//                if (log.isDebugEnabled()) {
//                    log.debug(">>> getTargetException [{}] >>>", undeclaredThrowable.getTargetException());
//                    log.debug(">>> getTargetException json [{}] >>>", JSON.toJSONString(undeclaredThrowable.getTargetException()));
//                }
                apiException = undeclaredThrowable.getTargetException();

                Object object = redisUtils.get(RedisKey.genI18nLocaleDefaultKey());

                if (log.isDebugEnabled()) {
                    log.debug(">>> object [{}] >>>", object.toString());
                    log.debug(">>> undeclaredThrowable [{}] >>>", JSON.toJSONString(apiException));
                    log.debug("{} ===> {} ===> msg: {}", "ExceptionHandle", "errorHandle", apiException.toString());
                    log.debug("{} ===> {} ===> msg: {}", "ExceptionHandle", "errorHandle", apiException.getLocalizedMessage());
                }
                BeanRet beanRet = JSON.parseObject(apiException.getMessage(), BeanRet.class);
                return beanRet;
            } catch (Exception e1) {
                log.error("{} ===> {} ===>  {}", "ExceptionHandle", "errorHandle", "异常转换错误", e1);
                return BeanRet.create(false, service_error, service_error.toString());
            }
        }

        //业务异常
        if (exception instanceof BaseException) {
            if (log.isDebugEnabled()) {
                log.debug(">>> baseExceptionDTO [{}] >>>", JSON.toJSONString(exception));
            }
            if (StringUtils.isNotBlank(exception.getMessage())) {
                if (StringTools.isJson(exception.getMessage())) {
                    //实例化异常结果对象：捕获到的业务异常
                    baseExceptionDTO = JSONObject.parseObject(exception.getMessage(), BaseExceptionDTO.class);
                } else {
                    //实例化异常结果对象：业务异常的自定义信息
                    baseExceptionDTO = BaseExceptionDTO.toObj(service_error, exception.getMessage());
                }
            } else {
                //实例化异常结果对象:业务异常
                baseExceptionDTO = BaseExceptionDTO.toObj(service_error);
            }
        }
        //数据类型转换异常
        else if (exception instanceof ClassCastException) {
            if (log.isErrorEnabled()) {
                log.error(ClassCastException.codeEnum.zhName + exception.getMessage());
            }
            baseExceptionDTO = BaseExceptionDTO.toObj(ClassCastException, exception.getMessage());
        }
        //格式异常
        else if (exception instanceof MethodArgumentTypeMismatchException) {
            if (log.isErrorEnabled()) {
                log.error(MethodArgumentTypeMismatchException.codeEnum.zhName + exception.getMessage());
            }
            baseExceptionDTO = BaseExceptionDTO.toObj(MethodArgumentTypeMismatchException, exception.getMessage());
        }
        //数据库异常
        else if (exception instanceof DataIntegrityViolationException) {
            if (log.isErrorEnabled()) {
                log.error(DataIntegrityViolationException.codeEnum.zhName + exception.getMessage());
            }
            baseExceptionDTO = BaseExceptionDTO.toObj(DataIntegrityViolationException, exception.getMessage());
        }
        //数据库异常
        else if (exception instanceof SQLSyntaxErrorException) {
            if (log.isErrorEnabled()) {
                log.error(SQLSyntaxErrorException.codeEnum.zhName + exception.getMessage());
            }
            baseExceptionDTO = BaseExceptionDTO.toObj(SQLSyntaxErrorException, exception.getMessage());
        }
        //Mybatis异常
        else if (exception instanceof MyBatisSystemException) {
            if (log.isErrorEnabled()) {
                log.error(MyBatisSystemException.codeEnum.zhName + exception.getMessage());
            }
            baseExceptionDTO = BaseExceptionDTO.toObj(MyBatisSystemException, exception.getMessage());
        }
        //空指针异常
        else if (exception instanceof NullPointerException) {
            if (log.isErrorEnabled()) {
                log.error(NullPointerException.codeEnum.zhName + exception.getMessage());
            }
            baseExceptionDTO = BaseExceptionDTO.toObj(NullPointerException, exception.getMessage());
        }
        //参数类异常
        else if (exception instanceof org.springframework.validation.BindException) {
            if (log.isErrorEnabled()) {
                log.error(BindException.codeEnum.zhName + exception.getMessage());
            }
            baseExceptionDTO = BaseExceptionDTO.toObj(BindException, exception.getMessage());
        }
        //http请求方法不支持异常
        else if (exception instanceof org.springframework.web.HttpRequestMethodNotSupportedException) {
            if (log.isErrorEnabled()) {
                log.error(HttpRequestMethodNotSupportedException.codeEnum.zhName + exception.getMessage());
            }
            baseExceptionDTO = BaseExceptionDTO.toObj(HttpRequestMethodNotSupportedException, exception.getMessage());
        }
        // mysql数据
        else if (exception instanceof com.mysql.cj.jdbc.exceptions.MysqlDataTruncation) {
            if (log.isErrorEnabled()) {
                log.error(MysqlDataTruncation.codeEnum.zhName + exception.getMessage());
            }
            baseExceptionDTO = BaseExceptionDTO.toObj(MysqlDataTruncation, exception.getMessage());
        } else {
            //生产环境
            if (Env.isProd) {
                log.error(server_error.codeEnum.zhName + ":" + exception.getMessage());
                //实例化异常结果对象：服务异常
                baseExceptionDTO = BaseExceptionDTO.toObj(server_error);
            }
            //非生产环境
            else {
                log.error(server_error.codeEnum.zhName + ":" + exception.getMessage());
                baseExceptionDTO = BaseExceptionDTO.toObj(server_error, exception.getMessage());
            }
        }
        //打印异常
//        exception.printStackTrace();

        return BeanRet.create(false, baseExceptionDTO.getCode(), baseExceptionDTO.getInfo());
    }

    /**
     * 从redis缓存中取出缓存
     *
     * @param redisKey
     * @return
     */
    public String getValueFromRedis(String redisKey) {
        Object object = redisUtils.get(redisKey);
        if (null != object) {
            return object.toString();
        }
        return null;
    }



    public String replaceParams(String template, String[] params) {
        if (null == params || params.length == 0) {
            return template;
        }
        if (log.isDebugEnabled()) {
            log.debug(">>> template [{}] >>>", template);
        }

        for (String param: params) {
            template = template.replaceFirst("[{}]+", param);
            if (log.isDebugEnabled()) {
                log.debug(">>> template [{}] >>>", template);
            }
        }
        return template;
    }
}