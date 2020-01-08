package com.ponddy.test.service;

import com.alibaba.dubbo.config.annotation.Service;
import com.alibaba.dubbo.rpc.RpcContext;
import com.alibaba.fastjson.JSON;
import com.ponddy.logs.dao.SystemLogDAO;
import com.ponddy.logs.entity.SystemLog;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/12/27 14:45
 * @Description:
 */
@Slf4j
@Service(version = "${dubbo.provider.version}")
public class HelloSVImpl implements HelloSV {

    @Value("${spring.application.name}")
    private String serviceName;

    @Value("${dubbo.registry.address}")
    private String nacosAddress;

    @Resource
    private SystemLogDAO systemLogDAO;

    @Override
    public String sayHello(String name) {
        RpcContext rpcContext = RpcContext.getContext();

        if (log.isInfoEnabled()) {
            log.info(">>> rpcContext：{} >>>", JSON.toJSONString(rpcContext));
            log.info(">>> nacosAddress：{} >>>", nacosAddress);
        }

        List<SystemLog> list = systemLogDAO.list(new HashMap<>(0));
        if (log.isInfoEnabled()) {
            log.info(">>> list：{} >>>", JSON.toJSONString(list));
        }

        return String.format("[%s] : Hello, %s", serviceName, name);
    }
}
