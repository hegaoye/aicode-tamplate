package $package$.config.filter;

import $package$.cache.entity.RedisKey;
import $package$.cache.service.RedisServiceSVImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpHeaders;
import org.springframework.http.server.reactive.ServerHttpRequest;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Set;

/**
 * ip 白名单过滤
 */
@Slf4j
@Order(1)
@Component
public class IpFilter implements GlobalFilter {

    @Autowired
    private RedisServiceSVImpl redisServiceSV;

    /**
     * ip 表名单处理
     * 1.获取ip
     * 2.检查 缓存白名单
     */
    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        //1.获取ip
        String ip = this.getIpAddress(exchange.getRequest());

        //2.检查 缓存白名单
        String ipCacheKey = RedisKey.White_Ip.whiteIpCacheKey();
        Set<Object> whiteIpSet = redisServiceSV.getForSet(ipCacheKey);
        if (!whiteIpSet.contains(ip)) {
            //不合法返回
            log.warn("警告：ip 不是在白名单中-{}", ip);
            return exchange.getResponse().setComplete();
        }

        //向后转发
        return chain.filter(exchange);
    }

    /**
     * ip 地址
     *
     * @param request
     * @return
     */
    public String getIpAddress(ServerHttpRequest request) {
        HttpHeaders headers = request.getHeaders();
        String ip = headers.getFirst("x-forwarded-for");
        if (ip != null && ip.length() != 0 && !"unknown".equalsIgnoreCase(ip)) {
            // 多次反向代理后会有多个ip值，第一个ip才是真实ip
            if (ip.indexOf(",") != -1) {
                ip = ip.split(",")[0];
            }
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = headers.getFirst("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = headers.getFirst("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = headers.getFirst("HTTP_CLIENT_IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = headers.getFirst("HTTP_X_FORWARDED_FOR");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = headers.getFirst("X-Real-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddress().getAddress().getHostAddress();
        }
        return ip;
    }

}