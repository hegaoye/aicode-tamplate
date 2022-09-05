package $package$.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.ThreadPoolExecutor;

@EnableAsync
@Configuration
public class TaskExecutorConfig implements AsyncConfigurer {

    @Bean(name = "threadPoolExecutor")
    @Override
    public ThreadPoolTaskExecutor getAsyncExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        // 获取JAVA虚拟机的可用处理器数量。IO密集型建议核心线程数是该值2倍；计算密集型建议核心线程数是该值1倍
        int processorNum = Runtime.getRuntime().availableProcessors();
        // 设置核心线程数量。若池中的实际线程数小于该值，无论其中是否有空闲的线程，都会产生新的线程
        executor.setCorePoolSize(processorNum * 2);
        // 设置最大线程数量
        executor.setMaxPoolSize(30);
        // 设置阻塞任务队列大小
        executor.setQueueCapacity(50);
        // 线程名称前缀
        executor.setThreadNamePrefix("ThreadEvent-");
        // 设置线程池中任务的等待时间，若超过等待时间仍未销毁则强制销毁，以确保应用最后能够被关闭，而不是阻塞住
        executor.setAwaitTerminationSeconds(3);
        //处理异步线程打印日志的问题
        executor.setTaskDecorator(new MdcTaskDecorator());
        // 设置拒绝策略，当线程池阻塞队列已满时对新任务的处理。调节机制，即饱和时回退主线程执行
        executor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
        executor.initialize();
        return executor;
    }

}
