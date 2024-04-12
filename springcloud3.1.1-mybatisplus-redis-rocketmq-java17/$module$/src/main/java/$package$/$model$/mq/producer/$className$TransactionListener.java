package $package$.$model$.mq.producer;

import lombok.extern.slf4j.Slf4j;
import org.apache.rocketmq.client.producer.LocalTransactionState;
import org.apache.rocketmq.client.producer.TransactionListener;
import org.apache.rocketmq.common.message.Message;
import org.apache.rocketmq.common.message.MessageExt;
import org.springframework.stereotype.Component;

import java.util.Map;


/**
 * $notes$ $className$ 消息事务 实现
 * 此处为事务消息，不需要时应删除，需要启用 yml 事务消息配置
 * 注意开启 @Component 注解使其生效
 */
@Slf4j
//@Component
public class $className$TransactionListener implements TransactionListener {

    /**
     * 处理本地相关事务业务，如没有则无需处理，此处如果超时无响应，
     * 则 checkLocalTransaction 方法会被二次确认
     */
    @Override
    public LocalTransactionState executeLocalTransaction(Message msg, Object arg) {
        log.info("事务执行,消息: {}", msg.toString());

        Map<String, String> headerMap = msg.getProperties();
        log.info("message headers :{}", headerMap);
        try {
            log.info("消息实体：{}", String.valueOf(msg.getBody()));
            return LocalTransactionState.COMMIT_MESSAGE;
        } catch (Exception e) {
            log.error("{}", e.getLocalizedMessage(), e);
        }

        return LocalTransactionState.ROLLBACK_MESSAGE;
    }

    /**
     * 方法 executeLocalTransaction 执行无明确响应，
     * 或超时响应，则调用此方法再次确认事务结果
     */
    @Override
    public LocalTransactionState checkLocalTransaction(MessageExt msg) {
        log.info("事务检查，消息：{}", msg.toString());
        try {
            return LocalTransactionState.COMMIT_MESSAGE;
        } catch (Exception e) {
            log.error("{}", e.getLocalizedMessage(), e);
        }

        return LocalTransactionState.ROLLBACK_MESSAGE;
    }
}
