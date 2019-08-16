/*
 * 仁中和
 */
package ${basePackage}.basic.service;

import ${basePackage}.basic.entity.BasicSettings;
import ${basePackage}.core.base.BaseSV;
import ${basePackage}.core.enums.SettingKeyEnum;

import java.math.BigDecimal;
import java.util.List;

/**
 * 系统基础关键配置表
 *
 * @author borong
 */
public interface BasicSettingsSV extends BaseSV<BasicSettings, Long> {


    /**
     * 加载一个对象BasicSettings
     *
     * @param k 键
     * @return BasicSettings
     */
    BasicSettings loadByK(String k);

    /**
     * 加载一个对象BasicSettings
     *
     * @param k 键
     * @return BasicSettings
     */
    BasicSettings loadByK(SettingKeyEnum k);

    /**
     * 加载一个对象BasicSettings
     *
     * @param k 键
     * @return BasicSettings
     */
    BigDecimal loadBigDecimalByK(SettingKeyEnum k);

    /**
     * 根据主键id 更新 BasicSettings 的状态到另一个状态
     *
     * @param k      键
     * @param v      值
     * @param remark 备注
     */
    BasicSettings insert(String k, String v, String remark);

    /**
     * 根据主键id 更新 BasicSettings 的状态到另一个状态
     *
     * @param k      键
     * @param v      值
     * @param remark 备注
     */
    BasicSettings updateByK(String k, String v, String remark);

    /**
     * 查询BasicSettings分页
     *
     * @param basicSettings 系统基础关键配置表
     * @param offset        查询开始行
     * @param limit         查询行数
     * @return List<BasicSettings>
     */
    List<BasicSettings> list(BasicSettings basicSettings, int offset, int limit);

    int count(BasicSettings basicSettings);


    /**
     * 根据多个键查询多个系统配置
     *
     * @param ks
     * @return
     */
    List<BasicSettings> queryByKs(List<String> ks);
}
