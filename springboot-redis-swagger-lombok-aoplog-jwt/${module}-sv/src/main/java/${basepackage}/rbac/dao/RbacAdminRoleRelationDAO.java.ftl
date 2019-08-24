/*
 * ${copyright}
 */
package ${basePackage}.rbac.dao;

${basePackage}.core.base.BaseDAO;
${basePackage}.rbac.entity.RbacAdminRoleRelation;
${basePackage}.rbac.entity.RbacAdminRoleRelationState;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 权限系统-授权用户与角色关系
 *
 * @author borong
 */
@Mapper
@Repository
public interface RbacAdminRoleRelationDAO extends BaseDAO<RbacAdminRoleRelation, Long> {

    /**
     * 加载一个对象RbacAdminRoleRelation 通过id
     *
     * @param id 关系记录ID
     * @return RbacAdminRoleRelation
     */
    RbacAdminRoleRelation loadById(@Param("id") Long id);


    /**
     * 根据主键id,oldStates 共同更新 RbacAdminRoleRelation 的状态到newState状态
     *
     * @param id        关系记录ID
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    void updateStateById(@Param("id") Long id, @Param("updateTime") Date updateTime, @Param("newState") RbacAdminRoleRelationState newState, @Param("oldStates") RbacAdminRoleRelationState... oldStates);

    /**
     * 根据主键id 更新 RbacAdminRoleRelation 的状态到另一个状态
     *
     * @param id    关系记录ID
     * @param state 状态
     */
    void updateById(@Param("id") Long id, @Param("state") RbacAdminRoleRelationState state, @Param("updateTime") Date updateTime);

    /**
     * 删除对象RbacAdminRoleRelation
     *
     * @param params 实体的属性
     */
    void delete(Map<String, Object> params);


    /**
     * 加载一个对象RbacAdminRoleRelation,所有关联数据都将被查询
     *
     * @param id 关系记录ID
     * @return RbacAdminRoleRelation
     */
    RbacAdminRoleRelation getDetail(@Param("id") Long id);

    /**
     * 查询RbacAdminRoleRelation列表
     *
     * @param rowBounds 分页参数
     * @return List<RbacAdminRoleRelation>
     */
    List<RbacAdminRoleRelation> list(RowBounds rowBounds);

    /**
     * 根据角色id 删除角色与授权用户的关系
     *
     * @param roleId
     */
    void deleteByRoleId(@Param("roleId") Long roleId);

    /**
     * 删除管理员与角色的绑定关系
     *
     * @param adminCode
     */
    void deleteByAdminCode(@Param("adminCode") String adminCode);

    /**
     * 查询管理员拥有的所有角色id
     *
     * @param adminCode
     * @return
     */
    List<Long> listAdminRoleIds(@Param("adminCode") String adminCode);
}
