/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.dingtalk.config;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

/**
 * @Author borong
 * @Date 2019/6/5 20:25
 * @Description: 钉钉配置信息
 */
@Slf4j
@Component
@ConfigurationProperties(prefix = "dingtalk")
public class DingTalkConfig {

    @Getter
    private static String atMobiles;

    @Getter
    private static String webhook;

    @Value("${r'${dingtalk.robot.atMobilesDefault}'}")
    public void setAtMobiles(String atMobiles) {
        DingTalkConfig.atMobiles = atMobiles;
    }

    @Value("${r'${dingtalk.robot.webhook}'}")
    public void setWebhook(String webhook) {
        DingTalkConfig.webhook = webhook;
    }
}