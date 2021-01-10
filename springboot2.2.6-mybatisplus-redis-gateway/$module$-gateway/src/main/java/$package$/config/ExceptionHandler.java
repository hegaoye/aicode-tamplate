package $package$.config;

import com.alibaba.fastjson.JSON;
import com.subo.core.entity.R;
import org.springframework.boot.autoconfigure.web.ErrorProperties;
import org.springframework.boot.autoconfigure.web.ResourceProperties;
import org.springframework.boot.autoconfigure.web.reactive.error.DefaultErrorWebExceptionHandler;
import org.springframework.boot.web.reactive.error.ErrorAttributes;
import org.springframework.context.ApplicationContext;
import org.springframework.web.reactive.function.server.*;

import java.util.Map;

/**
 * 全局统一异常处理
 *
 * @author hello50
 * @date 2021/1/9 6:19 下午
 */
public class ExceptionHandler extends DefaultErrorWebExceptionHandler {
    public ExceptionHandler(ErrorAttributes errorAttributes, ResourceProperties resourceProperties,
                            ErrorProperties errorProperties, ApplicationContext applicationContext) {
        super(errorAttributes, resourceProperties, errorProperties, applicationContext);
    }

    /**
     * 获取异常属性
     */
    @Override
    protected Map<String, Object> getErrorAttributes(ServerRequest request, boolean includeStackTrace) {
        int code = 500;
        Throwable error = super.getError(request);
        if (error instanceof org.springframework.cloud.gateway.support.NotFoundException) {
            code = 404;
        }
        return response(String.valueOf(code), error.getMessage());
    }

    /**
     * 指定响应处理方法为JSON处理的方法
     *
     * @param errorAttributes
     */
    @Override
    protected RouterFunction<ServerResponse> getRoutingFunction(ErrorAttributes errorAttributes) {
        return RouterFunctions.route(RequestPredicates.all(), this::renderErrorResponse);
    }

    /**
     * 根据code获取对应的HttpStatus
     *
     * @param errorAttributes
     */
    @Override
    protected int getHttpStatus(Map<String, Object> errorAttributes) {
        int statusCode = Integer.parseInt(errorAttributes.get("code").toString());
        return statusCode;
    }

    /**
     * 构建返回的JSON数据格式
     *
     * @param status       状态码
     * @param errorMessage 异常信息
     * @return
     */
    public Map<String, Object> response(String status, String errorMessage) {
        return JSON.parseObject(JSON.toJSONString(R.builder()
                .code(status)
                .msg(errorMessage)
                .data(null)
                .build()), Map.class);
    }
}
