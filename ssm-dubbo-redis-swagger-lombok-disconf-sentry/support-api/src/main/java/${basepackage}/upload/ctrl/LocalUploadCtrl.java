/*
 * Copyright (c) 2017. 河南易景网络科技有限公司.保留所有权利.
 *          河南易景网络科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系.
 *      代码只针对特定业务使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 *      本代码仅用于易景商城系统.
 */

package com.rzhkj.upload.ctrl;

import com.alibaba.fastjson.JSON;
import com.rzhkj.core.entity.BeanRet;
import com.rzhkj.core.base.BaseUploadCtrl;
import com.rzhkj.core.common.Constants;
import com.rzhkj.core.entity.UploadBasicEntity;
import com.rzhkj.core.enums.BucketNameEnum;
import com.rzhkj.core.enums.ExceptionMsgEnum;
import com.rzhkj.core.tools.QiniuUpTools;
import com.rzhkj.core.tools.UuidTools;
import com.rzhkj.core.common.RedisKey;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.util.Assert;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

/**
 * 上传文件到本地控制器
 * Created by lixin on 2017/6/16.
 */
@Controller
@RequestMapping("/upload/local")
@Api(value = "上传文件到本地控制器", description = "上传文件到本地控制器")
public class LocalUploadCtrl extends BaseUploadCtrl {
    private final static Logger logger = LoggerFactory.getLogger(LocalUploadCtrl.class);

    /**
     * 上传文件到服务器 返回 UUID
     *
     * @return BeanRet
     */
    @ApiOperation(value = "上传文件到服务器 返回 UUID")
    @PostMapping("/file")
    @ResponseBody
    public BeanRet uploadLocal(@ApiParam(value = "springmvc文件对象", required = true) @RequestParam MultipartFile file) {
        BeanRet beanRet = BeanRet.create();
        try {
            Assert.notNull(file, ExceptionMsgEnum.PARAM_IS_NULL.toString());
            String fileUid = UuidTools.getUUIDString();
            String fileName = file.getOriginalFilename();
            String fileType = fileName.substring(fileName.lastIndexOf(".") + 1);
            String imgPath;
            imgPath = QiniuUpTools.getInstance().uploadSingleFile(file.getInputStream(), Constants.UPLOAD_PATH, fileUid, fileType, BucketNameEnum.space_name_common);
            UploadBasicEntity uploadBasicEntity = new UploadBasicEntity(fileUid, null, imgPath);
            logger.info("上传路径:" + imgPath);
            redisUtils.set(RedisKey.genUploadLocalKey(fileUid), JSON.toJSONString(uploadBasicEntity));
            beanRet.setData(fileUid);
            beanRet.setSuccess(true);
            return beanRet;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return BeanRet.create(ExceptionMsgEnum.UPLOAD_FAILED.toString());
    }


}
