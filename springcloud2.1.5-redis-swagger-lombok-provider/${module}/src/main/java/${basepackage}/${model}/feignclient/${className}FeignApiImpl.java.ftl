package ${basePackage}.${model}.feignclient;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class ${className}FeignApiImpl implements ${className}FeignApi {

  @Override
  public String load(String ${classNameLower}) {
    log.debug(${classNameLower});
    return "hegaoye";
  }
}
