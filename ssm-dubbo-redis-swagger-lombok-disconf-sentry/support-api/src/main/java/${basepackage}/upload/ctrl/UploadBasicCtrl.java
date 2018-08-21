/*
 *  Copyright (c) 2017. 郑州仁中和科技有限公司.保留所有权利.
 *                        http://www.rzhkj.com/
 *       郑州仁中和科技有限公司保留所有代码著作权.如有任何疑问请访问官方网站与我们联系.
 *       代码只针对特定客户使用，不得在未经允许或授权的情况下对外传播扩散.恶意传播者，法律后果自行承担.
 *       本代码仅用于郑州爱馨养老集团的爱馨养老综合管理系统项目.
 */

package com.rzhkj.upload.ctrl;

import com.alibaba.fastjson.JSON;
import com.rzhkj.core.base.BaseUploadCtrl;
import com.rzhkj.core.common.CookieKey;
import com.rzhkj.core.common.RedisKey;
import com.rzhkj.core.entity.BeanRet;
import com.rzhkj.core.entity.UploadBasicEntity;
import com.rzhkj.core.enums.BucketNameEnum;
import com.rzhkj.core.tools.CookieTools;
import com.rzhkj.core.tools.QiniuUpTools;
import com.rzhkj.core.tools.UuidTools;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;

/**
 * 文件上传基础支撑
 * Created by lixin on 2017/6/3.
 */
@Controller
@RequestMapping("/upload/basic")
@Api(value = "文件上传基础支撑", description = "文件上传（获得文件上传 uid 暗码）：过程中的通用问题解决接口")
public class UploadBasicCtrl extends BaseUploadCtrl {
    private final static Logger logger = LoggerFactory.getLogger(UploadBasicCtrl.class);

    /**
     * 生成文件uid
     * 1.生成uid
     * 2.写入缓存
     * 3.写入cookie
     *
     * @return
     */
    @ApiOperation(value = "获得文件uid号", notes = "上传业务中会有一种情况，创建对象和上传文件同时进行的问题，uid作为临时对象代理的出现时解决文件上传和业务接口分离的方案")
    @GetMapping("/uid")
    @ResponseBody
    public BeanRet genFileUid(HttpServletResponse response) {
        // 1.生成uid
        String uuid = UuidTools.getUUIDString();
        // 2.写入缓存
        String redisKey = RedisKey.genUploadKey(uuid);
        UploadBasicEntity uploadBasicEntity = new UploadBasicEntity(uuid, null, null);
        logger.info(redisKey);
        redisUtils.set(redisKey, JSON.toJSONString(uploadBasicEntity),600);
        //3.写入cookie
        CookieTools.INSTANCE.setCode(CookieKey.UploadUidKey, uuid, response);
        return BeanRet.create(true, "uid生成成功", uuid);
    }
}
