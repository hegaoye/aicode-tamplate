/*
* 仁中和
*/
package ${basePackage}.admin.entity;

import lombok.Data;


/**
* 管理员表 的实体类
*
* @author borong
*/
@Data
public class Admin implements java.io.Serializable {

    //数据库字段:id  属性显示:主键ID
    private java.lang.Long id;

    //数据库字段:code  属性显示:管理员编码
    private java.lang.String code;

    //数据库字段:name  属性显示:管理员名称
    private java.lang.String name;

    //数据库字段:loginAccount  属性显示:登录账户(长度限制4-16)
    private java.lang.String loginAccount;

    //数据库字段:pwd  属性显示:密码(MD5加密32位)
    private java.lang.String password;

    //数据库字段:phone  属性显示:手机号码
    private java.lang.String phone;

    //数据库字段:idcard  属性显示:身份证号
    private java.lang.String idcard;

    //数据库字段:roleTypeEnum  属性显示:角色（SUPER 超级，SENIOR 高级管理，FINACE 财务，EXPRESS 配货员）
    private java.lang.String role;

    //数据库字段:permissions  属性显示:菜单权限[json存储]
    private java.lang.String permissions;

    //数据库字段:state  属性显示:状态（OPEN 开启，DEL 删除）
    private java.lang.String state;

    //数据库字段:operatorCode  属性显示:操作管理员编码
    private java.lang.String operatorCode;

    //数据库字段:operatorName  属性显示:操作管理员名称
    private java.lang.String operatorName;

    //数据库字段:createTime  属性显示:创建时间
    private java.util.Date createTime;

        //数据库字段:createTime  属性显示:创建时间
        private java.util.Date createTimeBegin;
        //数据库字段:createTime  属性显示:创建时间
        private java.util.Date createTimeEnd;
    //数据库字段:updateTime  属性显示:更新时间
    private java.util.Date updateTime;

        //数据库字段:updateTime  属性显示:更新时间
        private java.util.Date updateTimeBegin;
        //数据库字段:updateTime  属性显示:更新时间
        private java.util.Date updateTimeEnd;





}
