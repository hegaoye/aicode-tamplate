package ${basePackage}.core.common;

import ${basePackage}.core.enums.EnvEnums;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * 项目的自定义配置
 */
@Slf4j
@Component
@ConfigurationProperties(prefix = "config")
public class Config {

    /**
     * 项目一级域名
     */
    @Getter
    public static String domain;

    @Value("${r'${config.domain}'}")
    public void setActive(String domain) {
        Config.domain = domain;
    }
}