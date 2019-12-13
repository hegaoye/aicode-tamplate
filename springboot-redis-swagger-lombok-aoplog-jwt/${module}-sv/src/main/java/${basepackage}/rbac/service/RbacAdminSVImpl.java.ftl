/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.baidu.fsg.uid.UidGenerator;
import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.core.base.BaseSVImpl;
import ${basePackage}.core.entity.Page;
import ${basePackage}.core.enums.*;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.hutool.util.IdcardUtil;
import ${basePackage}.core.hutool.util.StrUtil;
import ${basePackage}.core.jwt.JWTTools;
import ${basePackage}.core.jwt.vo.Account;
import ${basePackage}.core.redis.RedisKey;
import ${basePackage}.core.redis.RedisUtils;
import ${basePackage}.core.tools.RegexTools;
import ${basePackage}.core.tools.StringTools;
import ${basePackage}.core.tools.security.Md5;
import ${basePackage}.rbac.dao.RbacAdminDAO;
import ${basePackage}.rbac.dao.RbacAdminRoleRelationDAO;
import ${basePackage}.rbac.dao.RbacPermissionDAO;
import ${basePackage}.rbac.entity.RbacAdmin;
import ${basePackage}.rbac.entity.RbacPermission;
import ${basePackage}.rbac.entity.RbacPermissionMenu;
import ${basePackage}.rbac.util.RbacUtil;
import ${basePackage}.rbac.vo.TreeMenuNodeVO;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import static ${basePackage}.core.exceptions.BaseException.ExceptionEnums;

@Service("rbacAdminSV")
@Slf4j
public class RbacAdminSVImpl extends BaseSVImpl<RbacAdmin, Long> implements RbacAdminSV {

    @Autowired
    private RbacAdminDAO rbacAdminDAO;

    @Autowired
    private RbacPermissionDAO permissionDAO;

    @Autowired
    private RbacAdminRoleRelationDAO adminRoleRelationDAO;

    @Autowired
    private RbacRolePermissionRelationSV rolePermissionRelationSV;

    @Resource
    private UidGenerator uidGenerator;

    @Autowired
    private RedisUtils redisUtils;

    @Override
    protected BaseDAO getBaseDAO() {
        return rbacAdminDAO;
    }

