package com.my.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;


/**
 * mybatis-plus 注入扫描
 */
@Configuration
@ComponentScan(basePackages = {"com.my.*", "com.baidu.*"})
@MapperScan({"com.my.*.dao.mapper", "com.baidu.fsg.uid.worker.dao"})
public class MybatisPlusConfig {
}
