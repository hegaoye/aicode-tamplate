package $package$.$model$.mq.producer;

import $package$.$model$.entity.$className$;
import $package$.$model$.message.$className$Message;
import $package$.$model$.mq.$className$Sender;
import $package$.$model$.mq.$className$Topic;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.rocketmq.common.message.MessageConst;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.stream.function.StreamBridge;
import org.springframework.integration.support.MessageBuilder;
import org.springframework.stereotype.Service;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.Message;
import org.springframework.util.MimeTypeUtils;


/**
 * $notes$ $className$ 消息 生产 实现
 */
@Slf4j
@Service
public class $className$SenderImpl implements $className$Sender {

    @Autowired
    private StreamBridge streamBridge;

    /**
     * 创建 $notes$ $className$ 消息
     *
     * @param $classNameLower$ 的实体类
     */
    @Override
    public void build($className$ $classNameLower$) {
        log.info("创建 $notes$ $className$ 消息: {}", $classNameLower$);

        try {
            String linkId = RandomStringUtils.random(32, true, true);
            log.info("创建 $notes$ $className$ 消息 linkId: {}", linkId);

            $className$Message $classNameLower$Message = new $className$Message();
            BeanUtils.copyProperties($classNameLower$, $classNameLower$Message);

            Message<$className$Message> message = MessageBuilder.withPayload($classNameLower$Message)
                    .setHeader(MessageHeaders.CONTENT_TYPE, MimeTypeUtils.APPLICATION_JSON)
                    /**
                     * 延迟消息，必须设置延迟级别，每个级别代表一个延迟时间长度
                     *级别：1  2   3  4   5  6  7  8  9  10 11 12 13 14  15  16  17 18
                     *延迟：1s 5s 10s 30s 1m 2m 3m 4m 5m 6m 7m 8m 9m 10m 20m 30m 1h 2h
                     */
                    //.setHeader(MessageConst.PROPERTY_DELAY_TIME_LEVEL, 延迟级别)
                    //事务消息开启
//                    .setHeader(MessageConst.PROPERTY_TRANSACTION_PREPARED, true)
//                .setHeader(RocketMQHeaders.TAGS, $className$Message.getCode())
                    .setHeader(MessageHeaders.CONTENT_TYPE, MimeTypeUtils.APPLICATION_JSON)
                    .setHeader(MessageConst.PROPERTY_ORIGIN_MESSAGE_ID, linkId)
                    .setHeader(MessageConst.PROPERTY_KEYS, linkId)
                    .build();
            streamBridge.send($className$Topic.$className$Event_OUT.topic, message);
        } catch (Exception e) {
            log.error("生产 创建 $notes$ 消息-{}", e.getLocalizedMessage(), e);
        }
    }
}
