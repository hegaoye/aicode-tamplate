const berton = 'http://192.168.19.96:';  //berton

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
    target: berton + '8764',   //拦截 context配置路径，经过此地址
    secure: false
  }
];

module.exports = PROXY_CONFIG;
