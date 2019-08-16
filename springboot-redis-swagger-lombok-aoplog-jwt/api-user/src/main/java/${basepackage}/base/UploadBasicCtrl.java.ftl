/*
 * ${copyright}
 */
package ${basePackage}.base;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.common.Constants;
import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.enums.BucketNameEnum;
import ${basePackage}.core.tools.CookieUtil;
import ${basePackage}.core.tools.UuidTools;
import ${basePackage}.core.redis.RedisKey;
import ${basePackage}.core.redis.RedisUtils;
import ${basePackage}.thirdparty.upload.config.QiniuConfig;
import ${basePackage}.thirdparty.upload.entity.UploadBasicEntity;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.PrintWriter;
import java.util.Map;

/**
 * 文件上传基础支撑
 * Created by ${author}
 */
@Controller
@RequestMapping("/upload/basic")
@Api(tags = "UploadCtrl", description = "文件上传")
public class UploadBasicCtrl extends BaseUploadCtrl {
    @Resource
    public RedisUtils redisUtils;
    private final static Logger logger = LoggerFactory.getLogger(UploadBasicCtrl.class);

    /**
     * 生成文件uid
     * 1.生成uid
     * 2.写入缓存
     * 3.写入cookie
     *
     * @return
     */
    @ApiOperation(value = "获得文件uid号 暗码", notes = "上传业务中会有一种情况，创建对象和上传文件同时进行的问题，uid作为临时对象代理的出现时解决文件上传和业务接口分离的方案")
    @GetMapping("/uid")
    @ResponseBody
    public BeanRet genFileUid(HttpServletResponse response) {
        //1.生成uid
        String uuid = UuidTools.getUUIDString();
        //2.写入缓存
        String redisKey = RedisKey.genUploadKey(uuid);
        UploadBasicEntity uploadBasicEntity = new UploadBasicEntity(uuid, null, null);
        //2.1.600秒后自动过期
        redisUtils.set(redisKey, JSON.toJSONString(uploadBasicEntity), 600);
        //3.写入cookie
        CookieUtil.getInstance().setCookie(Constants.UPLOADUIDKEY, uuid, 600, response);
        return BeanRet.create(true, "uid生成成功", uuid);
    }

    @ApiOperation(value = "上传文件", notes = "上传文件，接口接收的是springmvc的文件mulpartfile类，请注意这个特性，并且是一个单文件模式")
    @PostMapping("/upload")
    @ResponseBody
    public BeanRet upload(@ApiParam(value = "springmvc文件对象", required = true) @RequestParam MultipartFile limitFile,
                          @ApiParam(value = "文件唯一标识编码", required = true) @RequestParam String uuid,
                          @ApiParam(value = "上传空间名 [枚举编号：1006]", required = true) @RequestParam BucketNameEnum bucketNameEnum) {
        return uploadFile(limitFile, uuid, bucketNameEnum);
    }

    @ApiOperation(value = "上传文件返回URL，不带HTTP")
    @PostMapping("/uploadRetUrl")
    @ResponseBody
    public BeanRet uploadRetUrl(@ApiParam(value = "springmvc文件对象", required = true) @RequestParam MultipartFile limitFile
    ) {
        return uploadFileRetURL(limitFile, BucketNameEnum.common);
    }

    @ApiOperation(value = "文件访问路径前缀")
    @GetMapping("/prefix")
    @ResponseBody
    public BeanRet prefix() {
        return BeanRet.create(true, QiniuConfig.getService());
    }

    /**
     * ckEditor上传文件 返回处理信息，带有HTTP
     *
     * @return BeanRet
     */
    @ApiOperation(value = "上传详情图片，本方法为ckEditor专门提供，带HTTP；返回格式<script>callFunction</script>")
    @PostMapping("/uploadGoodsForCkEditor")
    @ResponseBody
    public void uploadGoodsForCkEditor(HttpServletRequest request, HttpServletResponse response, @ApiParam(value = "springmvc文件对象", required = true) @RequestParam MultipartFile upload) {
        try {
            BeanRet br = uploadFileRetHttpURL(upload, BucketNameEnum.common);
            response.setContentType("text/html;charset=UTF-8");
            String callback = request.getParameter("CKEditorFuncNum");
            PrintWriter out = response.getWriter();
            if (br.isSuccess()) {
                out.println("<script type=\"text/javascript\">");
                out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",'" + br.getData() + "',''" + ")");
                out.println("</script>");
            } else {
                out.println("<script type=\"text/javascript\">");
                out.println("window.parent.CKEDITOR.tools.callFunction(" + callback + ",''," + "'" + br.getInfo() + "');");
                out.println("</script>");
            }
            out.flush();
            out.close();
        } catch (Exception e) {
            logger.info("<< 上传失败，原因是:" + e.getMessage());
        }
    }

    /**
     * ckEditor上传文件 返回处理信息，带有HTTP
     *
     * @return BeanRet
     */
    @ApiOperation(value = "上传详情图片，本方法为ckEditor专门提供，带HTTP；返回格式{link：'domain/path.jpg'}")
    @PostMapping("/uploadForCkEditor")
    @ResponseBody
    public void uploadForCkEditor(HttpServletRequest request, HttpServletResponse response, @ApiParam(value = "springmvc文件对象", required = true) @RequestParam MultipartFile upload) {
        try {
            BeanRet br = uploadFileRetHttpURL(upload, BucketNameEnum.common);
            response.setContentType("text/html;charset=UTF-8");
            String callback = request.getParameter("CKEditorFuncNum");
            PrintWriter out = response.getWriter();
            Map<String, Object> params = JSON.parseObject(JSON.toJSONString(br), Map.class);
            if (br.isSuccess()) {
                params.put("link", br.getData());
            } else {
                params.put("link", "");
            }
            out.println(JSON.toJSONString(params));
            out.flush();
            out.close();
        } catch (Exception e) {
            logger.info("<< 上传失败，原因是:" + e.getMessage());
        }
    }
}