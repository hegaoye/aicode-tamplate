/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. http://www.rzhkj.com/ 郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担. 本代码仅用于练手学习.
 */
package ${basePackage}.ctrl;

import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.enums.ActionTypeEnum;
import ${basePackage}.core.enums.PermissionTypeEnum;
import ${basePackage}.core.enums.RoleTypeEnum;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.redis.RedisUtils;
import ${basePackage}.rbac.entity.RbacPermission;
import ${basePackage}.rbac.entity.RbacPermissionMenu;
import ${basePackage}.rbac.service.RbacPermissionMenuSV;
import ${basePackage}.rbac.service.RbacPermissionSV;
import ${basePackage}.rbac.vo.TreeMenuNodeVO;
import ${basePackage}.syslog.annotation.SystemControllerLog;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

import static ${basePackage}.core.exceptions.BaseException.ExceptionEnums;

/**
 * 权限系统-权限资源 控制器
 *
 * @author borong
 */
@RestController
@RequestMapping("/rbac/permission")
@Slf4j
@Api(tags = "RbacPermissionCtrl", description = "权限系统-权限资源控制器")
public class RbacPermissionCtrl {

    @Resource
    protected RedisUtils redisUtils;
    @Autowired
    private RbacPermissionSV rbacPermissionSV;

    @Autowired
    private RbacPermissionMenuSV permissionMenuSV;

