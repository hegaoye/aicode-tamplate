/*
* ${copyright}
*/
package ${basePackage}.core.exceptions;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.dto.BaseExceptionDTO;
import lombok.extern.slf4j.Slf4j;

/**
 * Created by borong on 2018/07/21.
 */
@Slf4j
public class WxException extends BaseException {


    public WxException(WxException.ExceptionMessage exceptionMessage) {
        super(exceptionMessage.toString());
    }

    public WxException(WxException.ExceptionMessage exceptionMessage, Object... params) {
        super(exceptionMessage.toString());
        if (log.isErrorEnabled()) {
            log.error(">>> exceptionMessage:[{}]; params:[{}]>>>", JSON.toJSONString(exceptionMessage), JSON.toJSONString(params));
        }
    }

    /**
     * Fills in the execution stack trace. This method records within this
     * {@code Throwable} object information about the current state of
     * the stack frames for the current thread.
     * <p>
     * <p>If the stack trace of this {@code Throwable} {@linkplain
     * Throwable#Throwable(String, Throwable, boolean, boolean) is not
     * writable}, calling this method has no effect.
     *
     * @return a reference to this {@code Throwable} instance.
     * @see Throwable#printStackTrace()
     */
    @Override
    public synchronized Throwable fillInStackTrace() {
        return null;
    }

    /*异常信息定义*/
    public enum ExceptionMessage {
        WX("查询无数据", ""),
        WX_INTERFACE_REQUEST_FAIL("微信接口请求失败", ""),
        WX_AUTH_NONE("微信未授权", ""),
        WX_USER_UNAUTH("当前微信用户未授权", ""),
        WX_AUTH_EXPIRED("微信授权过期", ""),
        WX_SIGNATURE_FAIL("微信-签名-失败", ""),
        WX_MAPTOXML_FAIL("微信-将Map转换为XML格式的字符串-失败", ""),
        WX_REDIRECT_URI_ISNULL("微信-授权后重定向的回调链接地址-为空", ""),
        WX_CODE_ISNULL("微信-用户同意授权后，获取的code为空，请重新授权", ""),
        WX_JSCODE_ISNULL("微信-用户同意授权后，获取的code为空，请重新授权", ""),
        WX_JSAPI_TICKET_ISNULL("微信-获取jsapi_ticket-为空", ""),
        WX_PUBLIC_ACCESSTOKEN_ISNULL("微信-获取普通 accesstoken-为空", ""),
        WX_WAPAUTH_ACCESSTOKEN_ISNULL("微信-获取授权 accesstoken-为空", ""),
        WX_REFRESH_ACCESSTOKEN_ISNULL("微信-refresh_accessToken-为空", ""),
        WX_SCOPE_ISNULL("微信-应用授权作用域-为空", ""),
        WX_OPENID_ISNULL("微信-用户openid-为空", ""),
        WX_OPENID_ISNOAUTH("请允许微信登录的权限申请", ""),
        WX_OPENID_BIND_ANOTHER("微信号已绑定其它账号", ""),
        WX_OPENID_BIND("用户已绑定微信，不允许绑定新微信", ""),
        WX_PARTNER_TRADE_NO_ISNULL("微信-企业付款到零钱-商户订单号-为空", ""),
        WX_RE_USER_NAME_ISNULL("微信-企业付款到零钱-收款用户真实姓名-为空", ""),
        WX_AMOUNT_ISWRONG("微信-企业付款到零钱-企业付款金额-不正确", ""),
        WX_DESC_ISNULL("微信-企业付款到零钱-企业付款备注-为空", ""),
        WX_DESC_IS_TOO_LANG("微信-企业付款到零钱-企业付款备注-内容过长(请控制在50字以内)", ""),
        ;

        public int code;
        public String message;
        public String errorCode;

        ExceptionMessage(String message, String errorCode) {
            this.message = message;
            this.errorCode = errorCode;
        }

        ExceptionMessage(int code, String message, String errorCode) {
            this.code = code;
            this.message = message;
            this.errorCode = errorCode;
        }

        @Override
        public String toString() {
            return BaseExceptionDTO.toString(code, message);
        }
    }
}
