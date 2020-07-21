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
 * $notes$ 消费入口
 */
@Slf4j
@Service
public class $className$Consumer {

    @Autowired
    private $className$Service $classNameLower$Service;

    /**
     * 监听 创建 $model$ 数据消费
     *
     * @param $classNameLower$Message 玩家彩票id集合
     */
    @StreamListener($className$Sink.build$className$Input)
    public void autoReduceOddsInput(@Payload $className$Message $classNameLower$Message) {
        log.info("{}", $classNameLower$Message);
        try {
            $className$ $classNameLower$ = new $className$();
            BeanUtils.copyProperties($classNameLower$Message, $classNameLower$);
            $classNameLower$Service.save($classNameLower$);
        } catch (Exception e) {
            log.error("自动降赔通知玩家彩票id集合异常-{}-异常信息-{}", $classNameLower$Message, e.getMessage());
        }

    }

}
