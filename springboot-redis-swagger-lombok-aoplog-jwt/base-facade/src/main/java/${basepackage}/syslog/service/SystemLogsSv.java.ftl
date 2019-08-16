/*
 * ${copyright}
 */
package ${basePackage}.syslog.service;

import ${basePackage}.core.base.BaseSV;
import ${basePackage}.syslog.entity.SystemLogs;

import java.util.List;

/**
 * 系统操作日志;
 *
 * @author borong
 */
public interface SystemLogsSv extends BaseSV<SystemLogs, Long> {

    /**
     * 加载一个对象SystemLogs
     *
     * @param id 主键id
     * @return SystemLogs
     */
    SystemLogs load(Long id);

    /**
     * 删除对象SystemLogs
     *
     * @param id 主键id
     * @return SystemLogs
     */
    void delete(Long id);

    /**
     * 查询SystemLogs分页
     *
     * @param systemLogs 系统操作日志;
     * @param offset     查询开始行
     * @param limit      查询行数
     * @return List<SystemLogs>
     */
    List<SystemLogs> list(SystemLogs systemLogs, int offset, int limit);

    int count(SystemLogs systemLogs);
}