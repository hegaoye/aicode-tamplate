/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

import lombok.Data;
import java.util.List;

    import ${basePackage}.rbac.entity.RbacPermission;

/**
 * 权限系统-权限授权API；每一个权限对应多个授权API请求路径 的实体类
 *
 * @author borong
 */
@Data
public class RbacPermissionApi implements java.io.Serializable {

    /**
     * 数据库字段:menuId  属性显示:权限授权记录id
     */
    private java.lang.Long id;

    /**
     * 数据库字段:permission_id  属性显示:权限id
     */
    private java.lang.Integer permissionId;

    /**
     * 数据库字段:action_url  属性显示:功能授权API请求路径
     */
    private java.lang.String actionUrl;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private java.util.Date createTime;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private java.util.Date createTimeBegin;
    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private java.util.Date createTimeEnd;
    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private java.util.Date updateTime;

    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private java.util.Date updateTimeBegin;
    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private java.util.Date updateTimeEnd;

    /**
     * 1对1关联查询RbacPermission 权限系统-权限资源  属性显示:rbacPermission
     */
    private RbacPermission rbacPermission;

}