    /**
     * 查询权限资源-菜单信息
     *
     * @param permissionId 权限id
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询权限资源-菜单信息")
    @ApiOperation(value = "查询权限资源-菜单信息", notes = "查询权限资源-菜单信息")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "permissionId", value = "权限id", dataType = "java.lang.Long", paramType = "query", required = true)
    })
    @GetMapping(value = "/load")
    @ResponseBody
    public BeanRet load(Long permissionId) {
        if (permissionId == null) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("权限id"));
        }
        RbacPermission rbacPermission = rbacPermissionSV.loadById(permissionId);
        return BeanRet.create(true, ExceptionEnums.success, rbacPermission);
    }

    /**
     * 查询权限资源-菜单集合-树结构
     *
     * @return 分页对象
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询权限资源-菜单集合-树结构")
    @ApiOperation(value = "查询权限资源-菜单集合-树结构", notes = "查询权限资源-菜单集合-树结构")
    @ApiImplicitParams({
            /*@ApiImplicitParam(name = "curPage", value = "当前页", required = true, paramType = "query", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", required = true, paramType = "query", defaultValue = "10"),*/
    })
    @GetMapping(value = "/menu/tree/list")
    @ResponseBody
    public BeanRet listMenuTree() {

        List<TreeMenuNodeVO> treeMenuNodeVOS = rbacPermissionSV.queryPermissionTree(PermissionTypeEnum.menu);

        return BeanRet.create(true, ExceptionEnums.success, "", treeMenuNodeVOS);
    }

    /**
     * 查询权限资源-菜单集合
     *
     * @return 分页对象
     */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询权限资源-菜单集合")
    @ApiOperation(value = "查询权限资源-菜单集合", notes = "查询权限资源-菜单集合")
    @ApiImplicitParams({
            /*@ApiImplicitParam(name = "curPage", value = "当前页", required = true, paramType = "query", defaultValue = "1"),
            @ApiImplicitParam(name = "pageSize", value = "分页大小", required = true, paramType = "query", defaultValue = "10"),*/
    })
    @GetMapping(value = "/menu/list")
    @ResponseBody
    public BeanRet listMenu() {

        List<RbacPermissionMenu> rbacPermissionMenus = rbacPermissionSV.queryPermissionMenu();

        return BeanRet.create(true, ExceptionEnums.success, "", rbacPermissionMenus);
    }

    /**
     * 新增基础权限-菜单权限
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.add, roleType = RoleTypeEnum.Admin, description = "新增基础权限-菜单权限")
    @ApiOperation(value = "新增基础权限-菜单权限", notes = "新增基础权限-菜单权限")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "menuName", value = "菜单名", paramType = "query", required = true),
            @ApiImplicitParam(name = "menuHref", value = "菜单链接", paramType = "query", required = true),
            @ApiImplicitParam(name = "idPre", value = "上级菜单id", paramType = "query", dataType = "long"),
            @ApiImplicitParam(name = "menuIcon", value = "菜单图标", paramType = "query"),
            @ApiImplicitParam(name = "description", value = "描述", paramType = "query"),
            @ApiImplicitParam(name = "sort", value = "排序", paramType = "query", dataType = "integer"),
    })
    @PostMapping("/menu/add")
    @ResponseBody
    public BeanRet addMenu(String menuName, String menuHref, Long idPre,
                           String menuIcon, String description, Integer sort) {
        RbacPermission rbacPermission = rbacPermissionSV.insertMenu(menuName, menuHref, idPre, menuIcon, description, sort);
        return BeanRet.create(true, ExceptionEnums.success, rbacPermission);
    }

    /**
     * 修改基础权限-菜单
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.edit, roleType = RoleTypeEnum.Admin, description = "修改基础权限-菜单")
    @ApiOperation(value = "修改基础权限-菜单", notes = "修改基础权限-菜单")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "menuId", value = "菜单ID", paramType = "query", dataType = "long", required = true),
            @ApiImplicitParam(name = "menuName", value = "菜单名", paramType = "query", dataType = "string"),
            @ApiImplicitParam(name = "menuHref", value = "菜单链接", paramType = "query", dataType = "string"),
            @ApiImplicitParam(name = "menuIcon", value = "菜单图标", paramType = "query", dataType = "string"),
            @ApiImplicitParam(name = "description", value = "描述", paramType = "query", dataType = "string"),
            @ApiImplicitParam(name = "sort", value = "排序", paramType = "query", dataType = "integer"),
            @ApiImplicitParam(name = "newParentMenuId", value = "新的上级菜单ID；如果无上级，请填写0；", paramType = "query", dataType = "long"),
    })
    @PostMapping("/menu/edit")
    @ResponseBody
    public BeanRet editMenu(Long menuId, String menuName, String menuHref,
                           String menuIcon, String description, Integer sort, Long newParentMenuId) {
        // 修改基础权限-菜单信息
        RbacPermissionMenu rbacPermissionMenu = permissionMenuSV.updateMenu(menuId, menuName, menuHref, menuIcon, description, sort, newParentMenuId);
        return BeanRet.create(true, ExceptionEnums.success);
    }

    /**
     * 修改基础权限-菜单父级
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.edit, roleType = RoleTypeEnum.Admin, description = "修改基础权限-菜单父级")
    @ApiOperation(value = "修改基础权限-菜单父级", notes = "修改基础权限-菜单父级")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "menuId", value = "菜单ID", paramType = "query", dataType = "long", required = true),
            @ApiImplicitParam(name = "newParentMenuId", value = "新的上级菜单ID；如果无上级，请填写0", paramType = "query", dataType = "long", required = true),
    })
    @PostMapping("/menu/parent/edit")
    @ResponseBody
    public BeanRet editMenuParent(Long menuId, Long newParentMenuId) {
        // 变更菜单的父级与节点状态
        permissionMenuSV.updateMenuParent(menuId, newParentMenuId);
        return BeanRet.create(true, ExceptionEnums.success);
    }

    /**
     * 删除基础权限菜单
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.del, roleType = RoleTypeEnum.Admin, description = "删除基础权限菜单")
    @ApiOperation(value = "删除基础权限菜单", notes = "删除基础权限菜单")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "menuId", value = "菜单ID", paramType = "query", dataType = "long", required = true)
    })
    @DeleteMapping("/menu/delete")
    @ResponseBody
    public BeanRet deleteMenu(Long menuId) {
        if (null == menuId) {
            return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty("菜单id"));
        }

        permissionMenuSV.delete(menuId);
        return BeanRet.create(true, "成功删除基础权限菜单");
    }
}
