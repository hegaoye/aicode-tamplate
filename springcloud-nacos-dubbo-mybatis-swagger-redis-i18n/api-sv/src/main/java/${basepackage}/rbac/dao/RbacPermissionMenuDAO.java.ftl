/*
 * ${copyright}
 */
package ${basePackage}.rbac.dao;

import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.core.enums.YNEnum;
import ${basePackage}.rbac.entity.RbacPermissionMenu;
import ${basePackage}.rbac.entity.RbacPermissionMenuState;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 权限系统-菜单权限
 *
 * @author borong
 */
@Mapper
@Repository
public  interface RbacPermissionMenuDAO extends BaseDAO<RbacPermissionMenu, Long> {

    /**
     * 加载一个对象RbacPermissionMenu 通过id
     * @param id 菜单ID
     * @return RbacPermissionMenu
     */
    RbacPermissionMenu loadById(@Param("id") Long id);


    /**
     * 根据主键id,oldStates 共同更新 RbacPermissionMenu 的状态到newState状态
     *
     * @param id 菜单ID
     * @param newState 新状态
     * @param oldStates 旧状态集合
     */
    void updateStateById(@Param("id") Long id, @Param("updateTime") Date updateTime, @Param("newState") RbacPermissionMenuState newState, @Param("oldStates") RbacPermissionMenuState... oldStates);

    /**
     * 根据主键id 更新 RbacPermissionMenu 的状态到另一个状态
     *
     * @param id 菜单ID
     * @param state 状态
     */
    void updateById(@Param("id") Long id, @Param("state") RbacPermissionMenuState state, @Param("updateTime") Date updateTime);

    /**
     * 删除对象RbacPermissionMenu
     *@param params 实体的属性
     */
    void delete(Map<String, Object> params);


    /**
     * 加载一个对象RbacPermissionMenu,所有关联数据都将被查询
     * @param id 菜单ID
     * @return RbacPermissionMenu
     */
    RbacPermissionMenu getDetail(@Param("id") Long id);

    /**
     * 查询RbacPermissionMenu列表
     * @param rowBounds 分页参数
     * @return List<RbacPermissionMenu>
     */
    List<RbacPermissionMenu> list(RowBounds rowBounds);

    /**
     * 更新指定菜单的叶子节点状态
     * @param id 菜单id
     * @param isLeaf YNEnum 是否为叶子节点
     */
    void updateMenuLeaf(@Param("id") Long id, @Param("isLeaf") YNEnum isLeaf);

    /**
     * 删除指定id的菜单
     * @param menuId
     */
    void deleteById(@Param("menuId") Long menuId);
}
