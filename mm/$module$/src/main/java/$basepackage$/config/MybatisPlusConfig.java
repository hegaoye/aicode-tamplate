package $basepackage$.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;


/**
 * mybatis-plus 注入扫描
 */
@Configuration
@ComponentScan(basePackages = {"$basepackage$.*", "com.baidu.*"})
@MapperScan({"$basepackage$.*.dao.mapper", "com.baidu.fsg.uid.worker.dao"})
public class MybatisPlusConfig {
}
