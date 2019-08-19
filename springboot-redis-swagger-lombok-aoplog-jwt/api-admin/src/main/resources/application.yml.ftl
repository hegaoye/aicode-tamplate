spring:
  profiles:
    active: dev
  application:
    name: ${projectName?replace("_","-")}-provider
  output:
    ansi:
      enabled: always #控制台的输出颜色控制
  jpa:
    database: MySQL
    show-sql: true
  datasource:
    name: mysql-data
    url: jdbc:mysql://192.168.10.220:3306/${projectName}?useUnicode=true&characterEncoding=utf-8&characterSetResults=utf8&zeroDateTimeBehavior=exception&allowMultiQueries=true&serverTimezone=Asia/Shanghai
    username: root
    password: mysqladmin
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
    database: 0
    host: 192.168.10.220
    port: 6379
    #    password: 123456
    timeout:  0 # 连接超时时间（毫秒）
    pool:
      max-active: 8 # 连接池最大连接数（使用负值表示没有限制）
      max-wait: -1 # 连接池最大阻塞等待时间（使用负值表示没有限制）
      max-idle: 8 # 连接池中的最大空闲连接
      min-idle: 0 # 连接池中的最小空闲连接
  jackson:
    date-format: yyyy-MM-dd HH:mm:ss
    time-zone: GMT+8
#    serialization: true
#    deserialization: true
  http:
    multipart:
      max-file-size: "2MB"
      max-request-size: "10MB"
    encoding:
      charset: UTF-8
      enabled: true
  mail:
    host:
    username:
    port:
    password:
    protocol: smtp
    default-encoding: UTF-8
    jndi-name:
    test-connection: false
#      force: true
# 设定自己启动内置tomcat端口号
server:
  port: 8762
  tomcat:
    uri-encoding: UTF-8
  session:
    timeout: 10000
#  address: 192.168.10.110

# 指定mybatis映射文件的地址
mybatis:
  mapper-locations: classpath:mapper/*/*.xml,classpath:/META-INF/mybatis/mapper/WORKER*.xml
  configLocation: classpath:mapper/mybatis-config.xml

jwt:
  # 加密盐
  secret: 99)eq2<*>^(aem.(~JK3
  # token名称；此处定义 仅是token全称的后半部分，使用时需要添加角色为前缀
  tokenName: Authorization
  # 是否使用cookie保存token
  useCookie: true
  # 过期时间（单位：秒）60s * 60min * 24hour * 30day
  expiredSeconds: 2592000

# 微信配置
# wx.appid 是微信公众账号或开放平台APP的唯一标识，在公众平台申请公众账号或者在开放平台申请APP账号后，
# 微信会自动分配对应的appid，用于标识该应用。可在微信公众平台-->开发-->基本配置里面查看，
# 商户的微信支付审核通过邮件中也会包含该字段值。
# wx.app_secret 开发者密码
# 开发者密码是校验公众号开发者身份的密码，具有极高的安全性。切记勿把密码直接交给第三方开发者或直接存储在代码中。如需第三方代开发公众号，请使用授权方式接入。
# APPID对应的接口密码，用于获取接口调用凭证access_token时使用。
# 在微信支付中，先通过OAuth2.0接口获取用户openid，此openid用于微信内网页支付模式下单接口使用。
# 可登录公众平台-->微信支付，获取AppSecret（需成为开发者且帐号没有异常状态）。
# wx.mch_id 微信支付商户号
# wx.api_key API密钥，交易过程生成签名的密钥，仅保留在商户系统和微信支付后台，不会在网络中传播。
# 商户妥善保管该Key，切勿在网络中传输，不能在其他客户端中存储，保证key不会被泄漏。
# 商户可根据邮件提示登录微信商户平台进行设置。
# 也可按一下路径设置：微信商户平台(pay.weixin.qq.com)-->账户中心-->账户设置-->API安全-->密钥设置
# wx.notify_url 接收微信支付异步通知回调地址，通知url必须为直接可访问的url，不能携带参数。
# wx.mac_path 证书路径[APP相关配置]
# wx.js_mac_path 证书路径[JSAPI相关配置]
# wx.token 微信认证用的自定义token
# wx.pay_total_fee 沙箱环境支付金额
wx:
  appid:
  app_secret:
  js_appid: wxdac7ad67dd4a1044
  js_app_secret: 659dcfdb1cd4a5ff2a2071b89c8949f5
  mch_id:
  api_key:
  notify_url:
  mac_path:
  js_mac_path:
  token:
  pay_total_fee:

#七牛云账号与配置
qiniu:
  # AccessKey|AK
  AK:
  # SecretKey|SK
  SK:
  # 空间名称
  bucket_name:
  # 空间域名
  service:
  account:
  pwd:
  # 上传文件的临时目录
  upload_temp_dir: upload
  # 系统限制上传文件最大字节数（单位：字节；1mb=1048576b）
  upload_img_size: 10485760

dingtalk:
  robot:
    # 多个以 英文 逗号 , 隔开
    atMobilesDefault: 13460005569,
    webhook: https://oapi.dingtalk.com/robot/send?access_token=e082372f39de14c91908965f6a2e763024dea1bb0926bf2ff52c19701e1a9ac4


logging:
  level:
    root: debug