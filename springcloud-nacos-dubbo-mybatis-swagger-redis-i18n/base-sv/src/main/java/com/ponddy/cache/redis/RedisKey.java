package com.ponddy.cache.redis;

import com.ponddy.core.enums.ApiI18nKeyEnum;
import com.ponddy.core.enums.LanguagePlatformEnum;

/**
 * Copyright 2020 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2020/1/6 16:09
 * @Description:
 */
public class RedisKey {

    /**
     * 国际化语言缓存有效时长：24小时 = 60s * 60min * 24h = 86400;
     */
    public static final int LANGUAGE_I18N_TIME_SECONDS = 86400;

    /**
     * redis 缓存层级分隔符
     */
    public static final String SPLIT = ":";

    /**
     * 用户 TOKEN key
     */
    public static final String TOKEN_KEY = "TOKEN" + SPLIT;

    /**
     * 基础信息key
     */
    public static final String BASIC_HEADER = "Basic" + SPLIT;

    /**
     * 国际化i18n配置头Key
     */
    public static final String I18N_HEADER = "I18n" + SPLIT;

    /**
     * 上传相关缓存key的前缀
     */
    public static final String UPLOAD_KEY_HEADER = "Upload" + SPLIT;

    /**
     * 密码相关缓存key的前缀
     */
    public static final String PASSWORD_KEY_HEADER = "PASSWORD" + SPLIT;

    /**
     * 设定默认的国际化语言
     *
     * @return
     */
    public static String genI18nLocaleDefaultKey() {
        return I18N_HEADER + "DefaultLocale";
    }

    /**
     * 生成多终端平台的国际化语言缓存key
     *
     * @param platform
     * @param localeCode
     * @return
     */
    public static String genI18nKey(LanguagePlatformEnum platform, String localeCode) {
        return I18N_HEADER + platform.name() + SPLIT + localeCode;
    }

    /**
     * 生成指定终端平台的key对应语言的键值
     *
     * @param platform   平台
     * @param keyCode    键代码
     * @param localeCode 指定语言
     * @return
     */
    public static String genI18nKeyValue(LanguagePlatformEnum platform, String keyCode, String localeCode) {
        return I18N_HEADER + platform.name() + SPLIT + keyCode + SPLIT + localeCode;
    }

    /**
     * 生成指定终端平台的key对应语言的键值
     *
     * @param apiI18nKeyEnum Api响应信息键枚举
     * @param localeCode     指定语言
     * @return
     */
    public static String genI18nKeyValue(ApiI18nKeyEnum apiI18nKeyEnum, String localeCode) {
        return I18N_HEADER + LanguagePlatformEnum.API_RESPONSE_INFO + SPLIT + apiI18nKeyEnum.i18nKeyCode + SPLIT + localeCode;
    }
}