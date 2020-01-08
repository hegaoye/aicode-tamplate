package com.ponddy.language.utils;

import com.ponddy.cache.redis.RedisKey;
import com.ponddy.cache.redis.RedisUtils;
import com.ponddy.core.config.Env;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;

/**
 * Copyright 2020 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2020/1/6 17:10
 * @Description:
 */
@Component
public class LanguageLocaleUtil {

    @Resource
    private RedisUtils redisUtils;

    /**
     * 获取默认的国际化语言
     * @return
     */
    public String getDefault() {
        String key = RedisKey.genI18nLocaleDefaultKey();
        Object object = redisUtils.get(key);
        if (null == object) {
            return Env.language_i18n_locale;
        }
        return object.toString();
    }
}
