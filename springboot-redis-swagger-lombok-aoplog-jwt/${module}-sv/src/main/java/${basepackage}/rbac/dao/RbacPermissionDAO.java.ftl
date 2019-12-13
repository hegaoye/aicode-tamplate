/*
 * ${copyright}
 */
package ${basePackage}.rbac.dao;

import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.core.enums.PermissionTypeEnum;
import ${basePackage}.rbac.entity.RbacPermission;
import ${basePackage}.rbac.entity.RbacPermissionState;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 权限系统-权限资源
 *
 * @author borong
 */
@Mapper
@Repository
public interface RbacPermissionDAO extends BaseDAO<RbacPermission, Long> {

    /**
     * 加载一个对象RbacPermission 通过id
     *
     * @param id 权限id
     * @return RbacPermission
     */
    RbacPermission loadById(@Param("id") Long id);


    /**
     * 根据主键id,oldStates 共同更新 RbacPermission 的状态到newState状态
     *
     * @param id        权限id
     * @param newState  新状态
     * @param oldStates 旧状态集合
     */
    void updateStateById(@Param("id") Long id, @Param("updateTime") Date updateTime, @Param("newState") RbacPermissionState newState, @Param("oldStates") RbacPermissionState... oldStates);

    /**
     * 根据主键id 更新 RbacPermission 的状态到另一个状态
     *
     * @param id    权限id
     * @param state 状态
     */
    void updateById(@Param("id") Long id, @Param("state") RbacPermissionState state, @Param("updateTime") Date updateTime);

    /**
     * 删除对象RbacPermission
     *
     * @param params 实体的属性
     */
    void delete(Map<String, Object> params);

    /**
     * 根据菜单id删除所有权限资源
     *
     * @param menuId
     */
    void deleteByMenuId(@Param("menuId") Long menuId);


    /**
     * 加载一个对象RbacPermission,所有关联数据都将被查询
     *
     * @param id 权限id
     * @return RbacPermission
     */
    RbacPermission getDetail(@Param("id") Long id);

    /**
     * 查询RbacPermission列表
     *
     * @param rowBounds 分页参数
     * @return List<RbacPermission>
     */
    List<RbacPermission> list(RowBounds rowBounds);

    /**
     * 修改菜单权限资源中权限名称
     *
     * @param menuId   菜单id
     * @param typeEnum 权限类型
     * @param name     权限名称
     */
    void updateMenuPermissionName(
            @Param("menuId") Long menuId,
            @Param("type") PermissionTypeEnum typeEnum,
            @Param("updateTime") Date updateTime,
            @Param("name") String name);
}
