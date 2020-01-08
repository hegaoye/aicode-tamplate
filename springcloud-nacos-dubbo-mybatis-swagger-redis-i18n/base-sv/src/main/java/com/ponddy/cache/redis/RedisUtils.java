package com.ponddy.cache.redis;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.serializer.RedisSerializer;
import org.springframework.data.redis.serializer.StringRedisSerializer;

import javax.annotation.Resource;
import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/**
 * Redis缓存辅助类
 *
 * @author shangze
 * @version 2017年6月1日 上午10:17:22
 */
@Configuration
public class RedisUtils {

    @Resource
    @Qualifier(value = "redisTemplate")
    private RedisTemplate redisTemplate;


    public final Object get(final String key) {
//        expire(key, EXPIRE);
        return redisTemplate.boundValueOps(key).get();
    }

    public final Set<Object> getAll(final String pattern) {
        Set<Object> values = new HashSet<>();
        Set<Serializable> keys = redisTemplate.keys(pattern);
        for (Serializable key : keys) {
//            expire(key.toString(), EXPIRE);
            values.add(redisTemplate.opsForValue().get(key));
        }
        return values;
    }

    public final void set(final String key, final Serializable value, int seconds) {
        redisTemplate.boundValueOps(key).set(value);
        expire(key, seconds);
    }

    public final void set(final String key, final Serializable value) {
        redisTemplate.boundValueOps(key).set(value);
//        expire(key, EXPIRE);
    }

    public final Boolean exists(final String key) {
        return redisTemplate.hasKey(key);
    }

    public final void del(final String key) {
        redisTemplate.delete(key);
    }

    public final void delAll(final String pattern) {
        redisTemplate.delete(redisTemplate.keys(pattern));
    }

    public final String type(final String key) {
//        expire(key, EXPIRE);
        return redisTemplate.type(key).getClass().getName();
    }

    /**
     * 在某段时间后失效
     *
     * @return
     */
    public final Boolean expire(final String key, final int seconds) {
        return redisTemplate.expire(key, seconds, TimeUnit.SECONDS);
    }

    /**
     * 在某个时间点失效
     *
     * @param key
     * @param unixTime
     * @return
     */
    public final Boolean expireAt(final String key, final long unixTime) {
        return redisTemplate.expireAt(key, new Date(unixTime));
    }

    /**
     * 检查 key是否存在
     *
     * @param key 缓存key
     * @return
     */
    public final Boolean hasKey(String key) {
        return redisTemplate.hasKey(key);
    }

    public final Long ttl(final String key) {
        return redisTemplate.getExpire(key, TimeUnit.SECONDS);
    }

    public final void setrange(final String key, final long offset, final String value) {
        redisTemplate.boundValueOps(key).set(value, offset);
//        expire(key, EXPIRE);
    }

    public final String getrange(final String key, final long startOffset, final long endOffset) {
//        expire(key, EXPIRE);
        return redisTemplate.boundValueOps(key).get(startOffset, endOffset);
    }

    public final Object getSet(final String key, final Serializable value) {
//        expire(key, EXPIRE);
        return redisTemplate.boundValueOps(key).getAndSet(value);
    }

    public boolean setnx(String key, Serializable value) {
        return redisTemplate.boundValueOps(key).setIfAbsent(value);
    }

    public void unlock(String key) {
        del(key);
    }

    public void hset(String key, String field, String value) {
        redisTemplate.boundHashOps(key).put(field, value);
    }

    public Object hget(String key, String field) {
        return redisTemplate.boundHashOps(key).get(field);
    }

    public void hdel(String key, String field) {
        redisTemplate.boundHashOps(key).delete(field);
    }


    /**
     * 解决Spring Boot 使用RedisTemplate 存储键值出现乱码 \xac\xed\x00\x05t\x00
     *
     * @param redisTemplate
     */
    @Autowired(required = false)
    public void setRedisTemplate(RedisTemplate redisTemplate) {
        RedisSerializer stringSerializer = new StringRedisSerializer();
        redisTemplate.setKeySerializer(stringSerializer);
        redisTemplate.setValueSerializer(stringSerializer);
        redisTemplate.setHashKeySerializer(stringSerializer);
        redisTemplate.setHashValueSerializer(stringSerializer);
        this.redisTemplate = redisTemplate;
    }
}
