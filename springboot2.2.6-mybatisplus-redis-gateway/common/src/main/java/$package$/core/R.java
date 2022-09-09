package $package$.core;

import $package$.core.exceptions.BaseException;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 结果返回类  {"code":4001,"msg":"",data:{}}
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public final class R implements Serializable {
    private String code;
    private String msg;
    private Object data;


    /**
     * 失败 false  传递 异常枚举对象
     */
    public static R failed(String code, String msg) {
        return new R(code, msg, null);
    }

    public static R failed(BaseException.BaseExceptionEnum baseExceptionEnum) {
        return new R(baseExceptionEnum.code, baseExceptionEnum.msg, null);
    }

    public static R failed(BaseException.BaseExceptionEnum baseExceptionEnum, Object data) {
        return new R(baseExceptionEnum.code, baseExceptionEnum.msg, data);
    }

    /**
     * 成功 true 成功 “异常” 对象信息
     *
     * @param baseExceptionEnum 成功 “异常” 对象信息
     */

    public static R success(BaseException.BaseExceptionEnum baseExceptionEnum, Object data) {
        return new R(baseExceptionEnum.code, baseExceptionEnum.msg, data);
    }

    public static R success(BaseException.BaseExceptionEnum baseExceptionEnum) {
        return new R(baseExceptionEnum.code, baseExceptionEnum.msg, null);
    }

    public static R success(Object data) {
        return new R(BaseException.BaseExceptionEnum.Success.code, BaseException.BaseExceptionEnum.Success.msg, data);
    }

    public static R success() {
        return new R(BaseException.BaseExceptionEnum.Success.code, BaseException.BaseExceptionEnum.Success.msg, null);
    }


}