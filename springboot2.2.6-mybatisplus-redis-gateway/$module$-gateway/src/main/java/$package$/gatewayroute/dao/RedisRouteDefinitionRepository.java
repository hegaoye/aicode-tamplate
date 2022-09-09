package $package$.gatewayroute.dao;

import com.alibaba.fastjson.JSON;
import $package$.cache.entity.RedisKey;
import $package$.cache.service.RedisServiceSVImpl;
import $package$.gatewayroute.entity.GateWayRoute;
import $package$.gatewayroute.service.GateWayRouteService;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cloud.gateway.filter.FilterDefinition;
import org.springframework.cloud.gateway.handler.predicate.PredicateDefinition;
import org.springframework.cloud.gateway.route.RouteDefinition;
import org.springframework.cloud.gateway.route.RouteDefinitionRepository;
import org.springframework.stereotype.Repository;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.net.URI;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * 初始化 缓存规则
 */
@Repository
@Slf4j
public class RedisRouteDefinitionRepository implements RouteDefinitionRepository {

    @Autowired
    private GateWayRouteService gateWayRouteService;

    @Autowired
    private RedisServiceSVImpl redisServiceSV;

    /**
     * 初始化 路由规则
     */
    @Override
    public Flux<RouteDefinition> getRouteDefinitions() {
        try {
            Map<Object, Object> gatewayDefineMap = redisServiceSV.getForHash(RedisKey.Gateway.getGatewayKey());
            log.info("路由规则-{}", gatewayDefineMap);
            Map<String, RouteDefinition> routes = new LinkedHashMap<>();
            for (Map.Entry<Object, Object> objectObjectEntry : gatewayDefineMap.entrySet()) {
                GateWayRoute gateWayRoute = (GateWayRoute) objectObjectEntry.getValue();
                RouteDefinition definition = new RouteDefinition();
                definition.setId(gateWayRoute.getId());
                definition.setUri(new URI(gateWayRoute.getUri()));

                //断言设置
                if (StringUtils.isNotBlank(gateWayRoute.getPredicates())) {
                    List<PredicateDefinition> predicateDefinitions = JSON.parseArray(gateWayRoute.getPredicates(), PredicateDefinition.class);
                    definition.setPredicates(predicateDefinitions);
                }

                //设置过滤器
                if (StringUtils.isNotBlank(gateWayRoute.getFilters())) {
                    List<FilterDefinition> filterDefinitions = JSON.parseArray(gateWayRoute.getFilters(), FilterDefinition.class);
                    definition.setFilters(filterDefinitions);
                }
                routes.put(definition.getId(), definition);
            }
            return Flux.fromIterable(routes.values());
        } catch (Exception e) {
            e.printStackTrace();
            return Flux.empty();
        }
    }

    @Override
    public Mono<Void> save(Mono<RouteDefinition> route) {
        return route.flatMap(routeDefinition -> {
//            gateWayRouteService.save(routeDefinition);
            return Mono.empty();
        });
    }

    @Override
    public Mono<Void> delete(Mono<String> routeId) {
        return routeId.flatMap(id -> {
            gateWayRouteService.removeById(id);
            return Mono.empty();
        });
    }
}
