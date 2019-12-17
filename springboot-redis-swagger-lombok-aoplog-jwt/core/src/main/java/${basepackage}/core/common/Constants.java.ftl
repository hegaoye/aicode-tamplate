/*
 * ${copyright}
 */
package ${basePackage}.core.common;

/**
 * 常量表
 */
public class Constants {

    /**
     * 字符串编码为空时填充内容
     */
    public final static String NO_CODE_FIX_STRING = "0";

    /**
     * 整型编码为空时填充数字
     */
    public final static int NO_CODE_FIX_INT = 0;

    /**
     * 个人分组中的默认分组名称
     */
    public final static String DEFAULT_GROUPNAME_WITH_PERSONAL = "默认分组";

    /**
     * 企业的默认职务
     */
    public final static String DEFAULT_POSITION_WITH_CORPORATE = "职员";

    /**
     * 企业联系方式最多组数
     */
    public final static int CORPORATE_CONTACTS_MAX = 6;

    /**
     * 个人名片手机号或座机号最多组数
     */
    public final static int PERSONAL_CONTACTS_MAX = 3;

    //用户登录密码的最小长度
    public final static int USER_LOGIN_PWD_MIN_LENGTH = 6;

    //用户登录密码的最大长度
    public final static int USER_LOGIN_PWD_MAX_LENGTH = 20;

    //订单未付款时，12小时自动过期，并取消 = 12h * 60min * 60s = 43200;
    public final static int ORDER_UNPAY_EXPIRED_SECOND = 43200;


    /**
     * 订单中权重计算小数位长度
     */
    public final static int ORDER_WEIGHT_CALC_LENGTH = 10;

    /**
     * key = value 时，定义在此枚举中使用
     */
    public enum Key{
        http,//http请求协议火车头
    }

    // redis 缓存中枚举 key 的前缀
    public final static String REDIS_KEY_PREFIX_ENUM = "ENUMS_";

    // 用户
    public final static String PARA_NAME_USER = "user";

    /**
     * 上传对象主键
     */
    public static final String UPLOADUIDKEY = "Upload-Uid";

    /**
     * 系统参数枚举
     */
    public enum SystemEnum {

        /**
         * RBAC 权限系统 参数 begin
         */
        RBAC_SSO_LOGININFO("RBAC_LINFO"),
        RBAC_SSO_LGTICKET("RBAC_LGTICKET"),
        RBAC_SSO_USERCODE("RBAC_USERCODE"),
        RBAC_INFO("LoginInfo_RBAC_USER"),
        /**
         * RBAC 权限系统 参数 end
         */

        /**
         * 用户 参数 begin
         */
        USER_SSO_LOGININFO("USER_LINFO"),
        USER_SSO_LGTICKET("USER_LGTICKET"),
        USER_SSO_USERCODE("USER_USERCODE"),
        USER_INFO("LoginInfo_USER"),
        /**
         * 用户 参数 end
         */
        /**
         * 商家 参数 begin
         */
        STORE_SSO_LOGININFO("STORE_LINFO"),
        STORE_SSO_LGTICKET("STORE_LGTICKET"),
        STORE_SSO_USERCODE("STORE_USERCODE"),
        STORE_INFO("LoginInfo_STORE_USER");
        /**
         * 商家 参数 end
         */
        public String value;

        SystemEnum(String value) {
            this.value = value;
        }

        /**
         * 根据状态名称查询状态
         *
         * @param stateName
         * @return
         */
        public static SystemEnum getState(String stateName) {
            for (SystemEnum state : SystemEnum.values()) {
                if (state.name().equalsIgnoreCase(stateName)) {
                    return state;
                }
            }
            return null;
        }
    }
}