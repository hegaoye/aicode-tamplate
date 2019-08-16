/*
 * ${copyright}
 */
package ${basePackage}.core;

import com.alibaba.fastjson.JSONObject;
import ${basePackage}.core.config.Env;
import ${basePackage}.core.dto.BaseExceptionDTO;
import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.tools.StringTools;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.sql.SQLNonTransientException;
import java.sql.SQLSyntaxErrorException;

import static ${basePackage}.core.exceptions.BaseException.ExceptionEnums.*;

/**
 * Created by IntelliJ IDEA.
 *
 * @author lixin
 */
@ControllerAdvice
@Slf4j
public class ExceptionHandle {

    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public BeanRet catchException(Exception exception) {
        //创建异常数据结果对象
        BaseExceptionDTO baseExceptionDTO = null;
        if (exception == null) {
            return BeanRet.create(false, server_unknow_error.codeEnum.code, server_unknow_error.codeEnum.descs);
        }

        if (log.isDebugEnabled()) {
            log.debug(">>> exception.getClass().getName() >>> " + exception.getClass().getName());
        }
        //业务异常
        if (exception instanceof BaseException) {
            if (StringUtils.isNotBlank(exception.getMessage())) {
                if (StringTools.isJson(exception.getMessage())) {
                    //实例化异常结果对象：捕获到的业务异常
                    baseExceptionDTO = JSONObject.parseObject(exception.getMessage(), BaseExceptionDTO.class);
                }
                else {
                    //实例化异常结果对象：业务异常的自定义信息
                    baseExceptionDTO = new BaseExceptionDTO(service_error, exception.getMessage());
                }
            } else {
                //实例化异常结果对象:业务异常
                baseExceptionDTO = new BaseExceptionDTO(service_error);
            }
        }
        //数据类型转换异常
        else if (exception instanceof ClassCastException) {
            if (log.isErrorEnabled()) {
                log.error(ClassCastException.codeEnum.descs + exception.getMessage());
            }
            baseExceptionDTO = new BaseExceptionDTO(ClassCastException, exception.getMessage());
        }
        //格式异常
        else if (exception instanceof MethodArgumentTypeMismatchException) {
            if (log.isErrorEnabled()) {
                log.error(MethodArgumentTypeMismatchException.codeEnum.descs + exception.getMessage());
            }
            baseExceptionDTO = new BaseExceptionDTO(MethodArgumentTypeMismatchException, exception.getMessage());
        }
        //数据库异常
        else if (exception instanceof DataIntegrityViolationException) {
            if (log.isErrorEnabled()) {
                log.error(DataIntegrityViolationException.codeEnum.descs + exception.getMessage());
            }
            baseExceptionDTO = new BaseExceptionDTO(DataIntegrityViolationException, exception.getMessage());
        }
        //数据库异常
        else if (exception instanceof SQLSyntaxErrorException) {
            if (log.isErrorEnabled()) {
                log.error(SQLSyntaxErrorException.codeEnum.descs + exception.getMessage());
            }
            baseExceptionDTO = new BaseExceptionDTO(SQLSyntaxErrorException, exception.getMessage());
        }
        //Mybatis异常
        else if (exception instanceof MyBatisSystemException) {
            if (log.isErrorEnabled()) {
                log.error(MyBatisSystemException.codeEnum.descs + exception.getMessage());
            }
            baseExceptionDTO = new BaseExceptionDTO(MyBatisSystemException, exception.getMessage());
        }
        //空指针异常
        else if (exception instanceof NullPointerException) {
            if (log.isErrorEnabled()) {
                log.error(NullPointerException.codeEnum.descs + exception.getMessage());
            }
            baseExceptionDTO = new BaseExceptionDTO(NullPointerException, exception.getMessage());
        }
        else {
            //生产环境
            if (Env.isProd) {
                log.error(server_error.codeEnum.descs + ":" + exception.getMessage());
                //实例化异常结果对象：服务异常
                baseExceptionDTO = new BaseExceptionDTO(server_error);
            }
            //非生产环境
            else {
                log.error(server_error.codeEnum.descs + ":" + exception.getMessage());
                baseExceptionDTO = new BaseExceptionDTO(server_error, exception.getMessage());
            }
        }
        //打印异常
        exception.printStackTrace();

        return BeanRet.create(false, baseExceptionDTO.getCode(), baseExceptionDTO.getInfo());
    }


}
