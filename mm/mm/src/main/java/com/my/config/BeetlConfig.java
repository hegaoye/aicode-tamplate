package com.my.config;

import org.beetl.core.Function;
import org.beetl.ext.spring.BeetlGroupUtilConfiguration;
import org.beetl.ext.spring.SpELFunction;
import org.beetl.ext.spring.UtilsFunctionPackage;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.util.HashMap;
import java.util.Map;

@Configuration
public class BeetlConfig {

    @Bean
    public BeetlGroupUtilConfiguration beetlGroupUtilConfiguration() {
        BeetlGroupUtilConfiguration beetlGroupUtilConfiguration = new BeetlGroupUtilConfiguration();
        Map<String, Function> functionMap = new HashMap<>();
        functionMap.put("spel", new SpELFunction());
        beetlGroupUtilConfiguration.setFunctions(functionMap);
        Map<String, Object> map = new HashMap<>();
        map.put("sputil", new UtilsFunctionPackage());
        beetlGroupUtilConfiguration.setFunctionPackages(map);
        return beetlGroupUtilConfiguration;
    }
}
