package $package$.config;

import com.baomidou.mybatisplus.core.MybatisConfiguration;
import com.baomidou.mybatisplus.core.MybatisXMLLanguageDriver;
import com.baomidou.mybatisplus.core.config.GlobalConfig;
import com.baomidou.mybatisplus.extension.plugins.MybatisPlusInterceptor;
import com.baomidou.mybatisplus.extension.spring.MybatisSqlSessionFactoryBean;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.type.JdbcType;
import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;

@Configuration
@MapperScan(basePackages = "$package$.*.dao.mapper", sqlSessionTemplateRef = "tidbSqlSessionTemplate")
public class MybatisPlusConfigTidb {

    @Autowired
    private MybatisPlusMetaObjectHandler mybatisPlusMetaObjectHandler;

    @Autowired
    private MybatisPlusInterceptor mybatisPlusInterceptor;

    @Primary
    @Bean("tidbSqlSessionFactory")
    public SqlSessionFactory tidbSqlSessionFactory(@Qualifier("tidbDataSource") DataSource dataSource) throws Exception {
        MybatisSqlSessionFactoryBean sqlSessionFactory = new MybatisSqlSessionFactoryBean();
        sqlSessionFactory.setDataSource(dataSource);
        MybatisConfiguration configuration = new MybatisConfiguration();
        configuration.setDefaultScriptingLanguage(MybatisXMLLanguageDriver.class);
        configuration.setJdbcTypeForNull(JdbcType.NULL);
        sqlSessionFactory.setConfiguration(configuration);
        sqlSessionFactory.setMapperLocations(new PathMatchingResourcePatternResolver().
                getResources("classpath:mapper/*/*.xml"));
        sqlSessionFactory.setPlugins(new Interceptor[]{
                mybatisPlusInterceptor
        });

        GlobalConfig globalConfig = new GlobalConfig();
        globalConfig.setMetaObjectHandler(mybatisPlusMetaObjectHandler);
        sqlSessionFactory.setGlobalConfig(globalConfig.setBanner(false));
        return sqlSessionFactory.getObject();
    }

    @Primary
    @Bean(name = "tidbTransactionManager")
    public DataSourceTransactionManager tidbTransactionManager(@Qualifier("tidbDataSource") DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

    @Primary
    @Bean(name = "tidbSqlSessionTemplate")
    public SqlSessionTemplate tidbSqlSessionTemplate(@Qualifier("tidbSqlSessionFactory") SqlSessionFactory sqlSessionFactory) {
        return new SqlSessionTemplate(sqlSessionFactory);
    }

}