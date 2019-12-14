/*
 * ${copyright}
 */
package ${basePackage}.core.jwt;

import com.alibaba.fastjson.JSON;
import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTCreator;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.exceptions.JWTDecodeException;
import com.auth0.jwt.exceptions.JWTVerificationException;
import com.auth0.jwt.impl.PublicClaims;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import com.google.common.collect.Maps;
import ${basePackage}.core.enums.RoleTypeEnum;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.tools.CookieUtil;
import ${basePackage}.core.tools.DateTools;
import ${basePackage}.core.jwt.vo.Account;
import ${basePackage}.rbac.entity.RbacAdmin;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Map;

/**
 * jwt工具类
 */
@Slf4j
@Component
@ConfigurationProperties(prefix = "jwt")
public class JWTTools {
    //平台密钥
    @Getter
    private static String secret;

    @Getter
    private static String tokenName;

    @Getter
    private static boolean useCookie;

    //自动过期时长
    @Getter
    private static int expiredSeconds;

    /**
     * JWT 加密 的 token 类型
     */
    private static final String tokenType = "TokenType";

    /**
     * 生成jwt token
     *
     * @param params          参数列表
     * @param accountPassword 用户的md5加密的密码
     * @param response        response
     * @return
     */
    public static String genToken(Map<String, String> params, String accountPassword, HttpServletResponse response) {
        String token = null;
        try {
            JWTCreator.Builder builder = JWT.create();
            //将参数放入builder中
            for (String key : params.keySet()) {
                builder.withClaim(key, params.get(key));
            }
            //设置过期时间
            builder.withExpiresAt(DateTools.getSomeOneDate(new Date(), expiredSeconds, DateTools.DateType.second));
            //sign time,生成token的当前时间
            builder.withIssuedAt(new Date());
            //加盐 “平台密钥+用户的md5加密的密码” 进行组合加密
            token = builder.sign(Algorithm.HMAC256(secret + accountPassword));

        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        return token;
    }

    /**
     * 生成jwt token
     *
     * @param account         账号信息
     * @param accountPassword 账号对应密码，用于 JWT 加盐
     * @return
     */
    public static String genToken(Account account, String accountPassword, HttpServletResponse response) {
        Map<String, String> map = Maps.newHashMap();
        //确定token类型
        map.put(tokenType, account.getRoleTypeEnum().name());
        //put token类型 对应的 账号信息
        map.put(account.getRoleTypeEnum().name(), JSON.toJSONString(account));

        //生成并获得token
        String token = genToken(map, accountPassword, response);
        //判断是否将token放入cookie
        if (useCookie) {
            CookieUtil.getInstance().setCookie(account.getRoleTypeEnum().name() + tokenName, token, expiredSeconds, response);
        }
        return token;
    }

    /**
     * 验证token是否合法
     *
     * @param password 账号密码
     * @param token    要验证的token
     * @return boolean
     */
    public static boolean verifyToken(String password, String token) {
        if (StringUtils.isBlank(token)) {
            throw new BaseException(BaseException.ExceptionEnums.token_is_null.codeEnum.description);
        }

        boolean flag = true;
        JWTVerifier verifier;
        try {
            //验证token；结合平台设定的密钥与请求者的密码联合验证
            verifier = JWT.require(Algorithm.HMAC256(secret + password)).build();
            verifier.verify(token);
        } catch (UnsupportedEncodingException e) {
            log.error("UnsupportedEncodingException: " + e.getMessage());
            flag = false;
        } catch (JWTVerificationException e) {
            log.error("JWTVerificationException: " + e.getMessage());
            flag = false;
        }
        return flag;
    }

    /**
     * 从token中获取登录对象
     *
     * @param request request对象
     * @param roleTypeEnum
     * @return adminVO
     */
    public static Account decodeTokenToAccount(HttpServletRequest request, RoleTypeEnum roleTypeEnum) {
        Map<String, Claim> claimMap = decodeToken(request, roleTypeEnum);
        //从map对象中取出账号信息
        return decodeTokenToAccount(claimMap);
    }

    /**
     * 从token中获取登录的管理员对象
     *
     * @param request request对象
     * @return adminVO
     */
    public static RbacAdmin decodeTokenToAccountWithAdmin(HttpServletRequest request) {
        // 解码token（管理员），获取内部参数
        Map<String, Claim> claimMap = decodeToken(request, RoleTypeEnum.Admin);
        //从map对象中取出账号信息
        Account<RbacAdmin> account = decodeTokenToAccount(claimMap);
    return JSON.parseObject(JSON.toJSONString(account.getObject()), RbacAdmin.class);
    }

    /**
    * 从token中获取登录的管理员对象
    *
    * @param request request对象
    * @return adminVO
    */
    public static String decodeTokenToAccountWithAdminCode(HttpServletRequest request) {
    return decodeTokenToAccountWithAdmin(request).getCode();
    }

    /**
    * 对象转账号信息
    *
    * @param claimMap 从token中获取登录对象
    * @return adminVO
    */
    @SuppressWarnings(value = "unchecked")
    public static Account decodeTokenToAccount(Map<String, Claim> claimMap) {
    if (claimMap == null) {
    throw new BaseException(BaseException.ExceptionEnums.objIsEmpty("解码 token"));
    }

    //取出过期时间信息，与当前时间进行比较
    Date expiredTime = claimMap.get(PublicClaims.EXPIRES_AT).asDate();
    if (expiredTime.compareTo(new Date()) <= 0) {
    throw new BaseException(BaseException.ExceptionEnums.token_expired);
    }

    //取得token类型
    Claim tokenType = claimMap.get(JWTTools.tokenType);
    //通过token类型，取得对应的账号信息
    Claim claim = claimMap.get(tokenType.asString());
    if (claim == null) {
    throw new BaseException(BaseException.ExceptionEnums.objIsEmpty("解码 token 获取的 Claim"));
    }
    return JSON.parseObject(claim.asString(), Account.class);
    }

    /**
    * 解码token，获取内部参数
    *
    * @param token token
    * @return map
    */
    public static Map<String, Claim> decodeToken(String token) {
    DecodedJWT jwt;
    try {
    jwt = JWT.decode(token);
    } catch (JWTDecodeException e) {
    e.printStackTrace();
    return null;
    }
    return jwt.getClaims();
    }

    /**
    * 解码token，获取内部参数（按角色解码）
    *
    * @param request request
    * @param roleTypeEnum 角色
    * @return map
    */
    private static Map<String, Claim> decodeToken(HttpServletRequest request, RoleTypeEnum roleTypeEnum) {
    // 从request中取出token
    String token = gettoken(request, roleTypeEnum);
    // 解码token，获取内部参数
    return decodeToken(token);
    }

    /**
    * 注销token(仅对保存在cookie的有效)
    *
    * @param response response
    * @param roleTypeEnum 角色枚举
    */
    public static void invalidateToken(HttpServletResponse response, RoleTypeEnum roleTypeEnum) {
    CookieUtil.getInstance().delCookie(roleTypeEnum.name() + tokenName, response);
    }

    /**
    * 从request中取出token
    *
    * @param request request
    * @param roleTypeEnum
    * @return token
    */
    public static String gettoken(HttpServletRequest request, RoleTypeEnum roleTypeEnum) {
    //从header中取出token,若没有，则从cookie中取
    String token = request.getHeader(roleTypeEnum.name() + tokenName);
    //验证请求头 token是否为空
    if (StringUtils.isBlank(token)) {
    //请求头为空，则从cookie中取出token，若不存在，则返回失败
    token = CookieUtil.getInstance().getCookie(roleTypeEnum.name() + tokenName);
    if (StringUtils.isBlank(token)) {
    throw new BaseException(BaseException.ExceptionEnums.token_is_null);
    }
    }
    return token;
    }

    @Value("${r'${jwt.secret}'}")
    public void setSecret(String secret) {
    JWTTools.secret = secret;
    }

    @Value("${r'${jwt.tokenName}'}")
    public void setTokenName(String tokenName) {
    JWTTools.tokenName = tokenName;
    }

    @Value("${r'${jwt.useCookie}'}")
    public void setUseCookie(boolean useCookie) {
    JWTTools.useCookie = useCookie;
    }

    @Value("${r'${jwt.expiredSeconds}'}")
    public void setExpiredSeconds(int expiredSeconds) {
    JWTTools.expiredSeconds = expiredSeconds;
    }
}