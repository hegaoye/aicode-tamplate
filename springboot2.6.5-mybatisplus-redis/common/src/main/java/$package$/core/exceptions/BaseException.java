/*
* $copyright$
 */
package $package$.core.exceptions;

import com.alibaba.fastjson.JSON;
import lombok.extern.slf4j.Slf4j;

import java.io.Serializable;

/**
 * 基本异常类
 *
 * @author lixin 2017-08-03 17:46
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

        //-----------------系统异常定义 [9000~9499]--------------------------
        Server_Error("9999", "Server Error"),
        Success("0000", "Success"),
        State_Error("9002", "State msg"),
        Ilegal_Param("9003", "Parameter is ilegal"),
        Empty_Param("9004", "Parameter is empty"),
        Exists("9005", "There is already exists"),
        Result_Not_Exist("9006", "The query result does not exist"),
        //-----------------上传文件异常定义[9500~9599]--------------------------
        Build_Exist("9500", "build exist"),
        ;


        public String code;//错误编码
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

        BaseExceptionEnum(String code, String msg) {
            this.code = code;
            this.msg = msg;
        }

        @Override
        public String toString() {
            return "{code:" + code + ", msg:\"" + msg + "\"}";
        }

    }
}
