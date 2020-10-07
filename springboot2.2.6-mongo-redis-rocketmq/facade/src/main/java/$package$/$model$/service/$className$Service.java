/*
 * $copyright$
 */
package $package$.$model$.service;

import $package$.$model$.entity.$className$;

import java.util.List;

/**
 * 投注项
 *
 * @author $author$
 */
public interface $className$Service {

    /**
     * 查询详情
     *
     * @param $classNameLower$
     * @return $className$
     */
    $className$ load($className$ $classNameLower$);

    /**
     * 保存
     *
     * @param $classNameLower$
     * @return $className$
     */
    $className$ save($className$ $classNameLower$);

    /**
     * 修改
     *
     * @param $classNameLower$
     * @return $className$
     */
    $className$ modify($className$ $classNameLower$);

    /**
     * 根据id删除
     *
     * @param id
     */
    void delete(Long id);

    /**
     * 分页查询
     *
     * @param $classNameLower$ 条件
     * @param curPage   当前页
     * @param pageSize  条数
     * @return List<$className$>
     */
    List<$className$> list($className$ $classNameLower$, Integer curPage, Integer pageSize);

    /**
     * 统计总数
     *
     * @param $classNameLower$
     * @return 统计总数
     */
    long count($className$ $classNameLower$);

}
