package $package$.gatewayroute.dao;

import $package$.gatewayroute.dao.mapper.GateWayRouteMapper;
import $package$.gatewayroute.entity.GateWayRoute;
import $package$.core.base.BaseDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * App DAO
 * 数据服务层
 *
 * @author $author$
 */
@Repository
public class GateWayRouteDAO extends BaseDAO<GateWayRouteMapper, GateWayRoute> {


    /**
     * App mapper
     */
    @Autowired
    private GateWayRouteMapper gateWayRouteMapper;


}