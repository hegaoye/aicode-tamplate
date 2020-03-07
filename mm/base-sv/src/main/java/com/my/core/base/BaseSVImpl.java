package com.my.core.base;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import com.my.core.exceptions.BaseException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.transaction.annotation.Transactional;

import java.io.Serializable;
import java.util.List;

/**
 * 基础接口实现
 *
 * @author lixin hegaoye@qq.com
 */
@Slf4j
public abstract class BaseSVImpl<E extends Serializable> implements BaseSV<E> {

    @Transactional(rollbackFor = BaseException.class)
    @Override
    public E save(E e) {
        int i = this.getBaseDAO().insert(e);
        return i > 0 ? e : null;
    }

    @Transactional(rollbackFor = BaseException.class)
    @Override
    public void saveOrModify(E e, SFunction<E, ?>... columns) {
        this.getBaseDAO().insertOrUpdate(e, columns);
    }

    @Override
    public E load(QueryWrapper<E> queryWrapper) {
        return this.getBaseDAO().selectOne(queryWrapper);
    }

    @Override
    public E loadByPk(E e, SFunction<E, ?>... columns) {
        return this.getBaseDAO().selectOneByPk(e, columns);
    }

    @Transactional(rollbackFor = BaseException.class)
    @Override
    public void delete(E e, SFunction<E, ?>... columns) {
        this.getBaseDAO().deleteByPk(e, columns);
    }

    @Transactional(rollbackFor = BaseException.class)
    @Override
    public boolean modify(E e, SFunction<E, ?>... columns) {
        return this.getBaseDAO().updateByPk(e, columns) > 0 ? true : false;
    }

    @Override
    public List<E> list(QueryWrapper<E> queryWrapper, int offset, int limit) {
        return this.getBaseDAO().list(queryWrapper, offset, limit);
    }

    @Override
    public int count(QueryWrapper<E> queryWrapper) {
        return this.getBaseDAO().count(queryWrapper);
    }

    @Override
    public List<E> listAll(QueryWrapper<E> queryWrapper) {
        return this.getBaseDAO().list(queryWrapper);
    }
}
