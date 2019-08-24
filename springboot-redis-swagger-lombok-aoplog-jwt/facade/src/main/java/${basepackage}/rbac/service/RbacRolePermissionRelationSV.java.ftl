/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import ${basePackage}.core.base.BaseSV;
import ${basePackage}.rbac.entity.RbacPermission;
import ${basePackage}.rbac.entity.RbacRolePermissionRelation;
import ${basePackage}.rbac.vo.TreeMenuNodeVO;

import java.util.List;

/**
 * 权限系统-角色对应权限关系
 *
 * @author borong
 */
public interface RbacRolePermissionRelationSV extends BaseSV<RbacRolePermissionRelation, Long> {


    /**
     * 角色 绑定权限
     *
     * @param roleId        角色id
     * @param permissionIds 要绑定的权限id
     * @return
     */
    List<RbacRolePermissionRelation> bindRoleAndPermission(Long roleId, List<Long> permissionIds);

    /**
     * 根据角色查询绑定的所有权限，返回树结构
     *
     * @param roleId 角色id
     * @return
     */
    List<TreeMenuNodeVO> queryRolePermissionsTree(Long roleId);

    /**
     * 根据角色查询绑定的所有权限
     *
     * @param roleId 角色id
     * @return
     */
    List<RbacPermission> queryRolePermissions(Long roleId);

    /**
     * 根据多角色查询绑定的所有权限
     *
     * @param roleIds 角色id
     * @return
     */
    List<RbacPermission> queryRolePermissions(List<Long> roleIds);

    /**
     * 加载一个对象RbacRolePermissionRelation
     *
     * @param id 关系记录id
     * @return RbacRolePermissionRelation
     */
    RbacRolePermissionRelation load(java.lang.Long id);

    /**
     * 加载一个对象RbacRolePermissionRelation详情，(将查询关联数据)
     *
     * @param id 关系记录id
     * @return RbacRolePermissionRelation
     */
    RbacRolePermissionRelation get(java.lang.Long id);

    /**
     * 加载一个对象RbacRolePermissionRelation 通过id
     *
     * @param id 关系记录id
     * @return RbacRolePermissionRelation
     */
    RbacRolePermissionRelation loadById(java.lang.Long id);

    /**
     * 删除对象RbacRolePermissionRelation
     *
     * @param id 关系记录id
     * @return RbacRolePermissionRelation
     */
    void delete(java.lang.Long id);


    /**
     * 查询RbacRolePermissionRelation分页
     *
     * @param rbacRolePermissionRelation 权限系统-角色对应权限关系
     * @param offset                     查询开始行
     * @param limit                      查询行数
     * @return List<RbacRolePermissionRelation>
     */
    List<RbacRolePermissionRelation> list(RbacRolePermissionRelation rbacRolePermissionRelation, int offset, int limit);

    int count(RbacRolePermissionRelation rbacRolePermissionRelation);
}
