/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

import ${basePackage}.rbac.common.ConstantsRbac;
import ${basePackage}.core.enums.CheckboxEnum;
import ${basePackage}.core.enums.EnableStateEnum;
import ${basePackage}.core.enums.PermissionTypeEnum;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static ${basePackage}.rbac.common.ConstantsRbac.MENU_UNIQUE_CODE_HEADER;

/**
 * 权限系统-权限资源 的实体类
 *
 * @author borong
 */
@Data
public class RbacPermission implements java.io.Serializable {

    /**
     * 数据库字段:menuId  属性显示:权限id
     */
    private java.lang.Long id;

    /**
     * 数据库字段:menu_id  属性显示:菜单id
     */
    private java.lang.Long menuId;

    /**
     * 数据库字段:action_code  属性显示:功能权限的唯一识别码（同菜单编码下的功能识别码唯一）
     */
    private java.lang.String actionCode;

    /**
     * 数据库字段:name  属性显示:权限名称
     */
    private java.lang.String name;

    /**
     * 数据库字段:type  属性显示:权限类型（menu 菜单， action 功能操作）
     */
    private java.lang.String type;

    /**
     * 数据库字段:state  属性显示:状态（enable 启用，disable 禁用） [枚举编号：1007](/resources/enum/1007)
     */
    private java.lang.String state;

    /**
     * 数据库字段:description  属性显示:描述
     */
    private java.lang.String description;

    /**
     * 数据库字段:sort  属性显示:排序；相对于同一菜单下的功能权限排序
     */
    private java.lang.Integer sort;

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
     * 1对1关联查询RbacPermissionMenu 权限系统-菜单权限  属性显示:rbacPermissionMenu
     */
    private RbacPermissionMenu rbacPermissionMenu;
    /**
     * 1对1关联查询RbacPermissionAction 权限系统-功能操作权限  属性显示:rbacPermissionAction
     */
    private RbacPermissionAction rbacPermissionAction;

    /**
     * 1对多关联查询RbacPermissionApi 权限系统-权限授权API；每一个权限对应多个授权API请求路径  属性显示:rbacPermissionApi
     */
    private List<RbacPermissionApi> rbacPermissionApiList;
    /**
     * 1对多关联查询RbacRolePermissionRelation 权限系统-角色对应权限关系  属性显示:rbacRolePermissionRelation
     */
    private List<RbacRolePermissionRelation> rbacRolePermissionRelationList;

    /**
     * 扩展属性：选择状态；默认全不选
     */
    private CheckboxEnum checkbox = CheckboxEnum.none;

    public RbacPermission() {
    }

    /**
     * 构造器：用于新增菜单权限
     *
     * @param menuId      菜单权限id
     * @param name        菜单名
     * @param typeEnum    权限类型
     * @param stateEnum   功能状态
     * @param description 菜单描述
     * @param sort        排序
     * @param createTime  创建时间
     */
    public RbacPermission(Long menuId, String name, PermissionTypeEnum typeEnum, EnableStateEnum stateEnum, String description, Integer sort, Date createTime) {
        this.actionCode = String.format("%s%s", MENU_UNIQUE_CODE_HEADER, menuId);
        this.menuId = menuId;
        this.name = name;
        this.type = typeEnum.name();
        this.state = stateEnum.name();
        this.description = StringUtils.isBlank(description) ? "" : description;
        this.sort = null == sort ? ConstantsRbac.SORT : sort;
        this.createTime = createTime;
        this.updateTime = createTime;
    }

    /**
     * 权限集合筛选出权限id
     *
     * @param permissionList
     * @return
     */
    public static List<Long> listFilterIds(List<RbacPermission> permissionList) {
        if (null == permissionList || permissionList.size() == 0) {
            return null;
        }
        List<Long> ids = new ArrayList<>();
        permissionList.forEach(rbacPermission -> {
            ids.add(rbacPermission.getId());
        });
        return ids;
    }

    /**
     * 权限资源集合转权限菜单集合
     * @param permissionList
     * @return
     */
    public static List<RbacPermissionMenu> permissionList2MenuList(List<RbacPermission> permissionList) {
        if (null == permissionList || permissionList.size() == 0) {
            return null;
        }

        List<RbacPermissionMenu> menuList = new ArrayList<>();
        permissionList.forEach(permission -> {
            menuList.add(permission.getRbacPermissionMenu());
        });

        return menuList;
    }
}