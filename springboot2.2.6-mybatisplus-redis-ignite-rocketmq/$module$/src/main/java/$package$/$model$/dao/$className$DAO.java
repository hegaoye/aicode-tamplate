package $package$.$model$.dao;

import $package$.$model$.dao.mapper.$className$Mapper;
import $package$.$model$.entity.$className$;
import $package$.core.base.BaseDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/**
 * $className$ DAO
 * 数据服务层
 *
 * @author bruce
 */
@Repository
public class $className$DAO extends BaseDAO<$className$Mapper, $className$> {


    /**
     * $className$ mapper
     */
    @Autowired
    private $className$Mapper $classNameLower$Mapper;


}