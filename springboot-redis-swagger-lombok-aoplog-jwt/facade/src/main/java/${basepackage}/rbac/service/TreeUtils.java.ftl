/*
 * ${copyright}
 */
package ${basePackage}.rbac.service;

import ${basePackage}.rbac.vo.TreeMenuNodeVO;

import java.util.ArrayList;
import java.util.List;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/21 10:48
 * @Description:
 */
public class TreeUtils {

    /**
     * 集合转树结构
     *
     * @param list
     * @return
     */
    public static List<TreeMenuNodeVO> toTree(List<TreeMenuNodeVO> list) {
        List<TreeMenuNodeVO> treeList = new ArrayList<>();
        list.forEach(tree -> {
            if (tree.getIdPre().compareTo(0L) == 0) {
                treeList.add(tree);
            }
        });

        list.forEach(tree -> {
            toTreeChildren(treeList, tree);
        });
        return treeList;
    }

    /**
     * 树节点向下找子
     *
     * @param treeList
     * @param tree
     */
    private static void toTreeChildren(List<TreeMenuNodeVO> treeList, TreeMenuNodeVO tree) {
        treeList.forEach(node -> {
            // 确定根节点
            if (tree.getIdPre().compareTo(node.getIdPre()) == 0) {
                if (null == node.getChildren()) {
                    node.setChildren(new ArrayList<>());
                }
                node.getChildren().add(tree);
            }
            if (null != node.getChildren()) {
                toTreeChildren(node.getChildren(), tree);
            }
        });
    }
}
