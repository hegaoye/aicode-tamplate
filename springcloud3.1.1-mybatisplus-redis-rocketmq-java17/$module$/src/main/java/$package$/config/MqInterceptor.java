package $package$.config;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import $package$.core.http.HttpHeaders;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.MDC;
import org.springframework.integration.config.GlobalChannelInterceptor;
import org.springframework.messaging.Message;
import org.springframework.messaging.MessageChannel;
import org.springframework.messaging.MessageHeaders;
import org.springframework.messaging.support.ChannelInterceptor;
import org.springframework.messaging.support.GenericMessage;
import org.springframework.stereotype.Component;

import java.util.Map;

/**
 * mq 统一拦截器
 */
@Slf4j
@Component
@GlobalChannelInterceptor(patterns = "*")
public class MqInterceptor implements ChannelInterceptor {

    @Override
    public Message<?> preSend(Message<?> message, MessageChannel channel) {
        MessageHeaders headers = message.getHeaders();
        //消费时设置traceId
        if (headers.containsKey(HttpHeaders.TRACE_ID)) {
            String traceId = String.valueOf(headers.get(HttpHeaders.TRACE_ID));
            if (StringUtils.isNotBlank(traceId)) {
                MDC.put(HttpHeaders.TRACE_ID, traceId);
            }
            return ChannelInterceptor.super.preSend(message, channel);
        } else {
            //生产消息时设置traceId
            Message<?> myMessage = message;
            // 添加 traceId 头
            String traceId = MDC.get(HttpHeaders.TRACE_ID);
            log.debug("mq send 拦截traceId: {}", traceId);
            if (StringUtils.isNotBlank(traceId)) {
                JSONObject parseObject = JSON.parseObject(JSON.toJSONString(message));
                Map<String, Object> headersMap = (Map<String, Object>) parseObject.get("headers");
                headersMap.put(HttpHeaders.TRACE_ID, traceId);
                myMessage = new GenericMessage(message.getPayload(), headersMap);
            }
            return ChannelInterceptor.super.preSend(myMessage, channel);
        }

    }
}
