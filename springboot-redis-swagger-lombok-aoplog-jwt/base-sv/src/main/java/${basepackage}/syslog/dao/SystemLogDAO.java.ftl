/*
 * ${copyright}
 */
package ${basePackage}.syslog.dao;

import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.syslog.entity.SystemLog;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * 系统操作日志;
 *
 * @author borong
 */
@Mapper
@Repository
public  interface SystemLogDAO extends BaseDAO<SystemLog, Long> {

    /**
     * 删除对象SystemLogs
     *@param params 实体的属性
     */
     void delete(Map<String, Object> params);

   /**
    * 查询SystemLogs列表
    * @param rowBounds 分页参数
    * @return List<SystemLog>
    */
    List<SystemLog> list(RowBounds rowBounds);
}
