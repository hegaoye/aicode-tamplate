/*
 * ${copyright}
 */
package ${basePackage}.interceptor;

import ${basePackage}.core.enums.RoleTypeEnum;
import ${basePackage}.core.interceptor.LoginInterceptorTools;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.HashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 管理员登录拦截器
 */
@Component
@Slf4j
public class AdminLoginInterceptor implements HandlerInterceptor {
    @Resource
    private RedisTemplate<String, Object> redisTemplate;
    @Resource(name = "redisTemplate")
    private HashOperations<String, String, Object> hashOperations;

    @Resource
    private LoginInterceptorTools loginInterceptorTools;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (log.isDebugEnabled()) {
            log.info(">>> Into AdminLoginInterceptor >>> ");
        }

        //验证请求token
        boolean flag = loginInterceptorTools.verifyToken(request, handler, RoleTypeEnum.Admin);

        //未登录需要跳转的地址
        String loginUri = "/page/login";
        //如果是ajax请求响应头会有，x-requested-with
        if (request.getHeader("x-requested-with") != null && request.getHeader("x-requested-with").equalsIgnoreCase("XMLHttpRequest")) {
            response.setHeader("Content-type", "application/json;charset=UTF-8");
            response.setCharacterEncoding("UTF-8");
            response.setHeader("Location", loginUri);    //跳转登陆页面
            response.setHeader("serverError", "sessionOut");  //session过期
//            response.getWriter().write(JSON.toJSONString(BeanRet.create(false, "登陆已失效，请重新登陆！")));
        }
        return flag;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("postHandle: " + "request = [" + request + "], response = [" + response + "], handler = [" + handler + "], modelAndView = [" + modelAndView + "]");
        }
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("afterCompletion: request = [" + request + "], response = [" + response + "], handler = [" + handler + "], ex = [" + ex + "]");
        }
    }


}