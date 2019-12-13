/*
 * ${copyright}
 */
package ${basePackage}.core.interceptor;

import ${basePackage}.core.annocation.LoginToken;
import ${basePackage}.core.annocation.PassToken;
import ${basePackage}.core.enums.RoleTypeEnum;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.jwt.JWTTools;
import ${basePackage}.core.jwt.vo.Account;
import ${basePackage}.core.redis.RedisKey;
import ${basePackage}.core.redis.RedisUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.method.HandlerMethod;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;

import static ${basePackage}.core.exceptions.BaseException.ExceptionEnums;

/**
 * Created by borong on 2019/5/6 19:45
 * @author borong
 */
@Component
@Slf4j
public class LoginInterceptorTools {

    @Resource
    protected RedisUtils redisUtils;

    /**
     * 验证请求内容，无误返回true
     * @param request
     * @param handler
     * @param roleTypeEnum 角色枚举
     * @return
     */
    public boolean verifyToken(HttpServletRequest request, Object handler, RoleTypeEnum roleTypeEnum) {
        //如果不是映射到方法直接通过
        if (!(handler instanceof HandlerMethod)) {
            return true;
        }

        HandlerMethod handlerMethod = (HandlerMethod) handler;
        Method method = handlerMethod.getMethod();

        //检查是否有 passtoken注释，有则跳过认证
        if (method.isAnnotationPresent(PassToken.class)) {
            PassToken passToken = method.getAnnotation(PassToken.class);
            if (passToken.required()) {
                return true;
            }
        }
        //检查方法体有没有需要用户权限的注解
        if (method.isAnnotationPresent(LoginToken.class)) {
            LoginToken LoginToken = method.getAnnotation(LoginToken.class);
            //如果不需要，则直接返回
            if (!LoginToken.required()) {
                return true;
            }
        }

        //从 http 请求头中取出 token
        String token = JWTTools.gettoken(request, roleTypeEnum);

        //从token中取出账户信息
        Account account = JWTTools.decodeTokenToAccount(JWTTools.decodeToken(token));
        if (account == null) {
            throw new BaseException(ExceptionEnums.token_account_is_null);
        }
        //获得账号中的密码
        String password = getPasswordWithAccount(account, roleTypeEnum);

        //通过缓存的密码；验证 token
        boolean verify = JWTTools.verifyToken(password, token);

        if (!verify) {
            throw new BaseException(ExceptionEnums.token_invalid);
        }

        return true;
    }

    /**
     * 获得账号中的密码，供加盐校验
     * @param account token中账号对象
     * @param roleTypeEnum
     * @return
     */
    private String getPasswordWithAccount(Account account, RoleTypeEnum roleTypeEnum) {
        //获取管理员密码
        if (roleTypeEnum.equals(account.getRoleTypeEnum()) && RoleTypeEnum.Admin.equals(roleTypeEnum)) {

            Object passwordObject = redisUtils.get(RedisKey.genPasswordKey(RoleTypeEnum.Admin, account.getCode(), account.getTimestamp()));
            if (passwordObject != null) {
                return passwordObject.toString();
            }

            throw new BaseException(ExceptionEnums.token_expired);
        }
        //获取用户密码
        if (roleTypeEnum.equals(account.getRoleTypeEnum()) && RoleTypeEnum.User.equals(roleTypeEnum)) {

            Object passwordObject = redisUtils.get(RedisKey.genPasswordKey(RoleTypeEnum.User, account.getCode(), account.getTimestamp()));
            if (passwordObject != null) {
                return passwordObject.toString();
            }

            throw new BaseException(ExceptionEnums.token_expired);
        }

        throw new BaseException(ExceptionEnums.token_invalid);
    }
}
