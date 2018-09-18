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
  ${classNameLower}: {
      list: '/${classNameLower}/list',//${className}列表
      add: '/${classNameLower}/build',//添加${className}
      modify: '/${classNameLower}/modify',//修改${className}
      load: '/${classNameLower}/load/code/',//查询${className}信息
      updateState: '/${classNameLower}/updateState',//修改${className}状态
    },
/*
    supplier: {
      list: '/supplier/list',//供应商列表
      add: '/supplier/build',//添加供应商
      modify: '/supplier/modify',//修改供应商
      load: '/supplier/load/code/',//查询供应商信息
      updateState: '/supplier/updateState',//修改供应商状态
    },*/
    supplierCategory: {
      list: '/supplierCategory/list',//供应商类型列表
      add: '/supplierCategory/build',//添加供应商类型
      modify: '/supplierCategory/modify',//修改供应商类型
      load: '/supplierCategory/load/code/',//查询供应商类型信息
    },
    payment: {
      list: '/paymentTerm/list',//支付方式列表
      add: '/paymentTerm/build',//添加支付方式
      modify: '/paymentTerm/modify',//修改支付方式
      load: '/paymentTerm/load/code/',//查询支付方式信息
    },
    enums: {
      gender: '/res/enum/',//性别枚举
    },
  };

// 路由链接信息
  static ROUTERLINK: any = {
    basic: {
      home: '/main/home'
    },
    pass: {
      login: "/listData/login", //登录
    },
    supplier: {
      list: '/main/supplier/suppliers/list',//列表
      add: '/main/supplier/suppliers/add',//添加
      modify: '/main/supplier/suppliers/modify',//修改
      detail: '/main/supplier/suppliers/detail',//详情
    },
    material: {
      list: '/main/supplier/materials/list',//列表
      add: '/main/supplier/materials/add',//添加
      modify: '/main/supplier/materials/modify',//修改
      detail: '/main/supplier/materials/detail',//详情
    },
    staff: {
      list: '/main/managements/staff/list',//列表
      add: '/main/managements/staff/add',//添加
      modify: '/main/managements/staff/modify',//修改
    },
    sync: {
      syncTrace: {
        list: "/main/sync/syncTrace/list",    //同步追踪列表
        detail: "/main/sync/syncTrace/detail"    //同步追踪详情
      },
      newData: {
        list: "/main/sync/newData/list",     //可同步数据列表
        detail: "/main/sync/newData/detail"    //可同步数据详情
      }
    },
    sample:{
      list: "/main/managements/sample/list",     //样品列表
      detail: "/main/managements/sample/detail"     //样品列表
    }
  }
}
