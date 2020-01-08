package com.ponddy.core.enums;

/**
 * Copyright 2020 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2020/1/6 10:25
 * @Description: Api响应信息键枚举
 */
public enum ApiI18nKeyEnum {
    /**
     * 格式：键（键代码，状态码，默认值，说明）
     */
    http_response_success(1786275283548528640L, 200, "Response ok", "Response ok"),
    param_is_null(1786285402491478016L, 52, "Param is null", "自定义参数 ${param}"),
    server_unknow_error(1786383310565957632L, 31, "Unknown server exception", "未知服务器异常"),
    ;

    /**
     * i18n项目 键代码
     */
    public Long i18nKeyCode;

    /**
     * http 状态码
     */
    public int code;

    /**
     * 默认值
     */
    public String defaultValue;

    /**
     * 说明
     */
    public String description;

    /**
     * 构造器：用于创建枚举键
     *
     * @param i18nKeyCode
     * @param code
     * @param defaultValue
     * @param description
     */
    ApiI18nKeyEnum(Long i18nKeyCode, int code, String defaultValue, String description) {
        this.i18nKeyCode = i18nKeyCode;
        this.code = code;
        this.defaultValue = defaultValue;
        this.description = description;
    }

    public static ApiI18nKeyEnum getByI18nKeyCode(Long i18nKeyCode) {
        for (ApiI18nKeyEnum enums : ApiI18nKeyEnum.values()) {
            if (enums.i18nKeyCode.equals(i18nKeyCode)) {
                return enums;
            }
        }
        return null;
    }
}