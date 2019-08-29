package ${basePackage}.${model}.feignclient;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@FeignClient(value = "${classNameLower}", fallback = ${className}FeignApiImpl.class, path = "/${classNameLower}")
public interface ${className}FeignApi {
  @GetMapping(value = "/load")
  String load(@RequestParam("${classNameLower}") String ${classNameLower});
}
