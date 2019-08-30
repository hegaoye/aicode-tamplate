/*
 * ${copyright}
 */
package ${basePackage}.syslog.annotation;

import ${basePackage}.core.enums.ActionTypeEnum;
import ${basePackage}.core.enums.RoleTypeEnum;

import java.lang.annotation.*;

/**
 *@Author borong
 * @Date 2019/8/9 17:20
 * @Description: 定义注解，拦截controller
 * 三种策略：
 * 1 RetentionPolicy.SOURCE 注解只保留在源文件中，在编译成class文件的时候被遗弃
 * 2 RetentionPolicy.CLASS  注解只被保留在class中，但是在jvm加载的时候被抛弃，这个是默认的声明周期
 * 3 RetentionPolicy.RUNTIME 注解在jvm加载的时候仍被保留
 */
@Retention(RetentionPolicy.RUNTIME) // 元注解，定义注解被保留策略，一般有有三种我策略
@Target({ElementType.METHOD}) // 定义注解声明在哪些元素之前
@Documented
public @interface SystemControllerLog {

    /**
     * 描述
     *
     * @return
     */
    String description() default "";

    /**
     * 操作的类型
     * 1 添加、 2 修改、 3 删除、 4 查询、 5 登录
     *
     * @return
     */
    ActionTypeEnum actionType() default ActionTypeEnum.query;

    /**
     * 角色类型
     *
     * @return
     */
    RoleTypeEnum roleType() default RoleTypeEnum.Admin;
}