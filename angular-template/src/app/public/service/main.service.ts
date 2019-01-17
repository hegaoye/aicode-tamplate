import {Util} from "../util/util";
import {AjaxService} from "./ajax.service";
import {SettingUrl} from "../setting/setting_url";
import {isNullOrUndefined} from "util";
import {AREA_LEVEL_3_JSON} from "../util/area_level_3";
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
    let list: Array<any> = new Array<any>();
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
            ;
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
    let levelThreeArea: any = MainService.getAreaByTwelveBitCode(levelThreeAreaCode),//获取当前区域
      levelThreeAreaName: string = levelThreeArea.areaName,//获取当前区域名
      levelOneAreaCode: string = levelThreeArea.province, //当前区域的省级区域编码
      levelTwoAreaCode: string = levelThreeArea.city, //当前区域的市级区域编码
      levelOneAreaName: string = MainService.getAreaByTwelveBitCode(levelOneAreaCode).areaName,//当前区域的省级区域名
      levelTwoAreaName: string = MainService.getAreaByTwelveBitCode(levelTwoAreaCode).areaName,//当前区域的市级区域名
      _value = [
        {value: levelOneAreaCode, label: levelOneAreaName},
        {value: levelTwoAreaCode, label: levelTwoAreaName},
        {value: levelThreeAreaCode, label: levelThreeAreaName},
      ];//级联选择器默认值
    return _value;
  }
}
