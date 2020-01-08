/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

import ${basePackage}.core.enums.EnableStateEnum;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;

import java.util.Date;
import java.util.List;

import static ${basePackage}.rbac.common.ConstantsRbac.ID_PRE_PRESET;
import static ${basePackage}.rbac.common.ConstantsRbac.SORT;

/**
 * 权限系统-菜单权限 的实体类
 *
 * @author borong
 */
@Data
public class RbacPermissionMenu implements java.io.Serializable {

    /**
     * 数据库字段:menuId  属性显示:菜单ID
     */
    private java.lang.Long id;

    /**
     * 数据库字段:id_pre  属性显示:上级菜单id；为空时设为0
     */
    private java.lang.Long idPre;

    /**
     * 数据库字段:menu_name  属性显示:菜单名称
     */
    private java.lang.String menuName;

    /**
     * 数据库字段:menu_href  属性显示:菜单路径
     */
    private java.lang.String menuHref;

    /**
     * 数据库字段:menu_icon  属性显示:菜单图标
     */
    private java.lang.String menuIcon;

    /**
     * 数据库字段:state  属性显示:状态（enable 启用，disable 禁用） [枚举编号：1007] (/resources/enum/1007)
     */
    private java.lang.String state;

    /**
     * 数据库字段:is_leaf  属性显示:是否是叶子节点（Y是，N否） [枚举编号：1001] (/resources/enum/1001)
     */
    private java.lang.String isLeaf;

    /**
     * 数据库字段:description  属性显示:描述
     */
    private java.lang.String description;

    /**
     * 数据库字段:sort  属性显示:排序；默认 99
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
     * 1对多关联查询RbacPermission 权限系统-权限资源  属性显示:rbacPermission
     */
    private List<RbacPermission> rbacPermissionList;

    public RbacPermissionMenu() {
    }

    /**
     * 构造器，用于新增菜单
     *
     * @param menuName    菜单名
     * @param menuHref    菜单链接
     * @param idPre       上级菜单id
     * @param menuIcon    菜单图标
     * @param state       菜单状态 [枚举编号：1007](/resources/enum/1007)
     * @param description 描述
     * @param sort        排序；默认 1
     * @param now         当前时间
     */
    public RbacPermissionMenu(String menuName, String menuHref, Long idPre, String menuIcon, EnableStateEnum state,
                              String description, Integer sort, Date now) {
        this.idPre = null == idPre ? ID_PRE_PRESET : idPre;
        this.menuName = menuName;
        this.menuHref = menuHref;
        this.menuIcon = StringUtils.isBlank(menuIcon) ? "" : menuIcon;
        this.state = state.name();
        this.description = StringUtils.isBlank(description) ? "" : description;
        this.sort = null == sort ? SORT : sort;
        this.createTime = now;
        this.updateTime = now;
    }
}