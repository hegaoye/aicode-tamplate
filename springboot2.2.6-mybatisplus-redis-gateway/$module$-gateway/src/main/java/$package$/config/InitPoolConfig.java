package $package$.config;

import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import $package$.cache.entity.RedisKey;
import $package$.cache.service.RedisServiceSVImpl;
import $package$.gatewayroute.entity.GateWayRoute;
import $package$.gatewayroute.service.GateWayRouteService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.util.List;

@Slf4j
@Component
public class InitPoolConfig implements CommandLineRunner {
    @Autowired
    private RedisServiceSVImpl redisServiceSV;

    @Autowired
    private GateWayRouteService gateWayRouteService;


    @Override
    public void run(String... args) {
        //初始化ip白名单缓存信息
        try {
            List<GateWayRoute> gateWayRoutes = gateWayRouteService.list();
            if (CollectionUtils.isNotEmpty(gateWayRoutes)) {
                for (GateWayRoute gateWayRoute : gateWayRoutes) {
                    redisServiceSV.putForHash(RedisKey.Rbac.name() + RedisKey.Gateway.name(), gateWayRoute.getId(), gateWayRoute);
                }
            }


        } catch (Exception e) {
            log.error("{}", e.getMessage());
        }


    }
}
