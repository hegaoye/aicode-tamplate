/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.dingtalk.service;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.enums.EnvEnums;
import ${basePackage}.thirdparty.dingtalk.config.DingTalkConfig;
import ${basePackage}.thirdparty.dingtalk.dto.TextMsgAt;
import ${basePackage}.thirdparty.dingtalk.dto.TextMsgContent;
import ${basePackage}.thirdparty.dingtalk.entity.TextMsg;
import lombok.extern.slf4j.Slf4j;
import org.apache.http.HttpResponse;
import org.apache.http.HttpStatus;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


@Component
@Slf4j
@Service
public class DingTalkSVImpl implements DingTalkSV {

    /**
     * 通过 webhook 向自定义机器人发送消息通知
     * 内部指定@对象
     *
     * @param content
     */
    @Override
    public void sendText(String content) {
        List<String> atMobiles = new ArrayList<>();
        atMobiles.add("13460005569");
        this.sendText(atMobiles, true, content);
    }

    /**
     * 通过 webhook 向自定义机器人发送消息通知
     * @param atMobiles 自定义@对象人钉钉的手机号
     * @param isAtAll   是否@所有人
     * @param content
     */
    @Override
    public void sendText(List<String> atMobiles, boolean isAtAll, String content) {
        content = EnvEnums.getCurrent().desc + content;
        //实例化发送消息
        TextMsgContent textMsgContent = new TextMsgContent(content);
        //实例化@对象
        TextMsgAt textMsgAt = new TextMsgAt(atMobiles, Boolean.toString(isAtAll));
        //实例化消息对象
        TextMsg textMsg = new TextMsg(textMsgContent, textMsgAt);
        //转化json
        String textMsgJson = JSON.toJSONString(textMsg);

        log.info("textMsgJson：" + textMsgJson);

        //发送webhook 通知
        sendWebhookNotify(textMsgJson);
    }

    /**
     * 钉钉机器人 webhook 通知
     *
     * @param textJson
     */
    private void sendWebhookNotify(String textJson) {
        HttpClient httpclient = HttpClients.createDefault();
        //钉钉 机器人 Webhook地址
        String dingtalk_robot_webhook = DingTalkConfig.getWebhook();
        HttpPost httppost = new HttpPost(dingtalk_robot_webhook);
        httppost.addHeader("Content-Type", "application/json; charset=utf-8");

        StringEntity se = new StringEntity(textJson, "utf-8");
        httppost.setEntity(se);

        HttpResponse response = null;
        try {
            response = httpclient.execute(httppost);
            if (response.getStatusLine().getStatusCode() == HttpStatus.SC_OK) {
                String result = EntityUtils.toString(response.getEntity(), "utf-8");

                if (log.isDebugEnabled()) {
                    log.debug("钉钉机器人-发送通知消息结果：" + result);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}