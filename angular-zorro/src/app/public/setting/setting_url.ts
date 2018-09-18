/*接口访问路径配置*/

export class SettingUrl {
  // 接口通讯url集合
  static URL: any = {
    /**
     * 基础路径配置
     */
    base: {
      enum: '/res/enum/',            //获取枚举接口
    },
    <#list classes as class>
    ${class.classModel}: {
      list: '/${class.classModel}/list',//${className}列表
      add: '/${class.classModel}/build',//添加${className}
      modify: '/${class.classModel}/modify',//修改${className}
      load: '/${class.classModel}/load/code/',//查询${className}信息
      updateState: '/${class.classModel}/updateState',//修改${className}状态
      },
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
        list: '/main/${class.classModel}/list',//${className}列表
        add: '/main/${class.classModel}/build',//添加${className}
        modify: '/main/${class.classModel}/modify',//修改${className}
        detail: '/main/${class.classModel}/detail',//查询${className}信息
      },
    </#list>
  }
}
