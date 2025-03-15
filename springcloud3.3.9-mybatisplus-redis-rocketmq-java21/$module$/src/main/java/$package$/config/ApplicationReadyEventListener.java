package $package$.config;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.cloud.stream.config.BindingProperties;
import org.springframework.cloud.stream.config.BindingServiceProperties;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * ready程序事件监听
 */
@Slf4j
@Component
public class ApplicationReadyEventListener implements ApplicationListener<ApplicationReadyEvent> {

    @Value("${spring.application.name}")
    private String applicationName;

    @Autowired
    private BindingServiceProperties bindingServiceProperties;

    @Override
    public void onApplicationEvent(ApplicationReadyEvent event) {
        Map<String, BindingProperties> map = bindingServiceProperties.getBindings();
        if (!CollectionUtils.isEmpty(map)) {
            List<String> list = new ArrayList<>();
            List<String> finalList = list;
            map.forEach((key, bindingProperties) -> {
                String group = bindingProperties.getGroup();
                String destination = StringUtils.isBlank(group)
                        ? "OUT:     ".concat(bindingProperties.getDestination())
                        : "IN:      ".concat(bindingProperties.getDestination());
                finalList.add(destination);
            });

            list = list.stream().distinct().collect(Collectors.toList());

            StringBuffer stringBuffer = new StringBuffer();
            stringBuffer.append("\n");

            for (String topic : list) {
                stringBuffer.append(topic).append("\n");
            }

            String s = stringBuffer.toString();
            log.info("\n {} 项目中的 mq topic -\n{}", applicationName, s);
        }

        log.info("\n\n---服务启动完成---\n\n");
    }
}
