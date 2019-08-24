/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import ${basePackage}.core.base.BaseSV;
import ${basePackage}.rbac.entity.RbacAdmin;
import ${basePackage}.rbac.entity.RbacPermissionMenu;
import ${basePackage}.rbac.vo.TreeMenuNodeVO;

import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * 权限系统-管理员（授权用户）
 *
 * @author borong
 */
public interface RbacAdminSV extends BaseSV<RbacAdmin, Long> {

    /**
     * 通过账号和密码查询管理员信息
     * 用于管理员账号密码登录接口
     *
     * @param account  登录账户
     * @param password 密码
     * @return
     */
    RbacAdmin load(String account, String password);

    /**
     * 处理管理员登录
     *
     * @param account
     * @param password
     * @param response
     * @return
     */
    RbacAdmin loginHandle(String account, String password, HttpServletResponse response);

    /**
     * 新增管理员资料
     *
     * @param account  自定义账号 (长度限制5-16位，字母开头+数字)
     * @param phone    手机号
     * @param email    邮箱
     * @param idcard   身份证号
     * @param password 密码 未加密密码
     * @param name     姓名
     * @param creator  创建者（管理员）
     * @return
     */
    RbacAdmin addAdmin(String account, String phone, String email, String idcard, String password, String name,
                       RbacAdmin creator);

    /**
     * 修改自己的登录密码
     *
     * @param admin
     * @param password 新的登录密码
     * @return
     */
    void editPassword(RbacAdmin admin, String password);

    /**
     * 修改管理员资料
     *
     * @param code     管理员编码
     * @param account  自定义账号 (长度限制5-16位，字母开头+数字)
     * @param phone    手机号
     * @param email    邮箱
     * @param idcard   身份证号
     * @param password 新密码
     * @param name     姓名
     * @param editor   修改人
     * @return
     */
    RbacAdmin editAdmin(String code, String account, String phone, String email, String idcard, String password, String name, RbacAdmin editor);

    /**
     * 删除管理员
     *
     * @param code 主键ID
     * @return RbacAdmin
     */
    void delete(String code);

    /**
     * 检查新增[账号|手机号|邮箱]是否重复
     *
     * @param account
     * @param ownerCode
     * @return
     */
    public void checkAccountIsRepeat(String account, String ownerCode);

    /**
     * 变更管理员的启用状态
     *
     * @param code        变更管理员的编码
     * @param editorAdmin 当前操作的管理员
     * @return
     */
    RbacAdmin updateEnableState(String code, RbacAdmin editorAdmin);

    /**
     * 根据管理员编码查询详情
     *
     * @param code 管理员编码
     * @return RbacAdmin
     */
    RbacAdmin loadByCode(java.lang.String code);

    /**
     * 加载一个对象RbacAdmin
     *
     * @param id 主键ID
     * @return RbacAdmin
     */
    RbacAdmin load(java.lang.Long id);

    /**
     * 加载一个对象RbacAdmin详情，(将查询关联数据)
     *
     * @param id 主键ID
     * @return RbacAdmin
     */
    RbacAdmin get(java.lang.Long id);

    /**
     * 加载一个对象RbacAdmin 通过id
     *
     * @param id 主键ID
     * @return RbacAdmin
     */
    RbacAdmin loadById(java.lang.Long id);


    /**
     * 查询RbacAdmin分页
     *
     * @param rbacAdmin 权限系统-管理员（授权用户）
     * @param offset    查询开始行
     * @param limit     查询行数
     * @return List<RbacAdmin>
     */
    List<RbacAdmin> list(RbacAdmin rbacAdmin, int offset, int limit);

    int count(RbacAdmin rbacAdmin);

    /**
     * 查询管理员的所有权限
     *
     * @param admin
     */
    List<RbacPermissionMenu> queryMyPermissionMenuList(RbacAdmin admin);

    /**
     * 查询管理员的所有权限-树结构
     * @param admin
     * @return
     */
    List<TreeMenuNodeVO> queryMyPermissionMenuTreeList(RbacAdmin admin);
}
