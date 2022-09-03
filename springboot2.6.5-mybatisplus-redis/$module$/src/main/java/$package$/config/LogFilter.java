package $package$.config;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.MDC;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.util.StopWatch;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import java.util.UUID;

/**
 * 日志拦截器
 * 1：每个请求的唯一字段
 * 2：打印每个请求的时间，post请求参数，用于定位问题
 * 3:超過預警的值，就需要優化
 */
@Slf4j
@WebFilter(filterName = "logFilter", urlPatterns = "/*")
public class LogFilter implements Filter {

    @Value("${warm.time:1500}")
    private long warmTime;

    public static final String TRACE_KEY = "trace_id";

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        //初始化，先移除再添加
        remove();
        insertTraceId();
    }

    /**
     * 過濾，
     * 1：打印耨個請求，耗時多少，用於統計性能
     * 2：添加每個請求的唯一索引
     *
     * @param request  請求
     * @param response 響應
     * @param chain    鏈
     */
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {

        String url = null;
        StopWatch stopWatch = new StopWatch("LogFilter性能监控");
        stopWatch.start("LogFilter.doFilter");
        long beginTime = System.currentTimeMillis();
        long spendTime;

        try {
            //獲取url
            HttpServletRequest req = (HttpServletRequest) request;
            url = req.getRequestURL().toString();

            //先移除，再添加，防止重複
            remove();

            insertTraceId();

            chain.doFilter(request, response);

            stopWatch.stop();
            spendTime = System.currentTimeMillis() - beginTime;

            log.info("請求地址：{},耗時：{}ms,參數：{}", url, spendTime, stopWatch.prettyPrint());

        } catch (Exception e) {
            stopWatch.stop();
            spendTime = System.currentTimeMillis() - beginTime;
            log.info("請求地址：{},耗時：{}ms,參數：{}", url, spendTime, stopWatch.prettyPrint());
        }

        //提示超過優化預警值
        if (spendTime > warmTime) {
            log.error("<<<<《《{}接口耗時：{}ms，超過預警值，需要優化》》>>>>", url, spendTime);
        }

    }

    @Override
    public void destroy() {
        remove();
    }


    /**
     * MDC 添加值
     *
     * @return
     */
    private boolean insertTraceId() {
        try {
            MDC.put(TRACE_KEY, UUID.randomUUID().toString());
            return true;
        } catch (Exception e) {
            log.info("insert TraceId msg:{},error:{}", e.getMessage(), e);
            return false;
        }
    }

    /**
     * MDC刪除值
     */
    private void remove() {
        String traceId = MDC.get(TRACE_KEY);
        if (StringUtils.isNotBlank(traceId)) {
            MDC.remove(TRACE_KEY);
        }
    }
}
