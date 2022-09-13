package $package$.$model$.mq.consumer;

import $package$.$model$.service.$className$Service;
import $package$.$model$.entity.$className$;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import java.util.function.Consumer;

/**
 * $model$消费入口
 */
@Slf4j
@Service
public class $className$Receptor {

    @Autowired
    private $className$Service $classNameLower$Service;

    /**
     * 监听 创建 $model$ 数据消费
     */
    @Bean
    public Consumer<Setting> $classNameLower$Event() {
        return return message -> {
            log.info("{}", message);
            try {
                $classNameLower$Service.save(message);
            } catch (Exception e) {
                log.error("异常-{}-异常信息-{}", message.getPayload(), e.getMessage());
            }
        };
    }

}
