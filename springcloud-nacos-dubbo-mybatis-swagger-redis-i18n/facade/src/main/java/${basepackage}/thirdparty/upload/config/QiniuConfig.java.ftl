/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.upload.config;

import lombok.Getter;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Slf4j
@Component
@ConfigurationProperties(prefix = "qiniu")
public class QiniuConfig {

    //文件上传的临时目录
    @Getter
    private static String upload_temp_dir;

    //系统限制上传文件最大字节数（单位：字节；1mb=1048576b）
    @Getter
    private static long upload_img_size;

    //七牛云账号的 AK
    @Getter
    private static String AK;

    //七牛云账号的 SK
    @Getter
    private static String SK;

    //七牛云存储空间对象的名称
    @Getter
    private static String bucket_name;

    //图片服务器地址
    @Getter
    public static String service;

    @Value("${r'${qiniu.upload_temp_dir}'}")
    public void setUpload_temp_dir(String upload_temp_dir) {
        QiniuConfig.upload_temp_dir = upload_temp_dir;
    }

    @Value("${r'${qiniu.upload_img_size}'}")
    public void setUpload_img_size(long upload_img_size) {
        QiniuConfig.upload_img_size = upload_img_size;
    }

    @Value("${r'${qiniu.AK}'}")
    public void setAK(String AK) {
        QiniuConfig.AK = AK;
    }

    @Value("${r'${qiniu.SK}'}")
    public void setSK(String SK) {
        QiniuConfig.SK = SK;
    }

    @Value("${r'${qiniu.bucket_name}'}")
    public void setBucket_name(String bucket_name) {
        QiniuConfig.bucket_name = bucket_name;
    }

    @Value("${r'${qiniu.service}'}")
    public void setService(String service) {
        QiniuConfig.service = service;
    }
}
