/*接口访问路径配置*/

export class SettingUrl {
  // 接口通讯url集合
  static URL: any = {
    /**
     * 首页统计
     */
    home: {
      homePageInfo: "admin/bidding/homePageInfo",  //加载首页统计信息
    },
    /**
     * 基础路径配置
     */
    base: {
      enum: '/res/enum/',            //获取枚举接口
      uploadRetHttpUrl: '/upload/basic/uploadRetHttpURL',  //上传图片
      upload: '/upload/basic/upload',  //上传图片
      uuid: '/upload/basic/uid',      //获取上传图片的编码
    },
    /**
     * 登录接口
     */
    login: {
      login: '/login/rbac/login',//登录接口
      logout: "/login/rbac/logout", //（get）退出登录登录
      getSms: '/sms/forgetPasswordSMS',//（post）获取验证码
      checkSmsCode: '/sms/checkSmsCode',//（get）验证码的校验
    },
    <#list classes as class>
    ${class.className?uncap_first}: {
      list: '/${class.className?uncap_first}/list',//${class.className}列表
      add: '/${class.className?uncap_first}/build',//添加${class.className}
      modify: '/${class.className?uncap_first}/modify',//修改${class.className}
      load: '/${class.className?uncap_first}/load/code/',//查询${class.className}信息
      updateState: '/${class.className?uncap_first}/updateState'//修改${class.className}状态
    }<#if class_has_next>,</#if>
    </#list>

  };

// 路由链接信息
  static ROUTERLINK: any = {
    basic: {
      home: '/main/home'
    },
    pass: {
      login: "/listData/login", //登录
    },
  <#list modelDatas as modelData>
  <#list modelData.classes as class>
  <#if modelData.classes?size gt 1>
    ${class.className?uncap_first}: {
      list: '/main/${class.classModel}/${class.dashedCaseName}/list',//${class.className}列表
      add: '/main/${class.classModel}/${class.dashedCaseName}/add',//添加${class.className}
      modify: '/main/${class.classModel}/${class.dashedCaseName}/modify',//修改${class.className}
      detail: '/main/${class.classModel}/${class.dashedCaseName}/detail'<#if class_has_next>,</#if>//查询${class.className}信息
    }<#if class_has_next>,</#if>
  <#else>
    ${class.className?uncap_first}: {
      list: '/main/${class.classModel}/list',//${class.classModel}列表
      add: '/main/${class.classModel}/add',//添加${class.classModel}
      modify: '/main/${class.classModel}/modify',//修改${class.classModel}
      detail: '/main/${class.classModel}/detail'//查询${class.classModel}信息
    }<#if modelData_has_next>,</#if>
    </#if>
    </#list>
    </#list>
  }
}
