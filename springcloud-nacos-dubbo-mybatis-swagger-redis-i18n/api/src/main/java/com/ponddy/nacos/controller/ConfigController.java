package com.ponddy.nacos.controller;

import com.alibaba.dubbo.config.annotation.Reference;
import com.ponddy.cache.redis.RedisUtils;
import com.ponddy.core.entity.BeanRet;
import com.ponddy.logs.entity.SystemLog;
import com.ponddy.logs.service.SystemLogSv;
import com.ponddy.test.service.HelloSV;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.cloud.context.config.annotation.RefreshScope;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;
import java.util.List;

import static com.ponddy.core.exceptions.BaseException.ExceptionEnums;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/12/28 10:13
 * @Description:
 */
@Slf4j
@RestController
@RequestMapping("/config")
@RefreshScope
public class ConfigController {

    @Reference(version = "${dubbo.consumer.version}")
    private HelloSV helloSV;

    @Reference(version = "${dubbo.consumer.version}")
    private SystemLogSv systemLogSv;

    @Resource
    private RedisUtils redisUtils;

    @RequestMapping(value = "/get", method = RequestMethod.GET)
    @ResponseBody
    public BeanRet get() {
        String hello = helloSV.sayHello("custom");

        List<SystemLog> list = null;

        list = systemLogSv.list(new SystemLog(), 1, 10);


        if (log.isInfoEnabled()) {
            log.info(">>> hello：{}; count: {} >>>", hello, list);
        }

        Object object = redisUtils.get("I18n:API_RESPONSE_INFO:1786275283548528640:en");

        if (log.isInfoEnabled()) {
            log.info(">>> object [{}] >>>", object.toString());
        }

        return BeanRet.create(true, ExceptionEnums.success, list);
    }
}
