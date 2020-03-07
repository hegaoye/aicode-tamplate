/*
 * mm
 */
package com.my.project.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.Accessors;

/**
 * 账户 的实体类
 *
 * @author mm
 */
@Data
@EqualsAndHashCode(callSuper = false)
@Accessors(chain = true)
public class Project implements java.io.Serializable {

    /**
     * 数据库字段:id  属性显示:
     */
    @TableId(type = IdType.AUTO)
    private java.lang.Long id;

    /**
     * 数据库字段:code  属性显示:账户编码
     */
    private java.lang.String code;

    /**
     * 数据库字段:account  属性显示:账户
     */
    private java.lang.String account;

    /**
     * 数据库字段:password  属性显示:密码
     */
    private java.lang.String password;

    /**
     * 数据库字段:status  属性显示:
     */
    private java.lang.String status;

    /**
     * 数据库字段:createTime  属性显示:
     */
    private java.util.Date createTime;

    /**
     * 数据库字段:updateTime  属性显示:
     */
    private java.util.Date updateTime;

}
