package $package$.config;

import $package$.core.http.HttpHeaders;
import feign.RequestInterceptor;
import feign.RequestTemplate;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.MDC;
import org.springframework.stereotype.Component;

/**
 * feign 统一拦截
 */
@Component
public class FeignInterceptor implements RequestInterceptor {
    @Override
    public void apply(RequestTemplate template) {
        String traceId = MDC.get(HttpHeaders.TRACE_ID);
        if (StringUtils.isNotBlank(traceId)) {
            template.header(HttpHeaders.TRACE_ID, traceId);
        }
    }
}
