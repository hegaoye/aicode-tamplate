/*
 * ${copyright}
 */
package ${basePackage}.rbac.entity;

import ${basePackage}.rbac.common.ConstantsRbac;
import ${basePackage}.core.enums.YNEnum;
import ${basePackage}.core.enums.CheckboxEnum;
import ${basePackage}.core.enums.EnableStateEnum;
import ${basePackage}.rbac.vo.TreeMenuNodeVO;
import lombok.Data;
import org.apache.commons.lang.StringUtils;

import java.util.Date;
import java.util.List;

/**
 * 权限系统-角色 的实体类
 *
 * @author borong
 */
@Data
public class RbacRole implements java.io.Serializable {

    /**
     * 数据库字段:menuId  属性显示:角色id
     */
    private java.lang.Long id;

    /**
     * 数据库字段:id_pre  属性显示:上级角色id；无上级时，设为0
     */
    private java.lang.Long idPre;

    /**
     * 数据库字段:role_name  属性显示:角色名称
     */
    private java.lang.String roleName;

    /**
     * 数据库字段:state  属性显示:状态（enable 启用，disable 禁用）
     */
    private java.lang.String state;

    /**
     * 数据库字段:is_leaf  属性显示:是否是叶子节点（Y是，N否） [枚举编号：1001] (/resources/enum/1001)
     */
    private java.lang.String isLeaf;

    /**
     * 数据库字段:description  属性显示:描述
     */
    private java.lang.String description;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private java.util.Date createTime;

    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private java.util.Date createTimeBegin;
    /**
     * 数据库字段:createTime  属性显示:创建时间
     */
    private java.util.Date createTimeEnd;
    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private java.util.Date updateTime;

    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private java.util.Date updateTimeBegin;
    /**
     * 数据库字段:updateTime  属性显示:更新时间
     */
    private java.util.Date updateTimeEnd;


    /**
     * 1对多关联查询RbacAdminRoleRelation 权限系统-授权用户与角色关系  属性显示:rbacAdminRoleRelation
     */
    private List<RbacAdminRoleRelation> rbacAdminRoleRelationList;
    /**
     * 1对多关联查询RbacRolePermissionRelation 权限系统-角色对应权限关系  属性显示:rbacRolePermissionRelation
     */
    private List<RbacRolePermissionRelation> rbacRolePermissionRelationList;

    /**
     * 扩展属性：树
     */
    private List<TreeMenuNodeVO> treeMenuNodeVOS;

    /**
     * 扩展属性：选择状态；默认全不选
     */
    private CheckboxEnum checkbox = CheckboxEnum.none;

    public RbacRole() {
    }

    public RbacRole(Long idPre) {
        this.idPre = idPre;
    }

    /**
     * 构造器：用于新增角色使用
     *
     * @param idPre 上级角色id
     * @param roleName 角色名
     * @param stateEnum 启用状态
     * @param createTime 创建时间
     */
    public RbacRole(Long idPre, String roleName, EnableStateEnum stateEnum, String description, YNEnum isLeaf, Date createTime) {
        this.idPre = null == idPre ? ConstantsRbac.ID_PRE_PRESET : idPre;
        this.roleName = roleName;
        this.state = stateEnum.name();
        this.description = StringUtils.isBlank(description) ? "" : description;
        this.isLeaf = isLeaf.name();
        this.createTime = createTime;
        this.updateTime = createTime;
    }
}