const berton = 'http://192.168.1.182:';  //berton

/**
 * 配置代理
 * @type {[null,null]}
 */
const PROXY_CONFIG = [
  {
    context: [
      "/supplier",    //供应商
      "/supplierCategory", //供应商类型
      "/material",    //材料
      "/materialCategory", //材料类型
      "/materialBrand", //材料品牌
      "/cycleTime", //生产周期
      "/paymentTerm", //支付方式
      "/login", //登录
      "/admin", //数据字典
      "/syncTrace",   //同步追踪
      "/syncNewData", //需同步
      "/syncDataTrace", //同步详情
      "/setting", //设置
      "/staff", //员工
      "/factory", //工厂
      "/factorySample", //工厂样品
      "/errortype", //错误类型
      "/sample", //样品
      "/testOption", //测试项
      "/testUnit", //测试件
      "/succedaneumMaterial", //可替换材料
    ],
    target: berton + '8764',   //拦截 context配置路径，经过此地址
    secure: false
  }, {
    context: [
      "/res",    //枚举
      "/frontendI18n",    //国际化
    ],
    target: berton + '8756',   //拦截 context配置路径，经过此地址
    secure: false
  }
];

module.exports = PROXY_CONFIG;
