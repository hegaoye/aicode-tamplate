/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import java.util.List;
import ${basePackage}.core.base.BaseSV;
import ${basePackage}.rbac.entity.RbacPermissionApi;

/**
 * 权限系统-权限授权API；每一个权限对应多个授权API请求路径
 *
 * @author borong
 */
public interface RbacPermissionApiSV extends BaseSV<RbacPermissionApi,Long> {


    /**
     * 加载一个对象RbacPermissionApi
     * @param id 权限授权记录id
     * @return RbacPermissionApi
     */
    RbacPermissionApi load(java.lang.Long id);

    /**
    * 加载一个对象RbacPermissionApi详情，(将查询关联数据)
    * @param id 权限授权记录id
    * @return RbacPermissionApi
    */
        RbacPermissionApi get(java.lang.Long id);

    /**
     * 加载一个对象RbacPermissionApi 通过id
     * @param id 权限授权记录id
     * @return RbacPermissionApi
     */
        RbacPermissionApi loadById(java.lang.Long id);

    /**
     * 删除对象RbacPermissionApi
     * @param id 权限授权记录id
     * @return RbacPermissionApi
     */
     void delete(java.lang.Long id);



    /**
     * 查询RbacPermissionApi分页
     *
     * @param rbacPermissionApi  权限系统-权限授权API；每一个权限对应多个授权API请求路径
     * @param offset 查询开始行
     * @param limit  查询行数
     * @return List<RbacPermissionApi>
     */
     List<RbacPermissionApi> list(RbacPermissionApi rbacPermissionApi, int offset, int limit);
     int count(RbacPermissionApi rbacPermissionApi);
}
