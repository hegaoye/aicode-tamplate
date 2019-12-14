/*
* ${copyright}
*/
package ${basePackage}.core.exceptions;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.dto.BaseExceptionDTO;
import ${basePackage}.core.enums.FormatEnum;
import ${basePackage}.core.enums.HttpCodeEnum;
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

    public BaseException(HttpCodeEnum codeEnum, String message) {
        super(BaseExceptionDTO.toString(codeEnum, message));
        if (logger.isDebugEnabled()) {
            logger.debug(">>> 业务异常：[状态码：{}，异常信息：{}] >>>", codeEnum.code, message);
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
        success(HttpCodeEnum.code_200),

        //-----------------系统异常定义--------------------------
        server_error(HttpCodeEnum.code_31),
        service_error(HttpCodeEnum.code_32),
        server_unknow_error(HttpCodeEnum.code_33),
        unknow_request(HttpCodeEnum.code_404),
        MethodArgumentTypeMismatchException(HttpCodeEnum.code_4001),
        DataIntegrityViolationException(HttpCodeEnum.code_4002),
        MyBatisSystemException(HttpCodeEnum.code_4003),
        NullPointerException(HttpCodeEnum.code_4000),
        ClassCastException(HttpCodeEnum.code_4004),
        BindException(HttpCodeEnum.code_4005),
        MissingServletRequestParameterException(HttpCodeEnum.code_4006),
        HttpRequestMethodNotSupportedException(HttpCodeEnum.code_4007),
        MysqlDataTruncation(HttpCodeEnum.code_4008),
        SQLSyntaxErrorException(HttpCodeEnum.code_4002),
        BadSqlGrammarException(HttpCodeEnum.code_4002),
        http_post_exception(HttpCodeEnum.code_41),
        http_get_exception(HttpCodeEnum.code_42),
        enums_undefined(HttpCodeEnum.code_43),
        json_object_invalid(HttpCodeEnum.code_45),
        json_array_invalid(HttpCodeEnum.code_46),
        repeat_operation(HttpCodeEnum.code_37),
        response_data_error(HttpCodeEnum.code_66),
        //-----------------账户登录异常，需要重新登录--------------------------
        token_is_null(HttpCodeEnum.code_71),
        token_expired(HttpCodeEnum.code_71),
        token_account_is_null(HttpCodeEnum.code_72),
        token_invalid(HttpCodeEnum.code_73),
        account_disable(HttpCodeEnum.code_74),
        //-----------------账户异常--------------------------
        account_login_error(HttpCodeEnum.code_47),
        request_invalid(HttpCodeEnum.code_44),
        auth_wait(HttpCodeEnum.code_63),
        auth_pass(HttpCodeEnum.code_64),
        auth_unapply(HttpCodeEnum.code_65),
        //-----------------文件相关异常--------------------------
        upload_file_size_overflow(HttpCodeEnum.code_80),
        //-----------------消息相关异常--------------------------
        sms_send_error(HttpCodeEnum.code_86),
        sms_verify_code_expired(HttpCodeEnum.code_87),
        sms_verify_code_invalid(HttpCodeEnum.code_88),
        //-----------------微信相关异常--------------------------
        wx_binded_someone(HttpCodeEnum.code_91),
        wx_unbind(HttpCodeEnum.code_92),
        wx_decrypt_fail(HttpCodeEnum.code_93),


        //-----------------订单/商品相关异常--------------------------
        please_select_area(HttpCodeEnum.code_1001),
        please_fix_receiver(HttpCodeEnum.code_1002),
        please_fix_service_time(HttpCodeEnum.code_1003),
        order_create_exception(HttpCodeEnum.code_1004),
        order_pay_exception(HttpCodeEnum.code_1005),
        cart_not_data(HttpCodeEnum.code_1006),
        pay_currency_wrong(HttpCodeEnum.code_1007),
        currency_is_less(HttpCodeEnum.code_1008),
        money_is_minus(HttpCodeEnum.code_1009),
        please_select_service_type(HttpCodeEnum.code_1010),
        service_order_grab_fail(HttpCodeEnum.code_1011),
        service_order_cant_start(HttpCodeEnum.code_1012),
        service_order_cant_finish(HttpCodeEnum.code_1013),
        currency_pay_less(HttpCodeEnum.code_1014),
        order_not_allow_after(HttpCodeEnum.code_1015),
        order_not_allow_audit(HttpCodeEnum.code_1016),
        unknow_after_audit_state(HttpCodeEnum.code_1017),
        after_refund_fail(HttpCodeEnum.code_1018),
        order_not_exist_third_party_pay(HttpCodeEnum.code_1019),
        order_pay_error(HttpCodeEnum.code_1020),
        order_not_allow_deliver(HttpCodeEnum.code_1021),
        order_is_paid(HttpCodeEnum.code_1022),
        order_is_close(HttpCodeEnum.code_1023),
        order_cannt_finish(HttpCodeEnum.code_1024),
        callback_service_unchecked(HttpCodeEnum.code_1025),

        menu_is_repeat(HttpCodeEnum.code_9000),
        node_has_children_cant_delete(HttpCodeEnum.code_9001),
        no_permission(HttpCodeEnum.code_9002),
        old_password_error(HttpCodeEnum.code_9003),
        disable_super_operation(HttpCodeEnum.code_9004),
        delete_not_allow(HttpCodeEnum.code_9005),
        ;

        public HttpCodeEnum codeEnum;


        ExceptionEnums(HttpCodeEnum codeEnum) {
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
            return BaseExceptionDTO.toString(HttpCodeEnum.code_32, errorInfo);
        }

//-----------------属性检查类代号--------------------------

        /**
         * 信息提示：格式错误
         *
         * @param arg
         * @return
         */
        public static String paramFormatError(String arg) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_50, "[" + arg + "]格式有误");
        }

        /**
         * 信息提示：格式错误
         *
         * @param arg
         * @param rightFormat 正确格式
         * @return
         */
        public static String paramFormatError(String arg, FormatEnum rightFormat) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_51, "参数[" + arg + "]格式有误；正确格式[" + rightFormat.val + "]");
        }

        /**
         * 信息提示：某参数为空
         *
         * @param arg
         * @return
         */
        public static String paramIsEmpty(String arg) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_52, "参数[" + arg + "]为空");
        }

        /**
         * 信息提示：某参数值无效
         *
         * @param arg
         * @return
         */
        public static String paramIsInvalid(String arg) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_53, "参数[" + arg + "]无效");
        }

        /**
         * 信息提示：对象为空
         *
         * @param arg
         * @return
         */
        public static String objIsEmpty(String arg) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_54, "查询[" + arg + "]为空");
        }

        /**
         * 信息提示：某对象不存在
         *
         * @param arg
         * @return
         */
        public static String objIsNotExist(String arg) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_55, "查询[" + arg + "]不存在");
        }

        /**
         * 信息提示：某对象已存在
         *
         * @param arg
         * @return
         */
        public static String objIsExist(String arg) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_56, "查询[" + arg + "]已存在");
        }

        /**
         * 信息提示：某某已经设置
         *
         * @param arg
         * @return
         */
        public static String alreadySet(String arg) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_57, "参数[" + arg + "]无需重复设置");
        }

        /**
         * 信息提示：添加失败
         *
         * @param arg
         * @return
         */
        public static String addFailed(String arg) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_58, "添加 " + arg + " 失败");
        }

        /**
         * 信息提示：字节长度超限
         *
         * @param arg
         * @param maxBytesLength 最大字节长度
         * @return
         */
        public static String lengthOverWithBytes(String arg, long maxBytesLength) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_59, "参数[" + arg + "]长度超限；允许最大 " + maxBytesLength + "字节");
        }

        /**
         * 信息提示：长度超限
         *
         * @param arg
         * @param maxLength 最大长度
         * @return
         */
        public static String lengthOver(String arg, long maxLength) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_60, "参数[" + arg + "]长度超限；允许最大长度 " + maxLength);
        }

        /**
         * 信息提示：长度超限
         *
         * @param arg
         * @param maxLength 最大长度
         * @return
         */
        public static String lengthOver(String arg, String maxLength, String unit) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_60, String.format("参数[%s]超限；最多 %s %s", arg, maxLength, unit));
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
            return BaseExceptionDTO.toString(HttpCodeEnum.code_61, "参数[" + arg + "]长度超限；请保持长度在[" + minLength + "-" + maxLength + "]");
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
                return BaseExceptionDTO.toString(HttpCodeEnum.code_61, "[" + arg + "]超限；最大" + max + "元");
            } else if (min.compareTo(BigDecimal.ZERO) > 0 && null == max) {
                return BaseExceptionDTO.toString(HttpCodeEnum.code_61, "[" + arg + "]超限；最小" + min + "元");
            } else {
                return BaseExceptionDTO.toString(HttpCodeEnum.code_61, "[" + arg + "]超限；最小" + min + "元，最大" + min + "元");
            }
        }

        /**
         * 信息提示：上传的文件为空
         *
         * @param arg
         * @return
         */
        public static String uploadFileIsNull(String arg) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_62, "请上传[" + arg + "]");
        }

        /**
         * 信息提示：上传的文件过大
         *
         * @param maxSizeMb 图片最大MB
         * @return
         */
        public static String uploadFileSizeOverrun(long maxSizeMb) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_80, String.format("请上传不大于%sMb的文件", maxSizeMb));
        }


        /**
         * 信息提示：枚举类型未定义
         *
         * @param enums 枚举类型
         * @return
         */
        public static String enumUndefined(Object enums) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_43, String.format("未定义枚举类型 [%s]", JSON.toJSONString(enums)));
        }

        /**
         * 信息提示：枚举类型未定义
         *
         * @param enums     枚举类型
         * @param enumClass 枚举类
         * @return
         */
        public static String enumUndefined(Object enums, Class<?> enumClass) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_43, String.format("枚举 [%s] 有未定义类型 [%s]", enumClass.getName(), JSON.toJSONString(enums)));
        }

        /**
         * 检查元素正在被使用
         * @param arg
         * @return
         */
        public static String elementIsUsed(String arg) {
            return BaseExceptionDTO.toString(HttpCodeEnum.code_67, String.format("[%s] 正在被使用", arg));
        }
    }
}