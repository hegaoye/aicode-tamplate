package $package$.$model$.mq.producer;

import $package$.$model$.entity.$className$;
import $package$.$model$.message.$className$Message;
import $package$.$model$.mq.$className$Producer;
import $package$.$model$.mq.$className$Sink;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.rocketmq.common.message.MessageConst;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.integration.support.MessageBuilder;
import org.springframework.stereotype.Service;

/**
 * 消息生产 实现
 */
@Slf4j
@Service
public class $className$ProducerImpl implements $className$Producer {
    @Autowired
    private $className$Sink $classNameLower$Sink;

    /**
     * 创建 $className$
     *
     * @param $classNameLower$ 账户 的实体类
     */
    @Override
    public void build($className$ $classNameLower$) {
        String linkId = RandomStringUtils.random(32, true, true);
        $className$Message $classNameLower$Message = new $className$Message();
        BeanUtils.copyProperties($classNameLower$, $classNameLower$Message);

        MessageBuilder messageBuilder = MessageBuilder.withPayload($classNameLower$Message)
                .setHeader(MessageConst.PROPERTY_KEYS, linkId);
//                .setHeader(RocketMQHeaders.TAGS, $classNameLower$Message.getCode());
        $classNameLower$Sink.build$className$Output().send(messageBuilder.build());
    }
}
