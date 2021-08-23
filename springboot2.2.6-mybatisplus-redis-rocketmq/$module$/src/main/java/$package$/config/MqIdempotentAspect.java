package $package$.config;

import $package$.core.annotation.IdempotentLock;
import $package$.cache.service.RedisServiceSVImpl;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.expression.Expression;
import org.springframework.expression.ExpressionParser;
import org.springframework.expression.common.TemplateParserContext;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.concurrent.TimeUnit;

/**
 * mq的幂等切面拦截
 * 实现对消息队列的自动幂等处理，需要配合在需要的方法上的
 *
 * @see IdempotentLock 注解完成，具体的定义可以查看
 * {@link IdempotentLock}的定义
 */
@Slf4j
@Aspect
@Component
@Order(100)
public class MqIdempotentAspect {
    @Autowired
    private RedisServiceSVImpl redisServiceSV;

    /**
     * 设置切面切入点
     * 针对所有的MQ消费者进行切入
     */
    @Pointcut("execution(* com.order.*.mq.consumer..*(..))")
    public void idempotent() {
    }

    /**
     * 环绕切入
     * 解析注解，并实现加锁，自动释放锁功能
     */
    @Around(value = "idempotent() && @annotation(idempotentLock)")
    public Object doAround(ProceedingJoinPoint joinPoint, IdempotentLock idempotentLock) throws Exception {
        String key = this.renderKey(joinPoint, idempotentLock.key());
        try {
            boolean locked = this.lock(key, idempotentLock.timeout(), idempotentLock.timeUnit());
            if (!locked) {
                return null;
            }
            return joinPoint.proceed();
        } catch (Throwable throwable) {
            return null;
        } finally {
            this.unLock(key);
        }
    }

    /**
     * 渲染 key
     *
     * @param key key 模板 #{对象.属性} -> spel 表达式#{#对象.属性}
     * @return 缓存key
     */
    private String renderKey(JoinPoint joinpoint, String key) {
        if (StringUtils.isEmpty(key)) {
            return null;
        }

        //自动转化成 spel的格式
        String result = "mq:" + key.replaceAll("#\\{\\w+.", "#{");
        Object[] args = joinpoint.getArgs();
        for (Object arg : args) {
            ExpressionParser expressionParser = new SpelExpressionParser();
            StandardEvaluationContext context = new StandardEvaluationContext();
            context.setRootObject(arg);
            Expression expression = expressionParser.parseExpression(result, new TemplateParserContext());
            result = expression.getValue(context, String.class);
        }

        log.info("消息幂等 key-{}", result);
        return result;
    }


    /**
     * 加分布式锁
     *
     * @param key      缓存key也可以成为锁
     * @param timeout  过期时间
     * @param timeUnit 时间单位
     */
    private Boolean lock(String key, long timeout, TimeUnit timeUnit) {
        try {
            key = "Lock:" + key;
            if (TimeUnit.SECONDS == timeUnit) {
                timeout = timeout * 1000;
            }
            Boolean locked = redisServiceSV.lock(key, timeout);
            return locked;
        } catch (Exception e) {
            log.error("获取分布式锁失败，key={}", key, e);
            return false;
        }
    }


    /**
     * 解锁，释放锁
     *
     * @param key 锁的key
     */
    private void unLock(String key) {
        try {
            key = "Lock:" + key;
            redisServiceSV.unlock(key);
        } catch (Exception e) {
            log.error("释放分布式锁失败，key={}", key, e);
        }
    }
}
