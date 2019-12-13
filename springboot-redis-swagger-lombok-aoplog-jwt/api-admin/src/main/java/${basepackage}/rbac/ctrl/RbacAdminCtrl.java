/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. http://www.rzhkj.com/ 郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担. 本代码仅用于练手学习.
 */
package ${basePackage}.ctrl;

${basePackage}.core.base.BaseCtrl;
${basePackage}.core.entity.BeanRet;
${basePackage}.core.entity.Page;
${basePackage}.core.enums.ActionTypeEnum;
${basePackage}.core.enums.RoleTypeEnum;
${basePackage}.core.exceptions.BaseException;
${basePackage}.core.jwt.JWTTools;
${basePackage}.core.redis.RedisUtils;
${basePackage}.core.tools.ObjectTools;
${basePackage}.rbac.entity.RbacAdmin;
${basePackage}.rbac.entity.RbacPermissionMenu;
${basePackage}.rbac.entity.RbacRole;
${basePackage}.rbac.service.RbacAdminRoleRelationSV;
${basePackage}.rbac.service.RbacAdminSV;
${basePackage}.rbac.service.RbacRoleSV;
${basePackage}.rbac.vo.RbacAdminVO;
${basePackage}.rbac.vo.TreeMenuNodeVO;
${basePackage}.syslog.annotation.SystemControllerLog;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import springfox.documentation.annotations.ApiIgnore;

import javax.annotation.Resource;
import java.util.Arrays;
import java.util.List;

/**
 * 权限系统-管理员（授权用户） 控制器
 *
 * @author borong
 */
@RestController
@RequestMapping("/rbac/admin")
@Slf4j
@Api(tags = "AdminCtrl", description = "权限系统-管理员（授权用户）控制器")
public class RbacAdminCtrl extends BaseCtrl {

    @Resource
    protected RedisUtils redisUtils;
    @Autowired
    private RbacAdminSV rbacAdminSV;
    @Autowired
    private RbacAdminRoleRelationSV rbacAdminRoleRelationSV;
    @Autowired
    private RbacRoleSV rbacRoleSV;

