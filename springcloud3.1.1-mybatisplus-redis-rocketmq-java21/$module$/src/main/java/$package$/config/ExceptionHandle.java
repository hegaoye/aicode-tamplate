package $package$.config;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.parser.Feature;
import $package$.core.R;
import $package$.core.exceptions.BaseException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 统一异常拦截器
 * 处理异常从底层抛出后，封装为统一格式返回给请求
 */
@ControllerAdvice
@Slf4j
public class ExceptionHandle {

    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public R catchException(Exception exception) {
        String errorMsg = null;
        JSONObject jsonObject = null;
        if (exception != null) {
            if (exception instanceof BaseException) {
                if (StringUtils.isNotBlank(exception.getMessage())) {
                    if (exception.getMessage().contains("{") && exception.getMessage().contains("}")) {
                        errorMsg = exception.getMessage().substring(exception.getMessage().indexOf("{"), exception.getMessage().indexOf("}") + 1);
                        jsonObject = JSON.parseObject(errorMsg, Feature.OrderedField);
                    }
                } else {
                    errorMsg = BaseException.BaseExceptionEnum.Server_Error.toString();
                    jsonObject = JSON.parseObject(errorMsg, Feature.OrderedField);
                }
            }
            log.error("{}", exception.getLocalizedMessage(), exception);
        } else {
            errorMsg = BaseException.BaseExceptionEnum.Server_Error.toString();
            log.error("{}", errorMsg);
            jsonObject = JSON.parseObject(errorMsg, Feature.OrderedField);
        }
        if (null == jsonObject) {
            errorMsg = BaseException.BaseExceptionEnum.Server_Error.toString();
            jsonObject = JSON.parseObject(errorMsg, Feature.OrderedField);
        }
        return jsonObject.toJavaObject(R.class);
    }


}