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
        try {
            String linkId = RandomStringUtils.random(32, true, true);
            $className$Message $classNameLower$Message = new $className$Message();
            BeanUtils.copyProperties($classNameLower$, $classNameLower$Message);

            MessageBuilder messageBuilder = MessageBuilder.withPayload($classNameLower$Message)
                    .setHeader(MessageHeaders.CONTENT_TYPE, MimeTypeUtils.APPLICATION_JSON)
                    .setHeader(MessageConst.PROPERTY_KEYS, linkId);
//                .setHeader(RocketMQHeaders.TAGS, $className$Message.getCode());
            streamBridge.send($className$Topic.$className$Event_OUT.topic, messageBuilder.build());
        } catch (Exception e) {
            log.error("生产 创建 $notes$ 消息-{}", e.getLocalizedMessage(), e);
        }
    }
}
