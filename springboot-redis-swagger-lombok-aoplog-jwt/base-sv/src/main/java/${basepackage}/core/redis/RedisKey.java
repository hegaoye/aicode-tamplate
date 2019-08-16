/*
 * ${copyright}
 */
package ${basePackage}.core.redis;


import ${basePackage}.core.enums.RoleTypeEnum;
import ${basePackage}.core.enums.SettingKeyEnum;

public class RedisKey {

    /**
     * 区域信息key 的有效时长 分钟 = 60s * 60min * 24 = ‭86400‬;
     */
    public static final int AREA_TIME_SECONDS = 86400;

    /**
     * 微信支付携带参数集的key 的有效时长 30分钟 = 60s * 30min = 1800;
     */
    public static final int WXPAY_ORDER_TIME_SECONDS = 1800;

    /**
     * 微信网页授权认证时，code的有效期 5分钟 = 60s * 5min = 300;
     */
    public static final int WX_WAP_AUTH_CODE_EFFECTIVE_TIME_SECONDS = 300;

    /**
     * 商品相关缓存key 的有效时长 24小时 = 60s * 60min * 24h = 86400;
     */
    public static final int GOODS_KEY_TIME_SECONDS = 86400;

    /**
     * redis 缓存层级分隔符
     */
    public static final String SPLIT = ":";

    /**
     * 用户 TOKEN key
     */
    public static final String TOKEN_KEY = "TOKEN" + SPLIT;

    /**
     * 微信相关缓存key的前缀
     */
    public static final String WX_KEY_HEADER = "WX" + SPLIT;

    /**
     * 用户相关缓存key的前缀
     */
    public static final String USER_KEY_HEADER = "USER" + SPLIT;

    /**
     * 阿里相关缓存key的前缀
     */
    public static final String ALI_KEY_HEADER = "ALI" + SPLIT;
    /**
     * 短信相关缓存key的前缀
     */
    public static final String SMS_KEY_HEADER = "SMS" + SPLIT;
    /**
     * 小程序相关缓存key的前缀
     */
    public static final String MINI_PROGRAM_KEY_HEADER = "MINI_PROGRAM" + SPLIT;

    /**
     * 支付相关缓存key的前缀
     */
    public static final String PAY_KEY_HEADER = "PAY" + SPLIT;

    /**
     * 商品相关缓存key的前缀
     */
    public static final String GOODS_KEY_HEADER = "Goods" + SPLIT;


    /**
     * 基础信息key
     */
    public static final String BASIC_HEADER = "Basic" + SPLIT;

    /**
     * 区域key
     */
    public static final String AREA_HEADER = "AREA" + SPLIT;

    /**
     * 系统配置表信息key
     */
    public static final String SETTINGS_HEADER = "Settings" + SPLIT;

    /**
     * 上传相关缓存key的前缀
     */
    public static final String UPLOAD_KEY_HEADER = "Upload" + SPLIT;

    /**
     * 密码相关缓存key的前缀
     */
    public static final String PASSWORD_KEY_HEADER = "PASSWORD" + SPLIT;

    /**
     * 获得token类型对应角色的登录密码缓存key
     *
     * @return
     */
    public static String genPasswordKey(RoleTypeEnum roleTypeEnum, String code) {
        return PASSWORD_KEY_HEADER + roleTypeEnum.name() + SPLIT + code;
    }

    /**
     * 生成系统配置缓存key
     *
     * @return
     */
    public static String genSettingsKey(SettingKeyEnum settingKey) {
        return BASIC_HEADER + SETTINGS_HEADER + settingKey.name();
    }

    /**
     * 获得小程序用户的sessionkey缓存key
     *
     * @return
     */
    public static String genCode2SessionKey(String userCode) {
        return WX_KEY_HEADER + MINI_PROGRAM_KEY_HEADER + "SessionKey" + SPLIT + userCode;
    }

    /**
     * 获得公众号全局基础token的key
     *
     * @return
     */
    public static String genBaseTokenKey(String appid) {
        return WX_KEY_HEADER + "Wap" + SPLIT + "BaseAccessToken:" + appid;
    }

    /**
     * 获得公众号全局 jsapi_ticket 的key
     *
     * @return
     */
    public static String genJsApiTicketKey(String appid) {
        return WX_KEY_HEADER + "Wap" + SPLIT + "JsApiTicket" + SPLIT + appid;
    }

    /**
     * 获得微信用户的 网页授权code 的key
     * 有效期5分钟
     *
     * @param ip        用户请求ip地址
     * @param sessionid 用户请求会话的sessionid
     * @return
     */
    public static String genWXAuthCodeKey(String ip, String sessionid) {
        return WX_KEY_HEADER + "Auth" + SPLIT + "Code" + SPLIT + ip + SPLIT + sessionid;
    }

    /**
     * 获得微信用户授权的 accesstoken 的key
     * 有效期5分钟
     *
     * @param sessionid 用户请求会话的sessionid
     * @return
     */
    public static String genWXAuthAccessTokenKey(String sessionid) {
        return WX_KEY_HEADER + "AuthAccessToken" + SPLIT + "sessionid" + SPLIT + sessionid;
    }

    /**
     * 获得微信用户的 accesstoken 的key
     * 有效期5分钟
     *
     * @param code 用户网页授权的code
     * @return
     */
    public static String genWXAccessTokenKey(String code) {
        return WX_KEY_HEADER + "AuthAccessToken" + SPLIT + code;
    }

    /**
     * 获得微信用户信息 的key
     *
     * @return
     */
    public static String genWxUserInfoKey(String openid) {
        return WX_KEY_HEADER + "UserInfo" + SPLIT + openid;
    }

    /**
     * 生成上传进度数据编号
     *
     * @param uid uid
     * @return String
     */
    public static String genUploadProgressKey(String uid) {
        return UPLOAD_KEY_HEADER + "Progress" + SPLIT + "Key" + SPLIT + uid;
    }

    /**
     * 生成uploadkey
     *
     * @param uid uid
     * @return key
     */
    public static String genUploadKey(String uid) {
        return UPLOAD_KEY_HEADER + "Key" + SPLIT + uid;
    }
    /**
     * 用户 token key
     *
     * @param roleType 角色类型
     * @param userCode 用户编码
     * @return
     */
    public final static String getWebSocketTokenKey(RoleTypeEnum roleType, String userCode) {
        return TOKEN_KEY + roleType.name() + SPLIT + userCode;
    }

    /**
     * 生成区域树的key
     *
     * @return
     */
    public static String genAreaTreeKey() {
        return BASIC_HEADER + AREA_HEADER + "Tree";
    }

    /**
     * 生成行业树的key
     *
     * @return
     */
    public static String genIndustryTreeKey() {
        return BASIC_HEADER + "Industry:Tree";
    }
}