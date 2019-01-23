import {Util} from "../util/util";
import {AjaxService} from "./ajax.service";
import {SettingUrl} from "../setting/setting_url";
import {isNullOrUndefined} from "util";
import {Injectable} from "@angular/core";

@Injectable()
export class MainService {

  constructor(private ajaxService: AjaxService) {
  }

  /**
   * 根据类型标示获取枚举信息
   * @param code 类型标示（如：1001、1002、1003....）
   * @returns {any}
   */
  public getEnumData (code) {
    if (!Util.enumData.hasOwnProperty(code)) {
      this.ajaxService.get({
        async: false,
        url: SettingUrl.URL.base.enum + code,
        suffix: '',
        success: function (result) {
          if (isNullOrUndefined(result)) return ''; else Util.enumData[code] = result;
        }
      });
    }
    return Util.enumData[code];
  }

  /**
   * 根据类型标示获取枚举list信息
   * code 类型标示（如：1001、1002、1003....）
   * @param code
   * @returns {Array<any>}
   */
  public getEnumDataList (code) {
    let list: Array<any> = [];
    let enumInfo = this.getEnumData(code);
    for (let prop in enumInfo) {
      if (enumInfo.hasOwnProperty(prop)) {
        list.push({'key': prop, 'val': enumInfo[prop]});
      }
    }
    return list;
  }

  /**
   * 根据类型标示和key获取信息值
   * @param code （如：1001、1002、1003....）
   * @param key （如：ILLNESSCASE、TYPELESS、NURSING....）
   * @returns {any}
   */
  public getEnumDataValByKey (code, key) {
    let enumData = this.getEnumData(code);
    if (enumData != null && enumData !== '' && enumData !== undefined) {
      if (enumData[key] != null && enumData[key] !== '' && enumData[key] !== undefined) {
        return enumData[key];
      } else {
        return '';
      }
    } else {
      return '';
    }
  };
}
