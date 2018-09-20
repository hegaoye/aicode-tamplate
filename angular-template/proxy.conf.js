const berton = 'http://192.168.1.182:';  //berton

/**
 * 配置代理
 * @type {[null,null]}
 */
const PROXY_CONFIG = [
  {
    context: [
      "/login", //登录
      <#list classes as class>
  "/${class.className}",//${class.classModel}
      </#list>
    ],
    target: berton + '8764',   //拦截 context配置路径，经过此地址
    secure: false
  },
{
    context: [
      "/res",    //枚举
      "/frontendI18n",    //国际化
    ],
    target: berton + '8756',   //拦截 context配置路径，经过此地址
    secure: false
  }
];

module.exports = PROXY_CONFIG;
