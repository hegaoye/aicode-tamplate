/*
 * ${copyright}
 */
package ${basePackage}.core.upload;

import ${basePackage}.core.enums.BucketNameEnum;
import ${basePackage}.core.enums.FileTypeEnum;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.hutool.io.FileUtil;
import ${basePackage}.core.hutool.util.StrUtil;
import ${basePackage}.core.config.UploadConfig;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;

import static ${basePackage}.core.enums.FormatEnum.upload_limit_suffix_file;
import static ${basePackage}.core.exceptions.BaseException.ExceptionEnums;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/22 18:28
 * @Description: 文件上传工具
 */
@Slf4j
public class FileUploadUtil {


    //单例模式
    private static FileUploadUtil instance;

    public static FileUploadUtil getInstance() {
        if (instance == null) {
            instance = new FileUploadUtil();
        }
        return instance;
    }

    /**
     * 上传文件至本地服务器
     *
     * @param file
     * @param folders
     * @return 项目存放路径(相对本地存储路径)
     */
    public String uploadFileToLocal(MultipartFile file, BucketNameEnum folders) {
        if (null == file) {
            throw new BaseException(ExceptionEnums.uploadFileIsNull("图片"));
        }

        // 默认为测试目录，可删除目录下所有文件
        if (null == folders) {
            folders = BucketNameEnum.test;
        }

        // 上传文件类型
        String contentType = file.getContentType();
        if (log.isDebugEnabled()) {
            log.debug(">>> contentType [{}] >>>", contentType);
        }

        // 检查图片格式是否允许上传
        if (null == FileTypeEnum.getEnum(contentType)) {
            throw new BaseException(ExceptionEnums.paramFormatError("图片", upload_limit_suffix_file));
        }

        // 检查图片大小是否超限
        long fileSize = file.getSize();
        if (isOverrunFileSize(fileSize)) {
            throw new BaseException(ExceptionEnums.uploadFileSizeOverrun(getProjectFileUploadMaxMb()));
        }

        // 上传文件至本地
        String filePath = null;
        try {
            filePath = uploadFile(file.getBytes(), folders.path, file.getOriginalFilename());
        } catch (IOException e) {
            if (log.isErrorEnabled()) {
                log.error(">>> 文件-本地上传-异常 [{}] >>>", e.getMessage());
            }
            e.printStackTrace();
        }
        return filePath;
    }

    /**
     * 上传文件至本地
     *
     * @param file     文件的字节组
     * @param folders  上传文件存放的文件夹，支持多级
     * @param fileName 文件的新名
     * @throws Exception
     */
    public String uploadFile(byte[] file, String folders, String fileName) throws IOException {

        if (log.isDebugEnabled()) {
            log.debug(">>> file length [{}] >>>", file.length);
        }

        String localPath = UploadConfig.getLocal_path();
        // 如果上传路径结尾没有/，则添加/
        if (!localPath.endsWith("/")) {
            localPath = String.format("%s/", localPath);
        }

        if (StrUtil.isNotBlank(folders)) {
            // 如果上传文件夹的开头，有/，则去掉
            if (folders.startsWith("/")) {
                folders = folders.substring(1);
            }
            // 如果上传文件夹的结尾，没有/，则添加/
            if (!folders.endsWith("/")) {
                folders = String.format("%s/", folders);
            }
        }
        else {
            folders = "/";
        }

        Date now = new Date();
        // 文件名 + 日期+时间+随机数
        String date = String.format("%tY%tm%td", now, now, now);
        // 为文件夹进行日期分层
        folders = String.format("%s%s/", folders, date);

        // 上传的文件名
        String mainName = FileUtil.mainName(fileName);
        // 上传文件的扩展名（后缀）
        String extName = FileUtil.extName(fileName);

        // 获得当前时间串
        String timeStamp = String.format("%tH%tM%tS", now, now, now);
        fileName = String.format("%s_%s.%s", timeStamp, mainName, extName);


        if (log.isDebugEnabled()) {
            log.debug(">>> fileName [{}] >>>", fileName);
        }

        String filePath = String.format("%s%s", localPath, folders);

        // 创建文件夹
        File targetFile = new File(filePath);
        if (!targetFile.exists()) {
            targetFile.mkdirs();
        }

        if (log.isDebugEnabled()) {
            log.debug(">>> targetFile.getCanonicalPath() [{}] >>>", targetFile.getCanonicalPath());
            log.debug(">>> targetFile.getAbsolutePath() [{}] >>>", targetFile.getAbsolutePath());
        }

        // 文件流输出至指定文件夹位置
        FileOutputStream out = new FileOutputStream(String.format("%s%s", filePath, fileName));
        out.write(file);
        out.flush();
        out.close();

        // 返回图片新路径（文件夹+文件名）
        return String.format("%s%s", folders, fileName);
    }

    /**
     * 过滤文件大小是否超出系统限制
     *
     * @param fileByte 文件字节数
     * @return
     */
    public boolean isOverrunFileSize(Long fileByte) {
        //获得项目设定的上传文件最大字节数
        Long projectFileUploadMaxByte = getProjectFileUploadMaxByte();
        return (fileByte.compareTo(projectFileUploadMaxByte) > 0) ? true : false;
    }

    /**
     * 获得系统限制上传文件最大byte
     *
     * @return
     */
    public Long getProjectFileUploadMaxByte() {
        return UploadConfig.getFile_max_byte();
    }

    /**
     * 获得系统限制上传文件最大mb
     *
     * @return
     */
    public Long getProjectFileUploadMaxMb() {
        return (getProjectFileUploadMaxByte() / 1048576);
    }
}