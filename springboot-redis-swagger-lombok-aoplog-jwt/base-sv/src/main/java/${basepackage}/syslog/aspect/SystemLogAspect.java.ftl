/*
 * ${copyright}
 */
package ${basePackage}.syslog.aspect;

import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.enums.ActionTypeEnum;
import ${basePackage}.core.enums.HttpCodeEnum;
import ${basePackage}.core.enums.RoleTypeEnum;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.jwt.JWTTools;
import ${basePackage}.core.jwt.vo.Account;
import ${basePackage}.syslog.annotation.SystemControllerLog;
import ${basePackage}.syslog.service.SystemLogSv;
import lombok.extern.slf4j.Slf4j;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/9 17:30
 * @Description: 定义系统日志切入类
 */
@Slf4j
@Aspect
@Component
@Order(-5)
public class SystemLogAspect {

    @Autowired
    private SystemLogSv systemLogSv;

    /**
     * 定义service切入点拦截规则，拦截 SystemServiceLog 注解的方法
     */
    @Pointcut("@annotation(${basePackage}.syslog.annotation.SystemServiceLog)")
    public void serviceAspect() {
    }

    /**
     * 定义service切入点拦截规则，拦截 SystemControllerLog 注解的方法
     */
    @Pointcut("@annotation(${basePackage}.syslog.annotation.SystemControllerLog)")
    public void controllerAspect() {
    }

    /**
     * 设置拦截到的切面信息 并保存日志
     *
     * @param request
     * @param joinPoint
     * @return
     * @throws Throwable
     */
    private BeanRet setSystemLogs(HttpServletRequest request, ProceedingJoinPoint joinPoint) throws Throwable {


        // 获取并解析 拦截到控制器访问设置的 log 注解
        SystemControllerLog systemControllerLog = getControllerMethodLogAnnotation(joinPoint);

        if (null == systemControllerLog) {
            // 处理如果获取 log 注解 为空
            return BeanRet.create(false, BaseException.ExceptionEnums.server_error);
        }

        // 提取controller中 返回结果 BeanRet 的对象属性
        BeanRet beanRet = (BeanRet) joinPoint.proceed();

        // 如果不在以下预设范围，不增加日志记录
        if (!ActionTypeEnum.isInSet(systemControllerLog.actionType(), ActionTypeEnum.login, ActionTypeEnum.add, ActionTypeEnum.edit, ActionTypeEnum.del)) {
            return beanRet;
        }

        // 获取请求API中传递参数
        List<String> parameters = new ArrayList<>();
    Object[] params = joinPoint.getArgs();
    for (Object param : params) {
    if (param instanceof String
    || param instanceof Integer
    || param instanceof Enum
    || param instanceof Long) {
    parameters.add(param.toString());
    }
    }

    // 获取并保存 访问角色类型
    RoleTypeEnum roleTypeEnum = systemControllerLog.roleType();

    String roleCode = "";
    String roleName = "";
    // 处理并保存 游客访问
    if (RoleTypeEnum.Tourist.equals(roleTypeEnum)) {
    roleCode = request.getSession().getId();
    roleName = RoleTypeEnum.Tourist.val;
    }
    // 处理并保存 角色用户访问
    else {
    Account account = JWTTools.decodeTokenToAccount(request, roleTypeEnum);
    roleCode = account.getCode();
    roleName = account.getName();
    }

    // 保存系统的访问日志
    systemLogSv.addLog(roleTypeEnum, roleCode, roleName, systemControllerLog.actionType(), systemControllerLog.description(),
    HttpCodeEnum.getEnum(beanRet.getCode()), request,
    joinPoint.getTarget().getClass(), joinPoint.getSignature().getName());

    return beanRet;
    }

    /**
    * 拦截控制层的操作日志
    *
    * @param joinPoint
    * @throws Throwable
    */
    @Around("controllerAspect()")
    public BeanRet controllerRecordLog(ProceedingJoinPoint joinPoint) throws Throwable {
    // 获取 Request 请求对象
    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
    return setSystemLogs(request, joinPoint);
    }

