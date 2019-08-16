/*
 * ${copyright}
 */
package ${basePackage}.core.tools;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.common.Config;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * cookie 工具类
 *
 * @author borong
 */
@Slf4j
@Component
public class CookieUtil {

    //cookie工具类的单例模式
    private static CookieUtil instance;

    public static CookieUtil getInstance() {
        if (instance == null) {
            instance = new CookieUtil();
        }
        return instance;
    }

    /**
     * 获取 HttpServletRequest 对象
     *
     * @return HttpServletRequest
     */
    public HttpServletRequest getRequest() {
        return ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    }

    /**
     * 获取指定cookie值
     *
     * @param key cookie键
     * @return String
     * @author borong
     * @CreateDate 2019.5.13 21:32
     */
    public String getCookie(String key) {
        return getCookie(key, getRequest());
    }

    /**
     * 获取指定cookie值
     *
     * @param key     cookie键
     * @param request
     * @return String
     * @author borong
     * @CreateDate 2019.5.13 21:32
     */
    private String getCookie(String key, HttpServletRequest request) {
        String code = null;
        try {

            Cookie[] cookies = getCookies(request);
            if (cookies == null || cookies.length == 0) {
                return null;
            }
            if (log.isDebugEnabled()) {
                log.debug("从客户端获取的所有cookie: " + JSON.toJSONString(cookies));
            }
            for (int i = 0; i < cookies.length; i++) {
                Cookie cookie = cookies[i];
                if (cookie.getName().equals(key)) {
                    code = cookie.getValue();
                    break;
                }
            }
            if (log.isDebugEnabled()) {
                log.debug("最终获取的cookie ['" + key + "':'" + code + "']");
            }

        } catch (Exception e) {
            if (log.isErrorEnabled()) {
                log.error("Get cookie error:" + e.getMessage());
            }
            e.printStackTrace();
        }

        return code;
    }

    /**
     * 获取客户端所有cookie
     *
     * @param request
     * @return Cookie[]
     * @author borong
     * @CreateDate 2019.5.13 21:32
     */
    public Cookie[] getCookies(HttpServletRequest request) {
        return request.getCookies();
    }

    /**
     * 设置 cookie
     * path default "/"
     * domain default not set
     *
     *
     * @param key   cookie名称
     * @param value cookie值
     * @param times 有效时间单位为 秒
     * @return : void
     * @author borong
     * @CreateDate 2019.5.13 21:32
     */
    public void setCookie(String key, String value, int times, HttpServletResponse response) {
        try {
            Cookie cookie = new Cookie(key, value);
            cookie.setMaxAge(times);
            if (StringUtils.isNotBlank(Config.getDomain())) {
                cookie.setDomain(Config.getDomain());
            }
            cookie.setPath("/");
            //设置cookie不能被js获取到
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
        } catch (Exception e) {
            if (log.isErrorEnabled()) {
                log.error("Set cookie error:" + e.getMessage());
            }
            e.printStackTrace();
        }
    }

    /**
     * 删除cookie
     *
     * @param key      要删除的cookie键
     * @param domain   一级域名
     * @param path     设置cookie路径 不设置默认为当前路径(对于servlet来说为request.getContextPath() +
     *                 web.xml 里配置的该Servlet的url-pattern路径部分)
     * @param response HttpServletResponse对象
     * @return : void
     * @author borong
     * @CreateDate 2019.5.13 21:32
     */
    public void delCookie(String key, String domain, String path, HttpServletResponse response) {
        try {
            Cookie cookie = new Cookie(key, null);
            cookie.setMaxAge(0);
            if (StringUtils.isNotBlank(Config.getDomain())) {
                cookie.setDomain(Config.getDomain());
            }
            cookie.setPath(path);
            //设置cookie不能被js获取到
            cookie.setHttpOnly(true);
            response.addCookie(cookie);
        } catch (Exception e) {
            if (log.isErrorEnabled()) {
                log.error("Delete cookie error:" + e.getMessage());
            }
            e.printStackTrace();
        }
    }

    /**
     * 删除cookie
     *
     * @param key      要删除的cookie键
     * @param response HttpServletResponse对象
     * @return : void
     * @author borong
     * @CreateDate 2019.5.13 21:32
     */
    public void delCookie(String key, HttpServletResponse response) {
        delCookie(key, null, "/", response);
    }
}