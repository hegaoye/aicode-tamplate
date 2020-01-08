/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.core.tools;

import com.alibaba.fastjson.JSON;
import com.ponddy.core.dto.UserRequestClientDto;
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
        UserRequestClientDto userRequestClientDto = new UserRequestClientDto(
                null == operatingSystem ? "" : operatingSystem.getName(),
                null == browser ? "" : browser.getName(),
                null == version ? "" : version.getVersion());
        return userRequestClientDto;
    }
}
