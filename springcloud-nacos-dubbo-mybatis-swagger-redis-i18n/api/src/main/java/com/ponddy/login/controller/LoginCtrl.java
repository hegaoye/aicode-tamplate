package com.ponddy.login.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.ponddy.core.entity.BeanRet;
import com.ponddy.core.exceptions.BaseException;
import com.ponddy.logs.entity.SystemLog;
import com.ponddy.logs.service.SystemLogSv;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

/**
 * Copyright 2020 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2020/1/7 15:57
 * @Description:
 *
 * @RefreshScope 结合属性上的@Value注解，可以使配置文件自动刷新
 */
@RestController
@RequestMapping("/login")
@Api(tags = "LoginCtrl", value = "登录控制器", description = "登录控制器")
public class LoginCtrl {

    @Reference(version = "${dubbo.consumer.version}")
    private SystemLogSv systemLogSv;


    @ApiOperation(value = "日志查看", notes = "")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "offset", value = "查询开始行", dataType = "int", paramType = "query", required = true, defaultValue = "1"),
            @ApiImplicitParam(name = "limit", value = "查询行数", dataType = "int", paramType = "query", required = true, defaultValue = "10")
    })
    @GetMapping(value = "/logs/list")
    @ResponseBody
    public BeanRet listLogs(int offset, int limit) {
        try {
            BeanRet beanRet = systemLogSv.listReturn(new SystemLog(), offset, limit);
            return beanRet;
        } catch (BaseException e) {
            e.printStackTrace();
            return BeanRet.create(BaseException.ExceptionEnums.service_error);
        }
    }
}