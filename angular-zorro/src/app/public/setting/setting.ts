/*基本属性配置*/
export class Setting {
  public user: any = {
    name: 'Andy'
  };                                   //保存管理员的基本信息
  public static AJAX: any = {
    errorTip: '处理失败，请稍候重试或联系我们：',//ajax请求错误提示信息
    failText: '服务器异常' //ajax请求失败提示信息
  };//ajax 信息

  public static APP: any = {                           //平台信息
    name: 'pi-top中国-后台管理系统',
    description: 'pi-top中国-后台管理系统',
    copyright: '© 2018 - 玺得科技',
    logo: '../../../assets/img/logo.png',
    logoDark: '../../../assets/img/logo-dark.png',
    defaultImg: '',
    // defaultImg: '../../../assets/img/dummy.png',
    userDefaultImg: '../../../assets/img/user-default.png',
    refundImg: '../../../assets/img/refund.png',
    contactInformation: {
      qq: "1234567893",
      wx: "15045678912",
      phone: "15045678912",
      email: "15045678912@163.com"
    },
  };
  public static MENUS: Array<any> = new Array();      //平台菜单
  public static PAGEMSG: any = {                        //平台信息提示（公式、提示、引导等等...）
    noAuthTip: "您的权限不足",
    tipTitle: "操作提示",
    user: {
      freeze: '您确认“冻结”该账户吗？',
      unfreeze: '您确认“解冻”该账户吗？'
    },
    announce: {
      delete: '您确认“删除”该公告吗？'
    }
  }

  /**
   * 表单校验的状态，配合Util.ngValidateErrorMsg方法使用，此状态一般用来判断显示表单提示信息
   * eg1:<div nz-form-explain *ngIf="ngValidateErrorMsg(ngPhone) == Setting.valitateState.empty">请输入手机号！</div>
   * eg2:<div nz-form-explain *ngIf="ngValidateErrorMsg(ngPhone) == Setting.valitateState.error">请输入正确的手机号！</div>
   */
  public static valitateState: any = {
    empty: "empty",
    error: "error"
  }

  //存入storage信息的键名
  public static storage: any = {
    menusInfo: 'menus',//存入localStorage的菜单的键值
    language: 'language',//存入localStorage的语言的键值
  }

  public static I18nData: any = {};

}
