/*
* $copyright$
 */
package $package$.gatewayroute.ctrl;

import com.alibaba.fastjson.JSON;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import $package$.core.exceptions.BaseException;
import $package$.exceptions.GateWayRouteException;
import $package$.gatewayroute.entity.GateWayRoute;
import $package$.gatewayroute.service.GateWayRouteService;
import $package$.gatewayroute.vo.GateWayRoutePageVO;
import $package$.gatewayroute.vo.GateWayRouteSaveVO;
import $package$.gatewayroute.vo.GateWayRouteVO;
import io.swagger.annotations.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import java.util.Date;
import java.util.List;

/**
 * 路由
 *
 * @author $author$
 */
@RestController
@RequestMapping("/gatewayRoute")
@Slf4j
@Api(value = "路由控制器", tags = "路由控制器")
public class GateWayRouteController {
    @Autowired
    private GateWayRouteService gateWayRouteService;


    /**
     * 创建 路由
     *
     * @return R
     */
    @ApiOperation(value = "创建GateWayRoute", notes = "创建GateWayRoute")
    @PostMapping("/build")
    public GateWayRouteSaveVO build(@ApiParam(name = "创建GateWayRoute", value = "传入json格式", required = true)
                                    @RequestBody GateWayRouteSaveVO gateWayRouteSaveVO) {


        GateWayRoute gateWayRoute = new GateWayRoute();
        BeanUtils.copyProperties(gateWayRouteSaveVO, gateWayRoute);

        gateWayRouteService.save(gateWayRoute);

        gateWayRouteSaveVO = new GateWayRouteSaveVO();
        BeanUtils.copyProperties(gateWayRoute, gateWayRouteSaveVO);
        log.debug(JSON.toJSONString(gateWayRouteSaveVO));
        return gateWayRouteSaveVO;
    }


    /**
     * 查询路由信息集合
     *
     * @return 分页对象
     */
    @ApiOperation(value = "查询GateWayRoute信息集合", notes = "查询GateWayRoute信息集合")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "curPage", value = "当前页", required = true, paramType = "query"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", required = true, paramType = "query")
    })
    @GetMapping(value = "/list")
    public IPage<GateWayRouteVO> list(@ApiIgnore GateWayRoutePageVO gateWayRoutePageVO, Integer curPage, Integer pageSize) {
        IPage<GateWayRoute> page = new Page<>(curPage, pageSize);
        QueryWrapper<GateWayRoute> queryWrapper = new QueryWrapper<>();
        int total = gateWayRouteService.count(queryWrapper);
        if (total > 0) {
            queryWrapper.lambda().orderByDesc(GateWayRoute::getId);

            IPage<GateWayRoute> gateWayRouteIPage = gateWayRouteService.page(page, queryWrapper);
            List<GateWayRouteVO> gateWayRouteVOList = JSON.parseArray(JSON.toJSONString(gateWayRouteIPage.getRecords()), GateWayRouteVO.class);
            IPage<GateWayRouteVO> iPage = new Page<>();
            iPage.setPages(gateWayRouteIPage.getPages());
            iPage.setCurrent(curPage);
            iPage.setSize(pageSize);
            iPage.setTotal(gateWayRouteIPage.getTotal());
            iPage.setRecords(gateWayRouteVOList);
            log.debug("查询$notes$信息集合-{}",iPage);
            return iPage;
        }
        return new Page<>();
    }


    /**
     * 修改 路由
     *
     * @return R
     */
    @ApiOperation(value = "修改GateWayRoute", notes = "修改GateWayRoute")
    @PutMapping("/modify")
    public boolean modify(@ApiParam(name = "修改GateWayRoute", value = "传入json格式", required = true)
                          @RequestBody GateWayRouteVO appVO, String ip) {
        if (StringUtils.isBlank(appVO.getId())) {
            throw new GateWayRouteException(BaseException.BaseExceptionEnum.Illegal_Param);
        }

        GateWayRoute newGateWayRoute = new GateWayRoute();
        BeanUtils.copyProperties(appVO, newGateWayRoute);
        newGateWayRoute.setUpdateTime(new Date());
        boolean isUpdated = gateWayRouteService.update(newGateWayRoute, new LambdaQueryWrapper<GateWayRoute>()
                .eq(GateWayRoute::getId, appVO.getId()));
        return isUpdated;
    }


    /**
     * 删除 路由
     *
     * @return R
     */
    @ApiOperation(value = "删除GateWayRoute", notes = "删除GateWayRoute")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "id", value = "id", paramType = "query")
    })
    @DeleteMapping("/delete")
    public boolean delete(@ApiIgnore GateWayRouteVO appVO) {
        if (StringUtils.isBlank(appVO.getId())) {
            throw new GateWayRouteException(BaseException.BaseExceptionEnum.Illegal_Param);
        }
        GateWayRoute newGateWayRoute = new GateWayRoute();
        BeanUtils.copyProperties(appVO, newGateWayRoute);
        gateWayRouteService.remove(new LambdaQueryWrapper<GateWayRoute>()
                .eq(GateWayRoute::getId, appVO.getId()));
        return true;
    }

}
