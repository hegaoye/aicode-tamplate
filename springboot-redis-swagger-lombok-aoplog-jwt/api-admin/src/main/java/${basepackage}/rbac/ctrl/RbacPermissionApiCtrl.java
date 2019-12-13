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
${basePackage}.rbac.entity.RbacPermissionApi;
${basePackage}.rbac.service.RbacPermissionApiSV;
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
 * 权限系统-权限授权API；每一个权限对应多个授权API请求路径 控制器
 *
 * @author borong
 */
@Slf4j
//@RestController
//@RequestMapping("/rbacPermissionApi")
//@Api(tags = "RbacPermissionApiCtrl", description = "权限系统-权限授权API；每一个权限对应多个授权API请求路径控制器")
public class RbacPermissionApiCtrl {

    @Resource
    protected RedisUtils redisUtils;
    @Autowired
    private RbacPermissionApiSV rbacPermissionApiSV;


   /**
    * 查询RbacPermissionApi一个详情信息
    * @param id 权限授权记录id
    * @return BeanRet
    */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询RbacPermissionApi一个详情信息")
    @ApiOperation(value = "查询RbacPermissionApi一个详情信息", notes = "查询RbacPermissionApi一个详情信息")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "menuId", value = "权限授权记录id",dataType = "java.lang.Long", paramType = "query", required = true)
    })
    @GetMapping(value = "/load")
    @ResponseBody
    public BeanRet load(Long id) {
        if(id==null){
          return null;
        }
    RbacPermissionApi rbacPermissionApi = rbacPermissionApiSV.load(id);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, rbacPermissionApi);
    }


    /**
    * 查询RbacPermissionApi信息集合
    *
    * @return 分页对象
    */
    @SystemControllerLog(actionType = ActionTypeEnum.query, roleType = RoleTypeEnum.Admin, description = "查询RbacPermissionApi信息集合")
    @ApiOperation(value = "查询RbacPermissionApi信息集合", notes = "查询RbacPermissionApi信息集合")
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
    public BeanRet list(@ApiIgnore RbacPermissionApi rbacPermissionApi,@ApiIgnore Page<RbacPermissionApi> page) {
        if(page==null){
            return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty("分页设置"));
        }
        List<RbacPermissionApi> rbacPermissionApis = rbacPermissionApiSV.list(rbacPermissionApi,page.genRowStart(),page.getPageSize());
        int total = rbacPermissionApiSV.count(rbacPermissionApi);
        page.setTotalRow(total);
        page.setVoList(rbacPermissionApis);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, "", page);
    }

    /**
    * 创建RbacPermissionApi
    *
    * @return BeanRet
    */
    @SystemControllerLog(actionType = ActionTypeEnum.add, roleType = RoleTypeEnum.Admin, description = "创建RbacPermissionApi")
    @ApiOperation(value = "创建RbacPermissionApi", notes = "创建RbacPermissionApi")
    @ApiImplicitParams({
                @ApiImplicitParam(name = "menuId", value = "权限授权记录id", paramType = "query"),
                @ApiImplicitParam(name = "permissionId", value = "权限id", paramType = "query"),
                @ApiImplicitParam(name = "actionUrl", value = "功能授权API请求路径", paramType = "query"),
                @ApiImplicitParam(name = "createTime", value = "创建时间", paramType = "query"),
                @ApiImplicitParam(name = "updateTime", value = "更新时间", paramType = "query")
    })
    @PostMapping("/build")
    @ResponseBody
    public BeanRet build(@ApiIgnore RbacPermissionApi rbacPermissionApi) {
        if (StringUtils.isEmpty(rbacPermissionApi.getActionUrl())) {
           return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty("actionUrl"));
        }
        rbacPermissionApiSV.save(rbacPermissionApi);
        return BeanRet.create(true, BaseException.ExceptionEnums.success,rbacPermissionApi);
    }

    /**
    * 根据主键删除RbacPermissionApi
    *
    * @return BeanRet
    */
    @SystemControllerLog(actionType = ActionTypeEnum.del, roleType = RoleTypeEnum.Admin, description = "删除RbacPermissionApi")
    @ApiOperation(value = "删除RbacPermissionApi", notes = "删除RbacPermissionApi")
    @ApiImplicitParams({
        @ApiImplicitParam(name = "menuId", value = "权限授权记录id", paramType = "query", required = true)
    })
    @DeleteMapping("/delete")
    @ResponseBody
    public BeanRet delete(Long id) {
        if (id!=null) {
           return BeanRet.create(BaseException.ExceptionEnums.paramIsEmpty(""));
        }

        rbacPermissionApiSV.delete(id);
        return BeanRet.create(true, "删除RbacPermissionApi成功");
    }

}