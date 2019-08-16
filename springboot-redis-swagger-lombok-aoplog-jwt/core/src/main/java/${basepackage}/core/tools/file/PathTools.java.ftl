/*
 * ${copyright}
 */
package ${basePackage}.core.tools.file;

import ${basePackage}.core.tools.DateTools;

import java.util.Date;

/**
 * 图路径管理工具
 */
public class PathTools {
    /**
     * 相对基本文件路径
     *
     * @param path 路径
     * @return 相对基本路径 [/basic/xxxxx/]
     */
    public static String getBasicRelative(String path) {
        return "/basic/" + path + "/";
    }

    /**
     * 相对临时本地目录
     *
     * @return 相对基本路径 [/local/14位时间戳/]
     */
    public static String getLocalRelative() {
        return "/local/" + DateTools.dateToNum14(new Date()) + "/";
    }

    /**
     * 获得身份证生成相对路径
     *
     * @param idcard
     * @return 相对路径[/xx/xx/xx/]
     */
    public static String getIdcardRelative(String idcard) {
        String province = idcard.substring(0, 2);
        String city = idcard.substring(2, 4);
        String county = idcard.substring(4, 6);
        String year = idcard.substring(6, 10);
        String month = idcard.substring(10, 12);
        return "/Basic/" + province + "/" + city + "/" + county + "/" + year + "/" + month + "/";
    }
}