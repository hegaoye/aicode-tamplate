package ${basePackage}.rbac.vo;

import com.alibaba.fastjson.JSON;
import ${basePackage}.rbac.common.ConstantsRbac;
import ${basePackage}.core.enums.CheckboxEnum;
import ${basePackage}.core.enums.YNEnum;
import ${basePackage}.rbac.entity.RbacPermission;
import ${basePackage}.rbac.entity.RbacPermissionMenu;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/21 9:30
 * @Description: 菜单树的 VO
 */
@Data
@Slf4j
public class TreeMenuNodeVO implements Serializable {

    /**
     * 权限id
     */
    private java.lang.Long permissionId;

    /**
     * 数据库字段:menuId  属性显示:菜单ID
     */
    private java.lang.Long menuId;

    /**
     * 数据库字段:id_pre  属性显示:上级菜单id；为空时设为0
     */
    private java.lang.Long idPre;

    /**
     * 数据库字段:menu_name  属性显示:菜单名称
     */
    private java.lang.String menuName;

    /**
     * 数据库字段:menu_href  属性显示:菜单路径
     */
    private java.lang.String menuHref;

    /**
     * 数据库字段:menu_icon  属性显示:菜单图标
     */
    private java.lang.String menuIcon;

    /**
     * 数据库字段:state  属性显示:状态（enable 启用，disable 禁用） [枚举编号：1007](/resources/enum/1007)
     */
    private java.lang.String state;

    /**
     * 数据库字段:description  属性显示:描述
     */
    private java.lang.String description;

    /**
     * 数据库字段:sort  属性显示:排序；默认 99
     */
    private java.lang.Integer sort;

    /**
     * 扩展属性：选择状态
     */
    private CheckboxEnum checkbox;

    /**
     * 扩展属性：是否是叶子节点
     */
    private YNEnum isLeaf;

    /**
     * 子菜单集合
     */
    private List<TreeMenuNodeVO> children;

    public TreeMenuNodeVO() {
    }

    public TreeMenuNodeVO(Long permissionId, Long menuId, Long idPre, String menuName, String menuHref, String menuIcon, String state,
                          String description, Integer sort) {
        this.permissionId = permissionId;
        this.menuId = menuId;
        this.idPre = idPre;
        this.menuName = menuName;
        this.menuHref = menuHref;
        this.menuIcon = menuIcon;
        this.state = state;
        this.description = description;
        this.sort = sort;
    }

    /**
     * 权限资源列表 转 菜单VO列表
     *
     * @param permissionList
     * @return
     */
    public static List<TreeMenuNodeVO> listToVOList(List<RbacPermission> permissionList) {
        if (null == permissionList || permissionList.size() == 0) {
            return null;
        }

        List<TreeMenuNodeVO> treeMenuNodeVOList = new ArrayList<>();

        permissionList.forEach(permission -> {
            RbacPermissionMenu menu = permission.getRbacPermissionMenu();
            if (null != menu) {
                TreeMenuNodeVO vo = new TreeMenuNodeVO(permission.getId(), permission.getMenuId(),
                        menu.getIdPre(), permission.getName(), menu.getMenuHref(), menu.getMenuIcon(),
                        permission.getState(), menu.getDescription(), permission.getSort());
                vo.setCheckbox(permission.getCheckbox());
                vo.setIsLeaf(YNEnum.getEnum(menu.getIsLeaf()));
                treeMenuNodeVOList.add(vo);
            }
        });
        return treeMenuNodeVOList;
    }

    /**
     * 列表转树结构
     *
     * @param list
     * @return
     */
    public static List<TreeMenuNodeVO> listToTree(List<TreeMenuNodeVO> list) {
        if (null == list || list.size() == 0) {
            return null;
        }
        // 用递归找子
        List<TreeMenuNodeVO> treeList = new ArrayList<>();
        list.forEach(tree -> {
            // 确定根节点
            if (tree.getIdPre() - ConstantsRbac.ID_PRE_PRESET == 0) {
                treeList.add(findChildren(tree, list));
            }
        });
        return treeList;
    }

    /**
     * 树节点向下找子
     *
     * @param tree
     * @param list
     * @return
     */
    private static TreeMenuNodeVO findChildren(TreeMenuNodeVO tree, List<TreeMenuNodeVO> list) {
        if (null == tree || null == list || list.size() == 0) {
            return tree;

        }

        if (log.isDebugEnabled()) {
            log.debug(">>> tree [{}] >>>", JSON.toJSONString(tree));
        }

        list.forEach(node -> {
            // 如果节点的父id 与菜单id相同，则添加子集
            if (node.getIdPre().compareTo(tree.getMenuId()) == 0) {
                if (null == tree.getChildren()) {
                    tree.setChildren(new ArrayList<>());
                }
                tree.getChildren().add(findChildren(node, list));
            }
        });
        return tree;
    }

    /**
     * 转换权限集合为权限树
     *
     * @param rbacPermissions 权限集合
     * @return
     */
    public static List<TreeMenuNodeVO> permissionListToTree(List<RbacPermission> rbacPermissions) {
        // 权限资源列表 转 菜单VO列表
        List<TreeMenuNodeVO> treeMenuNodeVOS = TreeMenuNodeVO.listToVOList(rbacPermissions);
        // 列表转树结构
        treeMenuNodeVOS = TreeMenuNodeVO.listToTree(treeMenuNodeVOS);
        return treeMenuNodeVOS;
    }

    /**
     * 标记树节点的选择状态为全选
     *
     * @param treeMenuNodeVOList
     * @return
     */
    public static List<TreeMenuNodeVO> markTreeMenuNodeCheckAll(List<TreeMenuNodeVO> treeMenuNodeVOList) {

        for (TreeMenuNodeVO treeMenuNodeVO : treeMenuNodeVOList) {
            // 向下循环遍历节点，并标记节点的选择状态
            itertorTree(treeMenuNodeVO);
        }

        return treeMenuNodeVOList;
    }

    /**
     * 向下循环遍历节点，并标记节点的选择状态
     *
     * @param treeMenuNodeVO
     */
    private static void itertorTree(TreeMenuNodeVO treeMenuNodeVO) {
        // 如果是叶子节点时，停止向下遍历
        if (YNEnum.Y.equals(treeMenuNodeVO.getIsLeaf())) {
            // 检查当前叶子节点，且为选中部分时
            if (CheckboxEnum.part.equals(treeMenuNodeVO.getCheckbox())) {
                treeMenuNodeVO.setCheckbox(CheckboxEnum.all);
            }
        }
        // 如果不是叶子节点，继续遍历下级节点集
        else {
            // 定义临时变量：下级菜单是否全选
            boolean nextLevelIsAllCheck = true;

            // 遍历节点的子菜单
            for (TreeMenuNodeVO treeMenuNode : treeMenuNodeVO.getChildren()) {
                // 如果有一个子节点为非选择状态，则标记 下级菜单是否全选 为 否
                if (nextLevelIsAllCheck && !CheckboxEnum.isInSet(treeMenuNode.getCheckbox(), CheckboxEnum.all)) {
                    nextLevelIsAllCheck = false;
                }
                itertorTree(treeMenuNode);
            }

            // 如果当前树节点的子节点已全选，则节点为全选
            if (nextLevelIsAllCheck) {
                treeMenuNodeVO.setCheckbox(CheckboxEnum.all);
            }
        }
    }
}
