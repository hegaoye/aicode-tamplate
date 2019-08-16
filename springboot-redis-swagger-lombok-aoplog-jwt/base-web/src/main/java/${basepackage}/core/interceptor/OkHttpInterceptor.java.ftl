/*
 * ${copyright}
 */
package ${basePackage}.core.interceptor;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;
import okhttp3.Interceptor;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;

import java.io.IOException;

/**
 * @author borong
 */
@Slf4j
public class OkHttpInterceptor implements Interceptor {

    @Override
    public Response intercept(Chain chain) throws IOException {
        Request request = chain.request();
        long t1 = System.nanoTime();
        Response response = chain.proceed(chain.request());
        long t2 = System.nanoTime();
        ResponseBody responseBody = response.peekBody(1024 * 1024);
        log.info(String.format("发送请求 %s on %s%n%s",
                request.url(), request.method(), chain.connection(), request.headers()));
        log.info(String.format("接收响应: [%s] %n返回 JSON : %n%s %n耗时 ： %.1fms%n%s",
                response.request().url(),
                JSON.toJSONString(responseBody.string()),
                (t2 - t1) / 1e6d,
                response.headers()));
        okhttp3.MediaType mediaType = response.body().contentType();
        String content = response.body().string();
        return response.newBuilder()
                .body(ResponseBody.create(mediaType, content))
                .build();
    }
}