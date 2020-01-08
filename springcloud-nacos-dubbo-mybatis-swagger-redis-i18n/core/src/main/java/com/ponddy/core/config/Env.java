/*
 * Copyright (c) 2017. 郑州仁中和科技有限公司.保留所有权利.
 *                       http://www.rzhkj.com/
 *      郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系.
 *      代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 *      本代码仅用于龐帝業務系统.
 */

package com.ponddy.core.config;

import com.ponddy.core.enums.EnvEnums;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 开发环境，沙箱环境，生产环境切换
 * 当 public static Env env = PRODUCT;则为生产环境
 * 默认为开发环境，
 * 生产环境将自动启用所有生产配置，
 * 谨慎配置，
 * 非生产环境不要开启
 *
 * @author borong
 */
@Slf4j
@Component
@ConfigurationProperties(prefix = "spring.profiles")
public class Env {

    /**
     * 当前项目运行的环境 标识名称（dev,sandbox,prod）
     */
    @Getter
    public static String active;

    @Getter
    public static String domain;

    /**
     * 初始化当前环境是否是生产环境
     */
    public static boolean isProd;

    /**
     * 初始化当前环境是否是沙箱测试环境
     */
    public static boolean isSandbox;

    /**
     * 初始化当前环境是否是开发环境
     */
    public static boolean isDev;

    /**
     * 此项目在i18n平台中的名字
     */
    public final static String PLATFORM_I18N_NAME = "API_RESPONSE_INFO";

    /**
     * 多语言默认语言
     */
    public final static String language_i18n_locale = "en";

    @Value("${spring.profiles.active}")
    public void setActive(String active) {
        Env.active = active;
        if (StringUtils.isNotBlank(active)) {
            isProd = EnvEnums.PROD.name().equalsIgnoreCase(active);
            isSandbox = EnvEnums.SANDBOX.name().equalsIgnoreCase(active);
            isDev = EnvEnums.DEV.name().equalsIgnoreCase(active);
        }
    }

    @Value("${ponddy.config.domain}")
    public static void setDomain(String domain) {
        Env.domain = domain;
    }
}