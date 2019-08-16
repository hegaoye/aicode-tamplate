/*
 * ${copyright}
 */
package ${basePackage}.basic.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.baidu.fsg.uid.UidGenerator;
import ${basePackage}.basic.dao.BasicSettingsDAO;
import ${basePackage}.basic.entity.BasicSettings;
import ${basePackage}.core.base.BaseDAO;
import ${basePackage}.core.base.BaseSVImpl;
import ${basePackage}.core.entity.Page;
import ${basePackage}.core.enums.SettingKeyEnum;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.tools.RegexTools;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static ${basePackage}.core.exceptions.BaseException.ExceptionEnums;

/**
 * @author borong
 */
@Service("basicSettingsSV")
@Slf4j
public class BasicSettingsSVImpl extends BaseSVImpl<BasicSettings, Long> implements BasicSettingsSV {

    @Autowired
    private BasicSettingsDAO basicSettingsDAO;

    @Resource
    private UidGenerator uidGenerator;

    @Override
    protected BaseDAO getBaseDAO() {
        return basicSettingsDAO;
    }

    /**
     * 加载一个对象BasicSettings
     *
     * @param k 键
     * @return BasicSettings
     */
    @Override
    public BasicSettings loadByK(String k) {
        if (StringUtils.isBlank(k)) {
            throw new BaseException(ExceptionEnums.paramIsInvalid("键"));
        }
        return basicSettingsDAO.loadByK(k);
    }

    /**
     * 加载一个对象BasicSettings
     *
     * @param k 键
     * @return BasicSettings
     */
    @Override
    public BasicSettings loadByK(SettingKeyEnum k) {
        if (null == k) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("键"));
        }
        return basicSettingsDAO.loadByK(k.name());
    }

    /**
     * 加载一个对象BasicSettings
     *
     * @param k 键
     * @return BasicSettings
     */
    @Override
    public BigDecimal loadBigDecimalByK(SettingKeyEnum k) {
        BasicSettings settings = loadByK(k);
        if (log.isDebugEnabled()) {
            log.debug(">>> 获取系统配置 [{}]： [{}] >>>", k.name(), JSON.toJSONString(settings));
        }
        if (settings == null || null == settings.getV()) {
            return null;
        }
        if (!RegexTools.isFloat(settings.getV())) {
            return null;
        }
        return new BigDecimal(settings.getV());
    }

    /**
     * 根据主键id 更新 BasicSettings 的状态到另一个状态
     *
     * @param k      键
     * @param v      值
     * @param remark 备注
     */
    @Override
    public BasicSettings insert(String k, String v, String remark) {
        if (StringUtils.isBlank(k)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("键"));
        }

        //检查k是否重复
        BasicSettings basicSettings = basicSettingsDAO.loadByK(k);
        if (basicSettings != null) {
            throw new BaseException(ExceptionEnums.objIsExist("键 " + k));
        }

        if (StringUtils.isBlank(v)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("值"));
        }
        if (StringUtils.isBlank(remark)) {
            remark = "";
        }
        Date now = new Date();
        BasicSettings settings = new BasicSettings(k, v, remark, now, now);
        basicSettingsDAO.insert(settings);
        return settings;
    }

    /**
     * 根据主键id 更新 BasicSettings 的状态到另一个状态
     *
     * @param k      键
     * @param v      值
     * @param remark 备注
     */
    @Override
    public BasicSettings updateByK(String k, String v, String remark) {

        if (StringUtils.isBlank(k)) {
            throw new BaseException(ExceptionEnums.paramIsEmpty("键"));
        }
        //如果都为空，则直接返回
        if (StringUtils.isBlank(v) && StringUtils.isBlank(remark)) {
            return null;
        }

        // 检查要更新的数据字典是否存在
        BasicSettings settings = basicSettingsDAO.loadByK(k);
        if (settings == null) {
            throw new BaseException(ExceptionEnums.objIsNotExist("键 " + k));
        }
        Date now = new Date();
        if (StringUtils.isNotBlank(v)) {
            settings.setV(v);
        }
        if (StringUtils.isNotBlank(remark)) {
            settings.setRemark(remark);
        }
        settings.setUpdateTime(now);
        // 更新键
        basicSettingsDAO.update(settings);
        return settings;
    }

    /**
     * 查询BasicSettings分页
     *
     * @param basicSettings 对象
     * @param offset        查询开始行
     * @param limit         查询行数
     * @return List<BasicSettings>
     */
    @Override
    public List<BasicSettings> list(BasicSettings basicSettings, int offset, int limit) {
        if (offset < 0) {
            offset = 0;
        }

        if (limit < 0) {
            limit = Page.limit;
        }

        Map<String, Object> map = null;
        if (basicSettings != null) {
            map = JSON.parseObject(JSON.toJSONString(basicSettings, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return basicSettingsDAO.list(map, new RowBounds(offset, limit));
    }

    @Override
    public int count(BasicSettings basicSettings) {
        Map<String, Object> map = null;
        if (basicSettings != null) {
            map = JSON.parseObject(JSON.toJSONString(basicSettings, SerializerFeature.WriteDateUseDateFormat));
        } else {
            map = new HashMap<>();
        }
        return basicSettingsDAO.count(map);
    }

    /**
     * 根据多个键查询多个系统配置
     *
     * @param ks
     * @return
     */
    @Override
    public List<BasicSettings> queryByKs(List<String> ks) {
        Map<String, Object> params = new HashMap<>();
        params.put("ks", ks);
        return basicSettingsDAO.list(params);
    }
}
