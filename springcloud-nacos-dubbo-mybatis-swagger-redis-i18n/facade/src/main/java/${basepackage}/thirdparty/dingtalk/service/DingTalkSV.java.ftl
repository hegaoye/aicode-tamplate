/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.dingtalk.service;

import java.util.List;

public interface DingTalkSV {

    /**
     * 通过 webhook 向自定义机器人发送消息通知
     * 内部指定@对象
     * @param content
     */
    void sendText(String content);

    /**
     * 通过 webhook 向自定义机器人发送消息通知
     * @param atMobiles
     * @param isAtAll
     * @param content
     */
    void sendText(List<String> atMobiles, boolean isAtAll, String content);
}