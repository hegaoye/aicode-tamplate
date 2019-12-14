/*
 * ${copyright}
 */
package ${basePackage}.core.dto;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.enums.HttpCodeEnum;
import ${basePackage}.core.exceptions.BaseException;
import lombok.Data;

import java.io.Serializable;

/**
 * 异常结果对象
 * Created by borong on 2019/5/8 20:31
 * @author borong
 */
@Data
public class BaseExceptionDTO implements Serializable {

    private static final long serialVersionUID = -3943854279691998661L;

    //单例模式
    private static BaseExceptionDTO instance;

    public static BaseExceptionDTO getInstance() {
        if (instance == null) {
            instance = new BaseExceptionDTO();
        }
        return instance;
    }

    //代号
    private int code;
    //信息
    private String info;

    public BaseExceptionDTO() {
    }

    public BaseExceptionDTO(int code, String info) {
        this.code = code;
        this.info = info;
    }

    public BaseExceptionDTO(BaseException.ExceptionEnums exceptionEnums) {
        this.code = exceptionEnums.codeEnum.code;
        this.info = exceptionEnums.codeEnum.description;
    }

    public BaseExceptionDTO(BaseException.ExceptionEnums exceptionEnums, String info) {
        this.code = exceptionEnums.codeEnum.code;
        this.info = exceptionEnums.codeEnum.description + info;
    }

    public static String toString(HttpCodeEnum requestCodeEnum, String info) {
        return JSON.toJSONString(new BaseExceptionDTO(requestCodeEnum.code, info));
    }

    public static String toString(HttpCodeEnum requestCodeEnum) {
        return JSON.toJSONString(new BaseExceptionDTO(requestCodeEnum.code, requestCodeEnum.description));
    }

    public static String toString(int wxExceptionExceptionMessageCode, String message) {
        return JSON.toJSONString(new BaseExceptionDTO(wxExceptionExceptionMessageCode, message));
    }
}
