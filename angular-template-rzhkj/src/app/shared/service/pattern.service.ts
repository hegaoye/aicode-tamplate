import {Injectable} from '@angular/core';

/**
 * 用来定义表单验证的正则表达式
 */
@Injectable()
export class PatternService {

  public static email: RegExp = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;//邮箱
  public static pwd: RegExp = /^\S{6,16}$/;//密码
  public static sms: RegExp = /^[0-9]{6}$/;//短信验证码
  public static mobile: string = '^1[0-9]{10}$'; //手机号正则
  public static phone: RegExp = /^((^[0-9]{3,4}-[0-9]{7,8}$)|(^[0-9]{7,8}$))$/;//固话
  public static tel: string = '(^1[0-9]{10}$)|(^((^[0-9]{3,4}-[0-9]{7,8}$)|(^[0-9]{7,8}$))$)';//手机号和固话同时验证
  public static idCard: RegExp = /^(^[1-9][0-9]{7}((0[0-9])|(1[0-2]))(([0|1|2][0-9])|3[0-1])[0-9]{3}$)|(^[1-9][0-9]{5}[1-9][0-9]{3}((0[0-9])|(1[0-2]))(([0|1|2][0-9])|3[0-1])(([0-9]{4})|[0-9]{3}[Xx])$)$/;//身份证号
  public static num: RegExp = /^[0-9]*$/;//数字
  public static letter: RegExp = /^[A-Za-z]*$/;//字母
  public static buno: RegExp = /^(([a-zA-Z0-9]{8}-[a-zA-Z0-9])|([a-zA-Z0-9]{18})|([a-zA-Z0-9]{15}))$/;//营业执照
  public static backcard: RegExp = /^([0-9]{16}|[0-9]{19})$/;//银行卡正则（三网合一）
  public static _URL: RegExp = /^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$/;//网址
  public static integer: RegExp = /^[0-9]*[1-9][0-9]*$/;//正整数
  public static website = '^(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?$';//网址正则

  constructor() {

  }

  // public num: string; //数字
  // public letter: string; //字母
  // public email: string; //邮箱
  // public phone: string; //手机号
  // public idcard: string; //身份证
  // public telephone: string; //固话
  // public buno: string; //营业执照
  // public backcard: string; //银行卡
  // public backAffiliated: string; //银行联号
  // public chinese: string; //中文
  // public tel: string;//手机号和固话
  // public creditCode: string;  //社会信用代码
  // public taxCode: string;  //税务登记号
  // public orgCode: string;  //组织机构代码证号
  // public decimals: string;  // 0-1小数
  // public doubleDigit: string; // 两位为整数（0-99）
  // public _URL: string; //网址
  // public twodecimal: string;//两位小数
  // public threedecimal: string;//三位小数
  // public integer: string;//正整数
  // public storage: string;//库存，十以上正整数
  // public icCard: any;//银行卡正则（15~32位）
  // public letterNumber: any;//字母和符号
  // public pwd: any;
  //
  // constructor() {
  //   this.num = '^[0-9]*$'; //数字正则
  //   this.letter = '^[A-Za-z]*$'; //字母正则
  //   this.phone = '^1[0-9]{10}$'; //手机号正则
  //   this.email = '^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$'
  //   this.idcard = '^(^[1-9][0-9]{7}((0[0-9])|(1[0-2]))(([0|1|2][0-9])|3[0-1])[0-9]{3}$)|(^[1-9][0-9]{5}[1-9][0-9]{3}((0[0-9])|(1[0-2]))(([0|1|2][0-9])|3[0-1])(([0-9]{4})|[0-9]{3}[Xx])$)$'; //身份证正则
  //   this.telephone = '^((^[0-9]{3,4}-[0-9]{7,8}$)|(^[0-9]{7,8}$))$'; //固话正则（支持带区号和不带区号）
  //   this.buno = '^(([a-zA-Z0-9]{8}-[a-zA-Z0-9])|([a-zA-Z0-9]{18})|([a-zA-Z0-9]{15}))$'; //营业执照正则（三网合一）
  //   this.backcard = '^([0-9]{16}|[0-9]{19})$'; //银行卡正则（三网合一）
  //   this.backAffiliated = '^[0-9]{12}$'; //银行联号
  //   this.creditCode = '^[0-9A-Z]{18}$';//社会信用代码
  //   this.taxCode = '^[0-9]{15}$';//税务登记号
  //   this.orgCode = '^[0-9]{8}-([0-9]{1}|[A-Z]{1})$';//组织机构代码证号
  //   this.chinese = '^[\u4e00-\u9fa5]{0,}$'; //中文正则（三网合一），除中文的任何数字包括字符
  //   this.tel = '(^1[0-9]{10}$)|(^((^[0-9]{3,4}-[0-9]{7,8}$)|(^[0-9]{7,8}$))$)';//手机号和固话同时验证
  //   this._URL = '^([hH][tT]{2}[pP]:\/\/|[hH][tT]{2}[pP][sS]:\/\/)(([A-Za-z0-9-~]+)\.)+([A-Za-z0-9-~\/])+$'; //网址
  //   this.decimals = '^(0\.[0-9]*[1-9]$)|^0$';　　//0-1小数，包含0,不包含1
  //   this.twodecimal = '^[0-9]+(.[0-9]{1,2})?$';    //两位小数
  //   this.threedecimal = '^[0-9]+(.[0-9]{1,3})?$';    //两位小数
  //   this.doubleDigit = '^[0-9]{1,2}$';      // 两位整数（0-99）
  //   this.integer = '^[0-9]*[1-9][0-9]*$';   //只能正整数
  //   this.storage = '^[1-9]{1}[0-9]+';//库存，十以上正整数
  //   this.icCard = '^[0-9]{15,32}$'; //银行卡正则（15~32位）
  //   this.letterNumber = '^[A-Za-z]|[\s]|[/]+$';//字母和符号
  //   this.pwd = /^[0-9a-zA-Z_]{6,15}$/; //密码（6-15位数字字母组成）
  // }

}
