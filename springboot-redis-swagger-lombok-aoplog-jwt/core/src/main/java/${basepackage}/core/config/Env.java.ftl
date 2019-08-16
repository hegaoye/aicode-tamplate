/*
 * ${copyright}
 */
package ${basePackage}.core.config;

import ${basePackage}.core.enums.EnvEnums;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 项目的三种运行环境的标记
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

    //初始化当前环境是否是生产环境
    public static boolean isProd;
    //初始化当前环境是否是沙箱测试环境
    public static boolean isSandbox;
    //初始化当前环境是否是开发环境
    public static boolean isDev;

    @Value("${r'${spring.profiles.active}'}")
    public void setActive(String active) {
        Env.active = active;
        if (StringUtils.isNotBlank(active)) {
            isProd = EnvEnums.PROD.name().equalsIgnoreCase(active);
            isSandbox = EnvEnums.SANDBOX.name().equalsIgnoreCase(active);
            isDev = EnvEnums.DEV.name().equalsIgnoreCase(active);
        }
    }
}