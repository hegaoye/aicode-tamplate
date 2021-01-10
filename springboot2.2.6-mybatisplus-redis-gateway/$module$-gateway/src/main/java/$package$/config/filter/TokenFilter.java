//package $package$.config.filter;
//
//import com.auth0.jwt.JWTCreator;
//import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
//import $package$.cache.entity.RedisKey;
//import $package$.cache.service.RedisServiceSVImpl;
//import com.subo.core.enums.ConstantsEnum;
//import com.subo.core.enums.SessionEnum;
//import com.subo.core.tools.JwtToken;
//import lombok.extern.slf4j.Slf4j;
//import org.apache.commons.lang.StringUtils;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.cloud.gateway.filter.GatewayFilterChain;
//import org.springframework.cloud.gateway.filter.GlobalFilter;
//import org.springframework.core.annotation.Order;
//import org.springframework.core.io.buffer.DataBuffer;
//import org.springframework.http.HttpHeaders;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.server.reactive.ServerHttpRequest;
//import org.springframework.stereotype.Component;
//import org.springframework.web.server.ServerWebExchange;
//import reactor.core.publisher.Flux;
//import reactor.core.publisher.Mono;
//
//import java.util.Map;
//import java.util.Set;
//
///**
// * token 验证
// * 会话验证合法性
// */
//@Slf4j
//@Order(2)
//@Component
//public class TokenFilter implements GlobalFilter {
//
//    @Autowired
//    private RedisServiceSVImpl redisServiceSV;
//
//    /**
//     * token 验证
//     * 1.获取token
//     * 2.验证token合法性
//     * 3.验证是否踢出会话
//     * 4.token续约
//     */
//    @Override
//    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
//        //1.获取token
//        ServerHttpRequest request = exchange.getRequest();
//        String jwtToken = request.getHeaders().getFirst(HttpHeaders.AUTHORIZATION);
//        if (StringUtils.isBlank(jwtToken)) {
//            log.warn("会话过期，重新登录");
//            return this.unauthorized(exchange);
//        }
//
//        //2.验证token合法性
//        boolean flag = JwtToken.verifier(jwtToken, ConstantsEnum.Jwt_Secret.value);
//        if (!flag) {
//            log.warn("会话过期，重新登录");
//            return this.unauthorized(exchange);
//        }
//
//        String method = request.getMethodValue();
//        String url = request.getPath().value();
//        log.info("url:{},method:{},headers:{}", url, method, request.getHeaders());
//
//        if (StringUtils.isBlank(jwtToken)) {
//            log.error("登录会话不存在token错误");
//            return this.unauthorized(exchange);
//        }
//
//        //3.验证是否踢出会话
//        String userId = JwtToken.getTokenValue(jwtToken, ConstantsEnum.Jwt_Secret.value, SessionEnum.Session_Key.name());
//        String account = JwtToken.getTokenValue(jwtToken, ConstantsEnum.Jwt_Secret.value, SessionEnum.Account.name());
//
//        Set<Object> kickOutSet = redisServiceSV.getForSet(RedisKey.Rbac.name() + RedisKey.KickOut.name());
//        if (CollectionUtils.isNotEmpty(kickOutSet)) {
//            if (kickOutSet.contains(userId)) {
//                redisServiceSV.del(RedisKey.Session.sessionCacheKey(userId));
//                return this.unauthorized(exchange);
//            }
//        }
//
//
//        try {
//            //4.token续约
//            //动态获取 token 秘钥 todo 更换为 实体类
//            Map<String, Object> objectMap = (Map<String, Object>) redisServiceSV.getForHash(RedisKey.Rbac.name() + RedisKey.Jwt_Secret.name(), userId);
//
//            long expireMinutes = Long.parseLong(objectMap.get("expireTime").toString());
//
//
//            JWTCreator.Builder builder = JwtToken.create();
//            builder.withClaim(SessionEnum.Session_Key.name(), userId)
//                    .withClaim(SessionEnum.Account.name(), account);
//            jwtToken = JwtToken.createToken(builder, objectMap.get("secret").toString(), expireMinutes);
//
//            //缓存刷新
//            if (redisServiceSV.hasKey(account)) {
//                Object user = redisServiceSV.get(RedisKey.Session.sessionCacheKey(userId));
//                redisServiceSV.set(account, user, expireMinutes);
//            }
//        } catch (Exception e) {
//            log.error("{}", e.getMessage());
//        }
//
//
//        ServerHttpRequest.Builder builder = request.mutate();
//        builder.header(HttpHeaders.AUTHORIZATION, jwtToken);
//        return chain.filter(exchange.mutate().request(builder.build()).build());
//    }
//
//    /**
//     * 网关拒绝，返回401
//     */
//    private Mono<Void> unauthorized(ServerWebExchange serverWebExchange) {
//        serverWebExchange.getResponse().setStatusCode(HttpStatus.UNAUTHORIZED);
//        DataBuffer buffer = serverWebExchange.getResponse()
//                .bufferFactory().wrap(HttpStatus.UNAUTHORIZED.getReasonPhrase().getBytes());
//        return serverWebExchange.getResponse().writeWith(Flux.just(buffer));
//    }
//}