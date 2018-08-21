package com.rzhkj.core.common;

import com.rzhkj.core.tools.UuidTools;

/**
 * Created by lixin on 2017/6/8.
 */
public class RedisKey {

    /**
     * 生成uploadkey
     *
     * @param uid uid
     * @return key
     */
    public static String genUploadKey(String uid) {
        return "Upload:" + uid;
    }

    /**
     * 生成临时上传uploadkey
     *
     * @param uid uid
     * @return key
     */
    public static String genUploadLocalKey(String uid) {
        return "Upload:Local:" + uid;
    }


    /**
     * 生成区域编码
     *
     * @param code 编码
     * @return
     */
    public static String genAreaKey(String code) {
        return "BasicArea:" + code;
    }


    /**
     * 生成上传进度数据编号
     *
     * @param uid uid
     * @return key
     */
    public static String genUploadProgressKey(String uid) {
        return "Upload:Progress:" + uid;
    }
}
