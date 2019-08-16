/*
 * 仁中和
 */
package ${basePackage}.admin.service;

import ${basePackage}.admin.entity.Admin;
import ${basePackage}.admin.entity.AdminState;
import ${basePackage}.core.base.BaseSV;

import java.util.List;

/**
 * 管理员表
 *
 * @author borong
 */
public interface AdminSV extends BaseSV<Admin, Long> {


    /**
     * 加载一个对象Admin
     *
     * @param id 主键ID
     * @return ADMIN
     */
    Admin load(java.lang.Long id);


    /**
     * 加载一个对象Admin 通过id
     *
     * @param id 主键ID
     * @return ADMIN
     */
    Admin loadById(java.lang.Long id);


    /**
     * 删除对象Admin
     *
     * @param id 主键ID
     * @return ADMIN
     */
    void delete(java.lang.Long id);


    /**
     * 查询Admin分页
     *
     * @param admin  管理员表
     * @param offset 查询开始行
     * @param limit  查询行数
     * @return List<ADMIN>
     */
    List<Admin> list(Admin admin, int offset, int limit);

    int count(Admin admin);

    /**
     * 通过账号和密码查询管理员信息
     * 用于管理员账号密码登录接口
     *
     * @param account  登录账户
     * @param password 密码
     * @return
     */
    Admin load(String account, String password);

    /**
     * 通过编码查询管理员信息
     * @param code
     * @return
     */
    Admin loadByCode(String code);
}
