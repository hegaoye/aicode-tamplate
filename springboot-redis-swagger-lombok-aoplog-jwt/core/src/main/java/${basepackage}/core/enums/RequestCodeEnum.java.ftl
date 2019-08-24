/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;

import static ${basePackage}.core.common.Constants.CORPORATE_CONTACTS_MAX;
import static ${basePackage}.core.common.Constants.PERSONAL_CONTACTS_MAX;

/**
 * 请求状态码及说明
 * [枚举编号：1004](/resources/enum/1004)
 * 枚举键的规则：code_ 开头，后跟数字作为代号，以保证代号数字唯一
 * Created by borong on 2019/7/15.
 */
public enum RequestCodeEnum {
    code_200(200, "OK"),

    code_31(31, "服务器异常；"),
    code_32(32, "业务异常；"),
    code_33(33, "未知异常！"),
    code_34(34, "控制器方法参数类型不匹配；原因为 => "),
    code_35(35, "数据库相关异常；原因为 => "),
    code_36(36, "Mybatis相关异常；原因为 => "),
    code_37(37, "空指针异常"),
    code_38(38, "数据类型转换异常；原因为 => "),
    code_39(39, "对象装箱异常；原因为 => "),
    code_40(40, "参数异常；原因为 => "),
    code_41(41, "http post请求异常"),
    code_42(42, "http get请求异常"),
    code_43(43, "枚举类型未定义"),
    code_44(44, "您的请求已被服务器阻挡"),
    code_45(45, "JSON对象格式无效"),
    code_46(46, "JSON集合格式无效"),
    code_47(47, "账号或密码错误，请重新输入"),
    code_48(48, ""),
    code_49(49, ""),
    //-----------------数据检查类代号 定义[50~70]--------------------------
    code_50(50, "格式错误"),
    code_51(51, "格式错误，并提醒正确格式"),
    code_52(52, "某参数为空"),
    code_53(53, "某参数值无效"),
    code_54(54, "对象为空"),
    code_55(55, "某对象不存在"),
    code_56(56, "某对象已存在"),
    code_57(57, "某某已经设置"),
    code_58(58, "添加失败"),
    code_59(59, "字节长度超限"),
    code_60(60, "长度超限"),
    code_61(61, "区间长度超限"),
    code_62(62, "一张名片最多添加" + PERSONAL_CONTACTS_MAX + "个手机号和" + PERSONAL_CONTACTS_MAX + "个座机号"),
    code_63(63, "上传的文件为空"),
    code_64(64, "一个企业最多添加" + CORPORATE_CONTACTS_MAX + "组联系方式"),
    code_65(65, "一位用户仅能申请一家企业入驻"),
    code_66(66, "正在认证审核中，请耐心等待..."),
    code_67(67, "已认证；如要修改信息，请联系管理员；"),
    code_68(68, "尚未申请认证"),
    code_69(69, "已申请/入职企业"),
    code_70(70, "尚未申请企业入驻"),
    //-----------------账户登录异常，需要重新登录 定义[71~79]--------------------------
    code_71(71, "会话过期，请重新登录"),
    code_72(72, "会话异常，请重新登录"),
    code_73(73, "会话无效，请重新登录"),
    code_74(74, "账号被冻结，请联系管理员"),
    code_75(75, ""),
    code_76(76, ""),
    code_77(77, ""),
    code_78(78, ""),
    code_79(79, ""),
    //-----------------文件相关异常，需要重新登录 定义[80~85]--------------------------
    code_80(80, "上传的文件有点大喽"),
    code_81(81, ""),
    code_82(82, ""),
    code_83(83, ""),
    code_84(84, ""),
    code_85(85, ""),
    //-----------------消息相关异常，需要重新登录 定义[80~85]--------------------------
    code_86(86, "短信发送失败"),
    code_87(87, "验证码已过期"),
    code_88(88, "验证码无效"),
    code_89(89, "验证码无效"),
    //-----------------微信相关异常，定义[91~100]--------------------------
    code_91(91, "当前微信号已绑定其它用户"),
    code_92(92, "请移驾去绑定微信"),
    code_93(93, "加密数据解密失败"),



