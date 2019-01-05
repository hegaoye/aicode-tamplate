/*接口访问路径配置*/

export class SettingUrl {
  // 接口通讯url集合
  static URL: any = {
    /**
     * 基础路径配置
     */
    base: {
      enum: '/res/enum/',
      // uploadForEditor: '/upload/basic/uploadForCkEditor',  //上传图片
    },
    // basicSettings: {
    //   list: '/basicSettings/list',//BasicSettings列表
    // },

    <#list classes as class>
      ${class.className?uncap_first}: {
        list: '/${class.className?uncap_first}/list',//${class.className}列表
      }<#if class_has_next>,</#if>
    </#list>
  };

  // 路由链接信息
  static ROUTERLINK: any = {
    admin: {
      admin: 'admin',
      dashboard: 'dashboard',
      dashboardFull: '/admin/dashboard',

      // basic: {
      //   basic: 'basic',
      //   basicSettings: {
      //     basicSettings: 'basicSettings',
      //     list: 'list',
      //     listFull: '/admin/basic/basicSettings/list'
      //   },
      // },

      <#list modelDatas as modelData>
        ${modelData.model}Model:{
          ${modelData.model}Main:'${modelData.model}',
          <#list modelData.classes as class>
            ${class.className?uncap_first}: {
            ${class.className?uncap_first}: '${class.dashedCaseName}',
            list: 'list',
            listFull: '/admin/${class.classModel}/${class.dashedCaseName}/list'//${class.className}列表
          }<#if modelData_has_next || class_has_next>,</#if>
          </#list>
        },
      </#list>

    },
    passport: {
      passport: 'passport',
      login: 'login',
      lock: 'lock',
      register: 'register',
      registerResult: 'register-result',
      loginFull: '/passport/login', //登录
      lockFull: '/passport/lock', //锁屏
    },
    page: {
      callback: 'callback/:type',
      p403: '403',
      p404: '404',
      p500: '500',
    },
  };
}
