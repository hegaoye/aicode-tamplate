package $package$.gatewayroute.dao;

import $package$.gatewayroute.dao.mapper.GateWayRouteMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * App DAO
 * 数据服务层
 *
 * @author $author$
 */
@Repository
public class GateWayRouteDAO {


    /**
     * App mapper
     */
    @Autowired
    private GateWayRouteMapper gateWayRouteMapper;


}