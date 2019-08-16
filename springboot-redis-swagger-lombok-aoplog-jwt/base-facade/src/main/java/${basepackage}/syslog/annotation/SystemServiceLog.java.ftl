/*
 * ${copyright}
 */
package ${basePackage}.syslog.annotation;

import java.lang.annotation.*;

/**
 * @Author borong
 * @Date 2019/8/9 17:26
 * @Description: 定义注解，拦截 service
 */
@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.METHOD)
@Documented
public @interface SystemServiceLog {
    /**
     * 定义成员
     *
     * @return
     */
    String description() default "";
}
