package $package$.config;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.MDC;
import org.springframework.core.task.TaskDecorator;

import java.util.Map;
import java.util.UUID;

public class MdcTaskDecorator implements TaskDecorator {


    /**
     * 处理异步线程打印traceId的问题
     *
     * @param runnable 异步
     * @return 返回的
     */
    @Override
    public Runnable decorate(Runnable runnable) {
        Map<String, String> map = MDC.getCopyOfContextMap();
        return () -> {
            try {
                MDC.setContextMap(map);
                String traceId = MDC.get(LogFilter.TRACE_KEY);
                if (StringUtils.isBlank(traceId)) {
                    traceId = UUID.randomUUID().toString();
                    MDC.put(LogFilter.TRACE_KEY, traceId);
                }
                runnable.run();
            } finally {
                MDC.clear();
            }
        };
    }
}