/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import ${basePackage}.core.base.BaseSV;
import ${basePackage}.core.enums.PermissionTypeEnum;
import ${basePackage}.rbac.entity.RbacPermission;
import ${basePackage}.rbac.entity.RbacPermissionMenu;
import ${basePackage}.rbac.vo.TreeMenuNodeVO;

import java.util.List;

/**
 * 权限系统-权限资源
 *
 * @author borong
 */
public interface RbacPermissionSV extends BaseSV<RbacPermission, Long> {


    /**
     * 添加菜单
     * 检查同级菜单名是否重名
     *
     * @param menuName    必填，菜单名
     * @param menuHref    必填，菜单链接
     * @param idPre       选填，上级菜单id
     * @param menuIcon    选填，菜单图标
     * @param description 选填，描述
     * @param sort        选填，排序；默认 1
     * @return RbacPermissionMenu
     */
    RbacPermission insertMenu(String menuName, String menuHref,
                              Long idPre, String menuIcon, String description, Integer sort);

    /**
     * 根据权限类型查询所有权限
     *
     * @param permissionTypeEnum 权限类型 [枚举编号：1008](/resources/enum/1008)
     * @return
     */
    List<RbacPermission> queryPermission(PermissionTypeEnum permissionTypeEnum);

    /**
     * 查询权限菜单集合
     *
     * @return
     */
    List<RbacPermissionMenu> queryPermissionMenu();

    /**
     * 根据权限类型 查询所有权限，返回树结构
     *
     * @param permissionTypeEnum 权限类型 [枚举编号：1008](/resources/enum/1008)
     * @return
     */
    List<TreeMenuNodeVO> queryPermissionTree(PermissionTypeEnum permissionTypeEnum);

    /**
     * 加载一个对象RbacPermission
     *
     * @param id 权限id
     * @return RbacPermission
     */
    RbacPermission load(java.lang.Long id);

    /**
     * 加载一个对象RbacPermission详情，(将查询关联数据)
     *
     * @param id 权限id
     * @return RbacPermission
     */
    RbacPermission get(java.lang.Long id);

    /**
     * 加载一个对象RbacPermission 通过id
     *
     * @param id 权限id
     * @return RbacPermission
     */
    RbacPermission loadById(java.lang.Long id);

    /**
     * 删除对象RbacPermission
     *
     * @param id 权限id
     * @return RbacPermission
     */
    void delete(java.lang.Long id);


    /**
     * 查询RbacPermission分页
     *
     * @param rbacPermission 权限系统-权限资源
     * @param offset         查询开始行
     * @param limit          查询行数
     * @return List<RbacPermission>
     */
    List<RbacPermission> list(RbacPermission rbacPermission, int offset, int limit);

    int count(RbacPermission rbacPermission);
}
