package $package$.core.base;

import lombok.extern.slf4j.Slf4j;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.Collection;
import java.util.List;

/**
 * MongoDB 的 基础操作
 *
 * @param <E>
 */
@Slf4j
public abstract class MongoBaseDAO<E extends Serializable> {
    /**
     * 获得MongoTemplate对象
     *
     * @return MongoTemplate
     */
    protected abstract MongoTemplate getMongoTemplate();


    /**
     * 获取需要操作的实体类class
     *
     * @return
     */
    private Class<E> getEClass() {
        Type superclass = this.getClass().getGenericSuperclass();
        Type[] actualTypeArguments = ((ParameterizedType) superclass).getActualTypeArguments();
        return (Class) actualTypeArguments[0];
    }

    /**
     * 通过条件查询实体(集合)
     *
     * @param query 查询条件
     * @return 实体的集合
     */
    public List<E> findList(Query query) {
        return getMongoTemplate().find(query, this.getEClass());
    }

    /**
     * 通过条件，集合名查询实体(集合)
     *
     * @param query          查询条件
     * @param collectionName 集合名
     * @return 实体的集合
     */
    public List<E> findList(Query query, String collectionName) {
        return getMongoTemplate().find(query, this.getEClass(), collectionName);
    }

    /**
     * 分页查询
     *
     * @param query  查询条件
     * @param offset 起始行
     * @param limit  步长
     * @return 集合
     */
    public List<E> findList(Query query, int offset, int limit) {
        query.skip(offset).limit(limit);
        List<E> list = this.findList(query);
        return list;
    }

    /**
     * 分页查询
     *
     * @param query          查询条件
     * @param collectionName 集合名
     * @param offset         起始行
     * @param limit          步长
     * @return 集合
     */
    public List<E> findList(Query query, String collectionName, int offset, int limit) {
        query.skip(offset).limit(limit);
        List<E> list = this.findList(query, collectionName);
        return list;
    }

    /**
     * 获取实体的所有集合 （所有，仅用于小数据）
     *
     * @return 查询实体集合
     */
    public List<E> findAll() {
        return getMongoTemplate().findAll(this.getEClass());
    }

    /**
     * 获取实体的所有集合 （所有，仅用于小数据）
     *
     * @param collectName 集合名
     * @return 查询实体集合
     */
    public List<E> findAll(String collectName) {
        return getMongoTemplate().findAll(this.getEClass(), collectName);
    }

    /**
     * 通过条件查询实体 （单条）
     *
     * @param query 查询条件
     * @return 实体
     */
    public E find(Query query) {
        return getMongoTemplate().findOne(query, this.getEClass());
    }

    /**
     * 通过条件查询实体 （单条）
     *
     * @param query          查询条件
     * @param collectionName 集合名
     * @return 实体
     */
    public E find(Query query, String collectionName) {
        return getMongoTemplate().findOne(query, this.getEClass(), collectionName);
    }

    /**
     * 通过ID获取记录
     *
     * @param id id
     * @return 实体
     */
    public E findById(String id) {
        return getMongoTemplate().findById(id, this.getEClass());
    }

    /**
     * 通过ID获取记录,并且指定了集合名(表的意思)
     *
     * @param id             id
     * @param collectionName 集合名
     * @return 实体
     */
    public E findById(String id, String collectionName) {
        return getMongoTemplate().findById(id, this.getEClass(), collectionName);
    }

    /**
     * 通过条件查询更新数据
     *
     * @param query  更新条件
     * @param update 更新
     */
    public void modify(Query query, Update update) {
        getMongoTemplate().findAndModify(query, update, this.getEClass());
    }

    /**
     * 通过条件查询更新数据
     *
     * @param query          更新条件
     * @param update         更新
     * @param collectionName 集合名
     */
    public void modify(Query query, Update update, String collectionName) {
        getMongoTemplate().findAndModify(query, update, this.getEClass(), collectionName);
    }

    /**
     * 删除数据
     *
     * @param id             id
     * @param collectionName 集合名
     */
    public void remove(String id, String collectionName) {
        Query query = new Query();
        query.addCriteria(Criteria.where("_id").is(id));
        getMongoTemplate().remove(query, collectionName);
    }

    /**
     * 保存
     *
     * @param entity 实体
     * @return 实体
     */
    public E insert(E entity) {
        entity = getMongoTemplate().insert(entity);
        return entity;
    }

    /**
     * 保存
     *
     * @param entity         实体
     * @param collectionName 集合名
     * @return 实体
     */
    public E insert(E entity, String collectionName) {
        entity = getMongoTemplate().insert(entity, collectionName);
        return entity;
    }

    /**
     * 保存一个集合
     *
     * @param list           集合
     * @param collectionName 集合名
     * @return 集合结果
     */
    public Collection<E> insert(List<E> list, String collectionName) {
        if (list == null) {
            log.error("插入的list不能为null");
        } else if (list.isEmpty()) {
            log.warn("插入的list为空");
            return null;
        }
        return getMongoTemplate().insert(list, collectionName);
    }

    /**
     * 保存一个集合
     *
     * @param list 集合
     * @return 集合结果
     */
    public Collection<E> insert(List<E> list) {
        if (list == null) {
            log.error("插入的list不能为null");
        } else if (list.isEmpty()) {
            log.warn("插入的list为空");
            return null;
        }
        return getMongoTemplate().insert(list, this.getEClass());
    }


    /**
     * count
     *
     * @param query 条件
     * @return 条数
     */
    public long count(Query query) {
        return getMongoTemplate().count(query, this.getEClass());
    }

    /**
     * 条数
     *
     * @param query          条件
     * @param collectionName 集合名
     * @return 条数
     */
    public long count(Query query, String collectionName) {
        return getMongoTemplate().count(query, this.getEClass(), collectionName);
    }
}
