package $package$.core.base;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * 通用DAO接口.
 *
 * @author bruce 11-12-12 下午10:37
 */
@Slf4j
public abstract class BaseDAO<M extends BaseMapper<E>, E> {
    @Autowired
    protected M baseMapper;

    /**
     * 分页查询
     *
     * @param queryWrapper 分页查询条件
     * @param offset       起始行
     * @param limit        步长
     * @return List<E>
     */
    public List<E> list(QueryWrapper<E> queryWrapper, int offset, int limit) {
        return baseMapper.selectList(queryWrapper.lambda().last("limit " + offset + "," + limit));
    }

}
