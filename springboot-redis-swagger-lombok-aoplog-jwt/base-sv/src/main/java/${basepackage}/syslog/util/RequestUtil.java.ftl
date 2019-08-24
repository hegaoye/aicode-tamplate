/*
 * ${copyright}
 */
package ${basePackage}.syslog.util;

import ${basePackage}.core.dto.UserRequestClientDto;
import ${basePackage}.core.tools.IPGetter;
import ${basePackage}.core.tools.UserAgentTools;
import ${basePackage}.syslog.entity.SystemLog;

import javax.servlet.http.HttpServletRequest;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/21 17:23
 * @Description: 请求工具
 */
public class RequestUtil {

    /**
     * 获取请求的客户端信息，并装箱至系统日志
     *
     * @param systemLog
     * @param request
     */
    public static void getRequestClientInfo(SystemLog systemLog, HttpServletRequest request) {
        // 获取 用户访问 IP 地址
        String ip = IPGetter.getAccessIp(request);
        systemLog.setIpAddress(IPGetter.inetAton(ip));

        UserRequestClientDto clientDto = UserAgentTools.getUserAgent(request);
        if (null != clientDto) {
            systemLog.setSystem(clientDto.getSystem());
            systemLog.setBrowser(String.format("%s:%s", clientDto.getBrowser(), clientDto.getBrowserVersion()));
        } else {
            systemLog.setSystem("");
            systemLog.setBrowser("");
        }
    }
}
