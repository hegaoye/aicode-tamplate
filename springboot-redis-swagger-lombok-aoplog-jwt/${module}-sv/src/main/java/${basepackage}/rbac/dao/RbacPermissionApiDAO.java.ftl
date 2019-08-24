/*
 * ${copyright}
 */
package ${basePackage}.rbac.dao;

${basePackage}.core.base.BaseDAO;
${basePackage}.rbac.entity.RbacPermissionApi;
${basePackage}.rbac.entity.RbacPermissionApiState;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 权限系统-权限授权API；每一个权限对应多个授权API请求路径
 *
 * @author borong
 */
@Mapper
@Repository
public  interface RbacPermissionApiDAO extends BaseDAO<RbacPermissionApi, Long> {

    /**
     * 加载一个对象RbacPermissionApi 通过id
     * @param id 权限授权记录id
     * @return RbacPermissionApi
     */
    RbacPermissionApi loadById(@Param("id") Long id);


    /**
     * 根据主键id,oldStates 共同更新 RbacPermissionApi 的状态到newState状态
     *
     * @param id 权限授权记录id
     * @param newState 新状态
     * @param oldStates 旧状态集合
     */
    void updateStateById(@Param("id") Long id, @Param("updateTime") Date updateTime, @Param("newState") RbacPermissionApiState newState, @Param("oldStates") RbacPermissionApiState... oldStates);

    /**
     * 根据主键id 更新 RbacPermissionApi 的状态到另一个状态
     *
     * @param id 权限授权记录id
     * @param state 状态
     */
    void updateById(@Param("id") Long id, @Param("state") RbacPermissionApiState state, @Param("updateTime") Date updateTime);

    /**
     * 删除对象RbacPermissionApi
     *@param params 实体的属性
     */
    void delete(Map<String, Object> params);


    /**
     * 加载一个对象RbacPermissionApi,所有关联数据都将被查询
     * @param id 权限授权记录id
     * @return RbacPermissionApi
     */
    RbacPermissionApi getDetail(@Param("id") Long id);

    /**
     * 查询RbacPermissionApi列表
     * @param rowBounds 分页参数
     * @return List<RbacPermissionApi>
     */
    List<RbacPermissionApi> list(RowBounds rowBounds);
}
