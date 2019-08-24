/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import ${basePackage}.core.base.BaseSV;
import ${basePackage}.rbac.entity.RbacRole;
import ${basePackage}.rbac.vo.TreeMenuNodeVO;

import java.util.List;

/**
 * 权限系统-角色
 *
 * @author borong
 */
public interface RbacRoleSV extends BaseSV<RbacRole, Long> {

    /**
     * 新增角色
     *
     * @param roleName    必填，角色名
     * @param idPre       选填，上级角色id；为空时 默认 0
     * @param description 选填，描述
     * @return
     */
    RbacRole addRole(String roleName, Long idPre, String description);

    /**
     * 查询一个角色与拥有的权限
     *
     * @param roleId 角色 id
     * @return
     */
    RbacRole loadRoleAndPermissions(Long roleId);

    /**
     * 查询所有权限，并标记角色拥有的权限
     *
     * @param roleId 角色 id
     * @return
     */
    List<TreeMenuNodeVO> queryAllPermissionAndMine(Long roleId);

    /**
     * 加载一个对象RbacRole
     *
     * @param id 角色id
     * @return RbacRole
     */
    RbacRole load(java.lang.Long id);

    /**
     * 加载一个对象RbacRole详情，(将查询关联数据)
     *
     * @param id 角色id
     * @return RbacRole
     */
    RbacRole get(java.lang.Long id);

    /**
     * 加载一个对象RbacRole 通过id
     *
     * @param id 角色id
     * @return RbacRole
     */
    RbacRole loadById(java.lang.Long id);

    /**
     * 删除角色
     *
     * @param id 角色id
     * @return RbacRole
     */
    void delete(java.lang.Long id);


    /**
     * 查询RbacRole分页
     *
     * @param rbacRole 权限系统-角色
     * @param offset   查询开始行
     * @param limit    查询行数
     * @return List<RbacRole>
     */
    List<RbacRole> list(RbacRole rbacRole, int offset, int limit);

    int count(RbacRole rbacRole);

    /**
     * 查询所有角色，并标记管理员拥有的角色
     *
     * @param code 管理员编码
     * @return
     */
    List<RbacRole> queryAllRoleAndMarkAdmin(String code);
}