    //-----------------订单/商品相关异常，定义[101~199]--------------------------
    code_101(101, "请选择一个区域"),
    code_102(102, "请确定收货人信息"),
    code_103(103, "请预约一个服务时间"),
    code_104(104, "订单创建失败，请重试"),
    code_105(105, "订单支付失败，请确认订单状态"),
    code_106(106, "购物车无数据"),
    code_107(107, "请确认支付电子币"),
    code_108(108, "电子币余额不足"),
    code_109(109, "金额为负"),
    code_110(110, "请选择一个服务类型"),
    code_111(111, "很遗憾，差一点就抢到了，请您继续关注..."),
    code_112(112, "此单暂无分配服务人员，不能开始服务"),
    code_113(113, "此单暂无分配服务人员，不能完成服务"),
    code_114(114, "电子币支付太少"),
    code_115(115, "此订单不允许继续申请售后"),
    code_116(116, "此订单不允许继续审核"),
    code_117(117, "未知的售后处理结果"),
    code_118(118, "售后单退款失败"),
    code_119(119, "订单没有第三方支付"),
    code_120(120, "获取的订单支付金额有误"),
    code_121(121, "此订单不允许发货"),
    code_122(122, "此订单已付款"),
    code_123(123, "此订单已关闭"),
    code_124(124, "此订单不能确认收货"),
    code_125(125, "支付回调业务类型未检查"),

    //-----------------支付相关异常，定义[201~299]--------------------------
    code_201(201, "微信-统一下单-接口请求失败 => "),
    code_202(202, "微信-申请退款-接口请求失败=> "),
    code_203(203, "微信-支付交易状态查询-接口请求失败 => "),
    code_204(204, "微信-关闭订单-接口请求失败 => "),
    code_205(205, "微信-签名-接口请求失败 => "),
    code_206(206, "微信-沙箱签名-接口请求失败 => "),
    code_207(207, "微信-企业转账-接口请求失败 => "),
    code_208(208, "支付宝-统一下单-接口请求失败 => "),
    code_209(209, "支付宝-申请退款-接口请求失败 => "),
    code_210(210, "支付宝-支付交易状态查询-接口请求失败 => "),
    code_211(211, "支付宝-关闭订单-接口请求失败 => "),
    code_212(212, "支付宝-签名-接口请求失败 => "),


    //-----------------业务[商城]相关异常，定义[300~399]--------------------------
    code_300(300, "加入购物车商品的数量不正确"),

    //-----------------业务相关异常，定义[500~599]--------------------------
    code_500(500, "仍有职员归属于此职务"),
    code_501(501, "企业默认职务初始化失败"),
    code_502(502, "该职员尚未入职，不能离职"),
    code_503(503, "该职员尚未入职，不能转岗"),
    code_504(504, "变更职务重复，不能转岗"),
    code_505(505, "企业商城已开通"),

    //-----------------RBAC 相关异常，定义[1000~1099]--------------------------
    code_1000(1000, "菜单重名"),
    code_1001(1001, "存在子集，不能删除"),
    code_1002(1002, "权限不足"),
    code_1003(1003, "原密码不正确"),

    ;
    //代号
    public int code;
    //描述
    public String descs;

    RequestCodeEnum(int code, String descs) {
        this.code = code;
        this.descs = descs;
    }

    public static RequestCodeEnum getEnum(String name) {
        for (RequestCodeEnum enums : RequestCodeEnum.values()) {
            if (enums.name().equalsIgnoreCase(name)) {
                return enums;
            }
        }
        throw new BaseException(BaseException.ExceptionEnums.enums_undefined);
    }

    /**
     * 直接获取枚举键后的状态数
     *
     * @param enums
     * @return
     */
    public static int getCode(RequestCodeEnum enums) {
        //从 code_ 开始截取 数据状态
        return Integer.parseInt(enums.name().substring(5, enums.name().length()));
    }
}
