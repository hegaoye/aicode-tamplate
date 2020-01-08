/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.upload;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.enums.BucketNameEnum;
import ${basePackage}.core.tools.DateTools;
import ${basePackage}.core.tools.HandleFuncs;
import ${basePackage}.thirdparty.upload.config.QiniuConfig;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * 文件上传工具类
 * 用于文件的上传
 * 包括非图片，图片及其其他文件格式
 * 并自动上到七牛服务器上
 *
 * @author borong
 */
@Slf4j
public class QiNiuUpTools {
    /**
     * 项目路径
     */
    private static final String PROJECTPATH;

    static {
        PROJECTPATH = HandleFuncs.getInstance().getCurrentClassPath();
    }

    private static String upload_temp_dir;

    //密钥配置
    private static Auth auth;

    public static Auth getAuth() {
        if (auth == null) {
            auth = Auth.create(QiniuConfig.getAK(), QiniuConfig.getSK());
        }
        return auth;
    }

    //创建上传对象
    private static UploadManager uploadManager;

    public static UploadManager getUploadManager() {
        if (uploadManager == null) {
            uploadManager = new UploadManager(new Configuration());
        }
        return uploadManager;
    }

    //简单上传，使用默认策略，只需要设置上传的空间名就可以了
    public static String getUpToken() {
        return getAuth().uploadToken(QiniuConfig.getBucket_name());
    }

    //文件上传单例模式
    private static QiNiuUpTools instance;

    public static QiNiuUpTools getInstance() {
        if (instance == null) {
            instance = new QiNiuUpTools();
        }
        return instance;
    }

    public QiNiuUpTools() {
        if (StringUtils.isEmpty(upload_temp_dir)) {
            upload_temp_dir = QiniuConfig.getUpload_temp_dir();
        }
        //确定upload临时文件开头有 "/"
        upload_temp_dir = upload_temp_dir.startsWith("/") ? upload_temp_dir : "/" + upload_temp_dir;
        //确定upload临时文件结尾有 "/"
        upload_temp_dir = upload_temp_dir.endsWith("/") ? upload_temp_dir : upload_temp_dir + "/";
    }

    //七牛云删除 begin
    public static Configuration config = new Configuration(Zone.autoZone());

    // 七牛云上传  begin ------------------------

    /**
     * 上传文件到七牛云
     *
     * @param filePaths 文件本地路径
     * @throws IOException
     */
    private void upload(String[] filePaths, BucketNameEnum bucketNameEnum) {
        for (String filePath : filePaths) {

            String key = bucketNameEnum.name() + "/" + DateTools.dateToNum8(new Date()) + "/" + getFileName(filePath);

            Response response = null;
            try {
                //调用put方法上传
                response = getUploadManager().put(filePath, key, getUpToken());
                // 打印返回的信息
                while (!response.isOK()) {//上传不成功再上传，直到成功为止
                    response = getUploadManager().put(filePath, key, getUpToken());
                }
            } catch (QiniuException e) {
                e.printStackTrace();
                response = null;
            } finally {
                if (response != null) {
                    response = null;
                }
            }
        }
    }
    // 七牛云上传  end ------------------------

    /**
     * 上传单个文件到FTP服务器 （对外）
     * 如果是图片，按照默认压缩类型进行压缩
     *
     * @param inputStream       文件对象流数组
     * @param toSaveFilePath    ftp保存路径 [/xxx/xxx/]
     * @param toSaveFileNewName 期望保存的文件名 [xxxx|xxxx]
     * @param fileType          文件类型
     * @return
     * @throws Exception
     */
    public BeanRet uploadSingleFile(InputStream inputStream, String toSaveFilePath, String toSaveFileNewName, String fileType, BucketNameEnum bucketNameEnum) throws IOException {
        BeanRet beanRet = this.uploadFile(new InputStream[]{inputStream}, toSaveFilePath, toSaveFileNewName, new String[]{fileType}, true, bucketNameEnum);
        List<String> filePaths = JSON.parseArray(beanRet.getData().toString(), String.class);
        String filePath = filePaths.get(0);
        beanRet.setData(filePath);
        return beanRet;
    }

