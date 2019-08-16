/*
 * ${copyright}
 */
package ${basePackage}.thirdparty.upload;


import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.tools.HandleFuncs;
import ${basePackage}.thirdparty.upload.config.QiniuConfig;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;

/**
 * 文件上传工具类
 * 用于文件的上传 到本地目录下
 * 包括非图片，图片及其其他文件格式
 * Created by ${author}
 */
@Slf4j
public class LocalUpTools {

    /**
     * 项目路径
     */
    private static final String PROJECTPATH = HandleFuncs.getInstance().getCurrentClassPath();

    private static String upload_temp_dir;

    /**
     * 文件上传单例模式
     */
    private static LocalUpTools instance;

    public static LocalUpTools getInstance() {
        if (instance == null) {
            instance = new LocalUpTools();
        }
        return instance;
    }

    public LocalUpTools() {
        if (StringUtils.isEmpty(upload_temp_dir)) {
            upload_temp_dir = QiniuConfig.getUpload_temp_dir();
        }
        //确定upload临时文件开头有 "/"
        upload_temp_dir = upload_temp_dir.startsWith("/") ? upload_temp_dir : "/" + upload_temp_dir;
        //确定upload临时文件结尾有 "/"
        upload_temp_dir = upload_temp_dir.endsWith("/") ? upload_temp_dir : upload_temp_dir + "/";
    }

    /**
     * 上传文件到到本地临时目录
     *
     * @param inputStreams      文件对象流数组
     * @param toSaveFilePath    ftp保存路径 [/xxx/xxx/]
     * @param toSaveFileNewName 期望保存的文件名 [xxxx|xxxx]
     * @param fileTypes         文件类型数组
     * @return
     * @throws Exception
     */
    public java.util.List<String> uploadFile(InputStream[] inputStreams, String toSaveFilePath, String toSaveFileNewName, String[] fileTypes) throws IOException {
        java.util.List<String> imgnames = new ArrayList<>();
        toSaveFilePath = toSaveFilePath.startsWith("/") ? toSaveFilePath.substring(1) : toSaveFilePath;
        toSaveFilePath = toSaveFilePath.endsWith("/") ? toSaveFilePath : toSaveFilePath + "/";
        int i = 1;
        for (InputStream inputStream : inputStreams) {
            //检查文件大小是否超出系统限制
            if (this.isOverflowFileSize(Long.parseLong(String.valueOf(inputStream.available())))) {
                throw new BaseException(BaseException.ExceptionEnums.upload_file_size_overflow.codeEnum.descs + "；请确认上传文件在[" + Math.floor(getProjectFileUploadMaxMb()) + "Mb]以内");
            }
            String fileNewName = toSaveFileNewName.indexOf(".") == -1 ? toSaveFileNewName + "-" + i + "." + fileTypes[i - 1] : toSaveFileNewName.substring(0, toSaveFileNewName.indexOf(".")) + "-" + i + "." + fileTypes[i - 1];
            log.info(" fileNewName >> " + fileNewName);
//            String filePath = PROJECTPATH + upload_temp_dir + toSaveFilePath;
            String filePath = PROJECTPATH + upload_temp_dir + "/" + toSaveFilePath;
            log.info(" >> " + filePath);
            File toUploadFile = new File(filePath, fileNewName);
            FileUtils.copyInputStreamToFile(inputStream, toUploadFile);/* 上传文件到临时目录下 */
            imgnames.add(filePath + fileNewName);
            i++;
        }
        return imgnames;
    }


    /**
     * 过滤文件大小是否超出系统限制
     *
     * @param fileByte 文件字节数
     * @return true 可以上传 / false 不可以上传
     */
    private boolean isOverflowFileSize(Long fileByte) {
        //获得项目设定的上传文件最大字节数
        Long projectFileUploadMaxByte = getProjectFileUploadMaxByte();
        return (fileByte.compareTo(projectFileUploadMaxByte) > 0) ? true : false;
    }

    /**
     * 获得系统限制上传文件最大byte
     *
     * @return
     */
    private Long getProjectFileUploadMaxByte() {
        return QiniuConfig.getUpload_img_size();
    }

    /**
     * 获得系统限制上传文件最大mb
     *
     * @return
     */
    private Long getProjectFileUploadMaxMb() {
        return (getProjectFileUploadMaxByte() / 1048576);
    }

}