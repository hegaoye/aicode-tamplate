/*
* ${copyright}
*/
package ${basePackage};

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

//@EnableScheduling
@SpringBootApplication
public class UserApplication {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

    /**
    * 全局跨域配置
    * 直接上代码，也就提供一个自定义的WebMvcConfigurer bean，该bean的addCorsMappings方法中定义自己的跨域配置。
    * 可以看到我的跨域配置是允许来自http://localhost:6677访问/user/users/*的方法。等程序运行后我们可以发现如果我们的前端使用http://127.0.0.1:6677 或者我们的前端运行在http://localhost:8080都无法通过rest访问对应的API（备注，示例程序提供了/user/users和/user/users/{userId}方法）
    *
    * @return
    */
    /*@Bean
    public WebMvcConfigurer corsConfigurer() {
    return new WebMvcConfigurerAdapter() {
    *//**
    * {@inheritDoc}
    * <p>This implementation is empty.
        *
        * @param registry
        *//*
        @Override
        public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
        .allowedOrigins("127.0.0.1")
        .allowedOrigins("http://192.168.10.163:8762")
        .allowedOrigins("http://192.168.10.110:8762")
        .allowedOrigins("http://borong.ngrok.ilinm.com:7070")
        .allowedOrigins("http://borong.ngrok.ilinm.com");
        super.addCorsMappings(registry);
        }
        };
        }*/

        /**
        * request请未过滤器
        * 把请求中的流再次写入请求，以防止读取一次后因流关闭数据丢失的情况
        * @return
        */
        /*@Bean
        public FilterRegistrationBean httpServletRequestReplacedRegistration() {

        FilterRegistrationBean registration = new FilterRegistrationBean();
        registration.setFilter(new HttpServletRequestReplacedFilter());
        registration.addUrlPatterns("/*");
        registration.addInitParameter("paramName", "paramValue");
        registration.setName("httpServletRequestReplacedFilter");
        registration.setOrder(1);
        return registration;
        }*/
}
