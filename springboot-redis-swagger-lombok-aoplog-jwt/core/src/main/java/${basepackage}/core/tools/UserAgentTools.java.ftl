/*
 * ${copyright}
 */
package ${basePackage}.core.tools;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.dto.UserRequestClientDto;
import eu.bitwalker.useragentutils.Browser;
import eu.bitwalker.useragentutils.OperatingSystem;
import eu.bitwalker.useragentutils.UserAgent;
import eu.bitwalker.useragentutils.Version;
import lombok.extern.slf4j.Slf4j;

import javax.servlet.http.HttpServletRequest;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/10 16:10
 * @Description: 具有操作系统和浏览器详细信息的用户代理信息的工具类
 * Container class for user-agent information with operating system and browser details.
 * Can decode user-agent strings.
 */
@Slf4j
public class UserAgentTools {
    /**
     * 获取用户请求使用的客户端信息
     *
     * @param request
     * @return
     */
    public static UserRequestClientDto getUserAgent(HttpServletRequest request) {
        UserAgent userAgent = UserAgent.parseUserAgentString(request.getHeader("User-Agent"));
        // 获取浏览器信息
        Browser browser = userAgent.getBrowser();

        if (log.isDebugEnabled()) {
            log.debug(">>> browser [{}] >>>", JSON.toJSONString(browser));
        }

        // 浏览器版本
        Version version = userAgent.getBrowserVersion();

        if (log.isDebugEnabled()) {
            log.debug(">>> version [{}] >>>", JSON.toJSONString(version));
        }

        // 获取操作系统信息
        OperatingSystem operatingSystem = userAgent.getOperatingSystem();

        if (log.isDebugEnabled()) {
            log.debug(">>> operatingSystem [{}] >>>", JSON.toJSONString(operatingSystem));
        }

        // 实例化返回结果
        UserRequestClientDto userRequestClientDto = new UserRequestClientDto(operatingSystem.getName(), browser.getName(), version.getVersion());
        return userRequestClientDto;
    }
}
