/*
 * ${copyright}
 */
package ${basePackage}.syslog.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.baidu.fsg.uid.UidGenerator;
import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.core.base.BaseSVImpl;
import ${basePackage}.core.entity.Page;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.syslog.dao.SystemLogsDAO;
import ${basePackage}.syslog.entity.SystemLogs;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author borong
 */
@Slf4j
@Service("systemLogsSV")
public class SystemLogsSvImpl extends BaseSVImpl<SystemLogs, Long> implements SystemLogsSv {

    @Autowired
    private SystemLogsDAO systemLogsDAO;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return systemLogsDAO;
    }

    /**
     * 保存account对象
     *
     * @param entity 实体
     * @throws BaseException
     */
    @Override
    public void save(SystemLogs entity) throws BaseException {
        entity.setCreateTime(new Date());
        super.save(entity);
    }

    /**
     * 加载一个对象SystemLogs
     *
     * @param id 主键id
     * @return SystemLogs
     */
    @Override
    public SystemLogs load(Long id) {
        if (id == null) {
            throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }

        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        return systemLogsDAO.load(param);
    }

    /**
     * 删除对象SystemLogs
     *
     * @param id 主键id
     * @return SystemLogs
     */
    @Override
    public void delete(Long id) {
        if (id == null) {
            throw new BaseException(BaseException.ExceptionEnums.paramIsInvalid(""));
        }
        Map<String, Object> param = new HashMap<>();
        param.put("id", id);
        systemLogsDAO.delete(param);
    }


    /**
     * 查询SystemLogs分页
     *
     * @param systemLogs 对象
     * @param offset     查询开始行
     * @param limit      查询行数
     * @return List<SystemLogs>
     */
    @Override
    public List<SystemLogs> list(SystemLogs systemLogs, int offset, int limit) {
        if (offset < 0) {
            offset = 0;
        }

        if (limit < 0) {
            limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (systemLogs != null) {
            map = JSON.parseObject(JSON.toJSONString(systemLogs, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return systemLogsDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public int count(SystemLogs systemLogs) {
        Map<String, Object> map = null;
        if (systemLogs != null) {
            map = JSON.parseObject(JSON.toJSONString(systemLogs, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return systemLogsDAO.count(map);
    }
}