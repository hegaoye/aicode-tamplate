/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import ${basePackage}.core.base.BaseSV;
import ${basePackage}.rbac.entity.RbacPermissionMenu;

import java.util.List;

/**
 * 权限系统-菜单权限
 *
 * @author borong
 */
public interface RbacPermissionMenuSV extends BaseSV<RbacPermissionMenu, Long> {

    /**
     * 添加菜单
     * 检查同级菜单名是否重名
     *
     * @param menuName    必填，菜单名
     * @param menuHref    必填，菜单链接
     * @param idPre       选填，上级菜单id
     * @param menuIcon    选填，菜单图标
     * @param description 选填，描述
     * @param sort        选填，排序；
     * @return RbacPermissionMenu
     */
    RbacPermissionMenu insertMenu(String menuName, String menuHref,
                                  Long idPre, String menuIcon, String description, Integer sort);

    /**
     * 修改菜单信息
     *
     * @param menuId          必填，菜单id
     * @param menuName        选填，菜单名
     * @param menuHref        选填，菜单链接
     * @param menuIcon        选填，菜单图标
     * @param description     选填，描述
     * @param sort            选填，排序；
     * @param newParentMenuId 选填，新的上级菜单ID；如果无上级，请填写0；
     * @return
     */
    RbacPermissionMenu updateMenu(Long menuId, String menuName, String menuHref, String menuIcon,
                                  String description, Integer sort, Long newParentMenuId);

    /**
     * 变更菜单的父级与节点状态
     *
     * @param menuId          菜单
     * @param newParentMenuId 新父级菜单的id
     */
    void updateMenuParent(Long menuId, Long newParentMenuId);

    /**
     * 变更菜单的父级与节点状态
     *
     * @param permissionMenu  菜单
     * @param newParentMenuId 新父级菜单的id
     */
    void updateMenuParent(RbacPermissionMenu permissionMenu, Long newParentMenuId);

    /**
     * 根据id删除菜单
     *
     * @param menuId 菜单ID
     * @return RbacPermissionMenu
     */
    void delete(Long menuId);

    /**
     * 加载一个对象RbacPermissionMenu
     *
     * @param id 菜单ID
     * @return RbacPermissionMenu
     */
    RbacPermissionMenu load(java.lang.Long id);

    /**
     * 加载一个对象RbacPermissionMenu详情，(将查询关联数据)
     *
     * @param id 菜单ID
     * @return RbacPermissionMenu
     */
    RbacPermissionMenu get(java.lang.Long id);

    /**
     * 加载一个对象RbacPermissionMenu 通过id
     *
     * @param id 菜单ID
     * @return RbacPermissionMenu
     */
    RbacPermissionMenu loadById(java.lang.Long id);

    /**
     * 查询RbacPermissionMenu分页
     *
     * @param rbacPermissionMenu 权限系统-菜单权限
     * @param offset             查询开始行
     * @param limit              查询行数
     * @return List<RbacPermissionMenu>
     */
    List<RbacPermissionMenu> list(RbacPermissionMenu rbacPermissionMenu, int offset, int limit);

    int count(RbacPermissionMenu rbacPermissionMenu);
}
