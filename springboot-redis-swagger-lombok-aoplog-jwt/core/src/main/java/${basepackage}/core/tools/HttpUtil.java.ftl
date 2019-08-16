/*
 * ${copyright}
 */
package ${basePackage}.core.tools;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.exceptions.BaseException;
import lombok.extern.slf4j.Slf4j;
import okhttp3.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.net.SocketTimeoutException;
import java.util.Map;
import java.util.concurrent.TimeUnit;


/**
 * HTTP工具类，获取用户真实IP等信息
 *
 * @author CCW
 *         2017-03-31
 */

@Slf4j
public class HttpUtil {

    private static final MediaType FORM_MEDIA_TYPE = MediaType.parse("application/x-www-form-urlencoded;charset=utf-8");

    /**
     * 请求超时时间（s）
     */
    private static final int REQUEST_TIME_OUT_SECONDS = 10;

    /**
     * 获取用户真实IP
     * <p>
     * 2017-03-31
     *
     * @param request
     * @return IP
     */
    public String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

    /**
     * 获得请求结果
     *
     * @param url
     * @param params
     * @return String
     */
    public static String httpPostResult(String url, Map<String, String> params) {
        Response response = httpPost(url, params, null, 1);

        if (response == null) {
            throw new BaseException(BaseException.ExceptionEnums.http_post_exception, url);
        }

        try {
            // 返回请求结果
            return response.body().string();
        } catch (IOException e) {
            e.printStackTrace();
            throw new BaseException(BaseException.ExceptionEnums.http_post_exception, url);
        }
    }

    /**
     * 发送http请求
     *
     * @param params 参数
     * @return
     * @see {@link @param     url} 请求地址
     */
    public static Response httpPost(String url, Map<String, String> params) {
        return httpPost(url, params, null, 1);
    }

    /**
     * 发送http请求 Post
     *
     * @param params    参数
     * @param mediaType 允许为空
     * @param againTime 重复请求次数，允许5次
     * @return
     * @see {@link @param     url} 请求地址
     */
    public static Response httpPost(String url, Map<String, String> params, MediaType mediaType, int againTime) {
        if (mediaType == null) {
            mediaType = FORM_MEDIA_TYPE;
        }
        RequestBody requestBody = RequestBody.create(mediaType, genParams(params));

        OkHttpClient client = new OkHttpClient.Builder().readTimeout(REQUEST_TIME_OUT_SECONDS, TimeUnit.SECONDS).build();
        Request request = new Request.Builder()
                .url(url)
                .post(requestBody)
                .build();
        Call call = client.newCall(request);
        Response response = null;
        try {
            response = call.execute();
        }
        // 超时则重复请求
        catch (SocketTimeoutException e) {
            if (againTime <= 5) {
                return httpPost(url, params, mediaType, againTime + 1);
            }
            throw new BaseException(BaseException.ExceptionEnums.http_post_exception, url);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        return response;
    }

    /**
     * 获得请求结果 Get
     *
     * @param url
     * @param params
     * @param againTime 重复请求次数，允许5次
     * @return String
     */
    public static String httpGetResult(String url, Map<String, String> params, int againTime) {
        Response response = httpGet(url, params);
        if (response == null) {
            if (againTime <= 5) {
                return httpGetResult(url, params, againTime + 1);
            }
            throw new BaseException(BaseException.ExceptionEnums.http_get_exception, "第" + againTime + "次请求b:" + url);
        }
        try {
            return response.body().string();
        } catch (IOException e) {
            e.printStackTrace();
            throw new BaseException(BaseException.ExceptionEnums.http_get_exception, "第" + againTime + "次请求c:" + url);
        }
    }

    /**
     * 发送http请求 Get
     *
     * @param params 参数
     * @return
     * @see {@link @param     url} 请求地址
     */
    public static Response httpGet(String url, Map<String, String> params) {
        return httpGet(url, params, null, 1);
    }

    /**
     * 发送http请求 Get
     *
     * @param params    参数
     * @param mediaType 允许为空
     * @param againTime 重复请求次数，允许5次
     * @return
     * @see {@link @param     url} 请求地址
     */
    public static Response httpGet(String url, Map<String, String> params, MediaType mediaType, int againTime) {
        if (mediaType == null) {
            mediaType = FORM_MEDIA_TYPE;
        }
        if (params != null && params.size() > 0) {
            url += "?" + genParams(params);
        }
        OkHttpClient client = new OkHttpClient.Builder().readTimeout(REQUEST_TIME_OUT_SECONDS, TimeUnit.SECONDS).build();
        log.info("httpGet URL: " + url);
        log.info("httpGet Params: " + JSON.toJSONString(params));
        Request request = new Request.Builder()
                .url(url)
                .get()
                .build()
                ;
        Call call = client.newCall(request);
        Response response = null;
        try {
            response = call.execute();
        }
        // 超时则重复请求
        catch (SocketTimeoutException e) {
            if (againTime <= 5) {
                log.info("HTTP GET 超时"+againTime+"次，再请求：" + url);
                return httpGet(url, params, mediaType, againTime + 1);
            }
            throw new BaseException(BaseException.ExceptionEnums.http_get_exception, "第" + againTime + "次请求a:" + url);
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        return response;
    }

    /**
     * 根据参数map生成参数字符创
     *
     * @return 参数字符串
     */
    private static String genParams(Map<String, String> params) {
        StringBuilder str = new StringBuilder();
        for (String s : params.keySet()) {
            str.append("&").append(s).append("=").append(params.get(s).toString());
        }
        str = new StringBuilder(str.substring(1));
        return str.toString();
    }
}