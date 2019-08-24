package ${basePackage}.rbac.vo;

import lombok.Data;

import java.io.Serializable;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/22 12:42
 * @Description:
 */
@Data
public class RbacAdminVO implements Serializable {

    /**
     * 数据库字段:menuId  属性显示:主键ID
     */
    private java.lang.Long id;

    /**
     * 数据库字段:code  属性显示:管理员（授权用户）编码
     */
    private java.lang.String code;

    /**
     * 数据库字段:account  属性显示:自定义登录账号 (长度限制5-16位，字母开头+数字)
     */
    private java.lang.String account;

    /**
     * 数据库字段:phone  属性显示:手机号码（仅支持11位手机号）
     */
    private java.lang.String phone;

    /**
     * 数据库字段:email  属性显示:邮箱账号
     */
    private java.lang.String email;

    /**
     * 数据库字段:idcard  属性显示:身份证号
     */
    private java.lang.String idcard;

    /**
     * 数据库字段:name  属性显示:管理员名称
     */
    private java.lang.String name;

    /**
     * 数据库字段:whether_auth  属性显示:是否拥有授权权限
     */
    private java.lang.String whetherAuth;

    /**
     * 数据库字段:state  属性显示:状态（enable 启用，disable 禁用）
     */
    private java.lang.String state;

    /**
     * 数据库字段:type  属性显示:管理员类型（super 超级管理员，normal 普通管理员）
     */
    private java.lang.String type;

    /**
     * 数据库字段:creator_code  属性显示:创建者编码
     */
    private java.lang.String creatorCode;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private java.util.Date createTime;

    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private java.util.Date updateTime;

    /**
     * 扩展属性：创建者姓名
     */
    private java.lang.String creatorName;
}
