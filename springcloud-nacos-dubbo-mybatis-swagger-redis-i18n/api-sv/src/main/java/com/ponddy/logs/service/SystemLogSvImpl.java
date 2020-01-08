package com.ponddy.logs.service;

import com.alibaba.dubbo.config.annotation.Service;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.baidu.fsg.uid.UidGenerator;
import com.ponddy.core.base.BaseDAO;
import com.ponddy.core.base.BaseSVImpl;
import com.ponddy.core.entity.BeanRet;
import com.ponddy.core.entity.Page;
import com.ponddy.core.enums.ActionTypeEnum;
import com.ponddy.core.enums.HttpCodeEnum;
import com.ponddy.core.enums.RoleTypeEnum;
import com.ponddy.core.exceptions.BaseException;
import com.ponddy.core.tools.Executors;
import com.ponddy.logs.dao.SystemLogDAO;
import com.ponddy.logs.entity.SystemLog;
import com.ponddy.logs.utils.RequestUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.ponddy.core.exceptions.BaseException.ExceptionEnums;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/12/31 16:29
 * @Description:
 */

@Slf4j
@Component
@Service(version = "${dubbo.provider.version}")
public class SystemLogSvImpl extends BaseSVImpl<SystemLog, Long> implements SystemLogSv {

    @Autowired
    private SystemLogDAO systemLogDAO;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return systemLogDAO;
    }

    /**
     * 保存account对象
     *
     * @param entity 实体
     * @throws BaseException
     */
    @Override
    public void save(SystemLog entity) throws BaseException {
        entity.setCreateTime(new Date());
        super.save(entity);
    }

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
    @Override
    public void addLogWithLogin(RoleTypeEnum roleType, String roleCode, String roleName, HttpServletRequest request, Class<?> clazz, String classMethodName) {
        this.addLog(roleType, roleCode, roleName, ActionTypeEnum.login, String.format("%s登录", roleType.val), HttpCodeEnum.code_200, request, clazz, classMethodName);
    }

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
    @Override
    public void addLog(RoleTypeEnum roleType, String roleCode, String roleName, ActionTypeEnum type, String description, HttpCodeEnum httpCodeEnum, HttpServletRequest request) {
        this.addLog(roleType, roleCode, roleName, type, description, httpCodeEnum, request, null);
    }

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
    @Override
    public void addLog(RoleTypeEnum roleType, String roleCode, String roleName, ActionTypeEnum type, String description,
                       HttpCodeEnum httpCodeEnum, HttpServletRequest request, Class<?> clazz) {
        this.addLog(roleType, roleCode, roleName, type, description, httpCodeEnum, request, clazz, null);
    }

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
    @Override
    public void addLog(RoleTypeEnum roleType, String roleCode, String roleName, ActionTypeEnum type, String description,
                       HttpCodeEnum httpCodeEnum, HttpServletRequest request, Class<?> clazz, String classMethodName) {
        // 线程添加日志
        Executors.fixedThreadExecutor(new Runnable() {
            @Override
            public void run() {
                SystemLog systemLog = new SystemLog(roleType, roleCode, roleName, type, description, httpCodeEnum);

                systemLog.setClassName(null == clazz ? "" : clazz.getName());
                systemLog.setClassMethod(StringUtils.isBlank(classMethodName) ? "" : classMethodName);

                // 获取请求的客户端信息，并装箱至系统日志
                RequestUtil.getRequestClientInfo(systemLog, request);

                systemLogDAO.insert(systemLog);
            }
        });

    }

    /**
     * 加载一个对象SystemLogs
     *
     * @param id 主键id
     * @return SystemLog
     */
    @Override
    public SystemLog load(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.param_is_null, "id");
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return systemLogDAO.load(param);
    }

    /**
     * 删除对象SystemLogs
     *
     * @param id 主键id
     * @return SystemLog
     */
    @Override
    public void delete(Long id) {
        if (id == null) {
            throw new BaseException(ExceptionEnums.param_is_null, "id");
        }
        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        systemLogDAO.delete(param);
    }


    /**
     * 查询SystemLogs分页
     *
     * @param systemLog 对象
     * @param offset    查询开始行
     * @param limit     查询行数
     * @return List<SystemLog>
     */
    @Override
    public List<SystemLog> list(SystemLog systemLog, int offset, int limit) {
        if (offset < 0) {
            offset = 0;
        }

        if (limit < 0) {
            limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (systemLog != null) {
            map = JSON.parseObject(JSON.toJSONString(systemLog, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        map.put("sortColumns", "id desc");
        return systemLogDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public BeanRet listReturn(SystemLog systemLog, int offset, int limit) throws BaseException{
        if (offset < 0) {
            offset = 0;
        }

        if (limit < 0) {
            limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (systemLog != null) {
            map = JSON.parseObject(JSON.toJSONString(systemLog, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        map.put("sortColumns", "id desc");
        List<SystemLog> list = systemLogDAO.list(map, new RowBounds(offset, limit));
        return BeanRet.create(true, ExceptionEnums.success, list);
    }

    @Override
    public int count(SystemLog systemLog) throws BaseException {
        Map<String, Object> map = null;
        if (systemLog != null) {
            map = JSON.parseObject(JSON.toJSONString(systemLog, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return systemLogDAO.count(map);
    }
}