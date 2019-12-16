/*
 * ${copyright}
 */
package ${basePackage}.config;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

/**
 * @Author borong
 * @Date 2019/5/29 9:43
 * @Description:
 */
@Component
@Slf4j
public class MyCommandRunner implements CommandLineRunner {

    @Value("${r'${spring.web.loginurl}'}")
    private String loginUrl;

    @Value("${r'${spring.web.browserExcutePath}'}")
    private String browserExcutePath;

    @Value("${r'${spring.auto.openurl}'}")
    private boolean isOpen;

    /**
     * Callback used to run the bean.
     *
     * @param args incoming main method arguments
     * @throws Exception on error
     */
    @Override
    public void run(String... args) throws Exception {
        if (isOpen) {
            Runtime run = Runtime.getRuntime();
            try{
                run.exec(browserExcutePath + " " +  loginUrl);

                if (log.isDebugEnabled()) {
                    log.debug(">>> 启动浏览器 >>> {}", browserExcutePath);
                    log.debug(">>> 打开项目 >>> {}", loginUrl);
                }
                run.gc();
            } catch (Exception e) {
                e.printStackTrace();
                if (log.isWarnEnabled()) {
                    log.warn(">>> 浏览器打开失败 >>> " + e);
                }
            }
        }
    }
}
