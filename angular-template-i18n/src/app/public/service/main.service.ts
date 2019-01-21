import {Util} from "../util/util";
import {AjaxService} from "./ajax.service";
import {SettingUrl} from "../setting/setting_url";
import {isNullOrUndefined} from "util";
import {AREA_LEVEL_3_JSON} from "../../../assets/data/area_level_3";
import {TranslateService} from "@ngx-translate/core";
import {Injectable} from "@angular/core";
import {en_US, NzI18nService, zh_CN} from "ng-zorro-antd";
import {Setting} from "../setting/setting";

@Injectable()
export class MainService {

  constructor(public translate: TranslateService,
              private ajaxService: AjaxService,
              private nzI18nService: NzI18nService) {
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
   * 国际化语言支持
   */
  public languageSupport() {
    //添加语言支持
    this.translate.addLangs(['zh_CN', 'en_US']);//这里语言名要与json文件名相同，记得在i18n里配置相应的中英文
    //获取获取上次修改语言存入本地的值，优先选用此值
    const lastLanguage = localStorage.getItem(Setting.storage.language);
    //设置默认语言，一般在无法匹配的时候使用
    const defaultLanguage = 'zh_CN';
    this.translate.setDefaultLang(defaultLanguage);

    //获取当前浏览器环境的语言比如en、 zh
    let broswerLang = this.translate.getBrowserCultureLang().replace('-', '_');
    let lang = lastLanguage ? lastLanguage : broswerLang.match(/en|zh/) ? broswerLang : defaultLanguage;
    console.log("█ lang ►►►", broswerLang.match(/en|zh/));
    this.translate.use(lang);//设置管理后台语言
    this.setZorroLanguage(lang);//设置Zorro框架语言
  }

  /**
   * 设置Zorro框架语言
   * @param lang
   */
  setZorroLanguage(lang) {
    switch (lang) {
      case 'en':
        this.nzI18nService.setLocale(en_US);
        break;
      case 'zh':
        this.nzI18nService.setLocale(zh_CN);
        break;
    }
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
