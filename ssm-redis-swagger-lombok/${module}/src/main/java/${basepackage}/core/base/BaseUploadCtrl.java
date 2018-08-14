package com.shangze.core.base;

import com.alibaba.fastjson.JSON;
import com.rzhkj.core.common.UploadKey;
import com.rzhkj.core.entity.BeanRet;
import com.rzhkj.core.entity.UploadBasicEntity;
import com.rzhkj.core.enums.CommonEnums;
import com.rzhkj.core.tools.*;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;

/**
 * 基础上传控制器
 * Created by bobai on 2017/6/1.
 */
public class BaseUploadCtrl extends BaseCtrl {
    private final static Logger logger = LoggerFactory.getLogger(com.rzhkj.core.base.BaseUploadCtrl.class);

    //默认图片路径
    protected final static String UPLOAD_PATH = "files";
    //文件上传的临时目录
    private static String upload_limit_suffix_file = ConfigUtil.getValue("upload_limit_suffix_file", "upload_config.properties");

    public BeanRet uploadFile(MultipartFile limitFile, String uuid, BucketNameEnum bucketNameEnum) {
        try {
            isEmpty("uuid", uuid);
            isEmpty("limitFile", limitFile);
            String redisKey = UploadKey.genUploadKey(uuid);
            String uploadBasicEntityJSON = (String) redisUtils.get(redisKey);
            UploadBasicEntity uploadBasicEntity = JSON.parseObject(uploadBasicEntityJSON, UploadBasicEntity.class);
            isEmpty("uploadBasicEntity", uploadBasicEntity);
            //1.上传文件
            String toSaveFileNewName = String.valueOf(System.currentTimeMillis());
            if (StringUtils.isBlank(bucketNameEnum.val)) {
                bucketNameEnum.val = UPLOAD_PATH;
            }
            String toSaveFilePath = PathTools.getBasicRelative(bucketNameEnum.val + "/" + DateTools.dateToNum14(new Date()));
            String fileType = QiniuUpTools.getFileSuffix(limitFile);
            if (!upload_limit_suffix_file.contains(fileType)) {
                fileType = CommonEnums.FileType.getFileType(limitFile.getContentType()).name();
                if (upload_limit_suffix_file.contains(fileType)) {
                    return BeanRet.create(false, "上传文件的类型不合法");
                }
            }

            //使用七牛云作为图片服务器
            String filePath = QiniuUpTools.getInstance().uploadSingleFile(limitFile.getInputStream(), toSaveFilePath, toSaveFileNewName, fileType, bucketNameEnum);
            if (StringUtils.isNotBlank(filePath)) {
                BeanRet br = BeanRet.create(true, "上传文件成功");
                //2.更新缓存
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
            } else return BeanRet.create(false, "上传文件失败");
        } catch (Exception e) {
            logger.info("<< 上传文件 失败，原因是:" + e.getMessage());
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
            logger.info("<< 上传文件 失败，原因是:" + e.getMessage());
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
            isEmpty("limitFile", limitFile);
            //1.上传文件
            String toSaveFileNewName = String.valueOf(System.currentTimeMillis());
            if (StringUtils.isBlank(bucketNameEnum.val)) {
                bucketNameEnum.val = UPLOAD_PATH;
            }
            String toSaveFilePath = PathTools.getBasicRelative(bucketNameEnum.val + "/" + DateTools.dateToNum14(new Date()));
            //上传到七牛云
            String fileType = QiniuUpTools.getFileSuffix(limitFile);
            if (!upload_limit_suffix_file.contains(fileType)) {
                fileType = CommonEnums.FileType.getFileType(limitFile.getContentType()).name();
                if (upload_limit_suffix_file.contains(fileType)) {
                    return BeanRet.create(false, "上传文件的类型不合法");
                }
            }
            //返回文件完整路径，直接可以通过此路径在浏览器中访问此文件
            String filePath = QiniuUpTools.getInstance().uploadSingleFile(limitFile.getInputStream(), toSaveFilePath, toSaveFileNewName, fileType, bucketNameEnum);
            return BeanRet.create(true, "上传成功", filePath);
        } catch (Exception e) {
            logger.info("<< 上传文件 失败，原因是:" + e.getMessage());
            return BeanRet.create(false, e.getMessage());
        }
    }

}
