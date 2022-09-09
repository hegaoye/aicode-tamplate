/*
 * $copyright$
 */
package $package$.gatewayroute.service;

import com.baidu.fsg.uid.UidGenerator;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import $package$.gatewayroute.dao.GateWayRouteDAO;
import $package$.gatewayroute.dao.mapper.GateWayRouteMapper;
import $package$.gatewayroute.entity.GateWayRoute;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
 * 路由
 *
 * @author $author$
 */
@Slf4j
@Service
public class GateWayRouteServiceImpl extends ServiceImpl<GateWayRouteMapper, GateWayRoute> implements GateWayRouteService {

    @Autowired
    private ApplicationEventPublisher publisher;

    @Autowired
    private GateWayRouteDAO gateWayRouteDAO;

    @Autowired
    private UidGenerator uidGenerator;


    @Transactional
    @Override
    public boolean save(GateWayRoute entity) {
        entity.setId(String.valueOf(uidGenerator.getUID()));
        boolean flag = super.save(entity);
        return flag;
    }

}


