/*
 * ${copyright}
 */
package ${basePackage}.core.interceptor;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.entity.BeanRet;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

@Component
@Slf4j
public class ContextInterceptor implements HandlerInterceptor {

    private static final SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy/MM/dd hh:mm:ss:SSS");

    /**
     * 此方法中返回值如果为false，则拦截器不会继续往下执行
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        //进入方法的开始时间
        testMethodTimeStart();
        /*防乱码过滤*/
        try {
            response.setCharacterEncoding("UTF-8");
            response.setContentType("text/html;charset=UTF-8");
            String pathInfo = request.getPathInfo() == null ? "" : request.getPathInfo();
            String url = request.getServletPath() + pathInfo;

            if (log.isDebugEnabled()) {
                log.debug("AuthType:\t" + request.getAuthType());
                log.debug("Scheme:\t" + request.getScheme());
                //服务器的名字
                log.debug("ServerName:\t" + request.getServerName());
                //服务器的端口
                log.debug("ServerPort:\t" + request.getServerPort());
                //客户端电脑的名字，若失败，则返回客户端电脑的ip地址
                log.debug("RemoteHost:\t" + request.getRemoteHost());
                //客户端的ip地址
                log.debug("RemoteAddr:\t" + request.getRemoteAddr());
                //客户端的端口
                log.debug("RemotePort:\t" + request.getRemotePort());
                //客户端的用户
                log.debug("RemoteUser:\t" + request.getRemoteUser());
                log.debug("Protocol:\t" + request.getProtocol());
                log.debug("Header-Host:\t" + request.getHeader("Host"));
                log.debug("RequestedSessionId:\t" + request.getRequestedSessionId());
            }

            if (log.isInfoEnabled()) {
                log.info("▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼▼" + "\t[base-web]ContextInterceptor" + "\tHttpServletRequest Parameters");
                log.info("Header-User-agent:\t" + request.getHeader("user-agent"));
                log.info("Header-Referer:\t" + request.getHeader("referer"));
                log.info("Header-Origin:\t" + request.getHeader("Origin"));
                //工程名部分，如果工程映射为/，此处返回则为空
                log.info("ContextPath:\t" + request.getContextPath());
                //客户端所请求的脚本文件的文件路径；除去host和工程名部分的路径
                log.info("ServletPath:\t" + request.getServletPath());
                log.info("PathInfo:\t" + request.getPathInfo());
                //全路径
                log.info("RequestURL:\t" + request.getRequestURL().toString());
                //除去host（域名或者ip）部分的路径
                log.info("RequestURI:\t" + request.getRequestURI());
                //发出请求字符串的客户端地址
                log.info("⇩⇩⇩⇩⇩⇩ Header-Method-Parameters ⇩⇩⇩⇩⇩⇩");
                //客户端向服务器端传送数据的方法有get、post、put等类型
                log.info(request.getMethod() + "\t" + request.getQueryString());
                log.info(request.getMethod() + "\t" + JSON.toJSONString(request.getParameterMap()));
//                log.info("Request-Payload:\t" + "\t" + getBody(request));
                log.info("▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲▲");
            }

            // * 1.获得所有的请求参数<p/>
            Enumeration<String> param_names = request.getParameterNames();
            // * 2.单个获得参数然后进行value过滤处理
            while (param_names.hasMoreElements()) {
                String param_name = param_names.nextElement();/*获得参数名称*/
                String[] values = request.getParameterValues(param_name); /*根据参数名称获得value值*/
                for (int i = 0; i < values.length; i++) {
                    if (checkSQLInject(values[i], url)) {/*判断内容是否为空，不为空进行处理*/
                        errorResponse(response, param_name);    //返回异常信息
                        return false;
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

    /**
     * 检查是否存在非法字符，防止SQL注入
     *
     * @param str 被检查的字符串
     * @return ture-字符串中存在非法字符，false-不存在非法字符
     */
    private boolean checkSQLInject(String str, String url) {
        if (StringUtils.isEmpty(str)) {
            return false;// 如果传入空串则认为不存在非法字符
        }

        // 判断黑名单
        String[] inj_stra = {"script", "master", "truncate", "insert", "select", "update", "declare", "alert", "atestu", "\\", "onload", "onmouseover", "onfocus", "onerror"};

        str = str.toLowerCase(); // sql不区分大小写

        for (int i = 0; i < inj_stra.length; i++) {
            if (str.indexOf(inj_stra[i]) >= 0) {
                if (log.isInfoEnabled()) {
                    log.info("xss防攻击拦截url:" + url + "，原因：特殊字符，传入str=" + str + ",包含特殊字符：" + inj_stra[i]);
                }
                return true;
            }
        }
        return false;
    }

    /**
     * @param response
     * @param paramNm  参数名称
     * @throws IOException
     */
    private void errorResponse(HttpServletResponse response, String paramNm) throws IOException {
        String warning = "输入项中不能包含非法字符";

        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();

        out.write(JSON.toJSONString(BeanRet.create(false, warning + ",fieldName:" + paramNm)));
    }

    /*测试方法执行时间开始*/
    private long startTime = 0;

    /**
     * 进入方法的开始时间
     */
    private void testMethodTimeStart() {
        if (log.isInfoEnabled()) {
            startTime = System.currentTimeMillis();
        }
        if (log.isDebugEnabled()) {
            log.debug(">>> Into ContextInterceptor >>>");
            log.debug("开始时间：" + simpleDateFormat.format(new Date(startTime)));
        }
    }

    /**
     * 方法执行完毕的结束时间
     */
    private void testMethoTimeEnd() {
        if (log.isInfoEnabled()) {
            long endTime = System.currentTimeMillis();
            long useTime = (endTime - startTime);
            Date startDate = new Date(startTime);
            Date endDate = new Date(endTime);
            log.info("开始时间：" + simpleDateFormat.format(startDate));
            log.info("结束时间：" + simpleDateFormat.format(endDate));
            log.info("请求总时间为：" + useTime + "ms");
        }
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (log.isInfoEnabled()) {
            log.info(">>> ContextInterceptor postHandle >>> ");
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        if (log.isInfoEnabled()) {
            testMethoTimeEnd();/*测试请求执行时间*/
            log.info(">>> ContextInterceptor afterCompletion >>> ");
        }
        if (log.isDebugEnabled()) {
            log.debug(">>> Out ContextInterceptor >>>");
        }
    }

    /**
     * 接收 payload 参数数据
     *
     * @param request
     * @return
     * @throws IOException
     */
    public static String getBody(HttpServletRequest request) throws IOException {
        String body = null;
        // 被修饰者
        StringBuilder stringBuilder = new StringBuilder();
        // 修饰者
        BufferedReader bufferedReader = null;
        try {
            InputStream inputStream = request.getInputStream();
            if (inputStream != null && !(((ServletInputStream) inputStream).isFinished())) {
                bufferedReader = new BufferedReader(new InputStreamReader(inputStream));
                char[] charBuffer = new char[128];
                int bytesRead = -1;
                while ((bytesRead = bufferedReader.read(charBuffer)) > 0) {
                    stringBuilder.append(charBuffer, 0, bytesRead);
                }
            } else {
                stringBuilder.append("");
            }
        } catch (IOException ex) {
            throw ex;
        } finally {
            if (bufferedReader != null) {
                try {
                    bufferedReader.close();
                } catch (IOException ex) {
                    throw ex;
                }
            }
        }

        body = stringBuilder.toString();
        return body;
    }
}