    /**
     * 上传多个文件(图片非图片都可以)到FTP服务器 （对外）
     * 1，上传原文件到项目临时目录下
     * 2，如果是图片，压缩不同规格的图片上传到临时目录下
     * 3，上传文件到ftp服务器目录下
     * 4，删除项目下临时文件
     *
     * @param inputStreams      文件对象流数组
     * @param toSaveFilePath    ftp保存路径 [/xxx/xxx/]
     * @param toSaveFileNewName 期望保存的文件名 [xxxx|xxxx]
     * @param fileTypes         文件类型数组
     * @param isWait            是否等待
     * @param bucketNameEnum
     * @return
     * @throws Exception
     */
    private BeanRet uploadFile(InputStream[] inputStreams, String toSaveFilePath, String toSaveFileNewName, String[] fileTypes, boolean isWait, BucketNameEnum bucketNameEnum) throws IOException {
        //1.上传原文件到项目临时目录下
        List<String> filePaths = LocalUpTools.getInstance().uploadFile(inputStreams, toSaveFilePath, toSaveFileNewName, fileTypes);
        if (log.isInfoEnabled()) {
            log.info("上传原图到项目临时目录下 >> " + JSON.toJSONString(filePaths));
        }
        if (filePaths == null || filePaths.size() == 0) {
            return BeanRet.create(false, "上传失败！");
        }
        //3.上传到七牛云
        if (isWait) {
            upload(filePaths.toArray(new String[filePaths.size()]), bucketNameEnum);
        }
        List<String> resultPaths = new ArrayList<>();
        filePaths.forEach(filePath -> {
            resultPaths.add(QiniuConfig.getService() + "/" + bucketNameEnum.name() + "/" + DateTools.dateToNum8(new Date()) + "/" + getFileName(filePath));
        });
        //删除临时目录下的文件  begin
        java.util.concurrent.Executors.newSingleThreadExecutor().execute(new Runnable() {
            @Override
            public void run() {
                try {
                    //4.删除项目下临时文件
                    String toSaveFilePath1 = toSaveFilePath.substring(toSaveFilePath.indexOf("/") + 1);
                    toSaveFilePath1 = toSaveFilePath1.substring(0, toSaveFilePath1.indexOf("/"));
                    File file = new File(PROJECTPATH + upload_temp_dir + toSaveFilePath1);
                    FileUtils.deleteDirectory(file);
                    if (log.isDebugEnabled()) {
                        log.debug("删除临时文件：" + PROJECTPATH + upload_temp_dir + toSaveFilePath1);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
        //删除临时目录下的文件  end
        if (!resultPaths.isEmpty()) {
            return BeanRet.create(true, "上传成功！", JSON.toJSONString(resultPaths));
        }
        return BeanRet.create(false, "上传失败！");
    }

    /**
     * 根据文件获得文件的后缀名
     *
     * @param multipartFile
     * @return
     */
    public static String getFileSuffix(MultipartFile multipartFile) {
        String filename = multipartFile.getOriginalFilename();
        return filename.substring(filename.lastIndexOf(".") + 1).toLowerCase();
    }

    /**
     * 根据文件获得文件的后缀名
     *
     * @param imageFileUrlOrPath
     * @return
     */
    public static String getFileSuffix(String imageFileUrlOrPath) {
        return imageFileUrlOrPath.substring(imageFileUrlOrPath.lastIndexOf(".") + 1).toLowerCase();
    }

    /**
     * 根据文件路径获得文件的名称带后缀
     *
     * @param filePath
     * @return
     */
    private static String getFileName(String filePath) {
        return filePath.substring(filePath.lastIndexOf("/") + 1).toLowerCase();
    }


}