export class Pattern {
  public static num: string = '^[0-9]*$'; //数字正则
  public static letter: string = '^[A-Za-z]*$'; //字母正则
  public static idCard: string = '^(^[1-9][0-9]{7}((0[0-9])|(1[0-2]))(([0|1|2][0-9])|3[0-1])[0-9]{3}$)|(^[1-9][0-9]{5}[1-9][0-9]{3}((0[0-9])|(1[0-2]))(([0|1|2][0-9])|3[0-1])(([0-9]{4})|[0-9]{3}[Xx])$)$'; //身份证正则
  public static email: string = '^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$'
  public static mobile: string = '^1[0-9]{10}$'; //手机号正则
  public static telephone: string = '^((^[0-9]{3,4}-[0-9]{7,8}$)|(^[0-9]{7,8}$))$'; //固话正则
  public static faxCode: string = '^([0-9]{3,4}-)?[0-9]{7,8}$'; //传真正则
  public static zipCode: string = '^[0-9]{6}$'; //邮编正则
  public static tel: string = '(^1[0-9]{10}$)|(^((^[0-9]{3,4}-[0-9]{7,8}$)|(^[0-9]{7,8}$))$)';//手机号和固话同时验证
  public static decimals: string = '^(0\.[0-9]*[1-9]$)|^0$';　　//0-1小数，包含0,不包含1
  public static doubleDigit: string = '^[0-9]{1,2}$';      // 两位整数（0-99）
  public static twodecimal: string = '^[0-9]+(.[0-9]{1,2})?$';    //两位小数
  public static integer: string = '^[0-9]*[1-9][0-9]*$';   //只能正整数
  public static positive: string = '^[0-9]+\.?[0-9]{0,9}$';//只能正数
  public static chinese: string = '^[\u4e00-\u9fa5]+$';//汉字
  public static bankcard = '^([0-9]{16}|[0-9]{19})$';//银行卡正则
  public static website = '^(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&amp;:/~\\+#]*[\\w\\-\\@?^=%&amp;/~\\+#])?$';//网址正则
  public static EMAIL_REGEXP: RegExp = /^[-a-z0-9~!$%^&*_=+}{\'?]+(\.[-a-z0-9~!$%^&*_=+}{\'?]+)*@([a-z0-9_][-a-z0-9_]*(\.[-a-z0-9_]+)*\.(aero|arpa|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro|travel|mobi|[a-z][a-z])|([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}))(:[0-9]{1,5})?$/i;//邮箱
  public static PWD_REGEXP: RegExp = /^\S{6,16}$/;//密码
  public static SMS_REGEXP: RegExp = /^[0-9]{6}$/;//短信验证码
  public static PHONE_REGEXP: RegExp = /^1[0-9]{10}$/;//手机号
  public static IDCARD_REGEXP: RegExp = /^(^[1-9][0-9]{7}((0[0-9])|(1[0-2]))(([0|1|2][0-9])|3[0-1])[0-9]{3}$)|(^[1-9][0-9]{5}[1-9][0-9]{3}((0[0-9])|(1[0-2]))(([0|1|2][0-9])|3[0-1])(([0-9]{4})|[0-9]{3}[Xx])$)$/;//身份证号
  public static POSITIVE_REGEXP: RegExp = /^[0-9]+\.?[0-9]{0,9}$/;//只能正数


}
