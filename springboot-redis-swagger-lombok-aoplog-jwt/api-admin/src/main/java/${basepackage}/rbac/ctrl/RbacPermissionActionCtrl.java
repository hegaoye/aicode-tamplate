/*
* Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. http://www.rzhkj.com/ 郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担. 本代码仅用于练手学习.
*/
package com.rzhkj.nt.ctrl;

${basePackage}.core.entity.BeanRet;
${basePackage}.core.entity.Page;
${basePackage}.core.enums.ActionTypeEnum;
${basePackage}.core.enums.RoleTypeEnum;
${basePackage}.core.exceptions.BaseException;
${basePackage}.core.redis.RedisUtils;
${basePackage}.rbac.entity.RbacPermissionAction;
${basePackage}.rbac.service.RbacPermissionActionSV;
${basePackage}.syslog.annotation.SystemControllerLog;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import springfox.documentation.annotations.ApiIgnore;

import javax.annotation.Resource;
import java.util.List;

/**
 * 权限系统-功能操作权限 控制器
 *
 * @author borong
 */
@Slf4j
//@RestController
//@RequestMapping("/rbacPermissionAction")
//@Api(tags = "RbacPermissionActionCtrl", description = "权限系统-功能操作权限控制器", hidden = true)
public class RbacPermissionActionCtrl {

    @Resource
    protected RedisUtils redisUtils;
    @Autowired
    private RbacPermissionActionSV rbacPermissionActionSV;


   /**
    * 查询RbacPermissionAction一个详情信息
    * @param id 主键ID
    * @return BeanRet
    */
    @SystemControllerLog(actionType = ActionTypeEnum.select, roleType = RoleTypeEnum.Admin, description = "查询RbacPermissionAction一个详情信息")
    @ApiOperation(value = "查询RbacPermissionAction一个详情信息", notes = "查询RbacPermissionAction一个详情信息")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "menuId", value = "主键ID",dataType = "java.lang.Long", paramType = "query", required = true)
    })
    @GetMapping(value = "/load")
    @ResponseBody
    public BeanRet load(Long id) {
        if(id==null){
          return null;
        }
    RbacPermissionAction rbacPermissionAction = rbacPermissionActionSV.load(id);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, rbacPermissionAction);
    }


    /**
    * 查询RbacPermissionAction信息集合
    *
    * @return 分页对象
    */
    @SystemControllerLog(actionType = ActionTypeEnum.select, roleType = RoleTypeEnum.Admin, description = "查询RbacPermissionAction信息集合")
    @ApiOperation(value = "查询RbacPermissionAction信息集合", notes = "查询RbacPermissionAction信息集合")
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
    public BeanRet list(@ApiIgnore RbacPermissionAction rbacPermissionAction,@ApiIgnore Page<RbacPermissionAction> page) {
        if(page==null){
            return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty("分页设置"));
        }
        List<RbacPermissionAction> rbacPermissionActions = rbacPermissionActionSV.list(rbacPermissionAction,page.genRowStart(),page.getPageSize());
        int total = rbacPermissionActionSV.count(rbacPermissionAction);
        page.setTotalRow(total);
        page.setVoList(rbacPermissionActions);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, "", page);
    }

    /**
    * 创建RbacPermissionAction
    *
    * @return BeanRet
    */
    @SystemControllerLog(actionType = ActionTypeEnum.insert, roleType = RoleTypeEnum.Admin, description = "创建RbacPermissionAction")
    @ApiOperation(value = "创建RbacPermissionAction", notes = "创建RbacPermissionAction")
    @ApiImplicitParams({
                @ApiImplicitParam(name = "menuId", value = "主键ID", paramType = "query"),
                @ApiImplicitParam(name = "actionCode", value = "功能权限的唯一识别码（同菜单编码下的功能识别码唯一）", paramType = "query"),
                @ApiImplicitParam(name = "actionName", value = "功能名称", paramType = "query"),
                @ApiImplicitParam(name = "actionIcon", value = "功能图标", paramType = "query"),
                @ApiImplicitParam(name = "description", value = "描述", paramType = "query"),
                @ApiImplicitParam(name = "createTime", value = "创建时间", paramType = "query"),
                @ApiImplicitParam(name = "updateTime", value = "更新时间", paramType = "query")
    })
    @PostMapping("/build")
    @ResponseBody
    public BeanRet build(@ApiIgnore RbacPermissionAction rbacPermissionAction) {
        if (StringUtils.isEmpty(rbacPermissionAction.getActionCode())) {
           return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty("actionCode"));
        }
        if (StringUtils.isEmpty(rbacPermissionAction.getActionName())) {
           return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty("actionName"));
        }
        if (StringUtils.isEmpty(rbacPermissionAction.getActionIcon())) {
           return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty("actionIcon"));
        }
        if (StringUtils.isEmpty(rbacPermissionAction.getDescription())) {
           return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty("description"));
        }
        rbacPermissionActionSV.save(rbacPermissionAction);
        return BeanRet.create(true, BaseException.ExceptionEnums.success,rbacPermissionAction);
    }

    /**
    * 根据主键删除RbacPermissionAction
    *
    * @return BeanRet
    */
    @SystemControllerLog(actionType = ActionTypeEnum.delete, roleType = RoleTypeEnum.Admin, description = "删除RbacPermissionAction")
    @ApiOperation(value = "删除RbacPermissionAction", notes = "删除RbacPermissionAction")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "menuId", value = "主键ID", paramType = "query", required = true)
    })
    @DeleteMapping("/delete")
    @ResponseBody
    public BeanRet delete(Long id) {
        if (id!=null) {
           return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty(""));
        }

        rbacPermissionActionSV.delete(id);
        return BeanRet.create(true, "删除RbacPermissionAction成功");
    }

}