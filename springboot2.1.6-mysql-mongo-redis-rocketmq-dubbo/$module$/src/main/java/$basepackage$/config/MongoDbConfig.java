package $package$.config;

import com.mongodb.MongoClient;
import com.mongodb.MongoClientOptions;
import com.mongodb.MongoCredential;
import com.mongodb.ServerAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.data.mongodb.MongoDbFactory;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.SimpleMongoDbFactory;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


@Configuration
@EnableConfigurationProperties({MongoDbProperties.class})
public class MongoDbConfig {

    final static String SPLIT_CHAR = ";";
    final static String SPLIT_CHAR_COLON = ":";

    @Bean
    @Autowired
    public MongoDbFactory mongoDbFactory(MongoDbProperties mongoSettingProperties) {
        MongoClientOptions.Builder builder = new MongoClientOptions.Builder();
        builder.connectionsPerHost(mongoSettingProperties.getConnectionsPerHost());
        builder.minConnectionsPerHost(mongoSettingProperties.getMinConnectionsPerHost());
        if (mongoSettingProperties.getReplicaSet() != null && !"".equals(mongoSettingProperties.getReplicaSet())) {
            builder.requiredReplicaSetName(mongoSettingProperties.getReplicaSet());
        }
        MongoClientOptions mongoClientOptions = builder.build();
        List<ServerAddress> serverAddresses = new ArrayList<>();
        /**
         * 处理配置项中的主机与端口
         */
        for (String address : mongoSettingProperties.getAddress()) {
            String[] addressArray = address.split(SPLIT_CHAR);
            if (addressArray != null && addressArray.length > 0) {
                Arrays.stream(addressArray).forEach(host -> {
                    String[] hostAndPort = host.split(SPLIT_CHAR_COLON);
                    if (hostAndPort != null && hostAndPort.length > 1) {
                        ServerAddress serverAddress = new ServerAddress(hostAndPort[0], Integer.parseInt(hostAndPort[1]));
                        serverAddresses.add(serverAddress);
                    }
                });
            }
        }
        // 连接认证
        List<MongoCredential> mongoCredentialList = new ArrayList<>();
        if (mongoSettingProperties.getUsername() != null) {
            mongoCredentialList.add(MongoCredential.createScramSha1Credential(
                    mongoSettingProperties.getUsername(),
                    mongoSettingProperties.getAuthenticationDatabase() != null ? mongoSettingProperties.getAuthenticationDatabase() : mongoSettingProperties.getDatabase(),
                    mongoSettingProperties.getPassword().toCharArray()));
        }
        if (serverAddresses == null || serverAddresses.isEmpty()) {
            return null;
        }
        MongoClient mongoClient = new MongoClient(serverAddresses, mongoCredentialList, mongoClientOptions);
        MongoDbFactory mongoDbFactory = new SimpleMongoDbFactory(mongoClient, mongoSettingProperties.getDatabase());
        return mongoDbFactory;
    }

    @Bean
    public MongoTemplate mongoTemplate(@Autowired MongoDbFactory mongoDbFactory) {
        return new MongoTemplate(mongoDbFactory);
    }
}
