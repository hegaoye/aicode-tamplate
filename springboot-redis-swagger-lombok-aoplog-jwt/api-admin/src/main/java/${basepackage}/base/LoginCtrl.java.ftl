/*
 * ${copyright}
 */
package ${basePackage}.base;


import ${basePackage}.core.annocation.PassToken;
import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.enums.ActionTypeEnum;
import ${basePackage}.core.enums.RoleTypeEnum;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.jwt.JWTTools;
import ${basePackage}.core.redis.RedisUtils;
import ${basePackage}.rbac.entity.RbacAdmin;
import ${basePackage}.rbac.service.RbacAdminSV;
import ${basePackage}.syslog.annotation.SystemControllerLog;
import ${basePackage}.syslog.service.SystemLogSv;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 管理员表 控制器
 *
 * @author borong
 */
@RestController
@RequestMapping("/admin")
@Slf4j
@Api(tags = "LoginCtrl", description = "登录控制器")
public class LoginCtrl {

    @Resource
    protected RedisUtils redisUtils;

    @Autowired
    private RbacAdminSV rbacAdminSV;

    @Autowired
    private SystemLogSv systemLogsSv;

    /**
     * 管理员登录
     */
//    @SystemControllerLog(actionType = ActionTypeEnum.login, roleType = RoleTypeEnum.Admin, description = "管理员登录")
    @ApiOperation(value = "管理员登录", notes = "管理员登录")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "account", value = "登录账户", dataType = "java.lang.String", paramType = "query", required = true),
            @ApiImplicitParam(name = "password", value = "密码", dataType = "java.lang.String", paramType = "query", required = true)
    })
    @PostMapping(value = "/login")
    @PassToken
    @ResponseBody
    public BeanRet login(String account, String password, HttpServletResponse response, HttpServletRequest request) {
        RbacAdmin admin = rbacAdminSV.loginHandle(account, password, response);

        // 记录登录日志
        systemLogsSv.addLogWithLogin(RoleTypeEnum.Admin, admin.getCode(), request, this.getClass(), "login");
        return BeanRet.create(true, BaseException.ExceptionEnums.success, admin);
    }

    /**
     * 管理员退出登录
     */
    @SystemControllerLog(actionType = ActionTypeEnum.login, roleType = RoleTypeEnum.Admin, description = "管理员退出登录")
    @ApiOperation(value = "管理员退出登录", notes = "管理员退出登录")
    @ApiImplicitParams({
    })
    @PostMapping(value = "/logout")
    @PassToken
    @ResponseBody
    public BeanRet logout(HttpServletResponse response) {
        JWTTools.invalidateToken(response, RoleTypeEnum.Admin);
        return BeanRet.create(true, BaseException.ExceptionEnums.success);
    }


    /**
     * 查询当前登录管理员的信息
     *
     * @return BeanRet
     */
    @SystemControllerLog(actionType = ActionTypeEnum.select, roleType = RoleTypeEnum.Admin, description = "查询当前登录管理员的信息")
    @ApiOperation(value = "查询当前登录管理员的信息", notes = "查询当前登录管理员的信息")
    @ApiImplicitParams({
    })
    @GetMapping(value = "/load")
    @ResponseBody
    public BeanRet load(HttpServletRequest request) {
        RbacAdmin admin = JWTTools.decodeTokenToAccountWithAdmin(request);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, admin);
    }
}