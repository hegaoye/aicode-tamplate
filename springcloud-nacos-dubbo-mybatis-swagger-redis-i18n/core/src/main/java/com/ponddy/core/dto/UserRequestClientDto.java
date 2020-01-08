/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.core.dto;

import lombok.Data;
import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;

/**
 * @Author borong
 * @Date 2019/8/10 16:14
 * @Description: 用户请求使用客户端的 dto
 */
@Data
public class UserRequestClientDto implements Serializable {
    private static final long serialVersionUID = -4268368619960004874L;

    /**
     * 操作系统
     */
    private String system;

    /**
     * 浏览器
     */
    private String browser;

    /**
     * 浏览器版本
     */
    private String browserVersion;

    public UserRequestClientDto() {
    }

    public UserRequestClientDto(String system, String browser, String browserVersion) {
        this.system = system;
        this.browser = browser;
        this.browserVersion = StringUtils.isBlank(browserVersion) ? "" : browserVersion;
    }
}
