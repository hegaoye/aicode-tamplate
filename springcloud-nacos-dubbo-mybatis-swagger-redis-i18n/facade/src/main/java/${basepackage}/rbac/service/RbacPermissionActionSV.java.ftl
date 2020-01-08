/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import java.util.List;
import ${basePackage}.core.base.BaseSV;
import ${basePackage}.rbac.entity.RbacPermissionAction;

/**
 * 权限系统-功能操作权限
 *
 * @author borong
 */
public interface RbacPermissionActionSV extends BaseSV<RbacPermissionAction,Long> {


    /**
     * 加载一个对象RbacPermissionAction
     * @param id 主键ID
     * @return RbacPermissionAction
     */
    RbacPermissionAction load(java.lang.Long id);

    /**
    * 加载一个对象RbacPermissionAction详情，(将查询关联数据)
    * @param id 主键ID
    * @return RbacPermissionAction
    */
        RbacPermissionAction get(java.lang.Long id);

    /**
     * 加载一个对象RbacPermissionAction 通过id
     * @param id 主键ID
     * @return RbacPermissionAction
     */
        RbacPermissionAction loadById(java.lang.Long id);

    /**
     * 删除对象RbacPermissionAction
     * @param id 主键ID
     * @return RbacPermissionAction
     */
     void delete(java.lang.Long id);



    /**
     * 查询RbacPermissionAction分页
     *
     * @param rbacPermissionAction  权限系统-功能操作权限
     * @param offset 查询开始行
     * @param limit  查询行数
     * @return List<RbacPermissionAction>
     */
     List<RbacPermissionAction> list(RbacPermissionAction rbacPermissionAction, int offset, int limit);
     int count(RbacPermissionAction rbacPermissionAction);
}
