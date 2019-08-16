/*
* ${copyright}
*/
package ${basePackage}.core.exceptions;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.dto.BaseExceptionDTO;
import ${basePackage}.core.enums.FormatEnum;
import ${basePackage}.core.enums.RequestCodeEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.Serializable;
import java.math.BigDecimal;

/**
* 基本异常类
*
* @author borong 2019-05-26 17:46
*/
public class BaseException extends RuntimeException implements Serializable {

private static final Logger logger = LoggerFactory.getLogger(BaseException.class);
private static final long serialVersionUID = -4693034217968231276L;

public BaseException(ExceptionEnums exceptionMessage) {
super(exceptionMessage.toString());
if (logger.isDebugEnabled()) {
logger.debug(">>> 业务异常：[{}] >>>", exceptionMessage.toString());
}
}

public BaseException(ExceptionEnums exceptionMessage, Object... params) {
super(exceptionMessage.toString());
if (logger.isErrorEnabled()) {
logger.error(">>> 系统发生异常，异常类型： [{}] \n 数据：[{}] >>>", exceptionMessage.toString(), JSON.toJSONString(params));
}
}

public BaseException(String message) {
super(message);

if (logger.isDebugEnabled()) {
logger.debug(">>> 系统发生异常 [{}] >>>", message);
}
}

public BaseException(String message, Throwable cause) {
super(message, cause);
if (logger.isDebugEnabled()) {
logger.debug(">>> 系统发生异常，异常信息：[{}] \t [{}] >>>", message, cause.getMessage());
}
}


/*异常信息定义*/
public enum ExceptionEnums {
success(RequestCodeEnum.code_200),

//-----------------系统异常定义--------------------------
server_error(RequestCodeEnum.code_31),
service_error(RequestCodeEnum.code_32),
server_unknow_error(RequestCodeEnum.code_33),
MethodArgumentTypeMismatchException(RequestCodeEnum.code_34),
DataIntegrityViolationException(RequestCodeEnum.code_35),
MyBatisSystemException(RequestCodeEnum.code_36),
NullPointerException(RequestCodeEnum.code_37),
ClassCastException(RequestCodeEnum.code_38),
BindException(RequestCodeEnum.code_39),
MissingServletRequestParameterException(RequestCodeEnum.code_40),
SQLSyntaxErrorException(RequestCodeEnum.code_35),
BadSqlGrammarException(RequestCodeEnum.code_35),
http_post_exception(RequestCodeEnum.code_41),
http_get_exception(RequestCodeEnum.code_42),
enums_undefined(RequestCodeEnum.code_43),
json_object_invalid(RequestCodeEnum.code_45),
json_array_invalid(RequestCodeEnum.code_46),
//-----------------账户登录异常，需要重新登录--------------------------
token_is_null(RequestCodeEnum.code_71),
token_expired(RequestCodeEnum.code_71),
token_account_is_null(RequestCodeEnum.code_72),
token_invalid(RequestCodeEnum.code_73),
//-----------------账户异常--------------------------
account_login_error(RequestCodeEnum.code_47),
request_invalid(RequestCodeEnum.code_44),
auth_wait(RequestCodeEnum.code_66),
auth_pass(RequestCodeEnum.code_67),
auth_unapply(RequestCodeEnum.code_68),
unapply_corporate(RequestCodeEnum.code_70),
//-----------------文件相关异常--------------------------
upload_file_size_overflow(RequestCodeEnum.code_80),
//-----------------消息相关异常--------------------------
sms_send_error(RequestCodeEnum.code_86),
sms_verify_code_expired(RequestCodeEnum.code_87),
sms_verify_code_invalid(RequestCodeEnum.code_88),
//-----------------微信相关异常--------------------------
wx_binded_someone(RequestCodeEnum.code_91),
wx_unbind(RequestCodeEnum.code_92),
wx_decrypt_fail(RequestCodeEnum.code_93),

personal_contacts_max(RequestCodeEnum.code_62),
corporate_contacts_max(RequestCodeEnum.code_64),

personal_corporate_entry_onlyone(RequestCodeEnum.code_65),
already_join_corporate(RequestCodeEnum.code_69),

//-----------------订单/商品相关异常--------------------------
please_select_area(RequestCodeEnum.code_101),
please_fix_receiver(RequestCodeEnum.code_102),
please_fix_service_time(RequestCodeEnum.code_103),
order_create_exception(RequestCodeEnum.code_104),
order_pay_exception(RequestCodeEnum.code_105),
cart_not_data(RequestCodeEnum.code_106),
pay_currency_wrong(RequestCodeEnum.code_107),
currency_is_less(RequestCodeEnum.code_108),
money_is_minus(RequestCodeEnum.code_109),
please_select_service_type(RequestCodeEnum.code_110),
service_order_grab_fail(RequestCodeEnum.code_111),
service_order_cant_start(RequestCodeEnum.code_112),
service_order_cant_finish(RequestCodeEnum.code_113),
currency_pay_less(RequestCodeEnum.code_114),
order_not_allow_after(RequestCodeEnum.code_115),
order_not_allow_audit(RequestCodeEnum.code_116),
unknow_after_audit_state(RequestCodeEnum.code_117),
after_refund_fail(RequestCodeEnum.code_118),
order_not_exist_third_party_pay(RequestCodeEnum.code_119),
order_pay_error(RequestCodeEnum.code_120),
order_not_allow_deliver(RequestCodeEnum.code_121),
order_is_paid(RequestCodeEnum.code_122),
order_is_close(RequestCodeEnum.code_123),
order_cannt_finish(RequestCodeEnum.code_124),
callback_service_unchecked(RequestCodeEnum.code_125),

worker_used_position(RequestCodeEnum.code_500),
corporate_position_init_fail(RequestCodeEnum.code_501),
worker_cant_leave(RequestCodeEnum.code_502),
worker_cant_transfer(RequestCodeEnum.code_503),
position_is_same(RequestCodeEnum.code_504),
goods_cart_number_wrong(RequestCodeEnum.code_500),
corporate_mall_opened(RequestCodeEnum.code_505),
;

public RequestCodeEnum codeEnum;

ExceptionEnums(RequestCodeEnum codeEnum) {
this.codeEnum = codeEnum;
}

@Override
public String toString() {
return BaseExceptionDTO.toString(codeEnum);
}

/**
* 自定义异常
*
* @param errorInfo
* @return
*/
public static String handleException(String errorInfo) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_32, errorInfo);
}

