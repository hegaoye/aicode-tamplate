package com.rzhkj.core.enums;

/**
 * 首页模板类型
 * Created by shangze on 2018-5-18.
 */
public enum BucketNameEnum {
    //#默认
    space_name_common("common"),
    //#首页
    space_name_phone_index("phone-index"),
    //#商品
    space_name_goods("goods"),
    //#商品评价
    space_name_comment("comment"),
    //#用户
    space_name_cust("cust"),
    //#企业店铺
    space_name_enterprise("enterprise"),
    //#代理商
    space_name_agent("agent"),
    //#资讯
    space_name_article("article"),
    //#财务
    space_name_finace("finace"),
    //#帮助中心
    space_name_help("help"),
    //#售后
    space_name_after("after"),
    //#活动
    space_name_activity("activity"),
    //#广告
    space_name_advertisement("advertisement");
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
        return null;
    }
}