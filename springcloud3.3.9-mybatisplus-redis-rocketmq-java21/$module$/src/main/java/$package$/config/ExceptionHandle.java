package $package$.config;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.parser.Feature;
import com.sl.core.BaseException;
import com.sl.core.R;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
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
    public ResponseEntity<R> catchException(Exception exception) {
        String errorMsg = null;
        JSONObject jsonObject = null;
        if (exception != null && exception instanceof BaseException) {
            String json = exception.getLocalizedMessage();
            jsonObject = JSON.parseObject(json, Feature.OrderedField);
        } else {
            errorMsg = BaseException.BaseExceptionEnum.Server_Error.toString();
            log.error("{}", errorMsg);
            jsonObject = JSON.parseObject(errorMsg, Feature.OrderedField);
        }

        if (null == jsonObject) {
            errorMsg = BaseException.BaseExceptionEnum.Server_Error.toString();
            jsonObject = JSON.parseObject(errorMsg, Feature.OrderedField);
        }
        
        exception.printStackTrace();
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(jsonObject.toJavaObject(R.class));
    }
}