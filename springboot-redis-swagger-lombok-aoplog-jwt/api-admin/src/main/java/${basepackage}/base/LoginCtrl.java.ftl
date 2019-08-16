/*
 * ${copyright}
 */
package ${basePackage}.base;


import com.alibaba.fastjson.JSON;
import ${basePackage}.admin.entity.Admin;
import ${basePackage}.admin.service.AdminSV;
import ${basePackage}.core.annocation.PassToken;
import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.enums.ActionTypeEnum;
import ${basePackage}.core.enums.RoleTypeEnum;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.jwt.JWTTools;
import ${basePackage}.core.jwt.vo.Account;
import ${basePackage}.core.redis.RedisKey;
import ${basePackage}.core.redis.RedisUtils;
import ${basePackage}.syslog.annotation.SystemControllerLog;
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
@Api(tags = "LoginCtrl", description = "管理员表控制器")
public class LoginCtrl {

    @Resource
    protected RedisUtils redisUtils;
    @Autowired
    private AdminSV adminSV;

    /**
     * 管理员登录
     */
    @SystemControllerLog(actionType = ActionTypeEnum.login, roleType = RoleTypeEnum.Admin, description = "管理员登录")
    @ApiOperation(value = "管理员登录", notes = "管理员登录")
    @ApiImplicitParams({
            @ApiImplicitParam(name = "account", value = "登录账户", dataType = "java.lang.String", paramType = "query", required = true),
            @ApiImplicitParam(name = "password", value = "密码", dataType = "java.lang.String", paramType = "query", required = true)
    })
    @PostMapping(value = "/login")
    @PassToken
    @ResponseBody
    public BeanRet login(String account, String password, HttpServletResponse response) {
        //通过账户和密码查询用户信息
        Admin admin = adminSV.load(account, password);
        if (admin == null) {
            throw new BaseException(BaseException.ExceptionEnums.account_login_error);
        }
        //中转加密后的密码
        password = admin.getPassword();

        //缓存至redis；用于再次请求接口时，jwt验证用户token信息
        redisUtils.set(RedisKey.genPasswordKey(RoleTypeEnum.Admin, admin.getCode()), password);

        //清空用户密码，禁止加密
        admin.setPassword(null);

        log.info("中转密码：" + password);

        //实例化token中包含信息
        Account<Admin> tokenAccount = new Account(admin.getId(), account, admin.getCode(), RoleTypeEnum.Admin, admin);
        //用户账号和密码校验通过后，生成token
        String token = JWTTools.genToken(tokenAccount, password, response);
        //把token放入 header
        response.setHeader(RoleTypeEnum.Admin.name() + JWTTools.getTokenName(), token);

        log.info(JSON.toJSONString(admin));
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
        Admin admin = JWTTools.decodeTokenToAccountWithAdmin(request);
        return BeanRet.create(true, BaseException.ExceptionEnums.success, admin);
    }
}