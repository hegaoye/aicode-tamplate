package $package$.config;

import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;

/**
 * 多数据源配置
 */
@Configuration
public class DataSourceConfig {
    @Bean(name = "igniteDataSourceProperties")
    @ConfigurationProperties(prefix = "spring.datasource.ignite")
    public DataSourceProperties igniteDataSourceProperties() {
        return new DataSourceProperties();
    }

    @Bean("igniteDataSource")
    public DataSource igniteDataSource(@Qualifier("igniteDataSourceProperties") DataSourceProperties igniteDataSourceProperties) {
        return igniteDataSourceProperties.initializeDataSourceBuilder().build();
    }


    //第二个uid数据源配置
    @Primary
    @Bean(name = "uidDataSourceProperties")
    @ConfigurationProperties(prefix = "spring.datasource.uid")
    public DataSourceProperties uidDataSourceProperties() {
        return new DataSourceProperties();
    }

    //第二个uid数据源
    @Primary
    @Bean("uidDataSource")
    public DataSource uidDataSource(@Qualifier("uidDataSourceProperties") DataSourceProperties uidDataSourceProperties) {
        return uidDataSourceProperties.initializeDataSourceBuilder().build();
    }
}
