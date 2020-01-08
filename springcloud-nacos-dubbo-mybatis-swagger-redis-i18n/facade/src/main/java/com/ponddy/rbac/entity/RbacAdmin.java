/*
 * Copyright (c) 2019. 郑州仁中和科技有限公司.保留所有权利. 
http://www.rzhkj.com/ 
郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系. 代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 */
package com.ponddy.rbac.entity;

import com.ponddy.core.enums.AdminTypeEnum;
import com.ponddy.core.enums.EnableStateEnum;
import com.ponddy.core.enums.YNEnum;
import lombok.Data;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;


/**
 * 权限系统-管理员（授权用户） 的实体类
 *
 * @author borong
 */
@Data
public class RbacAdmin implements java.io.Serializable {

    /**
     * 数据库字段:menuId  属性显示:主键ID
     */
    private Long id;

    /**
     * 数据库字段:code  属性显示:管理员（授权用户）编码
     */
    private String code;

    /**
     * 数据库字段:account  属性显示:自定义登录账号 (长度限制5-16位，字母开头+数字)
     */
    private String account;

    /**
     * 数据库字段:phone  属性显示:手机号码（仅支持11位手机号）
     */
    private String phone;

    /**
     * 数据库字段:email  属性显示:邮箱账号
     */
    private String email;

    /**
     * 数据库字段:idcard  属性显示:身份证号
     */
    private String idcard;

    /**
     * 数据库字段:password  属性显示:加密的登录密码 (MD5加密32位)
     */
    private String password;

    /**
     * 数据库字段:name  属性显示:管理员名称
     */
    private String name;

    /**
     * 数据库字段:whether_auth  属性显示:是否拥有授权权限
     */
    private String whetherAuth;

    /**
     * 数据库字段:state  属性显示:状态（enable 启用，disable 禁用）
     */
    private String state;

    /**
     * 数据库字段:type  属性显示:管理员类型（super 超级管理员，normal 普通管理员）
     */
    private String type;

    /**
     * 数据库字段:creator_code  属性显示:创建者编码
     */
    private String creatorCode;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private Date createTime;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private Date createTimeBegin;
    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private Date createTimeEnd;
    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private Date updateTime;

    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private Date updateTimeBegin;
    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private Date updateTimeEnd;

    /**
     * 扩展属性：创建者姓名
     */
    private String creatorName;

    /**
     * 1对多关联查询RbacAdminRoleRelation 权限系统-授权用户与角色关系  属性显示:rbacAdminRoleRelation
     */
    private List<RbacAdminRoleRelation> rbacAdminRoleRelationList;

    public RbacAdmin() {
    }

    /**
     * 构造器用于新增管理员
     * @param code
     * @param account
     * @param phone
     * @param email
     * @param idcard
     * @param password
     * @param name
     * @param whetherAuth
     * @param state
     * @param creatorCode
     * @param createTime
     */
    public RbacAdmin(String code, String account, String phone, String email, String idcard, String password,
                     String name, YNEnum whetherAuth, EnableStateEnum state, String creatorCode, Date createTime) {
        this.code = code;
        this.account = StringUtils.isBlank(account) ? "" : account;
        this.phone = StringUtils.isBlank(phone) ? "" : phone;
        this.email = StringUtils.isBlank(email) ? "" : email;
        this.idcard = StringUtils.isBlank(idcard) ? "" : idcard;
        this.password = password;
        this.name = name;
        this.whetherAuth = whetherAuth.name();
        this.state = state.name();
        // 默认普通管理员
        this.type = AdminTypeEnum.NORMAL.name();
        this.creatorCode = creatorCode;
        this.createTime = createTime;
        this.updateTime = createTime;
    }
}