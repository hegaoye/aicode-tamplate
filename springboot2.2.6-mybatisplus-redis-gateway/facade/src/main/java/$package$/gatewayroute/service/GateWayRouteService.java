/*
* $copyright$
 */
package $package$.gatewayroute.service;

import $package$.gatewayroute.entity.GateWayRoute;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * 路由
 *
 * @author $author$
 */
public interface GateWayRouteService extends IService<GateWayRoute> {

    /**
     * 分页查询
     *
     * @param queryWrapper 查询条件
     * @param offset       起始行
     * @param limit        步长
     * @return List<App>
     */
    List<GateWayRoute> list(QueryWrapper<GateWayRoute> queryWrapper, int offset, int limit);
}