    /**
     * 通过账号和密码查询管理员信息
     * 用于管理员账号密码登录接口
     *
     * @param account  登录账户
     * @param password 密码
     * @return
     */
    @Override
    public RbacAdmin load(String account, String password) {
        if (StringUtils.isBlank(account)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("登录账户"));
        }
        if (StringUtils.isBlank(password)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("密码"));
        }

        // 检查登录账号的格式，并自动装箱至map条件
        Map<String, Object> params = new HashMap<>();
        // 手机号登录
        if (RegexTools.isPhone(account)) {
            params.put("phone", account);
        }
        // 邮箱登录
        else if (RegexTools.isEmail(account)) {
            params.put("email", account);
        }
        // 账号登录
        else {
            params.put("account", account);
        }
        params.put("password", Md5.md5(password));

        return rbacAdminDAO.load(params);
    }

    /**
     * 处理管理员登录
     *
     * @param account
     * @param password
     * @param response
     * @return
     */
    @Override
    public RbacAdmin loginHandle(String account, String password, HttpServletResponse response) {

        //通过账户和密码查询用户信息
        RbacAdmin admin = this.load(account, password);
        if (admin == null) {
            throw new BaseException(ExceptionEnums.account_login_error);
        }

        // 检查用户启用状态
        if (!EnableStateEnum.enable.equals(EnableStateEnum.getEnum(admin.getState()))) {
            throw new BaseException(ExceptionEnums.account_disable);
        }

        //中转加密后的密码
        password = admin.getPassword();
        long timestamp = System.currentTimeMillis();

        //缓存至redis；用于再次请求接口时，jwt验证用户token信息
        redisUtils.set(RedisKey.genPasswordKey(RoleTypeEnum.Admin, admin.getCode(), timestamp), password);

        //清空用户密码，禁止加密
        admin.setPassword(null);

        log.info("中转密码：" + password);

        //实例化token中包含信息
        Account<RbacAdmin> tokenAccount = new Account(admin.getId(), account, admin.getCode(), admin.getName(), RoleTypeEnum.Admin, timestamp, admin);
        //用户账号和密码校验通过后，生成token
        String token = JWTTools.genToken(tokenAccount, password, response);
        //把token放入 header
        response.setHeader(RoleTypeEnum.Admin.name() + JWTTools.getTokenName(), token);
        return admin;
    }

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
    @Override
    public RbacAdmin addAdmin(String account, String phone, String email, String idcard, String password, String name, RbacAdmin creator) {

        if (StrUtil.isAllBlank(account, phone, email)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("账号|手机号|邮箱"));
        }

        // 检查管理员的账号/手机号/邮箱/身份证号 是否有重复
        checkAccountIsRepeat(account, phone, email, idcard, null);

        // 检查密码
        checkPassword(password);

        // 检查姓名长度
        if (StringUtils.isBlank(name)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("管理员姓名"));
        }
        checkAdminName(name);

        // 构造新的管理员信息，并新增到库
        RbacAdmin rbacAdmin = new RbacAdmin(String.valueOf(uidGenerator.getUID()), account, phone, email, idcard,
                Md5.md5(password), name, YNEnum.N, EnableStateEnum.enable, creator.getCode(), new Date());
        rbacAdminDAO.insert(rbacAdmin);

        return rbacAdmin;
    }

    /**
     * 检查管理员的 账号/手机号/邮箱/身份证号 是否有重复
     *
     * @param account   账号
     * @param phone     手机号
     * @param email     邮箱
     * @param idcard    身份证号
     * @param ownerCode 所有人编码，检查重复时，排除此用户
     */
    private void checkAccountIsRepeat(String account, String phone, String email, String idcard, String ownerCode) {
        // 检查账号
        if (StringUtils.isNotBlank(account)) {
            if (!RegexTools.isLetterAndNumberAndStartWithLetter(account) || StringTools.checkLengthIsOverrun(account, 5, 16)) {
                throw new BaseException(ExceptionEnums.paramFormatError("账号", FormatEnum.account));
            }
            // 检查账号是否重复
            checkAccountIsRepeat(account, ownerCode);

        }
        // 检查手机号
        if (StringUtils.isNotBlank(phone)) {
            if (!RegexTools.isPhone(phone)) {
                throw new BaseException(ExceptionEnums.paramFormatError("手机号", FormatEnum.phone));
            }
            // 检查手机是否重复
            checkAccountIsRepeat(phone, ownerCode);
        }
        // 检查邮箱
        if (StringUtils.isNotBlank(email)) {
            if (!RegexTools.isEmail(email)) {
                throw new BaseException(ExceptionEnums.paramFormatError("邮箱", FormatEnum.email));
            }
            // 检查邮箱是否重复
            checkAccountIsRepeat(email, ownerCode);
        }

        // 如果身份证号不为空时检查身份证号格式
        if (StringUtils.isNotBlank(idcard) && !IdcardUtil.isValidCard(idcard)) {
            throw new BaseException(ExceptionEnums.paramIsInvalid("身份证号"));
        }
    }

    /**
     * 检查管理员姓名
     *
     * @param name
     */
    private void checkAdminName(String name) {
        if (StringTools.checkLengthIsOverrun(name, 32)) {
            throw new BaseException(ExceptionEnums.lengthOver("管理员姓名", 32));
        }
    }

    /**
     * 检查密码 6-20位 字母+数字
     *
     * @param password
     */
    private static void checkPassword(String password) {
        if (!PasswordLevelRegexEnum.checkPassword(password, PasswordLevelRegexEnum.level_anyone_letter_and_number_6_to_20)) {
            throw new BaseException(ExceptionEnums.paramFormatError("密码", FormatEnum.password));
        }
    }

    /**
     * 修改自己的登录密码
     *
     * @param admin
     * @param oldPwd 老的登录密码
     * @param newPwd 新的登录密码
     * @return
     */
    @Override
    public void editPassword(RbacAdmin admin, String oldPwd, String newPwd) {

        if (null == admin) {
            throw new BaseException(ExceptionEnums.token_is_null);
        }

        if (StrUtil.isAllBlank(oldPwd, newPwd)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("新旧密码"));
        }

        admin = rbacAdminDAO.loadById(admin.getId());

        if (admin == null) {
            throw new BaseException(ExceptionEnums.objIsNotExist(String.format("管理员[%s]", admin.getName())));
        }

        if (!EnableStateEnum.enable.equals(EnableStateEnum.getEnum(admin.getState()))) {
            throw new BaseException(ExceptionEnums.no_permission);
        }

        // 验证原密码
        if (!admin.getPassword().equals(Md5.md5(oldPwd))) {
            throw new BaseException(ExceptionEnums.old_password_error);
        }

        checkPassword(newPwd);
        admin.setPassword(Md5.md5(newPwd));

        admin.setUpdateTime(new Date());
        rbacAdminDAO.update(admin);
    }

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
    @Override
    public RbacAdmin editAdmin(String code, String account, String phone, String email, String idcard, String password, String name, RbacAdmin editor) {

        // 检查 修改者 是否有修改 code 对应管理员的权限
        RbacAdmin rbacAdmin = checkAdminPermission(code, editor);

        if (StrUtil.isAllBlank(account, phone, email, idcard, password, name)) {
            return rbacAdmin;
        }

        // 检查管理员的账号/手机号/邮箱/身份证号 是否有重复
        checkAccountIsRepeat(account, phone, email, idcard, code);

        if (StringUtils.isNotBlank(account)) {
            rbacAdmin.setAccount(account);
        }
        if (StringUtils.isNotBlank(phone)) {
            rbacAdmin.setPhone(phone);
        }
        if (StringUtils.isNotBlank(email)) {
            rbacAdmin.setEmail(email);
        }
        if (StringUtils.isNotBlank(idcard)) {
            rbacAdmin.setIdcard(idcard);
        }

        // 检查密码
        if (StringUtils.isNotBlank(password)) {
            checkPassword(password);
            rbacAdmin.setPassword(Md5.md5(password));
        }

        if (StringUtils.isNotBlank(name)) {
            checkAdminName(name);
            rbacAdmin.setName(name);
        }

        rbacAdmin.setUpdateTime(new Date());

        rbacAdminDAO.update(rbacAdmin);

        return rbacAdmin;
    }

    /**
     * 删除管理员
     *
     * @param code 管理员编码
     * @return RbacAdmin
     */
    @Override
    public void delete(String code) {
        if (code == null) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("管理员ID"));
        }
        // 删除前校验管理员权限 todo

        // 删除管理员
        rbacAdminDAO.deleteByCode(code);

        // 删除管理员与角色的绑定关系
        adminRoleRelationDAO.deleteByAdminCode(code);
    }

    /**
     * 检查新增账号是否重复
     *
     * @param account
     * @param ownerCode 所有人编码，检查重复时，排除此用户
     * @return
     */
    @Override
    public void checkAccountIsRepeat(String account, String ownerCode) {

        String repeatMessage = "";

        Map<String, Object> params = new HashMap<>();
        if (RegexTools.isLetterAndNumberAndStartWithLetter(account)) {
            params.put("account", account);
            repeatMessage = "账号 %s";
        }
        if (RegexTools.isPhone(account)) {
            params.put("phone", account);
            repeatMessage = "手机号 %s";
        }
        if (RegexTools.isEmail(account)) {
            params.put("email", account);
            repeatMessage = "邮箱 %s";
        }
        RbacAdmin rbacAdmin = rbacAdminDAO.load(params);
        if (null != rbacAdmin && !rbacAdmin.getCode().equalsIgnoreCase(ownerCode)) {
            throw new BaseException(ExceptionEnums.objIsExist(String.format(repeatMessage, account)));
        }
    }

    /**
     * 变更管理员的启用状态
     *
     * @param code        变更管理员的编码
     * @param editorAdmin 当前操作的管理员
     * @return
     */
    @Override
    public RbacAdmin updateEnableState(String code, RbacAdmin editorAdmin) {

        /**
         * 禁止自己修改自己的状态
         */
        RbacUtil.disableEditMyself(code, editorAdmin);

        // 检查 修改者 是否有修改 code 对应管理员的权限
        RbacAdmin rbacAdmin = checkAdminPermission(code, editorAdmin);

        // 管理员新的启用状态；默认为关闭
        EnableStateEnum stateEnum = EnableStateEnum.disable;
        // 如果当前启用状态为禁用，则改为启用
        if (EnableStateEnum.disable.equals(EnableStateEnum.getEnum(rbacAdmin.getState()))) {
            stateEnum = EnableStateEnum.enable;
        }

        Date now = new Date();

        // 修改管理员状态
        rbacAdminDAO.updateStateById(rbacAdmin.getId(), now, stateEnum, EnableStateEnum.getEnum(rbacAdmin.getState()));

        rbacAdmin.setState(stateEnum.name());

        rbacAdmin.setUpdateTime(now);

        return rbacAdmin;
    }

    /**
     * 检查 修改者 是否有修改 code 对应管理员的权限
     *
     * @param code
     * @param editorAdmin 修改者
     * @return
     */
    private RbacAdmin checkAdminPermission(String code, RbacAdmin editorAdmin) {
        if (StringUtils.isBlank(code)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("管理员编码"));
        }

        Map<String, Object> params = new HashMap<>();
        params.put("code", code);
        RbacAdmin rbacAdmin = rbacAdminDAO.load(params);
        if (null == rbacAdmin) {
            throw new BaseException(ExceptionEnums.objIsNotExist("管理员"));
        }

        // 如果修改对象是超级管理员，仅允许超管自己修改
        RbacUtil.checkAdminPermission(rbacAdmin, editorAdmin);
        return rbacAdmin;
    }

    /**
     * 根据管理员编码查询详情
     *
     * @param code 管理员编码
     * @return RbacAdmin
     */
    @Override
    public RbacAdmin loadByCode(String code) {
        if (StringUtils.isBlank(code)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("管理员编码"));
        }
        return rbacAdminDAO.loadByCode(code);
    }

    /**
     * 加载一个对象RbacAdmin
     *
     * @param id 主键ID
     * @return RbacAdmin
     */
    @Override
    public RbacAdmin load(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacAdminDAO.load(param);
    }

    /**
     * 加载一个对象RbacAdmin,(将查询关联数据)
     *
     * @param id 主键ID
     * @return RbacAdmin
     */
    @Override
    public RbacAdmin get(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return rbacAdminDAO.getDetail(id);
    }

    /**
     * 加载一个对象RbacAdmin 通过id
     *
     * @param id 主键ID
     * @return RbacAdmin
     */
    @Override
    public RbacAdmin loadById(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.paramIsInvalid(""));
        }
        return rbacAdminDAO.loadById(id);
    }


    /**
     * 查询RbacAdmin分页
     *
     * @param rbacAdmin 对象
     * @param offset    查询开始行
     * @param limit     查询行数
     * @return List<RbacAdmin>
     */
    @Override
    public List<RbacAdmin> list(RbacAdmin rbacAdmin, int offset, int limit) {
        if (offset < 0) {
            offset = 0;
        }

        if (limit < 0) {
            limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (rbacAdmin != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacAdmin, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacAdminDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public int count(RbacAdmin rbacAdmin) {
        Map<String, Object> map = null;
        if (rbacAdmin != null) {
            map = JSON.parseObject(JSON.toJSONString(rbacAdmin, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return rbacAdminDAO.count(map);
    }

        /**
        * 查询管理员的所有权限
        *
        * @param admin
        */
        @Override
        public List<RbacPermissionMenu> queryMyPermissionMenuList(RbacAdmin admin) {
            if (null == admin) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("管理员"));
            }

            // 查询管理员拥有的权限
            List<RbacPermission> permissionList = queryAdminPermissions(admin);

                // 权限资源集合转权限菜单集合
                return RbacPermission.permissionList2MenuList(permissionList);
                }

                /**
                * 查询管理员的所有权限-树结构
                *
                * @param admin
                * @return
                */
                @Override
                public List<TreeMenuNodeVO> queryMyPermissionMenuTreeList(RbacAdmin admin) {
                    if (null == admin) {
                    throw new BaseException(ExceptionEnums.paramIsEmpty("管理员"));
                    }

                    // 查询管理员拥有的权限
                    List<RbacPermission> permissionList = queryAdminPermissions(admin);

                        // 处理排序问题
                        Collections.sort(permissionList, new Comparator<RbacPermission>() {
                            @Override
                            public int compare(RbacPermission o1, RbacPermission o2) {
                            return o1.getRbacPermissionMenu().getSort().compareTo(o2.getRbacPermissionMenu().getSort());
                            }
                            });

                            // 转换权限集合为权限树
                            return TreeMenuNodeVO.permissionListToTree(permissionList);
                            }

    /**
    * 查询管理员拥有的权限
    *
    * @param admin
    * @return
    */
    private List<RbacPermission> queryAdminPermissions(RbacAdmin admin) {
        List<RbacPermission> permissionList = null;

        // 如果是超级管理员，则返回所有权限
        if (AdminTypeEnum.SUPER.equals(AdminTypeEnum.getEnum(admin.getType()))) {
        Map<String, Object> params = new HashMap<>();
        params.put("state", EnableStateEnum.enable.name());
        permissionList = permissionDAO.list(params);
        } else {

        // 查询出自己拥有的所有角色
        List<Long> roleIds = adminRoleRelationDAO.listAdminRoleIds(admin.getCode());
        if (null == roleIds || roleIds.size() == 0) {
        return null;
        }

        // 根据多角色查询绑定的所有权限
        permissionList = rolePermissionRelationSV.queryRolePermissions(roleIds);
        }
        return permissionList;
    }
}