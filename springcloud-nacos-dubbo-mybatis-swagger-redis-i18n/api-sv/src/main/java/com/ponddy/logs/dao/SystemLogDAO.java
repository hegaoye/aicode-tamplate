/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.logs.dao;

import com.ponddy.core.base.BaseDAO;
import com.ponddy.logs.entity.SystemLog;
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
public interface SystemLogDAO extends BaseDAO<SystemLog, Long> {

    /**
     * 删除对象SystemLogs
     *
     * @param params 实体的属性
     */
    void delete(Map<String, Object> params);

    /**
     * 查询SystemLogs列表
     *
     * @param rowBounds 分页参数
     * @return List<SystemLog>
     */
    List<SystemLog> list(RowBounds rowBounds);
}
