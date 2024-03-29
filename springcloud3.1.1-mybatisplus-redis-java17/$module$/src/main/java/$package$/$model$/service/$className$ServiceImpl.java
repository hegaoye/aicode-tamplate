/*
 * $copyright$
 */
package $package$.$model$.service;

import $package$.$model$.dao.mapper.$className$Mapper;
import $package$.$model$.entity.$className$;
import com.baidu.fsg.uid.UidGenerator;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import $package$.$model$.dao.$className$DAO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


/**
 * $notes$
 *
 * @author $author$
 */
@Slf4j
@Service
public class $className$ServiceImpl extends ServiceImpl<$className$Mapper, $className$> implements $className$Service {

    @Autowired
    private $className$DAO $classNameLower$DAO;

    @Autowired
    private UidGenerator uidGenerator;

    @Transactional
    @Override
    public boolean save($className$ entity) {
//        entity.setId(String.valueOf(uidGenerator.getUID()));
        return super.save(entity);
    }

}


