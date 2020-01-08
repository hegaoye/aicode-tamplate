/*
 * ${copyright}
 */
package ${basePackage}.interceptor;

import ${basePackage}.core.interceptor.ContextInterceptor;
import org.springframework.boot.SpringBootConfiguration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import javax.annotation.Resource;

/**
 * Created by borong on 2019/07/30.
 */
@SpringBootConfiguration
public class ContextConfiguration extends WebMvcConfigurerAdapter {

    @Resource
    private ContextInterceptor contextInterceptor;

    @Resource
    private AdminLoginInterceptor adminLoginInterceptor;

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        //全局拦截器
        registry.addInterceptor(contextInterceptor)
        //添加拦截路径
        .addPathPatterns("/**")
        //配置拦截放行路径
        .excludePathPatterns("/swagger-resources/**");

        //管理员登录拦截器
        registry.addInterceptor(adminLoginInterceptor)
        //添加拦截路径
        .addPathPatterns("/**")
        //配置拦截放行路径
        .excludePathPatterns("/admin/login/")
        .excludePathPatterns("/swagger-resources/**");
    }
}
