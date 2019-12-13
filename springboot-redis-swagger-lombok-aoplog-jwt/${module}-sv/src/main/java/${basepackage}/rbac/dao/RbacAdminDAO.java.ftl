/*
 * ${copyright}
 */
package ${basePackage}.rbac.dao;

import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.core.enums.EnableStateEnum;
import ${basePackage}.rbac.entity.RbacAdmin;
import ${basePackage}.rbac.entity.RbacAdminState;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 权限系统-管理员（授权用户）
 *
 * @author borong
 */
@Mapper
@Repository
public  interface RbacAdminDAO extends BaseDAO<RbacAdmin, Long> {

    /**
     * 加载一个对象RbacAdmin 通过id
     * @param id 主键ID
     * @return RbacAdmin
     */
    RbacAdmin loadById(@Param("id") Long id);


    /**
     * 根据主键id,oldStates 共同更新 RbacAdmin 的状态到newState状态
     *
     * @param id 主键ID
     * @param newState 新状态
     * @param oldStates 旧状态集合
     */
    void updateStateById(@Param("id") Long id, @Param("updateTime") Date updateTime, @Param("newState") EnableStateEnum newState,
                         @Param("oldStates") EnableStateEnum... oldStates);

    /**
     * 根据主键id 更新 RbacAdmin 的状态到另一个状态
     *
     * @param id 主键ID
     * @param state 状态
     */
    void updateById(@Param("id") Long id, @Param("state") RbacAdminState state, @Param("updateTime") Date updateTime);

    /**
     * 删除对象RbacAdmin
     *@param params 实体的属性
     */
    void delete(Map<String, Object> params);


    /**
     * 加载一个对象RbacAdmin,所有关联数据都将被查询
     * @param id 主键ID
     * @return RbacAdmin
     */
    RbacAdmin getDetail(@Param("id") Long id);

    /**
     * 查询RbacAdmin列表
     * @param rowBounds 分页参数
     * @return List<RbacAdmin>
     */
    List<RbacAdmin> list(RowBounds rowBounds);

    /**
     * 根据编码查询授权用户（管理员）
     *
     * @param code
     * @return
     */
    RbacAdmin loadByCode(@Param("code") String code);

    /**
     * 删除管理员
     * @param code
     */
    void deleteByCode(@Param("code") String code);
}
