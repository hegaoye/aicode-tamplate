/*
 * 仁中和
 */
package ${basePackage}.basic.entity;

import lombok.Data;

import java.util.Date;


/**
 * 系统基础关键配置表 的实体类
 *
 * @author borong
 */
@Data
public class BasicSettings implements java.io.Serializable {

    //数据库字段:id  属性显示:id
    private java.lang.Long id;

    //数据库字段:k  属性显示:键
    private java.lang.String k;

    //数据库字段:v  属性显示:值
    private java.lang.String v;

    //数据库字段:remark  属性显示:备注
    private java.lang.String remark;

    //数据库字段:createTime  属性显示:创建时间
    private java.util.Date createTime;

    //数据库字段:createTime  属性显示:创建时间
    private java.util.Date createTimeBegin;
    //数据库字段:createTime  属性显示:创建时间
    private java.util.Date createTimeEnd;
    //数据库字段:updateTime  属性显示:修改时间
    private java.util.Date updateTime;

    //数据库字段:updateTime  属性显示:修改时间
    private java.util.Date updateTimeBegin;
    //数据库字段:updateTime  属性显示:修改时间
    private java.util.Date updateTimeEnd;

    public BasicSettings() {
    }

    public BasicSettings(String k, String v, String remark) {
        this.k = k;
        this.v = v;
        this.remark = remark;
    }

    public BasicSettings(String k, String v, String remark, Date createTime) {
        this.k = k;
        this.v = v;
        this.remark = remark;
        this.createTime = createTime;
    }

    public BasicSettings(String k, String v, String remark, Date createTime, Date updateTime) {
        this.k = k;
        this.v = v;
        this.remark = remark;
        this.createTime = createTime;
        this.updateTime = updateTime;
    }
}
