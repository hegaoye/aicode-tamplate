/*
 * ${copyright}
 */
package ${basePackage}.basic.dao;

import ${basePackage}.basic.entity.BasicSettings;
import ${basePackage}.core.base.BaseDAO;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Map;
import java.util.HashMap;
import java.util.Date;

/**
 * 系统基础关键配置表
 *
 * @author borong
 */
@Mapper
@Repository
public interface BasicSettingsDAO extends BaseDAO<BasicSettings, Long> {

    /**
     * 删除对象BasicSettings
     *
     * @param params 实体的属性
     */
    void delete(Map<String, Object> params);

    /**
     * 查询BasicSettings列表
     *
     * @param rowBounds 分页参数
     * @return List<BasicSettings>
     */
    List<BasicSettings> list(RowBounds rowBounds);

    /**
     * 根据键 查询 数据字典
     * @param k
     * @return
     */
    BasicSettings loadByK(String k);
}
