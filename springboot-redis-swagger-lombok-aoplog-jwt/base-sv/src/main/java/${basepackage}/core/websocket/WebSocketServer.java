package ${basePackage}.core.websocket;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import ${basePackage}.basic.service.BasicSettingsSV;
import ${basePackage}.core.redis.RedisUtils;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.websocket.*;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

/**
 * @author borong
 */
@Slf4j
@ServerEndpoint(value = "/ws/{token}", configurator = WebsocketSpringCofigurator.class)
@Component
public class WebSocketServer {

    @Resource
    private RedisUtils redisUtils;

    @Resource
    private BasicSettingsSV settingSV;

    /**
     * 连接建立成功调用的方法
     */
    @OnOpen
    public static void onOpen(Session session, @PathParam("token") String token) {
        if (log.isDebugEnabled()) {
            log.debug(">>> token open >>> " + token);
        }

        //加入缓存中
        WSClientManager.put(token, session);
        WSClientManager.sendMessage(token, "SOCKET_CONNECT_SUCCESS");
    }


    /**
     * 连接关闭调用的方法
     */
    @OnClose
    public static void onClose(@PathParam("token") String token) {
        if (log.isDebugEnabled()) {
            log.debug(">>> token close >>> " + token);
        }
        WSClientManager.remove(token);
        WSClientManager.sendMessage(token, "SOCKET_CONNECT_EXIT");
    }

    /**
     * 收到客户端消息后调用的方法
     *
     * @param message 客户端发送过来的消息
     */
    @OnMessage
    public void onMessage(@PathParam("token") String token, String message, Session session) {
        log.info("收到来自窗口" + token + "的信息:" + message);
        if (StringUtils.isEmpty(message)) {
            log.error("websocket信息不存在");
            return;
        }
        JSONObject cmdJson = JSON.parseObject(message);
        String name = cmdJson.getString("name");

        if (StringUtils.isEmpty(name)) {
            log.error("信息格式不正确");
            return;
        }
        switch (name) {
            case "term.open":
                System.out.println("name open = " + name);
                break;
            case "term.input":

                System.out.println("name input = " + name);
                break;
            case "term.exit":
                System.out.println("name exit = " + name);
                break;
            default:
                log.error("command [" + name + "] not found.");
                break;
        }
    }

    /**
     * 连接错误调用的方法
     *
     * @param session
     * @param error
     */
    @OnError
    public void onError(@PathParam("token") String token, Session session, Throwable error) {
        if (log.isErrorEnabled()) {
            log.error(">>> 发生错误 >>> " + error.getMessage());
            log.error(">>> token >>> " + token);
        }
//        WSClientManager.remove(token);
        error.printStackTrace();
    }
}
