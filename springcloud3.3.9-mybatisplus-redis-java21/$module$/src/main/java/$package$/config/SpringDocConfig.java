package $package$.config;


import io.swagger.v3.oas.models.OpenAPI;
import io.swagger.v3.oas.models.info.Info;
import org.springdoc.core.models.GroupedOpenApi;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author $author$
 */
@Configuration
public class SpringDocConfig {

    @Bean
    public OpenAPI springOpenAPI() {
        return new OpenAPI()
                .info(new Info()
                        .title("$projectName$ RESTful APIs")
                        .description("$projectName$ 应用")
                        .version("1.0"));
    }


    @Bean
    public GroupedOpenApi groupedOpenApi() {
        return GroupedOpenApi.builder()
                .group("java 21")
                .pathsToMatch("/**")
                .packagesToScan("$package$")
                .build();
    }
}
