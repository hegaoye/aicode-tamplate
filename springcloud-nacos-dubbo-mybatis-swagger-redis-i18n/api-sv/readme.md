```
在 Nacos Spring Cloud 中，dataId 的完整格式如下：

${prefix}-${spring.profile.active}.${file-extension}
prefix 默认为 spring.application.name 的值，
也可以通过配置项 spring.cloud.nacos.config.prefix来配置。

spring.profile.active 即为当前环境对应的 profile，详情可以参考 Spring Boot文档。 
注意：当 spring.profile.active 为空时，对应的连接符 - 也将不存在，
dataId 的拼接格式变成 ${prefix}.${file-extension}

file-exetension 为配置内容的数据格式，
可以通过配置项 spring.cloud.nacos.config.file-extension 来配置。
目前只支持 properties 和 yaml 类型。
```

```
dubbo支持了接口级别也支持方法级别，可以根据不同的实际情况精确控制每个方法的超时时间。所以最终的优先顺序为：客户端方法级>服务端方法级>客户端接口级>服务端接口级>客户端全局>服务端全局
```
