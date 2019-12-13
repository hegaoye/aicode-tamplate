/*
 * ${copyright}
 */
package ${basePackage}.core.config;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@ConfigurationProperties(prefix = "upload")
public class UploadConfig {

    //文件上传目录
    @Getter
    private static String local_path;

    //系统限制上传文件最大字节数（单位：字节；1mb=1048576b）
    @Getter
    private static long file_max_byte;

    //图片服务器地址
    @Getter
    public static String service;

    @Value("${r'${upload.local_path}'}")
    public void setLocal_path(String local_path) {
        UploadConfig.local_path = local_path;
    }

    @Value("${r'${upload.file_max_byte}'}")
    public void setFile_max_byte(long file_max_byte) {
        UploadConfig.file_max_byte = file_max_byte;
    }

    @Value("${r'${upload.service}'}")
    public void setService(String service) {
        UploadConfig.service = service;
    }
}
