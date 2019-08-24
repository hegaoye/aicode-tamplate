/*
 * ${copyright}
 */
package ${basePackage}.rbac.dao;

${basePackage}.core.base.BaseDAO;
${basePackage}.rbac.entity.RbacRolePermissionRelation;
${basePackage}.rbac.entity.RbacRolePermissionRelationState;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 权限系统-角色对应权限关系
 *
 * @author borong
 */
@Mapper
@Repository
public  interface RbacRolePermissionRelationDAO extends BaseDAO<RbacRolePermissionRelation, Long> {

    /**
     * 加载一个对象RbacRolePermissionRelation 通过id
     * @param id 关系记录id
     * @return RbacRolePermissionRelation
     */
    RbacRolePermissionRelation loadById(@Param("id") Long id);


    /**
     * 根据主键id,oldStates 共同更新 RbacRolePermissionRelation 的状态到newState状态
     *
     * @param id 关系记录id
     * @param newState 新状态
     * @param oldStates 旧状态集合
     */
    void updateStateById(@Param("id") Long id, @Param("updateTime") Date updateTime, @Param("newState") RbacRolePermissionRelationState newState, @Param("oldStates") RbacRolePermissionRelationState... oldStates);

    /**
     * 根据主键id 更新 RbacRolePermissionRelation 的状态到另一个状态
     *
     * @param id 关系记录id
     * @param state 状态
     */
    void updateById(@Param("id") Long id, @Param("state") RbacRolePermissionRelationState state, @Param("updateTime") Date updateTime);

    /**
     * 删除对象RbacRolePermissionRelation
     *@param params 实体的属性
     */
    void delete(Map<String, Object> params);


    /**
     * 加载一个对象RbacRolePermissionRelation,所有关联数据都将被查询
     * @param id 关系记录id
     * @return RbacRolePermissionRelation
     */
    RbacRolePermissionRelation getDetail(@Param("id") Long id);

    /**
     * 查询RbacRolePermissionRelation列表
     * @param rowBounds 分页参数
     * @return List<RbacRolePermissionRelation>
     */
    List<RbacRolePermissionRelation> list(RowBounds rowBounds);

    /**
     * 删除角色当前已经绑定的所有权限
     * @param roleId
     */
    void deleteByRoleId(@Param("roleId") Long roleId);

    /**
     * 根据角色查询绑定的所有权限
     * @param roleId
     * @return
     */
    List<RbacRolePermissionRelation> queryRolePermissions(@Param("roleId") Long roleId);

    /**
     * 根据多角色查询绑定的所有权限
     * @param roleIds
     * @return
     */
    List<RbacRolePermissionRelation> queryRolesPermissions(@Param("roleIds") List<Long> roleIds);

    /**
     * 根据权限资源id集 删除角色与菜单权限对应关系
     * @param permissionIds
     */
    void deleteByPermissionIds(@Param("permissionIds") List<Long> permissionIds);
}
