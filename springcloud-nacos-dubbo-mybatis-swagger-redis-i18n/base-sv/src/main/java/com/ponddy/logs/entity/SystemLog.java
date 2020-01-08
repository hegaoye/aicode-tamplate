package com.ponddy.logs.entity;

import com.ponddy.core.enums.ActionTypeEnum;
import com.ponddy.core.enums.HttpCodeEnum;
import com.ponddy.core.enums.RoleTypeEnum;
import lombok.Data;
import org.apache.commons.lang3.StringUtils;

import java.io.Serializable;
import java.util.Date;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/12/30 16:15
 * @Description:
 */
@Data
public class SystemLog implements Serializable {
    private static final long serialVersionUID = 4367942649643481415L;


    /**
     * 数据库字段:id  属性显示:主键id
     */
    private Long id;

    /**
     * 数据库字段:role_type  属性显示:操作人类型
     * RoleTypeEnum
     * [枚举编号：1003](/resources/enum/1003)
     */
    private String roleType;

    /**
     * 数据库字段:role_code  属性显示:操作人编码
     */
    private String roleCode;

    /**
     * 数据库字段:role_name  属性显示:操作人名称
     */
    private String roleName;

    /**
     * 数据库字段:type  属性显示:操作类型(add,edit,del,query)
     */
    private String type;

    /**
     * 数据库字段:description  属性显示:详细描述
     */
    private String description;

    /**
     * 数据库字段:response_state  属性显示:响应状态码
     * <p>
     * '100','101',
     * '200','201','202','203','204','205','206',
     * '300','301','302','303','304','305','306','307',
     * '400','401','402','403','404','405','406','407','408','409','410','411','412','413','414','415','416','417',
     * '500','501','502','503','504','505'
     */
    private Integer responseState;

    /**
     * 数据库字段:ip_address  属性显示:ip地址（二进制）
     */
    private Long ipAddress;

    /**
     * 数据库字段:system  属性显示:操作系统
     */
    private String system;

    /**
     * 数据库字段:browser  属性显示:浏览器
     */
    private String browser;

    /**
     * 数据库字段:class_name  属性显示:类(包.类)
     */
    private String className;

    /**
     * 数据库字段:class_method  属性显示:类方法
     */
    private String classMethod;

    /**
     * 数据库字段:create_time  属性显示:创建时间
     */
    private Date createTime;

    /**
     * 数据库字段:create_time  属性显示:创建时间
     */
    private Long createTimeBegin;
    /**
     * 数据库字段:create_time  属性显示:创建时间
     */
    private Long createTimeEnd;

    public SystemLog() {
    }

    public SystemLog(RoleTypeEnum type, String description, int responseState) {
        this.type = type.name();
        this.description = getDescription(description);
        this.responseState = responseState;
        this.createTime = new Date();
    }

    public SystemLog(RoleTypeEnum roleType, String roleCode, String roleName, ActionTypeEnum type, String description, HttpCodeEnum httpCodeEnum) {
        this.roleType = roleType.name();
        this.roleCode = roleCode;
        this.roleName = roleName;
        this.type = type.name();
        this.description = getDescription(description);
        this.responseState = httpCodeEnum.getCode();
        this.createTime = new Date();
    }

    public void setDescription(String description) {

        this.description = getDescription(description);
    }

    private String getDescription(String description) {
        if (StringUtils.isNotBlank(description) && description.length() > 1024) {
            description = description.substring(0, 1024);
        }
        return description;
    }
}
