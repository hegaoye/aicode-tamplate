/*基本属性配置*/
import { SettingUrl } from '@shared/setting/setting_url';

export class Setting {

  public static APP: any = {                           //平台信息
    simpleName: '仁中和',
    name: '仁中和科技',
    description: '企业级信息解决方案',
    copyright: '© 仁中和科技有限公司',
    record: '豫ICP备XXXXX号',
    address: '公司地址：XXXXXXXXXXXXX',
    logo: '../../assets/img/logo.jpg',
    defaultImg: '../../assets/img/default/no-img.png',
    userDefaultImg: '../../assets/img/default/user.png',
    contactInformation: {
      qq: '',
      wx: '',
      phone: '0371-67896359',
      email: 'rzhkj@126.com',
    },
  };

  public static RETURNINFO: any = {
    success: false,
    info: '操作有误',
  };

  //定义枚举
  public static ENUM: any = {
    // isState: 1001,  //是否
  };


  //定义枚举状态名
  public static ENUMSTATE: any = {
    yes: 'Y',
    no: 'N',
    web: 'WEB', //web端标识
    // activity: { //活动信息状态
    //   state: {
    //     OVER: "OVER", //已结束
    //     PICK: "PICK", //开奖中
    //     OFFLINE: "OFFLINE", //未上线
    //     ONLINE: "ONLINE" //上线
    //   }
    // }
  };

  //数据字典键名
  public static SETTINGINFO: any = {
    // bankTypeCode: "common_use_bank_name"
  };

  //存入cookie信息的键名
  public static COOKIE: any = {
    // userInfo: "user-info-cookie"//用户键名
  };

  //基础信息设置
  public static BASEINFO: any = {
    // defaultLng: '115.650497', //默认经度
    // defaultLat: '34.437054', //默认维度
    mapKey: '08ed420819a6b8182a990a056fb6ad12', //地图的key
  };

  //枚举信息集合
  public static enumData = {};

  //菜单列表
  public static MENUDATAS = [
    {
      text: '系统首页',
      link: SettingUrl.ROUTERLINK.admin.dashboardFull,
      icon: { type: 'icon', value: 'appstore' },
    },
    <#list modelDatas as modelData>
      {
        text: '${modelData.model}',
        icon: 'anticon anticon-dashboard',
        link: SettingUrl.ROUTERLINK.admin.${modelData.model}Model.${modelData.model}Main,
        children: [
          <#list modelData.classes as class>
            <#if modelData.classes?size gt 1>
              {
                text: '${class.notes}',
                link: SettingUrl.ROUTERLINK.admin.${modelData.model}Model.${class.className?uncap_first}.listFull,
              }<#if class_has_next>,</#if>
            </#if>
          </#list>
        ],
      },
    </#list>

  ];
}
