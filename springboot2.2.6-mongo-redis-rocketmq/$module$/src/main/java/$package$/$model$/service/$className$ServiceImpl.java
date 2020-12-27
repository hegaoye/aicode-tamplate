/*
 * $copyright$
 */
package $package$.$model$.service;

import $package$.$model$.dao.$className$MongoDAO;
import $package$.$model$.entity.$className$;
import $package$.core.exceptions.BaseException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

/**
 * $notes$
 *
 * @author $author$
 */
@Slf4j
@Service
public class $className$ServiceImpl implements $className$Service {

    @Autowired
    private $className$MongoDAO $classNameLower$DAO;


    /**
     * 查询详情
     *
     * @param $classNameLower$
     * @return $className$
     */
    @Override
    public $className$ load($className$ $classNameLower$) {
        Query query = new Query();
        Criteria criteria = new Criteria();

        /***
         for(pkField in pkFields){
         ***/
        if (StringUtils.isNotBlank($classNameLower$.get$pkField.upper$())) {
            criteria.and("$pkField.field$").is($classNameLower$.get$pkField.upper$());
        }
        /***}***/

        query.addCriteria(criteria);
        $className$ $className$Load = $classNameLower$DAO.findOne(query);
        return $className$Load;
    }

    /**
     * 保存
     *
     * @param $classNameLower$ 对象
     * @return $className$
     */
    @Transactional(rollbackFor = BaseException.class)
    public $className$ save($className$ $classNameLower$) {
        $classNameLower$.setCreateTime(new Date());
        $classNameLower$.setModifyTime(new Date());
        return $classNameLower$DAO.insert($classNameLower$);
    }

    /**
     * 修改
     *
     * @param $classNameLower$
     * @return $className$
     */
    @Override
    public $className$ modify($className$ $classNameLower$) {
        Query query = new Query();
        query.addCriteria(Criteria.where("id").is($classNameLower$.getId()));
        return $classNameLower$DAO.findAndReplace(query, $classNameLower$);
    }

    /**
     * 根据id删除
     *
     * @param id
     */
    @Override
    public void delete(Long id) {
        $classNameLower$DAO.remove(id);
    }

    /**
     * 分页查询
     *
     * @param $classNameLower$ 条件
     * @param curPage     当前页
     * @param pageSize    条数
     * @return List<$className$>
     */
    @Override
    public List<$className$> list($className$ $classNameLower$, Integer curPage, Integer pageSize) {
        Query query = new Query();
        Criteria criteria = new Criteria();
        /***
         for(pkField in pkFields){
         ***/
        if (StringUtils.isNotBlank($classNameLower$.get$pkField.upper$())) {
            criteria.and("$pkField.field$").is($classNameLower$.get$pkField.upper$());
        }
        /***}***/
        query.addCriteria(criteria);
        return $classNameLower$DAO.findList(query, curPage, pageSize);
    }

    /**
     * 统计总数
     *
     * @param $classNameLower$
     * @return 统计总数
     */
    @Override
    public long count($className$ $classNameLower$) {
        Query query = new Query();
        Criteria criteria = new Criteria();
        /***
         for(pkField in pkFields){
         ***/
        if (StringUtils.isNotBlank($classNameLower$.get$pkField.upper$())) {
            criteria.and("$pkField.field$").is($classNameLower$.get$pkField.upper$());
        }
        /***}***/
        return $classNameLower$DAO.count(query.addCriteria(criteria));
    }


}
