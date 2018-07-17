server:
  port: 9411

eureka:
  instance:
    prefer-ip-address: true
    instance-id: ${r'${spring.application.name}'}:${r'${spring.cloud.client.ipAddress}'}:${r'${'}spring.application.instance_id:${r'${'}server.port}}
    appname: zipkin-server
    hostname: localhost
  client:
    service-url:
      defaultZone: http://${r'${'}security.user.name}:${r'${'}security.user.password}@${r'${'}eureka.instance.hostname}:8761/eureka

spring:
  application:
    name: zipkin-server
  output:
    ansi:
      enabled: always

#启用密码保护
security:
 basic:
   enabled: true
 user:
   name: pitop
   password: www.pi-top.com