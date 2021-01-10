/*
 * subo
 */
package $package$.gatewayroute.vo;

import io.swagger.annotations.ApiModelProperty;
import com.subo.core.base.BaseVO;
import lombok.Data;

/**
 * 路由 分页 对象 VO
 *
 * @author bruce
 */
@Data
public class GateWayRoutePageVO extends BaseVO implements java.io.Serializable {
    /**
     * 数据库字段:id  属性显示:id
     */
    @ApiModelProperty(value = "id")
    private java.lang.String id;
    /**
     * 数据库字段:route_id  属性显示:路由id
     */
    @ApiModelProperty(value = "路由名")
    private java.lang.String routeId;
    /**
     * 数据库字段:uri  属性显示:uri
     */
    @ApiModelProperty(value = "uri")
    private java.lang.String uri;
    /**
     * 数据库字段:predicates  属性显示:判定器
     */
    @ApiModelProperty(value = "判定器")
    private java.lang.String predicates;
    /**
     * 数据库字段:filters  属性显示:过滤器
     */
    @ApiModelProperty(value = "过滤器")
    private java.lang.String filters;
     /**
     * 数据库字段:orders  属性显示:排序
     */
    @ApiModelProperty(value = "排序")
    private Integer orders;
    /**
     * 数据库字段:description  属性显示:描述
     */
    @ApiModelProperty(value = "描述")
    private java.lang.String description;
    /**
     * 数据库字段:status  属性显示:状态：Y 有效，N 无效
     */
    @ApiModelProperty(value = "状态：Y 有效，N 无效")
    private java.lang.String status;
    /**
     * 数据库字段:create_time  属性显示:创建时间
     */
    @ApiModelProperty(value = "创建时间")
    private java.util.Date createTime;
    /**
     * 数据库字段:update_time  属性显示:更新时间
     */
    @ApiModelProperty(value = "更新时间")
    private java.util.Date updateTime;


}