//-----------------属性检查类代号--------------------------

/**
* 信息提示：格式错误
*
* @param arg
* @return
*/
public static String paramFormatError(String arg) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_50, "[" + arg + "]格式有误");
}

/**
* 信息提示：格式错误
*
* @param arg
* @param rightFormat 正确格式
* @return
*/
public static String paramFormatError(String arg, FormatEnum rightFormat) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_51, "参数[" + arg + "]格式有误；正确格式[" + rightFormat.val + "]");
}

/**
* 信息提示：某参数为空
*
* @param arg
* @return
*/
public static String paramIsEmpty(String arg) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_52, "参数[" + arg + "]为空");
}

/**
* 信息提示：某参数值无效
*
* @param arg
* @return
*/
public static String paramIsInvalid(String arg) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_53, "参数[" + arg + "]值无效");
}

/**
* 信息提示：对象为空
*
* @param arg
* @return
*/
public static String objIsEmpty(String arg) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_54, "查询[" + arg + "]为空");
}

/**
* 信息提示：某对象不存在
*
* @param arg
* @return
*/
public static String objIsNotExist(String arg) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_55, "查询[" + arg + "]不存在");
}

/**
* 信息提示：某对象已存在
*
* @param arg
* @return
*/
public static String objIsExist(String arg) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_56, "查询[" + arg + "]已存在");
}

/**
* 信息提示：某某已经设置
*
* @param arg
* @return
*/
public static String alreadySet(String arg) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_57, "参数[" + arg + "]无需重复设置");
}

/**
* 信息提示：添加失败
*
* @param arg
* @return
*/
public static String addFailed(String arg) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_58, "添加 " + arg + " 失败");
}

/**
* 信息提示：字节长度超限
*
* @param arg
* @param maxBytesLength 最大字节长度
* @return
*/
public static String lengthOverWithBytes(String arg, long maxBytesLength) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_59, "参数[" + arg + "]长度超限；允许最大 " + maxBytesLength + "字节");
}

/**
* 信息提示：长度超限
*
* @param arg
* @param maxLength 最大长度
* @return
*/
public static String lengthOver(String arg, long maxLength) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_60, "参数[" + arg + "]长度超限；允许最大长度 " + maxLength);
}

/**
* 信息提示：区间长度超限
*
* @param arg
* @param minLength 区间最小值
* @param maxLength 区间最大值
* @return
*/
public static String lengthBetween(String arg, long minLength, long maxLength) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_61, "参数[" + arg + "]长度超限；请保持长度在[" + minLength + "-" + maxLength + "]");
}

/**
* 信息提示：价格检查
*
* @param arg
* @param min 价格最小值
* @param max 价格最大值
* @return
*/
public static String priceLimit(String arg, BigDecimal min, BigDecimal max) {
if (null == min && max.compareTo(BigDecimal.ZERO) > 0) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_61, "[" + arg + "]超限；最大"  + max + "元");
}
else if (min.compareTo(BigDecimal.ZERO) > 0 && null == max) {
return BaseExceptionDTO.toString(RequestCodeEnum.code_61, "[" + arg + "]超限；最小" + min + "元");
}
else {
return BaseExceptionDTO.toString(RequestCodeEnum.code_61, "[" + arg + "]超限；最小" + min+ "元，最大" + min + "元");
}
}

    /**
     * 信息提示：上传的文件为空
     *
     * @param arg
     * @return
     */
    public static String uploadFileIsNull(String arg) {
        return BaseExceptionDTO.toString(RequestCodeEnum.code_63, "请上传[" + arg + "]");
    }



    /**
     * 信息提示：枚举类型未定义
     *
     * @param enums 枚举类型
     * @return
     */
    public static String enumUndefined(Object enums) {
        return BaseExceptionDTO.toString(RequestCodeEnum.code_43, String.format("未定义枚举类型 [%s]", JSON.toJSONString(enums)));
    }

    /**
     * 信息提示：枚举类型未定义
     *
     * @param enums 枚举类型
     * @param enumClass 枚举类
     * @return
     */
    public static String enumUndefined(Object enums, Class<?> enumClass) {
        return BaseExceptionDTO.toString(RequestCodeEnum.code_43, String.format("枚举 [%s] 有未定义类型 [%s]", enumClass.getName(), JSON.toJSONString(enums)));
    }
}
}