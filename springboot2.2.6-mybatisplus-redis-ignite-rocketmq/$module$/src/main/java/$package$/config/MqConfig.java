package $package$.config;
/***for(class in classes){***/

import $package$.$model$.mq.$class.className$Sink;
/***}***/
import org.springframework.cloud.stream.annotation.EnableBinding;
import org.springframework.context.annotation.Configuration;

/**
 * mq 注入 消息生产者消费者
 */
@Configuration
@EnableBinding({ /***for(class in classes){***/
        $class.className$Sink.class/***if(!classLP.last){***/,
/***}}***/})
public class MqConfig {
}
