/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;

/**
 * Created by borong on 2019/5/10 18:43
 * 上传文件的归类目录
 * [枚举编号：1006](/resources/enum/1006)
 */
public enum BucketNameEnum {

    /**
     * 上传文件的归类目录
     */
    common("公共资源"),
    admin("管理系统"),
    index_wap("手机wap首页"),
    index_web("手机web首页"),
    index_app("手机app首页"),
    index_js("小程序首页"),
    wap_banners("手机wap_banners"),
    goods("商品图片"),
    goods_comment("商品评价图片"),
    user("用户相关"),
    corporate("企业相关"),
    article("资讯"),
    help("帮助中心"),
    after("售后"),
    activity("活动"),
    advertisement("广告");

    public String val;

    BucketNameEnum(String val) {
        this.val = val;
    }

    //通过值获得枚举对象
    public static BucketNameEnum getEnum(String yn) {
        for (BucketNameEnum enums : BucketNameEnum.values()) {
            if (enums.name().equalsIgnoreCase(yn)) {
                return enums;
            }
        }
        throw new BaseException(BaseException.ExceptionEnums.enums_undefined);
    }
}