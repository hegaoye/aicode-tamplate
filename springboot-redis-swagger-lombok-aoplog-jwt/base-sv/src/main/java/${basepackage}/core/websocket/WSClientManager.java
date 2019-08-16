package ${basePackage}.core.websocket;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import javax.websocket.Session;
import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * websocket链接管理器
 *
 * @author shangze
 */
@Component
@Slf4j
public class WSClientManager {
    //线程安全map
    private static Map<String, Session> sessionMap = new ConcurrentHashMap<>();

    //静态变量，用来记录当前在线连接数。
    private static int onlineCount = 0;

    public static void put(String token, Session session) {
        Session ss = get(token);
        if (ss == null) {
            if (log.isDebugEnabled()) {
                log.debug(">>> SessionMap.size before >>> " + sessionMap.size());
            }
            sessionMap.put(token, session);
            if (log.isDebugEnabled()) {
                log.debug(">>> SessionMap.size after >>> " + sessionMap.size());
            }
            addOnlineCount();           //在线数加1
            if (log.isDebugEnabled()) {
                log.debug("有新窗口开始监听:" + token + "；\n当前在线人数为" + getOnlineCount());
            }
        }
        if (log.isDebugEnabled()) {
            log.debug(">>> SessionMap.size >>> " + sessionMap.size());
        }
    }

    public static void remove(String token) {
        sessionMap.remove(token);
        subOnlineCount();           //在线数减1
        if (log.isDebugEnabled()) {
            log.debug(">>> 有一连接关闭！当前在线人数为 >>> " + getOnlineCount() + "；\n" + sessionMap.size());
        }
    }

    /**
     * 根据token 获得session
     * @param token
     * @return
     */
    public static Session get(String token) {
        if (sessionMap.containsKey(token)) {
            return sessionMap.get(token);
        }
        return null;
    }

    /**
     * 实现服务器主动推送
     */
    public static void sendMessage(String token, String message) {

        if (log.isDebugEnabled()) {
            log.debug(">>> sendMessage token >>> " + token);
            log.debug(">>> sendMessage >>> " + message);
            log.debug(">>> sessionMap size >>> " + sessionMap.size());
        }
        Session session = get(token);
        if (session != null) {
            if (session.isOpen()) {
                try {
                    session.getBasicRemote().sendText(message);
                } catch (IOException e) {
                    e.printStackTrace();
                }
            } else {
                try {
                    session.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        else {
            if (log.isDebugEnabled()) {
                log.debug(">>> websocket token session is null >>> ");
            }
        }
    }

    public static synchronized int getOnlineCount() {
        return WSClientManager.onlineCount;
    }

    public static synchronized void addOnlineCount() {
        WSClientManager.onlineCount++;
    }

    public static synchronized void subOnlineCount() {
        WSClientManager.onlineCount--;
    }
}
