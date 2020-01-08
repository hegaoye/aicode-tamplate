package com.ponddy.logs.utils;

import com.ponddy.core.dto.UserRequestClientDto;
import com.ponddy.core.tools.IPGetter;
import com.ponddy.core.tools.UserAgentTools;
import com.ponddy.logs.entity.SystemLog;

import javax.servlet.http.HttpServletRequest;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/12/31 16:41
 * @Description:
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
