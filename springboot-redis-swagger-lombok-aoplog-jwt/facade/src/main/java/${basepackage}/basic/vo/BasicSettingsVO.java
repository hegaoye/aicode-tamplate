package ${basePackage}.basic.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/6/14 16:48
 * @Description: 系统基础关键配置表 的实体类
 */
@Data
public class BasicSettingsVO implements Serializable {
    private static final long serialVersionUID = -4856825933143380566L;

    //数据库字段:k  属性显示:键
    private String k;

    //数据库字段:v  属性显示:值
    private String v;
}
