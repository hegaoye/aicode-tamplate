/*
 * ${copyright}
 */
package ${basePackage}.rbac.dao;

${basePackage}.core.base.BaseDAO;
${basePackage}.core.enums.YNEnum;
${basePackage}.rbac.entity.RbacRole;
${basePackage}.rbac.entity.RbacRoleState;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 权限系统-角色
 *
 * @author borong
 */
@Mapper
@Repository
public interface RbacRoleDAO extends BaseDAO<RbacRole, Long> {

    /**
     * 加载一个对象RbacRole 通过id
     *
     * @param id 角色id
     * @return RbacRole
     */
    RbacRole loadById(@Param("id") Long id);

    /**
     * 根据主键id,oldStates 共同更新 RbacRole 的状态到newState状态
     *
     * @param id        角色id
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    void updateStateById(@Param("id") Long id, @Param("updateTime") Date updateTime, @Param("newState") RbacRoleState newState, @Param("oldStates") RbacRoleState... oldStates);

    /**
     * 根据主键id 更新 RbacRole 的状态到另一个状态
     *
     * @param id    角色id
     * @param state 状态
     */
    void updateById(@Param("id") Long id, @Param("state") RbacRoleState state, @Param("updateTime") Date updateTime);

    /**
     * 删除对象RbacRole
     *
     * @param params 实体的属性
     */
    void delete(Map<String, Object> params);


    /**
     * 加载一个对象RbacRole,所有关联数据都将被查询
     *
     * @param id 角色id
     * @return RbacRole
     */
    RbacRole getDetail(@Param("id") Long id);

    /**
     * 查询RbacRole列表
     *
     * @param rowBounds 分页参数
     * @return List<RbacRole>
     */
    List<RbacRole> list(RowBounds rowBounds);

    /**
     * 根据角色id集合，查询当前角色
     *
     * @param roleIds
     * @return
     */
    List<RbacRole> list(List<Long> roleIds);

    /**
     * 更新角色的叶子节点状态
     *
     * @param id
     * @param isLeaf
     */
    void updateRoleLeaf(Long id, @Param("isLeaf") YNEnum isLeaf);

    /**
     * 根据角色id删除角色
     *
     * @param id
     */
    void deleteById(@Param("id") Long id);
}
