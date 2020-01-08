package com.ponddy.core.enums;

import org.apache.commons.lang3.StringUtils;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/12/17 11:17
 * @Description: 国际化语言-键-终端平台
 * [枚举编号：3001](/resources/enum/3001)
 * 前端 frontend
 * API响应信息 api_response_info
 */
public enum LanguagePlatformEnum {
    // 前端-学生
    FRONTEND_STUDENT("前端-学生"),
    // 前端-老师
    FRONTEND_TUTOR("前端-老师"),
    // 前端-管理平台
    FRONTEND_MANAGEMENT("前端-管理平台"),
    // API响应结果信息
    API_RESPONSE_INFO("API响应结果信息"),
    ;

    /**
     * 描述
     */
    public String description;

    LanguagePlatformEnum(String description) {
        this.description = description;
    }

    /**
     * 通过值获得枚举对象
     * @param name
     * @return
     */
    public static LanguagePlatformEnum getEnum(String name) {
        if (StringUtils.isBlank(name)) {
            return null;
        }
        for (LanguagePlatformEnum enums : LanguagePlatformEnum.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        return null;
    }
}