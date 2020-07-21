package $package$.config;

import $package$.$model$.mq.$className$Sink;
import org.springframework.cloud.stream.annotation.EnableBinding;
import org.springframework.context.annotation.Configuration;

/**
 * mq 注入 消息生产者消费者
 */
@Configuration
@EnableBinding({
        $className$Sink.class
})
public class MqConfig {
}
