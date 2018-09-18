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
  ${classNameLower}: {
      list: '/${classNameLower}/list',//${className}列表
      add: '/${classNameLower}/build',//添加${className}
      modify: '/${classNameLower}/modify',//修改${className}
      load: '/${classNameLower}/load/code/',//查询${className}信息
      updateState: '/${classNameLower}/updateState',//修改${className}状态
    }
  };

// 路由链接信息
  static ROUTERLINK: any = {
    basic: {
      home: '/main/home'
    },
    pass: {
      login: "/listData/login", //登录
    },
${classNameLower}: {
      list: '/main/${classNameLower}/list',//列表
      add: '/main/${classNameLower}/add',//添加
      modify: '/main/${classNameLower}/modify',//修改
      detail: '/main/${classNameLower}/detail',//详情
    },
  }
}
