package $package$.core.base;

import cn.hutool.core.util.ReflectUtil;
import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.toolkit.support.SFunction;
import lombok.extern.slf4j.Slf4j;

import java.io.Serializable;
import java.lang.invoke.SerializedLambda;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 通用DAO接口.
 * <p>
 * <p>其中的泛型参数E为实体，是一个与表字段一一对应的JavaBean;
 * <p>
 * <p>PK是主键类型，是一个实现序列化Serializable接口的类型，一般为Long型;
 * <p>
 * <p>通过继承此DAO可以享有此接口所拥有的操作方法，建议用户所有的DAO都继承此DAO。
 *
 * @author lixin 11-12-12 下午10:37
 */
@Slf4j
public abstract class BaseDAO<E extends Serializable> {
    /**
     * 获得dao对象
     *
     * @return BaseDAO
     */
    protected abstract BaseMapper<E> getBaseMapper(); // 获得当前dao对象

    /**
     * 插入数据
     *
     * @param e 保存对象
     */
    public int insert(E e) {
        return this.getBaseMapper().insert(e);
    }

    /**
     * 插入或更新 ，更新时传递 pkColums 条件
     *
     * @param e         对象
     * @param pkColumns 更新时的主键条件指定
     */
    public int insertOrUpdate(E e, SFunction<E, ?>... pkColumns) {
        Object value = null;
        if (null != pkColumns && pkColumns.length > 0) {
            for (SFunction<E, ?> pkColumn : pkColumns) {
                value = this.getValueByField(e, pkColumn);
                if (null != value) {
                    break;
                }
            }
        }

        if (null != value) {
            return this.updateByPk(e, pkColumns);
        } else {
            return this.insert(e);
        }

    }


    /**
     * 根据主键 查询一个对象  可伸缩 至少1个主键
     *
     * @param e       实例
     * @param columns 主键
     * @return E
     */
    public E selectOneByPk(E e, SFunction<E, ?>... columns) {
        Wrapper<E> wrapper = this.getWrapper(e, columns);
        e = this.getBaseMapper().selectOne(wrapper);
        return e;
    }

    /**
     * 根据任意条件 查询一个对象
     * 需要自己构造条件查询器，（不推荐） 仅用于提供接口无法实现复杂参数查询时使用
     * 切勿滥用
     *
     * @param queryWrapper 条件查询器
     * @return E
     */
    public E selectOne(QueryWrapper<E> queryWrapper) {
        return this.getBaseMapper().selectOne(queryWrapper);
    }

    public E selectOne(LambdaQueryWrapper<E> queryWrapper) {
        return this.getBaseMapper().selectOne(queryWrapper);
    }

    /**
     * 分页查询
     *
     * @param queryWrapper 分页查询条件
     * @param offset       起始行
     * @param limit        步长
     * @return List<E>
     */
    public List<E> list(QueryWrapper<E> queryWrapper, int offset, int limit) {
        return getBaseMapper().selectList(queryWrapper.lambda().last("limit " + offset + "," + limit));
    }

    public int count(QueryWrapper<E> queryWrapper) {
        return getBaseMapper().selectCount(queryWrapper);
    }

    /**
     * 根据条件查询 没有限制 建议使用时自己拼装 ，或者使用上面的分页list
     * queryWrapper.lambda().last("limit " + offset + "," + limit)
     *
     * @param queryWrapper 条件构造器
     * @return List<E>
     */
    public List<E> list(QueryWrapper<E> queryWrapper) {
        return getBaseMapper().selectList(queryWrapper);
    }


    /**
     * 根据 更新构造器进行更新
     *
     * @param e             实例对象，被更新的数据
     * @param updateWrapper 更新条件构造器
     */
    public int update(E e, UpdateWrapper<E> updateWrapper) {
        return this.getBaseMapper().update(e, updateWrapper);
    }

    public int update(E e, LambdaUpdateWrapper<E> updateWrapper) {
        return this.getBaseMapper().update(e, updateWrapper);
    }

    /**
     * 根据 更新构造器进行更新
     * 设置值如下：
     * updateWrapper.lambda().set(属性,新数据) 设置具体的属性和值
     * updateWrapper.lambda().eq() 条件
     *
     * @param updateWrapper 更新条件构造器
     */
    public int update(UpdateWrapper<E> updateWrapper) {
        return this.getBaseMapper().update(null, updateWrapper);
    }

