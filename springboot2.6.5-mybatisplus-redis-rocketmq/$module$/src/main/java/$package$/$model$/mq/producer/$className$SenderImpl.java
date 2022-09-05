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

/**
 * 消息生产 实现
 */
@Slf4j
@Service
public class $className$SenderImpl implements $className$Sender {

    @Autowired
    private StreamBridge streamBridge;

    /**
     * 创建 $className$
     *
     * @param $classNameLower$  的实体类
     */
    @Override
    public void build(Setting setting) {
        String linkId = RandomStringUtils.random(32, true, true);
        $className$Message $classNameLower$Message = new $className$Message();
        BeanUtils.copyProperties($classNameLower$, $classNameLower$Message);

        MessageBuilder messageBuilder = MessageBuilder.withPayload($classNameLower$Message)
                .setHeader(MessageConst.PROPERTY_KEYS, linkId);
//                .setHeader(RocketMQHeaders.TAGS, settingMessage.getCode());
        streamBridge.send($className$Topic.$className$Event_OUT.topic, messageBuilder.build());
    }
}
