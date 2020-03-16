package $package$.$model$.dao;

import $package$.core.base.MongoBaseDAO;
import $package$.$model$.entity.$className$;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Repository;

/**
 * $notes$
 * $className$ DAO
 * 数据服务层
 *
 * @author $author$
 */
@Repository
public class $className$MongoDAO extends MongoBaseDAO<$className$> {

    @Autowired
    private MongoTemplate mongoTemplate;

    @Override
    protected MongoTemplate getMongoTemplate() {
        return mongoTemplate;
    }
}