    /**
    * 拦截业务层的操作日志
    *
    * @param joinPoint
    * @throws Throwable
    */
    @Deprecated
    @Around("serviceAspect()")
    public void serviceRecordLog(ProceedingJoinPoint joinPoint) throws Throwable {

    // 获取 Request 请求对象
    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

    // 获取并解析 拦截到控制器访问设置的 log 注解
    SystemControllerLog systemControllerLog = getControllerMethodLogAnnotation(joinPoint);
    if (null == systemControllerLog) {
    // 处理如果获取 log 注解 为空
    return;
    }

    // 获取并保存 访问角色类型
    RoleTypeEnum roleTypeEnum = systemControllerLog.roleType();

    String roleCode = "";
    String roleName = "";
    // 处理并保存 游客访问
    if (RoleTypeEnum.Tourist.equals(roleTypeEnum)) {
    roleName = RoleTypeEnum.Tourist.val;
    }
    // 处理并保存 角色用户访问
    else {
    Account account = JWTTools.decodeTokenToAccount(request, roleTypeEnum);
    roleCode = account.getCode();
    roleName = account.getName();
    }

    // 提取controller中 返回结果 BeanRet 的对象属性
    BeanRet beanRet = (BeanRet) joinPoint.proceed();

    Object[] params = joinPoint.getArgs();
    StringBuffer returnString = new StringBuffer();
    for (Object param : params) {
    if (param instanceof String) {
    returnString.append(param);
    } else if (param instanceof Integer) {
    returnString.append(param);
    }
    }

    // 保存系统的访问日志
    systemLogSv.addLog(roleTypeEnum, roleCode, roleName, systemControllerLog.actionType(), systemControllerLog.description(),
    HttpCodeEnum.getEnum(beanRet.getCode()), request,
    joinPoint.getTarget().getClass(), joinPoint.getSignature().getName());
    }

    /**
    * 异常处理
    *
    * @param joinPoint
    * @param throwable
    * @throws Throwable
    */
    @AfterThrowing(pointcut = "controllerAspect()", throwing = "throwable")
    public void doAfterThrowing(JoinPoint joinPoint, Throwable throwable) throws Throwable {

    // 获取 Request 请求对象
    HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();

    // 获取并解析 拦截到控制器访问设置的 log 注解
    SystemControllerLog systemControllerLog = getControllerMethodLogAnnotation(joinPoint);
    if (null == systemControllerLog) {
    // 处理如果获取 log 注解 为空
    return;
    }

    // 获取并保存 访问角色类型
    RoleTypeEnum roleTypeEnum = systemControllerLog.roleType();

    String roleCode = "";
    String roleName = "";

    // 处理并保存 游客访问
    if (RoleTypeEnum.Tourist.equals(roleTypeEnum)) {
    roleName = RoleTypeEnum.Tourist.val;
    }
    // 处理并保存 角色用户访问
    else {
    Account account = JWTTools.decodeTokenToAccount(request, roleTypeEnum);
    roleCode = account.getCode();
    roleName = account.getName();
    }

    // 保存系统的访问日志
    systemLogSv.addLog(roleTypeEnum, roleCode, roleName, systemControllerLog.actionType(),
    String.format("%s [请求异常] 原因：%s", systemControllerLog.description(), throwable.getMessage()),
    HttpCodeEnum.getEnum(HttpCodeEnum.code_33.code), request,
    joinPoint.getTarget().getClass(), joinPoint.getSignature().getName());
    }

    /**
    * 获取controller的操作信息
    *
    * @param joinPoint
    * @return
    */
    public SystemControllerLog getControllerMethodLogAnnotation(ProceedingJoinPoint joinPoint) throws Exception {
    //获取连接点目标类名
    String targetName = joinPoint.getTarget().getClass().getName();
    //获取连接点签名的方法名
    String methodName = joinPoint.getSignature().getName();
    //获取连接点参数
    Object[] args = joinPoint.getArgs();
    //根据连接点类的名字获取指定类
    Class targetClass = Class.forName(targetName);
    //获取类里面的方法
    Method[] methods = targetClass.getMethods();
    SystemControllerLog systemControllerLog = null;
    for (Method method : methods) {
    if (method.getName().equals(methodName)) {
    Class[] clazzs = method.getParameterTypes();
    if (clazzs.length == args.length) {
    systemControllerLog = method.getAnnotation(SystemControllerLog.class);
    break;
    }
    }
    }
    return systemControllerLog;
    }

    /**
    * 获取controller的操作信息
    *
    * @param joinPoint
    * @return
    */
    public SystemControllerLog getControllerMethodLogAnnotation(JoinPoint joinPoint) throws Exception {
    //获取连接点目标类名
    String targetName = joinPoint.getTarget().getClass().getName();
    //获取连接点签名的方法名
    String methodName = joinPoint.getSignature().getName();
    //获取连接点参数
    Object[] args = joinPoint.getArgs();
    //根据连接点类的名字获取指定类
    Class targetClass = Class.forName(targetName);
    //获取类里面的方法
    Method[] methods = targetClass.getMethods();
    SystemControllerLog systemControllerLog = null;
    for (Method method : methods) {
    if (method.getName().equals(methodName)) {
    Class[] clazzs = method.getParameterTypes();
    if (clazzs.length == args.length) {
    systemControllerLog = method.getAnnotation(SystemControllerLog.class);
    break;
    }
    }
    }
    return systemControllerLog;
    }
    }