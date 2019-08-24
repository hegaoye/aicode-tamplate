/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import ${basePackage}.core.base.BaseSV;
import ${basePackage}.rbac.entity.RbacAdmin;
import ${basePackage}.rbac.entity.RbacAdminRoleRelation;

import java.util.List;

/**
 * 权限系统-授权用户与角色关系
 *
 * @author borong
 */
public interface RbacAdminRoleRelationSV extends BaseSV<RbacAdminRoleRelation, Long> {


    /**
     * 为授权用户（管理员）绑定角色
     *
     * @param adminCode 被授权用户（管理员）编码
     * @param roleIds   要绑定的角色id
     * @param rbacAdmin 授权人
     * @return
     */
    List<RbacAdminRoleRelation> bindRoleAndPermission(String adminCode, List<Long> roleIds, RbacAdmin rbacAdmin);


    /**
     * 加载一个对象RbacAdminRoleRelation
     *
     * @param id 关系记录ID
     * @return RbacAdminRoleRelation
     */
    RbacAdminRoleRelation load(java.lang.Long id);

    /**
     * 加载一个对象RbacAdminRoleRelation详情，(将查询关联数据)
     *
     * @param id 关系记录ID
     * @return RbacAdminRoleRelation
     */
    RbacAdminRoleRelation get(java.lang.Long id);

    /**
     * 加载一个对象RbacAdminRoleRelation 通过id
     *
     * @param id 关系记录ID
     * @return RbacAdminRoleRelation
     */
    RbacAdminRoleRelation loadById(java.lang.Long id);

    /**
     * 删除对象RbacAdminRoleRelation
     *
     * @param id 关系记录ID
     * @return RbacAdminRoleRelation
     */
    void delete(java.lang.Long id);


    /**
     * 查询RbacAdminRoleRelation分页
     *
     * @param rbacAdminRoleRelation 权限系统-授权用户与角色关系
     * @param offset                查询开始行
     * @param limit                 查询行数
     * @return List<RbacAdminRoleRelation>
     */
    List<RbacAdminRoleRelation> list(RbacAdminRoleRelation rbacAdminRoleRelation, int offset, int limit);

    int count(RbacAdminRoleRelation rbacAdminRoleRelation);
}
