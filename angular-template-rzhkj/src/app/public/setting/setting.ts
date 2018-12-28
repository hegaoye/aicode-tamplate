/*基本属性配置*/
export class Setting {
  public user: any = {
    name: 'Andy'
  };

  public static APP: any = {                           //平台信息
    name: '${projectName}-后台管理系统',
    description: '${projectName}-后台管理系统',
    copyright: '© 2018 - 仁中和科技',
    logo: '',
    contactInformation: {
      qq: "1234567893",
      wx: "15045678912",
      phone: "15045678912",
      email: "15045678912@163.com"
    },
  };
  public static MENUS: Array<any> = new Array();      //平台菜单

  /**
   * 表单校验的状态，配合Util.ngValidateErrorMsg方法使用，此状态一般用来判断显示表单提示信息
   * eg1:<div nz-form-explain *ngIf="ngValidateErrorMsg(ngPhone) == Setting.valitateState.empty">请输入手机号！</div>
   * eg2:<div nz-form-explain *ngIf="ngValidateErrorMsg(ngPhone) == Setting.valitateState.error">请输入正确的手机号！</div>
   */
  public static valitateState: any = {
    empty: "empty",
    error: "error"
  };

  //存入storage信息的键名
  public static storage: any = {
    menusInfo: 'menus',//存入localStorage的菜单的键值
    language: 'language',//存入localStorage的语言的键值
  };

  public static I18nData: any = {};

}
