config:
  domain:
spring:
  datasource:
    name: mysql-data
    url: jdbc:mysql://172.31.54.88:3306/${projectName}_test?useUnicode=true&characterEncoding=utf-8&characterSetResults=utf8&zeroDateTimeBehavior=exception&allowMultiQueries=true&serverTimezone=Asia/Shanghai
    username: vcard_test
    password: dk@dSB4U@d3al8&vcard3#^
    driver-class-name: com.mysql.cj.jdbc.Driver
    type: com.alibaba.druid.pool.DruidDataSource # 使用druid数据源
    initialSize: 10 #初始化连接数量，最大最小连接数
    maxActive: 100
    minIdle: 3
    maxWait: 600000  #获取连接等待超时的时间
    removeAbandoned: true  #超过时间限制是否回收
    removeAbandonedTimeout: 180 #超过时间限制多长
    timeBetweenEvictionRunsMillis: 600000 #配置间隔多久才进行一次检测，检测需要关闭的空闲连接，单位是毫秒
    minEvictableIdleTimeMillis: 300000 #配置一个连接在池中最小生存的时间，单位是毫秒
    validationQuery: SELECT 1 FROM DUAL #用来检测连接是否有效的sql，要求是一个查询语句
    testWhileIdle: true #申请连接的时候检测
    testOnBorrow: false #申请连接时执行validationQuery检测连接是否有效，配置为true会降低性能
    testOnReturn: false #归还连接时执行validationQuery检测连接是否有效，配置为true会降低性能
    poolPreparedStatements: true #打开PSCache，并且指定每个连接上PSCache的大小
    maxPoolPreparedStatementPerConnectionSize: 100
    connectionProperties: druid.stat.mergeSql=true;druid.stat.slowSqlMillis=5000
    filters: stat #属性类型是字符串，通过别名的方式配置扩展插件，常用的插件有：监控统计用的filter:stat 日志用的filter:log4j 防御SQL注入的filter:wall
  redis:
    database: 8
    host: 172.31.54.88
    port: 6379
    password: NSpfbhlEeeqc09L9ir2XKO4raJmRfM
    timeout:  0 # 连接超时时间（毫秒）
    pool:
      max-active: 8 # 连接池最大连接数（使用负值表示没有限制）
      max-wait: -1 # 连接池最大阻塞等待时间（使用负值表示没有限制）
      max-idle: 8 # 连接池中的最大空闲连接
      min-idle: 0 # 连接池中的最小空闲连接
wx:
  js_appid: wxdac7ad67dd4a1044
  js_app_secret: 659dcfdb1cd4a5ff2a2071b89c8949f5

# 七牛云账号与配置
qiniu:
  # AccessKey|AK
  AK:
  # SecretKey|SK
  SK:
  # 空间名称
  bucket_name:
  # 空间域名
  service:
  # 上传文件的临时目录
  upload_temp_dir: upload

logging:
  level:
    root: debug
    sun.rmi: warn
    java.sql.Connection: info
    java.sql.Statement: info
    java.sql.PreparedStatement: info
    org.mybatis.spring: info
    com.github: error
    org.apache: warn
    org.apache.tomcat: info
    org.apache.ibatis: info
    org.hibernate: error
    org.jboss.logging: error
    org.springframework: warn
    org.springframework.boot: info
    springfox.documentation: warn
