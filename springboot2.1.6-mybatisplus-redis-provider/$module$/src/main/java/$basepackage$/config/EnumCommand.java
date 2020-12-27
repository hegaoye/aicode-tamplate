package $package$.config;

import com.baomidou.mybatisplus.core.toolkit.CollectionUtils;
import $package$.cache.entity.RedisKey;
import $package$.cache.service.RedisServiceSVImpl;
import $package$.core.annotation.CacheEnumTools;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;


@Component
@Order(value = 100)
@Slf4j
public class EnumCommand implements CommandLineRunner {


    @Autowired
    private RedisServiceSVImpl redisServiceSV;


    @Override
    public void run(String... args) throws Exception {
        List<Map<String, Map<String, String>>> list = CacheEnumTools.Instance.getCacheEnumList("$package$");
        if (CollectionUtils.isEmpty(list)) {
            return;
        }

        String cachekey = RedisKey.getCachekey();
        for (Map<String, Map<String, String>> map : list) {
            for (Map.Entry<String, Map<String, String>> mapEntry : map.entrySet()) {
                String hashKey = mapEntry.getKey();
                redisServiceSV.putForHash(cachekey, hashKey, mapEntry.getValue());
                log.info("缓存枚举值 : " + map);
            }

        }

    }


}
