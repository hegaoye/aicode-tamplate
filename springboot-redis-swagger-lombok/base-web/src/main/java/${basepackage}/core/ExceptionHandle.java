package ${basePackage}.core;

import com.alibaba.fastjson.JSON;
import ${basePackage}.core.entity.BeanRet;
import ${basePackage}.core.exceptions.BaseException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * Created by IntelliJ IDEA.
 *
 * @author lixin 2016-08-03 11:27
 */
@ControllerAdvice
@Slf4j
public class ExceptionHandle {

    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public BeanRet catchException(Exception exception) {
        String errorMsg = null;
        Map<String, Object> map = null;
        if (exception != null) {
            if (exception instanceof BaseException) {
                if (StringUtils.isNotBlank(exception.getMessage())) {
                    if (exception.getMessage().contains("{") && exception.getMessage().contains("}")) {
                        errorMsg = exception.getMessage().substring(exception.getMessage().indexOf("{"), exception.getMessage().indexOf("}") + 1);
                        map = JSON.parseObject(errorMsg, Map.class);
                    }
                } else {
                    errorMsg = BaseException.BaseExceptionEnum.Server_Error.toString();
                    map = JSON.parseObject(errorMsg, Map.class);
                }
            }
            log.error(exception.getMessage());
            exception.printStackTrace();
        } else {
            errorMsg = BaseException.BaseExceptionEnum.Server_Error.toString();
            map = JSON.parseObject(errorMsg, Map.class);
        }

        return BeanRet.create(false, map.get("code").toString(), map.get("error").toString());
    }


}
