/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.logs.service;

import com.ponddy.core.base.BaseSV;
import com.ponddy.core.entity.BeanRet;
import com.ponddy.core.enums.ActionTypeEnum;
import com.ponddy.core.enums.HttpCodeEnum;
import com.ponddy.core.enums.RoleTypeEnum;
import com.ponddy.core.exceptions.BaseException;
import com.ponddy.logs.entity.SystemLog;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 系统操作日志;
 *
 * @author borong
 */
public interface SystemLogSv extends BaseSV<SystemLog, Long> {

    /**
     * 添加登录日志
     *
     * @param roleType        角色类型
     * @param roleCode        角色编码
     * @param roleName
     * @param request         请求对象
     * @param clazz           类名
     * @param classMethodName 方法名
     */
    void addLogWithLogin(RoleTypeEnum roleType, String roleCode, String roleName, HttpServletRequest request, Class<?> clazz, String classMethodName);

    /**
     * 添加系统日志
     *
     * @param roleType
     * @param roleCode
     * @param roleName
     * @param type
     * @param description
     * @param httpCodeEnum
     * @param request
     * @return
     */
    void addLog(RoleTypeEnum roleType, String roleCode, String roleName, ActionTypeEnum type, String description, HttpCodeEnum httpCodeEnum, HttpServletRequest request);

    /**
     * 添加系统日志
     *
     * @param roleType
     * @param roleCode
     * @param roleName
     * @param type
     * @param description
     * @param httpCodeEnum
     * @param request
     * @param clazz        调用此接口的类名（包.类）
     * @return
     */
    void addLog(RoleTypeEnum roleType, String roleCode, String roleName, ActionTypeEnum type, String description, HttpCodeEnum httpCodeEnum, HttpServletRequest request, Class<?> clazz);

    /**
     * 添加系统日志
     *
     * @param roleType
     * @param roleCode
     * @param roleName
     * @param type
     * @param description
     * @param httpCodeEnum
     * @param request
     * @param clazz           调用此接口的类名（包.类）
     * @param classMethodName 调用此接口的方法名
     * @return
     */
    void addLog(RoleTypeEnum roleType, String roleCode, String roleName, ActionTypeEnum type, String description, HttpCodeEnum httpCodeEnum, HttpServletRequest request, Class<?> clazz, String classMethodName);

    /**
     * 加载一个对象SystemLogs
     *
     * @param id 主键id
     * @return SystemLog
     */
    SystemLog load(Long id);

    /**
     * 删除对象SystemLogs
     *
     * @param id 主键id
     * @return SystemLog
     */
    void delete(Long id);

    /**
     * 查询SystemLogs分页
     *
     * @param systemLog 系统操作日志;
     * @param offset    查询开始行
     * @param limit     查询行数
     * @return List<SystemLog>
     */
    List<SystemLog> list(SystemLog systemLog, int offset, int limit);

    BeanRet listReturn(SystemLog systemLog, int offset, int limit) throws BaseException;

    int count(SystemLog systemLog) throws BaseException;
}