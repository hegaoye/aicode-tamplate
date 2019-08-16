/*
 * ${copyright}
 */
package ${basePackage}.base;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.enums.BucketNameEnum;
import ${basePackage}.core.enums.FileTypeEnum;
import ${basePackage}.core.enums.FormatEnum;
import ${basePackage}.core.redis.RedisKey;
import ${basePackage}.core.redis.RedisUtils;
import ${basePackage}.core.tools.DateTools;
import ${basePackage}.core.tools.file.PathTools;
import ${basePackage}.thirdparty.upload.QiNiuUpTools;
import ${basePackage}.thirdparty.upload.entity.UploadBasicEntity;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import java.util.Date;

/**
 * Created by ${author}
 */
public class BaseUploadCtrl {
    @Resource
    public RedisUtils redisUtils;
    //文件上传的临时目录
    private static String upload_limit_suffix_file = FormatEnum.upload_limit_suffix_file.val;

    public BeanRet uploadFile(MultipartFile limitFile, String uuid, BucketNameEnum bucketNameEnum) {
        try {
            String redisKey = RedisKey.genUploadKey(uuid);
            String uploadBasicEntityJSON = (String) redisUtils.get(redisKey);
            UploadBasicEntity uploadBasicEntity = JSON.parseObject(uploadBasicEntityJSON, UploadBasicEntity.class);
            //1.上传文件
            String toSaveFileNewName = String.valueOf(System.currentTimeMillis());
            if (bucketNameEnum == null) {
                bucketNameEnum = BucketNameEnum.common;
            }
            String toSaveFilePath = PathTools.getBasicRelative(bucketNameEnum.name() + "/" + DateTools.dateToNum14(new Date()));
            String fileType = QiNiuUpTools.getFileSuffix(limitFile);
            if (!upload_limit_suffix_file.contains(fileType)) {
                fileType = FileTypeEnum.getEnum(limitFile.getContentType()).name();
                if (upload_limit_suffix_file.contains(fileType)) {
                    return BeanRet.create(false, "上传文件的类型不合法");
                }
            }

            QiNiuUpTools qiniuUpTools = QiNiuUpTools.getInstance();
            System.out.println("qiniuUpTools:" + qiniuUpTools);

            //使用七牛云作为图片服务器
            BeanRet beanRet = QiNiuUpTools.getInstance().uploadSingleFile(limitFile.getInputStream(), toSaveFilePath, toSaveFileNewName, fileType, bucketNameEnum);
            if (beanRet.isSuccess()) {
                BeanRet br = BeanRet.create(true, "上传文件成功", beanRet.getData());
                //2.更新缓存

                String filePath = beanRet.getData().toString();
                //返回文件半路径 begin 如果不返回半路经，那么注释此段
//                filePath = filePath.replace("//", "");
//                if (filePath.contains("/")) {
//                    filePath = filePath.substring(filePath.indexOf("/"));
//                }
                //返回文件半路径 end
                uploadBasicEntity.setData(filePath);
                uploadBasicEntity.setFileType(fileType);
                if (uploadBasicEntity.getState().equals(UploadBasicEntity.UploadState.UPDATED.name())) {
                    uploadBasicEntity.setState(UploadBasicEntity.UploadState.UPLOADED.name());
                    redisUtils.set(redisKey, JSON.toJSONString(uploadBasicEntity));
                    br.setData(uploadBasicEntity.getUniqueCode());
                } else if (uploadBasicEntity.getState().equals(UploadBasicEntity.UploadState.CREATED.name())) {
                    uploadBasicEntity.setState(UploadBasicEntity.UploadState.UPLOADED.name());
                    redisUtils.set(redisKey, JSON.toJSONString(uploadBasicEntity));
                }
                return br;
            } else {
                return BeanRet.create(false, "上传文件失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            return BeanRet.create(false, e.getMessage());
        }
    }


    /**
     * 为多功能编辑器中的上传准备
     * 上传文件到FTP，返回的文件URL
     *
     * @param limitFile      文件对象
     * @param bucketNameEnum 上传的文件夹名
     * @return
     */
    public BeanRet uploadFileRetURL(MultipartFile limitFile, BucketNameEnum bucketNameEnum) {
        try {
            BeanRet beanRet = uploadFileRetHttpURL(limitFile, bucketNameEnum);
            String filePath = beanRet.getData().toString();
            filePath = filePath.replace("//", "");
            if (filePath.contains("/")) {
                filePath = filePath.substring(filePath.indexOf("/"));
            }
            beanRet.setData(filePath);
            //返回文件半路径
            return beanRet;
        } catch (Exception e) {
            return BeanRet.create(false, e.getMessage());
        }
    }

    /**
     * 为多功能编辑器中的上传准备
     * 上传文件到FTP，返回的文件完整URL
     *
     * @param limitFile      文件对象
     * @param bucketNameEnum 上传的文件夹名
     * @return
     */
    public BeanRet uploadFileRetHttpURL(MultipartFile limitFile, BucketNameEnum bucketNameEnum) {
        try {
            //1.上传文件
            String toSaveFileNewName = String.valueOf(System.currentTimeMillis());
            if (bucketNameEnum == null) {
                bucketNameEnum = BucketNameEnum.common;
            }
            String toSaveFilePath = PathTools.getBasicRelative(bucketNameEnum.name() + "/" + DateTools.dateToNum14(new Date()));
            //上传到七牛云
            String fileType = QiNiuUpTools.getFileSuffix(limitFile);
            if (!upload_limit_suffix_file.contains(fileType)) {
                fileType = FileTypeEnum.getEnum(limitFile.getContentType()).name();
                if (upload_limit_suffix_file.contains(fileType)) {
                    return BeanRet.create(false, "上传文件的类型不合法");
                }
            }
            BeanRet beanRet = QiNiuUpTools.getInstance().uploadSingleFile(limitFile.getInputStream(), toSaveFilePath, toSaveFileNewName, fileType, bucketNameEnum);
            //返回文件完整路径，直接可以通过此路径在浏览器中访问此文件
            return beanRet;
        } catch (Exception e) {
            return BeanRet.create(false, e.getMessage());
        }
    }

}
