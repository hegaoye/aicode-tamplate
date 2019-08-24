/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

import lombok.Data;
import java.util.List;

    import ${basePackage}.rbac.entity.RbacPermission;
    import java.util.List;

/**
 * 权限系统-功能操作权限 的实体类
 *
 * @author borong
 */
@Data
public class RbacPermissionAction implements java.io.Serializable {

    /**
     * 数据库字段:menuId  属性显示:主键ID
     */
    private java.lang.Long id;

    /**
     * 数据库字段:action_code  属性显示:功能权限的唯一识别码（同菜单编码下的功能识别码唯一）
     */
    private java.lang.String actionCode;

    /**
     * 数据库字段:action_name  属性显示:功能名称
     */
    private java.lang.String actionName;

    /**
     * 数据库字段:action_icon  属性显示:功能图标
     */
    private java.lang.String actionIcon;

    /**
     * 数据库字段:description  属性显示:描述
     */
    private java.lang.String description;

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
     * 1对多关联查询RbacPermission 权限系统-权限资源  属性显示:rbacPermission
     */
    private List<RbacPermission> rbacPermissionList;
}