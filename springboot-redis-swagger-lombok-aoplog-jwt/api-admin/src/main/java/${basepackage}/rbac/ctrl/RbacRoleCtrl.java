/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. http://www.rzhkj.com/ 郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担. 本代码仅用于练手学习.
 */
package ${basePackage}.ctrl;

${basePackage}.core.entity.BeanRet;
${basePackage}.core.entity.Page;
${basePackage}.core.enums.ActionTypeEnum;
${basePackage}.core.enums.RoleTypeEnum;
${basePackage}.core.exceptions.BaseException;
${basePackage}.core.redis.RedisUtils;
${basePackage}.rbac.entity.RbacRole;
${basePackage}.rbac.entity.RbacRolePermissionRelation;
${basePackage}.rbac.service.RbacRolePermissionRelationSV;
${basePackage}.rbac.service.RbacRoleSV;
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

import static ${basePackage}.core.exceptions.BaseException.*;
import static ${basePackage}.rbac.common.ConstantsRbac.ID_PRE_PRESET;

/**
 * 权限系统-角色 控制器
 *
 * @author borong
 */
@RestController
@RequestMapping("/rbac/role")
@Slf4j
@Api(tags = "RbacRoleCtrl", description = "权限系统-角色控制器")
public class RbacRoleCtrl {

    @Resource
    protected RedisUtils redisUtils;
    @Autowired
    private RbacRoleSV rbacRoleSV;
    @Autowired
    private RbacRolePermissionRelationSV rbacRolePermissionRelationSV;

    /**
     * 新增角色
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.add, roleType = RoleTypeEnum.Admin, description = "新增角色")
    @ApiOperation(value = "新增角色", notes = "新增角色")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleName", value = "角色名", paramType = "query", required = true),
            @ApiImplicitParam(name = "idPre", value = "上级角色id", paramType = "query", dataType = "long"),
            @ApiImplicitParam(name = "description", value = "描述", paramType = "query"),
    })
    @PostMapping("/add")
    @ResponseBody
    public BeanRet addMenu(String roleName, Long idPre, String description) {

        RbacRole rbacRole = rbacRoleSV.addRole(roleName, idPre, description);

        return BeanRet.create(true, ExceptionEnums.success, rbacRole);
    }

    /**
     * 为角色绑定权限
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.add, roleType = RoleTypeEnum.Admin, description = "为角色绑定权限")
    @ApiOperation(value = "为角色绑定权限", notes = "为角色绑定权限")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleId", value = "角色id", paramType = "query", dataType = "long", required = true),
            @ApiImplicitParam(name = "permissionIds", value = "权限id；权限汇总表id", paramType = "query", dataType = "long", allowMultiple = true, required = true),
    })
    @PostMapping("/permission/bind")
    @ResponseBody
    public BeanRet bind(Long roleId, Long[] permissionIds) {
        // 防止绑定权限为空
        if (null == permissionIds) {
            permissionIds = new Long[0];
        }
        List<RbacRolePermissionRelation> relations = rbacRolePermissionRelationSV.bindRoleAndPermission(roleId, Arrays.asList(permissionIds));
        return BeanRet.create(true, ExceptionEnums.success, relations);
    }

    /**
     * 查询所有权限，并标记角色拥有的权限
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询所有权限，并标记角色拥有的权限")
    @ApiOperation(value = "查询所有权限，并标记角色拥有的权限", notes = "查询所有权限，并标记角色拥有的权限；\n checkbox 复选框-选择状态枚举：[枚举编号：1009](/resources/enum/1009)")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleId", value = "角色id", paramType = "query", dataType = "long", required = true),
    })
    @PostMapping("/permission/checkbox/query")
    @ResponseBody
    public BeanRet queryRolePermissionAndMarkCheckbox(Long roleId) {
        List<TreeMenuNodeVO> treeMenuNodeVOS = rbacRoleSV.queryAllPermissionAndMine(roleId);
        return BeanRet.create(true, ExceptionEnums.success, treeMenuNodeVOS);
    }

    /**
     * 查询角色及拥有权限
     *
     * @param roleId 角色id
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询角色及拥有权限")
    @ApiOperation(value = "查询角色及拥有权限", notes = "查询角色及拥有权限")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleId", value = "角色id", dataType = "java.lang.Long", paramType = "query", required = true)
    })
    @GetMapping(value = "/permission/load")
    @ResponseBody
    public BeanRet loadRoleAndPermission(Long roleId) {
        if (roleId == null) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("角色ID"));
        }
        RbacRole rbacRole = rbacRoleSV.loadRoleAndPermissions(roleId);
        return BeanRet.create(true, ExceptionEnums.success, rbacRole);
    }

    /**
     * 查询角色集合
     *
     * @return 分页对象
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询角色集合")
    @ApiOperation(value = "查询角色集合", notes = "查询角色集合")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "curPage", value = "当前页", required = true, paramType = "query", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", required = true, paramType = "query", defaultValue = "10"),
            @ApiImplicitParam(name = "idPre", value = "上级角色 id；默认查询顶级角色", required = false, paramType = "query", dataType = "long", defaultValue = "0"),
    })
    @GetMapping(value = "/list")
    @ResponseBody
    public BeanRet list(Long idPre, @ApiIgnore Page<RbacRole> page) {
        if (page == null) {
            return BeanRet.create(ExceptionEnums.paramIsEmpty("分页设置"));
        }
        // 默认查询顶级角色
        List<RbacRole> rbacRoles = rbacRoleSV.list(new RbacRole(null == idPre ? ID_PRE_PRESET : idPre), page.genRowStart(), page.getPageSize());
        int total = rbacRoleSV.count(new RbacRole(null == idPre ? ID_PRE_PRESET : idPre));
        page.setTotalRow(total);
        page.setVoList(rbacRoles);
        return BeanRet.create(true, ExceptionEnums.success, "", page);
    }

    /**
     * 根据主键删除角色
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.del, roleType = RoleTypeEnum.Admin, description = "删除角色")
    @ApiOperation(value = "删除角色", notes = "删除角色")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "roleId", value = "角色id", paramType = "query", required = true)
    })
    @DeleteMapping("/delete")
    @ResponseBody
    public BeanRet delete(Long roleId) {
        if (roleId == null) {
            return BeanRet.create(ExceptionEnums.paramIsEmpty("角色ID"));
        }

        rbacRoleSV.delete(roleId);
        return BeanRet.create(true, "删除角色成功");
    }

}