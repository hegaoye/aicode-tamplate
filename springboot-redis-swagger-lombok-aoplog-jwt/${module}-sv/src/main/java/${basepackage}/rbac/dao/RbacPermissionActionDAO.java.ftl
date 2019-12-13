/*
 * ${copyright}
 */
package ${basePackage}.rbac.dao;

import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.rbac.entity.RbacPermissionAction;
import ${basePackage}.rbac.entity.RbacPermissionActionState;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 权限系统-功能操作权限
 *
 * @author borong
 */
@Mapper
@Repository
public  interface RbacPermissionActionDAO extends BaseDAO<RbacPermissionAction, Long> {

    /**
     * 加载一个对象RbacPermissionAction 通过id
     * @param id 主键ID
     * @return RbacPermissionAction
     */
    RbacPermissionAction loadById(@Param("id") Long id);


    /**
     * 根据主键id,oldStates 共同更新 RbacPermissionAction 的状态到newState状态
     *
     * @param id 主键ID
     * @param newState 新状态
     * @param oldStates 旧状态集合
     */
    void updateStateById(@Param("id") Long id, @Param("updateTime") Date updateTime, @Param("newState") RbacPermissionActionState newState, @Param("oldStates") RbacPermissionActionState... oldStates);

    /**
     * 根据主键id 更新 RbacPermissionAction 的状态到另一个状态
     *
     * @param id 主键ID
     * @param state 状态
     */
    void updateById(@Param("id") Long id, @Param("state") RbacPermissionActionState state, @Param("updateTime") Date updateTime);

    /**
     * 删除对象RbacPermissionAction
     *@param params 实体的属性
     */
    void delete(Map<String, Object> params);


    /**
     * 加载一个对象RbacPermissionAction,所有关联数据都将被查询
     * @param id 主键ID
     * @return RbacPermissionAction
     */
    RbacPermissionAction getDetail(@Param("id") Long id);

    /**
     * 查询RbacPermissionAction列表
     * @param rowBounds 分页参数
     * @return List<RbacPermissionAction>
     */
    List<RbacPermissionAction> list(RowBounds rowBounds);
}
