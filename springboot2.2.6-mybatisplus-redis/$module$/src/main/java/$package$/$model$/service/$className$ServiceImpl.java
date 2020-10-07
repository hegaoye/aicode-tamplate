/*
 * $copyright$
 */
package $package$.$model$.service;

import com.baidu.fsg.uid.UidGenerator;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import $package$.$model$.dao.$className$DAO;
import $package$.$model$.dao.mapper.$className$Mapper;
import $package$.$model$.entity.$className$;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;


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

    @Override
    public boolean save($className$ entity) {
//        entity.setId(String.valueOf(uidGenerator.getUID()));
        return super.save(entity);
    }

    /**
     * 分页查询 投注项水位
     *
     * @param queryWrapper 查询条件
     * @param offset       起始行
     * @param limit        步长
     * @return List<$className$>
     */
    @Override
    public List<$className$> list(QueryWrapper<$className$> queryWrapper, int offset, int limit) {
        return $classNameLower$DAO.list(queryWrapper, offset, limit);
    }
}


