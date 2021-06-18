/*
* $copyright$
 */
package $package$.gatewayroute.entity;

import $package$.core.annotation.CacheEnum;

/**
 * 状态: 启用 Enable, 停用 Disable 的实体类的状态
 *
 * @author $author$
 */
@CacheEnum("rbac_002")
public enum GateWayRouteStatus implements java.io.Serializable {
    Enable("启用"),
    Disable("停用"),
    ;

    public String val;

    GateWayRouteStatus(String val) {
        this.val = val;
    }

    /**
     * 根据状态名称查询状态
     *
     * @param stateName
     * @return
     */
    public static GateWayRouteStatus getEnum(String stateName) {
        for (GateWayRouteStatus enumName : GateWayRouteStatus.values()) {
            if (enumName.name().equalsIgnoreCase(stateName)) {
                return enumName;
            }
        }
        return null;
    }

    @Override
    public String toString() {
        return this.name();
    }

}
