/*
 * sso
 */
package $package$.core.exceptions;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;

import java.io.Serializable;

/**
 * 基本异常类
 *
 * @author bruce 2017-08-03 17:46
 */
@Slf4j
public class BaseException extends RuntimeException implements Serializable {

    public BaseException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage.toString());
        log.error("系统发生异常[{}]", exceptionMessage.toString());
    }

    public BaseException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage.toString());
        log.error("系统发生异常[{}],参数为[{}]", exceptionMessage.toString(), JSON.toJSONString(params));
    }


    public BaseException(String message) {
        super(message);
        log.error("系统发生异常[{}]", message);
    }

    public BaseException(String message, Throwable cause) {
        super(message, cause);
        log.error("系统发生异常[{}],异常为[{}]", message, cause);
    }


    /*异常信息定义*/
    public enum BaseExceptionEnum {
        Success(0, "Success"),
        Session_Error(-1, "Session Error"),

        //-----------------系统异常定义 [9000~9499]--------------------------
        Server_Error(9999, "Server Error"),
        State_Error(9002, "State msg"),
        Ilegal_Param(9003, "Parameter is ilegal"),
        Exists(9005, "There is already exists"),
        Result_Not_Exist(9006, "The query result does not exist"),
        Ilegal_Domain(9007, "The domain is ilegal"),

        //-----------------上传文件异常定义[9500~9599]--------------------------
        Build_Exist(9500, "build exist"),
        //-----------------账户异常定义[1050~2000]--------------------------
        Insufficient_Balance(1050, "Insufficient balance,There is no enough money about your financial account"),
        Financial_Account_Not_Exist(1051, "The financial account does not exist"),


        //-----------------账户异常定义[1000~1050]--------------------------
        Account_Exist(1001, "The Account is already exists"),
        Account_Error(1000, "There is Error of Account and Password"),


        ;


        public int code;//错误编码
        public String msg;//错误信息

        //信息提示：不存在
        private static String not_exist(String arg) {
            return arg + " does not exist";
        }

        //信息提示：已经存在
        private static String already_exist(String arg) {
            return arg + " already exists";
        }

        //信息提示：添加失败
        private static String add_failed(String arg) {
            return "add " + arg + " failed";
        }

        BaseExceptionEnum(int code, String msg) {
            this.code = code;
            this.msg = msg;
        }

        public static BaseExceptionEnum getEnum(int code) {
            for (BaseExceptionEnum baseExceptionEnum : BaseExceptionEnum.values()) {
                if (baseExceptionEnum.code == code) {
                    return baseExceptionEnum;
                }
            }
            return null;
        }

        @Override
        public String toString() {
            return "{code:" + code + ", msg:\"" + msg + "\"}";
        }

    }
}
