package ${basePackage}.rbac.vo;

import ${basePackage}.core.TreeVO;
import lombok.Data;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/23 16:20
 * @Description:
 */
@Data
public class TreeRoleNodeVO extends TreeVO {


    /**
     * 数据库字段:role_name  属性显示:角色名称
     */
    private java.lang.String roleName;

    /**
     * 数据库字段:state  属性显示:状态（enable 启用，disable 禁用）
     */
    private java.lang.String state;

    /**
     * 数据库字段:description  属性显示:描述
     */
    private java.lang.String description;
}