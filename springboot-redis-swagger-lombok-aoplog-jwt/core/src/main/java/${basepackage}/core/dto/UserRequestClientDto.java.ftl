/*
 * ${copyright}
 */
package ${basePackage}.core.dto;

import lombok.Data;

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
        this.browserVersion = browserVersion;
    }
}
