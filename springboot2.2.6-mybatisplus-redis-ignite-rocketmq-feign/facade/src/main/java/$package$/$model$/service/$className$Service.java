/*
 * $copyright$
 */
package $package$.$model$.service;

import $package$.$model$.entity.$className$;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * $notes$
 *
 * @author $author$
 */
public interface $className$Service extends IService<$className$> {

    /**
     * 分页查询
     *
     * @param queryWrapper 查询条件
     * @param offset       起始行
     * @param limit        步长
     * @return List<$className$>
     */
    List<$className$> list(QueryWrapper<$className$> queryWrapper, int offset, int limit);
}


