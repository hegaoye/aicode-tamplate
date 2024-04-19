package $package$.$model$.mq.consumer;

import $package$.$model$.entity.$className$;
import $package$.$model$.message.$className$Message;
import $package$.$model$.mq.$className$Sink;
import $package$.$model$.service.$className$Service;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.stream.annotation.StreamListener;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.stereotype.Service;

/**
 * 消费入口
 */
@Slf4j
@Service
public class $className$Consumer {
    @Autowired
    private $className$Service $classNameLower$Service;

    /**
     * 消费 $notes$ 消息
     *
     * @param $classNameLower$Message 消息体
     */
    @StreamListener($className$Sink.build$className$Input)
    public void buildProjectInput(@Payload $className$Message $classNameLower$Message) {
        $className$ $classNameLower$ = new $className$();
        BeanUtils.copyProperties($classNameLower$Message, $classNameLower$);
        $classNameLower$Service.save($classNameLower$);
    }
}
