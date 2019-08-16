/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import java.io.Serializable;

/**
 * @Author borong
 * @Date 2019/6/7 17:52
 * @Description: 时间类查询条件枚举
 * [枚举编号：1007](/resources/enum/1007)
 */
public enum DateQueryEnums implements Serializable {
    /**
     * mysql条件：where to_days(时间字段名) = to_days(now())
     */
    today("今天"),
    /**
     * mysql条件：where to_days(now()) - to_days(时间字段名) = 1
     */
    yesterday("昨天"),
    /**
     * mysql条件：where date_sub(curdate(), interval 7 day) <= date(时间字段名)
     */
    nearly_7_days("近7天"),
    /**
     * mysql条件：where date_sub(curdate(), interval 30 day) <= date(时间字段名)
     */
    nearly_30_days("近30天"),
    /**
     * mysql条件：where date_sub(curdate(), interval 6 month) <= date(时间字段名)
     */
    nearly_6_month("近6个月"),
    /**
     * mysql条件：where yearweek(date_format(时间字段名,'%y-%m-%d')) = yearweek(now())
     */
    this_week("本周"),
    /**
     * mysql条件：where yearweek(date_format(时间字段名,'%y-%m-%d')) = yearweek(now())-1
     */
    last_week("上周"),
    /**
     * mysql条件：where date_format(时间字段名, '%y%m') = date_format(curdate(), '%y%m')
     */
    this_month("本月"),
    /**
     * mysql条件：where period_diff(date_format(now(), '%y%m' ), date_format(时间字段名, '%y%m'))=1
     */
    last_month("上月"),
    /**
     * mysql条件：where quarter(时间字段名)=quarter(now())
     */
    this_quarter("本季度"),
    /**
     * mysql条件：where quarter(时间字段名)=quarter(date_sub(now(),interval 1 quarter))
     */
    last_quarter("上季度"),
    /**
     * mysql条件：where 时间字段名 between date_sub(now(),interval 6 month) and now()
     */
    first_half_year("前半年"),
    /**
     * mysql条件：where year(时间字段名)=year(now())
     */
    this_year("本年"),
    /**
     * mysql条件：where year(时间字段名)=year(date_sub(now(),interval 1 year))
     */
    last_year("上年"),
    ;
    public String descs;

    DateQueryEnums(String descs) {
        this.descs = descs;
    }
}