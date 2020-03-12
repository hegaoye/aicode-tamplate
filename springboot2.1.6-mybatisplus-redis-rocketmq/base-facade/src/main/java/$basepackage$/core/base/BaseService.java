package $package$.core.base;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;

import java.io.Serializable;
import java.util.List;

/**
 * Created by lixin on 2017/6/22 0022. hegaoye@qq.com
 * 基础接口声明
 */
public interface BaseService<E extends Serializable> {

    /**
     * 获得dao对象
     *
     * @return BaseDAO
     */
    BaseDAO<E> getBaseDAO(); // 获得当前dao对象

    /**
     * 保存
     *
     * @param e 实体
     * @return E
     */
    E save(E e);

    /**
     * 保存 或 更新
     *
     * @param e 实体
     */
    void saveOrModify(E e, SFunction<E, ?>... columns);

    /**
     * 根据 任意条件 查询实体
     *
     * @param queryWrapper 条件构造器
     * @return 实体
     */
    E load(QueryWrapper<E> queryWrapper);

    /**
     * 加载一个对象 E 通过主键
     *
     * @param e 实体
     * @return E
     */
    E loadByPk(E e, SFunction<E, ?>... columns);

    /**
     * 删除对象Project
     *
     * @return E
     */
    void delete(E e, SFunction<E, ?>... columns);


    /**
     * 更新
     *
     * @param e 变更对象
     * @return true/false
     */
    boolean modify(E e, SFunction<E, ?>... columns);

    /**
     * 查询Project分页
     *
     * @param offset 查询开始行
     * @param limit  查询行数
     * @return List<E>
     */
    List<E> list(QueryWrapper<E> queryWrapper, int offset, int limit);

    int count(QueryWrapper<E> queryWrapper);


    /**
     * 查询所有数据
     *
     * @return
     */
    List<E> listAll(QueryWrapper<E> queryWrapper);

}
