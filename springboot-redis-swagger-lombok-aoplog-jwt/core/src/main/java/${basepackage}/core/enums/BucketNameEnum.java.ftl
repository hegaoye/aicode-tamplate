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
    common("公共资源", "common/"),
    admin("管理系统", "admin/"),
    rbac("权限系统", "rbac/"),
    avatar_user("用户头像", "avatar/user/"),
    avatar_admin("管理员头像", "avatar/admin/"),
    index_wap("手机wap首页", "html/index/wap/"),
    index_web("手机web首页", "html/index/web/"),
    index_app("手机app首页", "html/index/app/"),
    index_js("小程序首页", "html/index/js/"),
    banners_wap("手机wap_banners", "html/banner/wap/"),
    goods("商品图片", "goods/"),
    goods_comment("商品评价图片", "comment/goods/"),
    article("资讯", "article/"),
    help("帮助中心", "help/"),
    after("售后","/after/"),
    activity("活动", "activity/"),
    advertisement("广告", "advertisement/"),
    test("测试目录", "test/")
    ;

    public String description;
    public String path;

    BucketNameEnum(String description) {
        this.description = description;
    }

    BucketNameEnum(String description, String path) {
        this.description = description;
        this.path = path;
    }

    //通过值获得枚举对象
    public static BucketNameEnum getEnum(String yn) {
        for (BucketNameEnum enums : BucketNameEnum.values()) {
            if (enums.name().equalsIgnoreCase(yn)) {
                return enums;
            }
        }
        throw new BaseException(BaseException.ExceptionEnums.enumUndefined(yn));
    }
}