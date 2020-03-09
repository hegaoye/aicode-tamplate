package $basepackage$.$model$.dao.mapper;

import $basepackage$.$model$.entity.$className$;
import $basepackage$.core.cache.MybatisRedisCache;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.CacheNamespace;
import org.springframework.stereotype.Repository;

/**
 * $className$ mapper
 * 直接与xml映射
 * $notes$
 *
 * @author $author$
 */
@Repository
@CacheNamespace(implementation = MybatisRedisCache.class, eviction = MybatisRedisCache.class)
public interface $className$Mapper extends BaseMapper<$className$> {

}