    /**
     * 查询管理员的详情
     *
     * @param code 管理员编码
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询管理员的详情")
    @ApiOperation(value = "查询管理员的详情", notes = "查询管理员的详情")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "code", value = "管理员编码", dataType = "java.lang.String", paramType = "query", required = true)
    })
    @GetMapping(value = "/load")
    @ResponseBody
    public BeanRet load(String code) {
        RbacAdmin rbacAdmin = rbacAdminSV.loadByCode(code);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, ObjectTools.toVo(rbacAdmin, RbacAdminVO.class));
    }

    /**
     * 查询管理员信息集合
     *
     * @return 分页对象
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询管理员信息集合")
    @ApiOperation(value = "查询管理员信息集合", notes = "查询管理员信息集合")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "curPage", value = "当前页", required = true, paramType = "query", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", required = true, paramType = "query", defaultValue = "10"),

            @ApiImplicitParam(name = "createTimeBegin", value = "创建时间", paramType = "query"),
            @ApiImplicitParam(name = "createTimeEnd", value = "创建时间", paramType = "query"),
            @ApiImplicitParam(name = "updateTimeBegin", value = "更新时间", paramType = "query"),
            @ApiImplicitParam(name = "updateTimeEnd", value = "更新时间", paramType = "query")
    })
    @GetMapping(value = "/list")
    @ResponseBody
    public BeanRet list(@ApiIgnore RbacAdmin rbacAdmin, @ApiIgnore Page<RbacAdminVO> page) {
        if (page == null) {
            return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty("分页设置"));
        }
        List<RbacAdmin> rbacAdmins = rbacAdminSV.list(rbacAdmin, page.genRowStart(), page.getPageSize());
        int total = rbacAdminSV.count(rbacAdmin);
        page.setTotalRow(total);
        page.setVoList(ObjectTools.convertList(rbacAdmins, RbacAdminVO.class));
        return BeanRet.create(true, BaseException.ExceptionEnums.success, "", page);
    }

    /**
     * 添加管理员
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.add, roleType = RoleTypeEnum.Admin, description = "添加管理员")
    @ApiOperation(value = "添加管理员", notes = "添加管理员")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "account", value = "自定义登录账号 (长度限制5-16位，字母开头+数字)", paramType = "query"),
            @ApiImplicitParam(name = "phone", value = "手机号码（仅支持11位手机号）", paramType = "query"),
            @ApiImplicitParam(name = "email", value = "邮箱账号", paramType = "query"),
            @ApiImplicitParam(name = "idcard", value = "身份证号", paramType = "query"),
            @ApiImplicitParam(name = "password", value = "密码：字母数字，长度6-20", paramType = "query", required = true),
            @ApiImplicitParam(name = "name", value = "管理员名称", paramType = "query", required = true),
    })
    @PostMapping("/add")
    @ResponseBody
    public BeanRet add(String account, String phone, String email, String idcard, String password, String name) {

        RbacAdmin creatorAdmin = JWTTools.decodeTokenToAccountWithAdmin(request);

        RbacAdmin rbacAdmin = rbacAdminSV.addAdmin(account, phone, email, idcard, password, name, creatorAdmin);

        return BeanRet.create(true, BaseException.ExceptionEnums.success, ObjectTools.toVo(rbacAdmin, RbacAdminVO.class));
    }

    /**
     * 修改管理员信息
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.edit, roleType = RoleTypeEnum.Admin, description = "修改管理员信息")
    @ApiOperation(value = "修改管理员信息", notes = "修改管理员信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "code", value = "管理员编码", paramType = "query", required = true),
            @ApiImplicitParam(name = "account", value = "自定义登录账号 (长度限制5-16位，字母开头+数字)", paramType = "query"),
            @ApiImplicitParam(name = "phone", value = "手机号码（仅支持11位手机号）", paramType = "query"),
            @ApiImplicitParam(name = "email", value = "邮箱账号", paramType = "query"),
            @ApiImplicitParam(name = "idcard", value = "身份证号", paramType = "query"),
            @ApiImplicitParam(name = "password", value = "密码：字母数字，长度6-20", paramType = "query"),
            @ApiImplicitParam(name = "name", value = "管理员名称", paramType = "query"),
    })
    @PostMapping("/edit")
    @ResponseBody
    public BeanRet edit(String code, String account, String phone, String email, String idcard, String password, String name) {

        RbacAdmin editorAdmin = JWTTools.decodeTokenToAccountWithAdmin(request);
        // 修改管理员信息
        RbacAdmin rbacAdmin = rbacAdminSV.editAdmin(code, account, phone, email, idcard, password, name, editorAdmin);

        return BeanRet.create(true, BaseException.ExceptionEnums.success, ObjectTools.toVo(rbacAdmin, RbacAdminVO.class));
    }

    /**
     * 修改自己的登录密码
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.edit, roleType = RoleTypeEnum.Admin, description = "修改自己的登录密码")
    @ApiOperation(value = "修改自己的登录密码", notes = "修改自己的登录密码")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "oldPwd", value = "老密码：字母数字，长度6-20", paramType = "query", required = true),
            @ApiImplicitParam(name = "newPwd", value = "新密码：字母数字，长度6-20", paramType = "query", required = true),
    })
    @PostMapping("/password/edit")
    @ResponseBody
    public BeanRet editPassword(String oldPwd, String newPwd) {

        RbacAdmin editorAdmin = JWTTools.decodeTokenToAccountWithAdmin(request);
        // 修改自己的登录密码
        rbacAdminSV.editPassword(editorAdmin, oldPwd, newPwd);

        return BeanRet.create(true, BaseException.ExceptionEnums.success);
    }

    /**
     * 检查账号是否重复
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "检查账号是否重复")
    @ApiOperation(value = "检查账号是否重复", notes = "检查账号是否重复")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "account", value = "自定义登录账号|手机号|邮箱", paramType = "query", dataType = "string", required = true),
    })
    @GetMapping("/account/repeat/check")
    @ResponseBody
    public BeanRet checkAccountIsRepeat(String account) {

        rbacAdminSV.checkAccountIsRepeat(account, null);

        return BeanRet.create(true, BaseException.ExceptionEnums.success);
    }

    /**
     * 变更管理员的启用状态
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.edit, roleType = RoleTypeEnum.Admin, description = "变更管理员的启用状态")
    @ApiOperation(value = "变更管理员的启用状态", notes = "变更管理员的启用状态")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "code", value = "管理员编码", dataType = "java.lang.String", paramType = "query", required = true)
    })
    @PutMapping("/state/toggle")
    @ResponseBody
    public BeanRet updateEnableState(String code) {
        RbacAdmin editorAdmin = JWTTools.decodeTokenToAccountWithAdmin(request);

        RbacAdmin rbacAdmin = rbacAdminSV.updateEnableState(code, editorAdmin);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, ObjectTools.toVo(rbacAdmin, RbacAdminVO.class));
    }

    /**
     * 查询自己的所有权限菜单
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询自己的所有权限菜单")
    @ApiOperation(value = "查询自己的所有权限菜单", notes = "查询自己的所有权限菜单")
    @ApiImplicitParams({
    })
    @GetMapping(value = "/permission/menu/query")
    @ResponseBody
    public BeanRet queryMyPermissionMenuList() {
        RbacAdmin admin = JWTTools.decodeTokenToAccountWithAdmin(request);
        List<RbacPermissionMenu> menuList = rbacAdminSV.queryMyPermissionMenuList(admin);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, menuList);
    }

    /**
     * 查询自己的所有权限菜单-树结构
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询自己的所有权限菜单-树结构")
    @ApiOperation(value = "查询自己的所有权限菜单-树结构", notes = "查询自己的所有权限菜单-树结构")
    @ApiImplicitParams({
    })
    @GetMapping(value = "/permission/menu/tree/query")
    @ResponseBody
    public BeanRet queryMyPermissionMenuTreeList() {
        RbacAdmin admin = JWTTools.decodeTokenToAccountWithAdmin(request);
        List<TreeMenuNodeVO> menuList = rbacAdminSV.queryMyPermissionMenuTreeList(admin);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, menuList);
    }

    /**
     * 为管理员绑定角色
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.add, roleType = RoleTypeEnum.Admin, description = "为管理员绑定角色")
    @ApiOperation(value = "为管理员绑定角色", notes = "为管理员绑定角色")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "code", value = "管理员编码", paramType = "query", dataType = "string", required = true),
            @ApiImplicitParam(name = "roleIds", value = "角色id 数组结构；", paramType = "query", dataType = "long", allowMultiple = true, required = true),
    })
    @PostMapping("/role/bind")
    @ResponseBody
    public BeanRet bind(String code, Long[] roleIds) {
        // 防止绑定角色为空
        if (null == roleIds) {
            roleIds = new Long[0];
        }
        RbacAdmin rbacAdmin = JWTTools.decodeTokenToAccountWithAdmin(request);
        rbacAdminRoleRelationSV.bindRoleAndPermission(code, Arrays.asList(roleIds), rbacAdmin);
        return BeanRet.create(true, BaseException.ExceptionEnums.success);
    }

    /**
     * 查询所有角色，并标记管理员拥有的角色
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询所有角色，并标记管理员拥有的角色")
    @ApiOperation(value = "查询所有角色，并标记管理员拥有的角色", notes = "查询所有角色，并标记管理员拥有的角色；\n checkbox 复选框-选择状态枚举：[枚举编号：1009](/resources/enum/1009)")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "code", value = "管理员编码", paramType = "query", dataType = "string", required = true),
    })
    @PostMapping("/role/checkbox/query")
    @ResponseBody
    public BeanRet queryRolePermissionAndMarkCheckbox(String code) {
        List<RbacRole> rbacRoleList = rbacRoleSV.queryAllRoleAndMarkAdmin(code);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, rbacRoleList);
    }
}