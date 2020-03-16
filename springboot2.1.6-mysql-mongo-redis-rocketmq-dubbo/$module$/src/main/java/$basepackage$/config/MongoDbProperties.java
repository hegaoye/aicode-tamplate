package $package$.config;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import java.util.List;


@ConfigurationProperties(prefix = "spring.data.mongodb")
@Data
public class MongoDbProperties {
    /**
     * 数据库名称
     */
    @NotBlank
    private String database;

    /**
     * 主机地址(ip地址与端口)
     */
    @NotEmpty
    private List<String> address;
    /**
     * 分片设置
     */
    private String replicaSet;
    /**
     * mongodb用户名
     */
    private String username;
    /**
     * mongodb密码
     */
    private String password;
    /**
     * 数据安全
     */
    private String authenticationDatabase;
    /**
     * 为客户端的连接数
     */
    private Integer minConnectionsPerHost = 20;
    /**
     * 每个host允许链接的最大链接数,这些链接空闲时会放入池中,
     * 如果链接被耗尽，
     * 任何请求链接的操作会被阻塞等待链接可用
     */
    private Integer connectionsPerHost = 20;
}
