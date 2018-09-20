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
    <#list modelDatas as modelData>
    <#list modelData.classes as class>
    ${class.className}: {
      list: '/${class.className}/list',//${class.className}列表
        add: '/${class.className}/build',//添加${class.className}
        modify: '/${class.className}/modify',//修改${class.className}
        load: '/${class.className}/load/code/',//查询${class.className}信息
        updateState: '/${class.className}/updateState',//修改${class.className}状态
    },
    </#list>
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
  <#list classes as class>
    ${class.classModel}: {
      list: '/main/${class.classModel}/list',//${class.classModel}列表
      add: '/main/${class.classModel}/add',//添加${class.classModel}
      modify: '/main/${class.classModel}/modify',//修改${class.classModel}
      detail: '/main/${class.classModel}/detail',//查询${class.classModel}信息
    },
    </#list>
  }
}
