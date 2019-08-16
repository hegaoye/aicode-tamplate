/*
 * ${copyright}
 */
package ${basePackage}.core.interceptor;

import com.alibaba.fastjson.JSON;
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
 * 用户登录拦截器
 */
@Component
@Slf4j
public class UserLoginInterceptor implements HandlerInterceptor {
    @Resource
    private RedisTemplate<String, Object> redisTemplate;
    @Resource(name = "redisTemplate")
    private HashOperations<String, String, Object> hashOperations;

    @Resource
    private LoginInterceptorTools loginInterceptorTools;

    /**
     * 预处理回调方法,实现处理器的预处理，第三个参数为响应的处理器,自定义Controller,
     * 返回值为true表示继续流程（如调用下一个拦截器或处理器）或者接着执行
     * postHandle()和afterCompletion()；false表示流程中断，不会继续调用其他的拦截器或处理器，中断执行。
     * @param request
     * @param response
     * @param handler
     *
     * @return
     * @throws Exception
     */
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug(">>> Into UserLoginInterceptor >>> ");
        }

        //验证请求token
        boolean result = loginInterceptorTools.verifyToken(request, handler, RoleTypeEnum.User);

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
        return result;
    }

    /**
     * 后处理回调方法，实现处理器的后处理（DispatcherServlet进行视图返回渲染之前进行调用），
     * 此时我们可以通过modelAndView（模型和视图对象）对模型数据进行处理或对视图进行处理，modelAndView也可能为null。
     * @param request
     * @param response
     * @param handler
     * @param modelAndView
     * @throws Exception
     */
    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("postHandle: " + "request = [" + request + "], response = [" + response + "], handler = [" + handler + "], modelAndView = [" + modelAndView + "]");
            log.debug("modelAndView: " + JSON.toJSONString(modelAndView));
        }
    }

    /**
     * 整个请求处理完毕回调方法,该方法也是需要当前对应的Interceptor的preHandle()的返回值为true时才会执行，
     * 也就是在DispatcherServlet渲染了对应的视图之后执行。用于进行资源清理。整个请求处理完毕回调方法。
     * 如性能监控中我们可以在此记录结束时间并输出消耗时间，还可以进行一些资源清理，
     * 类似于try-catch-finally中的finally，但仅调用处理器执行链中
     *
     * @param request
     * @param response
     * @param handler
     * @param ex
     * @throws Exception
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        if (log.isDebugEnabled()) {
            log.debug("afterCompletion: request = [" + request + "], response = [" + response + "], handler = [" + handler + "], ex = [" + ex + "]");
        }

        response.setHeader("Access-Control-Allow-Credentials", "false");
        response.setHeader("Access-Control-Allow-Headers", "UserAuthorization, Content-Type, X-Requested-With, token");
        response.setHeader("Access-Control-Request-Headers", "UserAuthorization, Content-Type, X-Requested-With, token");
        response.setHeader("Access-Control-Allow-Methods", "GET, HEAD, OPTIONS, POST, PUT, DELETE");
        response.setHeader("Access-Control-Request-Method", "GET, HEAD, OPTIONS, POST, PUT, DELETE");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Max-Age", "3600");
    }


}