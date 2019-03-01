spring:
  application:
    name: ${projectName?replace("_","-")}-consumer
  zipkin:
    base-url: http://localhost:9411
    connectTimeout: 3000
    readTimeout: 3000
    flushInterval: 1
    compressionEnabled: true
  output:
    ansi:
      enabled: always
  redis:
    database: 0
    host: 192.168.1.220
    port: 6379
#    password: 123456
    timeout:  0 # 连接超时时间（毫秒）
    pool:
      max-active: 8 # 连接池最大连接数（使用负值表示没有限制）
      max-wait: -1 # 连接池最大阻塞等待时间（使用负值表示没有限制）
      max-idle: 8 # 连接池中的最大空闲连接
      min-idle: 0 # 连接池中的最小空闲连接

feign:
  hystrix:
    enabled: true

hystrix:
   command:
      default:
         execution:
           isolation:
             thread:
               timeoutInMilliseconds: 3000 #hystrix调用方法的超时时间，默认是1000毫秒


server:
  port: 8764


#访问注册中心配置
eureka:
    instance:
        prefer-ip-address: true
        instance-id: ${r'${'}spring.application.name}:${r'${'}spring.cloud.client.ipAddress}:${r'${'}spring.application.instance_id:${r'${'}server.port}}
        hostname: localhost #指定主机名
        status-page-url: http://${r'${'}eureka.instance.hostname}:${r'${'}server.port}/swagger-ui.html
        lease-expiration-duration-in-seconds: 5 #心跳更新时间5s
        lease-renewal-interval-in-seconds: 5 #心跳过期时间5s
    client:
        serviceUrl:
            defaultZone: http://${r'${'}security.user.name}:${r'${'}security.user.password}@${r'${'}eureka.instance.hostname}:8761/eureka/

#启用密码保护
security:
    basic:
        enabled: true
    user:
        name: ${projectName}
        password: www.${projectName}.com

logging:
#   pattern:
#     console: "%d{HH:mm:ss.SSS} [%t] %-5p: %m%n"
   level:
     com:
       pitop: debug

   path: /var/log/tomcat/
#     org:
#      springframework: debug
#      spring:
#        springboot:
#               dao: debug