    public int update(LambdaUpdateWrapper<E> updateWrapper) {
        return this.getBaseMapper().update(null, updateWrapper);
    }

    /**
     * 根据主键更新 可伸缩 至少1个主键
     *
     * @param e       实例
     * @param columns 主键
     */
    public int updateByPk(E e, SFunction<E, ?>... columns) {
        if (e == null || columns == null || columns.length <= 0) {
            return 0;
        }
        Wrapper<E> updateWrapper = this.getWrapper(e, columns);
        int updateCount = getBaseMapper().update(e, updateWrapper);
        return updateCount;
    }


    /**
     * 根据主键 进行删除，可伸缩 至少1个主键
     *
     * @param e       实例
     * @param columns 属性列
     */
    public void deleteByPk(E e, SFunction<E, ?>... columns) {
        if (e == null || columns == null || columns.length <= 0) {
            return;
        }
        Wrapper<E> deleteWrapper = this.getWrapper(e, columns);
        this.getBaseMapper().delete(deleteWrapper);
    }

    /**
     * 删除对象
     *
     * @param deleteWrapper 删除条件
     */
    public void delete(QueryWrapper<E> deleteWrapper) {
        this.getBaseMapper().delete(deleteWrapper);
    }

    public void delete(LambdaQueryWrapper<E> deleteWrapper) {
        this.getBaseMapper().delete(deleteWrapper);
    }

    /**
     * 构造 条件
     *
     * @param e       实例
     * @param columns 属性列
     */
    private Wrapper<E> getWrapper(E e, SFunction<E, ?>... columns) {
        QueryWrapper<E> wrapper = new QueryWrapper<>();
        for (SFunction<E, ?> column : columns) {
            String fieldName = this.convertToFieldName(column);
            if (null == fieldName) {
                continue;
            }

            Field field = ReflectUtil.getField(e.getClass(), fieldName);
            if (null == field) {
                continue;
            }

            Object value = ReflectUtil.getFieldValue(e, field);
            if (null != value) {
                wrapper.lambda().eq(column, value);
            }
        }

        return wrapper;
    }

    /**
     * 根据属性获取值
     */
    private Object getValueByField(E e, SFunction<E, ?> column) {
        String fieldName = this.convertToFieldName(column);
        if (null == fieldName) {
            return null;
        }

        Field field = ReflectUtil.getField(e.getClass(), fieldName);
        if (null == field) {
            return null;
        }

        Object value = ReflectUtil.getFieldValue(e, field);
        if (null != value) {
            return value;
        }
        return null;
    }


    private static Map<Class, SerializedLambda> CLASS_LAMDBA_CACHE = new ConcurrentHashMap<>();

    /**
     * 转换方法引用为属性名
     *
     * @param fn
     * @return
     */
    public <T> String convertToFieldName(SFunction fn) {
        SerializedLambda lambda = getSerializedLambda(fn);
        // 获取方法名
        String methodName = lambda.getImplMethodName();
        String prefix = null;
        if (methodName.startsWith("get")) {
            prefix = "get";
        } else if (methodName.startsWith("is")) {
            prefix = "is";
        }
        if (prefix == null) {
            log.error("无效的getter方法: " + methodName);
        }
        // 截取get/is之后的字符串并转换首字母为小写
        return toLowerCaseFirstOne(methodName.replace(prefix, ""));
    }

    /**
     * 首字母转小写
     *
     * @param s
     * @return
     */
    public String toLowerCaseFirstOne(String s) {
        if (Character.isLowerCase(s.charAt(0))) {
            return s;
        } else {
            return Character.toLowerCase(s.charAt(0)) + s.substring(1);
        }
    }

    /**
     * 关键在于这个方法
     */
    public SerializedLambda getSerializedLambda(Serializable fn) {
        SerializedLambda lambda = CLASS_LAMDBA_CACHE.get(fn.getClass());
        // 先检查缓存中是否已存在
        if (lambda == null) {
            try {
                // 提取SerializedLambda并缓存
                Method method = fn.getClass().getDeclaredMethod("writeReplace");
                method.setAccessible(Boolean.TRUE);
                lambda = (SerializedLambda) method.invoke(fn);
                CLASS_LAMDBA_CACHE.put(fn.getClass(), lambda);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return lambda;
    }

}
