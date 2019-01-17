const sz = 'http://192.168.10.112:8762';  //berton
const lk = 'http://192.168.10.163:8082';  //berton

/**
 * 配置代理
 * @type {[null,null]}
 */
const PROXY_CONFIG = [
  {
    context: [
      "/login", //登录
      <#list classes as class>
      "/${class.className?uncap_first}",//${class.className?uncap_first}
      </#list>
    ],
    target: sz,   //拦截 context配置路径，经过此地址
    secure: false
  },
  {
    context: [
      "/res",    //枚举
      "/frontendI18n",    //国际化
    ],
    target: sz,   //拦截 context配置路径，经过此地址
    secure: false
  }
];

module.exports = PROXY_CONFIG;
