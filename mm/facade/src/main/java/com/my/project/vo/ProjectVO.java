/**
 * mm
 */
package com.my.project.vo;

import lombok.Data;

/**
 * Project VO
 *
 * @author mm
 */
@Data
public class ProjectVO implements java.io.Serializable {

    /**
     * 数据库字段:code  属性显示:账户编码
     */
    private String code;

    /**
     * 数据库字段:account  属性显示:账户
     */
    private String account;

    /**
     * 数据库字段:status
     */
    private String status;

}
