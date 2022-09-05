package $package$.$model$.mq.consumer;

import $package$.$model$.service.$className$Service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cglib.core.internal.Function;
import org.springframework.context.annotation.Bean;
import org.springframework.messaging.Message;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/**
 * $model$消费入口
 */
@Slf4j
@Service
public class $className$Receptor {

    @Autowired
    private $className$Service $classNameLower$Service;

    /**
     * 监听 创建 $model$ 数据消费
     */
    @Bean
    public Function<Flux<Message<String>>, Mono<Void>> buildSettingEvent() {
        return flux -> flux.map(message -> {
            log.info("{}", message.getPayload());
            try {
                $className$ $classNameLower$ = new $className$();
                BeanUtils.copyProperties(message.getPayload(), $classNameLower$);
                $classNameLower$Service.save($classNameLower$);
            } catch (Exception e) {
                log.error("异常-{}-异常信息-{}", message.getPayload(), e.getMessage());
            }
            return message;
        }).then();
    }

}
