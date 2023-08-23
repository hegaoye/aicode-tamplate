package $package$.filter;

import com.baidu.fsg.uid.UidGenerator;
import $package$.core.http.HttpHeaders;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@Slf4j
@Component
public class ContextInterceptor implements HandlerInterceptor {
    @Autowired
    private UidGenerator uidGenerator;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) {
        //日志追踪 id
        String traceId = request.getHeader(HttpHeaders.TRACE_ID);
        log.info("日志追踪 traceId: {}", traceId);

        if (StringUtils.isBlank(traceId)) {
            traceId = String.valueOf(uidGenerator.getUID());
        }
        MDC.put(HttpHeaders.TRACE_ID, traceId);

        return true;
    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
    }
}