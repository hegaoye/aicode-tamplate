/*
 * ${copyright}
 */
package ${basePackage}.syslog.entity;

import ${basePackage}.core.enums.ActionTypeEnum;
import ${basePackage}.core.enums.HttpCodeEnum;
import ${basePackage}.core.enums.RoleTypeEnum;
import lombok.Data;
import org.apache.commons.lang.StringUtils;

import java.util.Date;


/**
 * 系统操作日志; 的实体类
 *
 * @author borong
 */
@Data
public class SystemLogs implements java.io.Serializable {

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
     * 数据库字段:type  属性显示:操作类型(insert,update,delete,select)
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
     * 数据库字段:create_time  属性显示:创建时间
     */
    private Date createTime;

    /**
     * 数据库字段:create_time  属性显示:创建时间
     */
    private Date createTimeBegin;
    /**
     * 数据库字段:create_time  属性显示:创建时间
     */
    private Date createTimeEnd;

    public SystemLogs() {
    }

    public SystemLogs(String type, String description, int responseState) {
        this.type = type;
        this.description = description;
        this.responseState = responseState;
        this.createTime = new Date();
    }

    public SystemLogs(String roleType, String roleCode, String type, String description, int responseState) {
        this.roleType = roleType;
        this.roleCode = roleCode;
        this.type = type;
        this.description = description;
        this.responseState = responseState;
        this.createTime = new Date();
    }

    public SystemLogs(RoleTypeEnum roleType, String roleCode, ActionTypeEnum type, String description, HttpCodeEnum httpCodeEnum, Long ipAddress, String system, String browser) {
        this.roleType = roleType.name();
        this.roleCode = roleCode;
        this.type = type.name();
        this.description = description;
        this.responseState = httpCodeEnum.getCode();
        this.ipAddress = ipAddress;
        this.system = system;
        this.browser = browser;
        this.createTime = new Date();
    }

    public void setDescription(String description) {
        if (StringUtils.isNotBlank(description) && description.length() > 2048) {
            description = description.substring(0, 2048);
        }
        this.description = description;
    }
}
