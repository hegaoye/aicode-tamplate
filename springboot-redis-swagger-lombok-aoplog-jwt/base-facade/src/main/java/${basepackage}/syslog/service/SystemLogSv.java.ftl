/*
 * ${copyright}
 */
package ${basePackage}.syslog.service;

import ${basePackage}.core.base.BaseSV;
import ${basePackage}.core.enums.ActionTypeEnum;
import ${basePackage}.core.enums.HttpCodeEnum;
import ${basePackage}.core.enums.RoleTypeEnum;
import ${basePackage}.syslog.entity.SystemLog;

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
     *  @param roleType        角色类型
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

    int count(SystemLog systemLog);
    }