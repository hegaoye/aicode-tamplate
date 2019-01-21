/*公共JS库*/
import {FormControl} from "@angular/forms";
import {Pattern} from "./pattern";
import {Setting} from "../setting/setting";
import {isNullOrUndefined} from "util";
import {Observable} from "rxjs";
import {AREA_LEVEL_3_JSON} from "../../../assets/data/area_level_3";

export class Util {
  public static enumData = {};

  /**
   * 格式化日期
   * @param date 日期对象
   * @param fmt  格式化形式
   * @returns {any}
   */
  public static dataFormat (date: Date, fmt) {
    let o = {
      "M+": date.getMonth() + 1, //月份
      "d+": date.getDate(), //日
      "H+": date.getHours(), //小时
      "m+": date.getMinutes(), //分
      "s+": date.getSeconds(), //秒
      "q+": Math.floor((date.getMonth() + 3) / 3), //季度
      "S": date.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (let k in o)
      if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
  };

  /**
   * 显示遮罩层（全局）
   */
  static showMask() {
    Setting.isSpinning = true;
  }

  /**
   * 隐藏遮罩层（全局）
   */
  static hideMask() {
    Setting.isSpinning = false;
  }

  /**
   * 转换区域数据格式，用于级联选择组件
   */
  public static transAreas(areas: Array<any>) {
    areas = areas.map(item => {
      if (item.value) return item;
      item.value = item.areaCode;
      item.label = item.areaName;
      if (item.children) this.transAreas(item.children); else item.isLeaf = true;
      return item;
    });
    return areas;
  }

  /**
   * 根据区域编码查询区域（3级）
   * @param code  12位区域编码
   * @returns {any}
   */
  public static getAreaByTwelveBitCode(code) {
    let areaList = AREA_LEVEL_3_JSON;
    let level = this.getLevelByCode(code);
    if (level == 1) {
      for (let levelOneItem of areaList) {
        if (levelOneItem.areaCode == code) {
          return levelOneItem;
        }
      }
    } else if (level == 2) {
      let parentCode = code.substring(0, 2) + '0000000000';//获取父级编码
      for (let area of areaList) {
        if (area.areaCode === parentCode) {
          for (let levelTwoItem of area.children) {
            if (levelTwoItem.areaCode == code) return levelTwoItem;
          }
        }
      }
    } else if (level == 3) {
      let parentsCode = code.substring(0, 2) + '0000000000';//获取祖父级编码
      let parentCode = code.substring(0, 4) + '00000000';//获取父级编码
      for (let area of areaList) {
        if (area.areaCode === parentsCode) {
          for (let levelTwoItem of area.children) {
            if (levelTwoItem.areaCode == parentCode) {
              for (let levelThreeItem of levelTwoItem.children) {
                if (levelThreeItem.areaCode == code) return levelThreeItem;
              }
            }
          }
        }
      }
    } else {
      return null
    }
  }

  /**
   * 12位的区域编码根据code查询级别
   * @param areaCode
   * @returns {number}
   */
  public static getLevelByCode(areaCode) {
    let level = 0;
    if (isNullOrUndefined(areaCode)) {
      return level;
    }
    areaCode = areaCode.toString();
    if (areaCode.length != 12) return level;
    if (areaCode.substr(2, 4) == '0000') level = 1;
    else if (areaCode.substr(4, 2) == '00') level = 2;
    else if (areaCode.substr(6, 6) == '000000') level = 3;
    else level = 4;
    return level;
  }

  /**
   * 通过区域编码找到区域选择器需要的三级区域数据
   * 参数：第三级区域编码
   */
  public static getAreaArrayByCode(levelThreeAreaCode: string) {
    let levelThreeArea: any = this.getAreaByTwelveBitCode(levelThreeAreaCode),//获取当前区域
      levelThreeAreaName: string = levelThreeArea.areaName,//获取当前区域名
      levelOneAreaCode: string = levelThreeArea.province, //当前区域的省级区域编码
      levelTwoAreaCode: string = levelThreeArea.city, //当前区域的市级区域编码
      levelOneAreaName: string = this.getAreaByTwelveBitCode(levelOneAreaCode).areaName,//当前区域的省级区域名
      levelTwoAreaName: string = this.getAreaByTwelveBitCode(levelTwoAreaCode).areaName,//当前区域的市级区域名
      _value = [
        {value: levelOneAreaCode, label: levelOneAreaName},
        {value: levelTwoAreaCode, label: levelTwoAreaName},
        {value: levelThreeAreaCode, label: levelThreeAreaName},
      ];//级联选择器默认值
    return _value;
  }

  /**
   * ************************************佐罗框架的表单验证方法**************************************
   * 请保证变量的状态参数与定义的validate中的字符串一致
   * eg:{error: true, phone: true}中phone等于Util.validate.isPhone;
   **/

  /*========================== 非FormGroup的表单验证 start ==============================
   * 非FormGroup下使用ngModel绑定模板变量的形式下使用
   */
  /**
   * 输入值状态信息判断
   * @param templateParam ：输入框ngModel模板变量
   * @returns 返回nzValidateStatus的几个状态，这里只给到'success' ,'error'
   *  <div nz-col [nzSpan]="10" nz-form-control nzHasFeedback [nzValidateStatus]="ngValidateStatus(ngPhone)">
   <input nz-input name="phone" [(ngModel)]="phone" required type=text placeholder="'企业名称'"
   #ngPhone="ngModel" pattern='^1[0-9]{10}$'>
   </div>
   */
  public static ngValidateStatus(templateParam) {
    return !templateParam.value && templateParam.pristine ? null ://未输入且没有值的状态不返回状态值
      templateParam.valid ? 'success' : 'error';//输入正确返回success，否则error
  }

  /**
   * 错误提示信息的提示状态
   * @param templateParam ：输入框ngModel模板变量
   * @returns 返回输入值的状态（输入正确:'success'，输入后清空:'empty',输入值不符合要求:'error',未输入：null）
   * 使用上面的输入模板：
   * eg1:<div nz-form-explain *ngIf="ngValidateErrorMsg(ngPhone) == Setting.valitateState.empty">请输入手机号！</div>
   * eg2:<div nz-form-explain *ngIf="ngValidateErrorMsg(ngPhone) == Setting.valitateState.error">请输入正确的手机号！</div>
   */
  public static ngValidateErrorMsg(templateParam) {
    return !templateParam.value && templateParam.pristine ? null ://未输入且没有值的状态不返回状态值
      templateParam.valid ? 'success' : //输入正确返回success
        templateParam.invalid && (isNullOrUndefined(templateParam.value) || templateParam.value == '') ? 'empty' :// 输入后如果不正确，判断是否是值为空，空则返回'empty'
          'error';
  }

  /*========================== 非FormGroup的表单验证 end ==============================*/

  /**
   以下方法会显示输入中状态，一定时间（eg:500ms）后不输入才会反馈校验结果;
   用法：this.validateForm = this.fb.group({
      phone ：[null, [ Validators.required ], [ Util.requiredPhoneValidator ]
    });//此种方式[ Validators.required ]是必要的

   * 必填的手机号异步校验
   * @param control
   * @returns {any}
   */
  public static requiredPhoneValidator = (control: FormControl): any => {
    return Util.asyncPatternsValidate(Pattern.PHONE_REGEXP, control, {error: true, phone: true});
  };

  /**
   * 短信验证码异步校验
   * @param control
   * @returns {any}
   */
  public static smsCodeValidator = (control: FormControl): any => {
    return Util.asyncPatternsValidate(Pattern.SMS_REGEXP, control, {error: true, smsCode: true});
  };

  /**
   * 身份证号校验
   * @param control
   * @returns {any}
   */
  public static idCardNumValidator = (control: FormControl): any => {
    return Util.asyncPatternsValidate(Pattern.IDCARD_REGEXP, control, {error: true, idCard: true});
  };

  /**
   * 有输入中状态的需要正则校验的异步校验方法封装，
   * 用法（Util.asyncPatternsValidate(Pattern.IDCARD_REGEXP, control, { error: true, idCard: true })
   * @param exp （需要匹配的正则表达式）
   * @param control （FormGroup的表单项）
   * @param obj （需要的返回对象，eg:{ error: true, idCard: true }）
   */
  public static asyncPatternsValidate = (exp: RegExp, control: FormControl, obj?: any) => {
    return Observable.create(function (observer) {
      setTimeout(() => {
        if (!exp.test(control.value)) {
          if (isNullOrUndefined(obj)) obj = {error: true};
          observer.next(obj);
        } else {
          observer.next(null);
        }
        observer.complete();
      }, 500);
    });
  }

  /**
   * 判断menu列表是否存在指定的路径信息，存在返回true，不存在返回false
   * @param {Array<any>} list 权限列表
   * @param {string} url 需要判断的路径url
   */
  public static haveJurisdiction(list: Array<any>, url: string) {
    let isTrue = false;
    list.forEach(item => {
      if (item.menuUrl == url) isTrue = true;
      else if (item.subMenuList && item.subMenuList.length > 0) {
        item.subMenuList.forEach(ret => {
          if (ret.menuUrl == url) isTrue = true;
        })
      }
    });
    return isTrue;
  }

  /**
   * 深度复制
   * 对象类型数据深度复制
   * 应用场景（对象类型数据有修改，需要进行前后数据对比）
   * @param o
   * @returns {any}
   */
  public static deepCopy = function (o: any) {
    if (o instanceof Array) {
      let n = [];
      for (let i = 0; i < o.length; ++i) {
        n[i] = this.deepCopy(o[i]);
      }
      return n;
    } else if (o instanceof Function) {
      let n = new Function("return " + o.toString())();
      return n;
    } else if (o instanceof Object) {
      let n = {};
      for (let i in o) {
        n[i] = this.deepCopy(o[i]);
      }
      return n;
    } else {
      return o;
    }
  }

  /**
   * 将中国标准时间转换成 yyyy/MM/dd 格式
   * @param timeGB
   */
  public static formateGBtime(timeGB) {
    let d = new Date(timeGB);
    return d.getFullYear() + '/' + (d.getMonth() + 1) + '/' + d.getDate();
  }
}
