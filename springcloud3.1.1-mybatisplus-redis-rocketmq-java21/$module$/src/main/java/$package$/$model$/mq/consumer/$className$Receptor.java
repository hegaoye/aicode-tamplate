package $package$.$model$.mq.consumer;

import com.alibaba.fastjson.JSON;
import $package$.$model$.service.$className$Service;
import $package$.$model$.entity.$className$;
import $package$.$model$.message.$className$Message;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.integration.redis.util.RedisLockRegistry;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageHeaders;
import org.springframework.stereotype.Component;

import java.util.Objects;
import java.util.Optional;
import java.util.UUID;
import java.util.concurrent.locks.Lock;
import java.util.function.Consumer;

/**
 * $model$消费入口
 */
@Slf4j
@Component
public class $className$Receptor {

    @Autowired
    private $className$Service $classNameLower$Service;

    @Autowired
    private RedisLockRegistry redisLockRegistry;

    /**
     * 监听 创建 $model$ 数据消费
     */
    @Bean
    public Consumer<Message<$className$Message>> $classNameLower$Event() {
        return message -> {
            log.info("{}", message);
            String messageId = message.getHeaders().get(MessageHeaders.ID).toString();
            String lockKey = messageId;
            Lock lock = redisLockRegistry.obtain(lockKey);
            if (!lock.tryLock()) {
                return;
            }

            try {
                $className$Message $classNameLower$Message = message.getPayload();
                $className$ $classNameLower$ = JSON.parseObject(JSON.toJSONString($classNameLower$Message), $className$.class);
                $classNameLower$Service.save($classNameLower$);
            } catch (Exception e) {
                log.error("异常-{}-异常信息-{}", message, e.getMessage());
            } finally {
                if (null != lock) {
                    try {
                        lock.unlock();
                        log.info("正常释放锁-{}", lockKey);
                    } catch (Exception e) {
                        log.warn("消费 事件释放锁已被释放");
                    }
                }
            }
        };
    }

}
