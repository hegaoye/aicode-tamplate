import {Injectable} from '@angular/core';
import {NzMessageService, NzNotificationService} from "ng-zorro-antd";
import {AjaxService} from "../../public/service/ajax.service";
import {SettingUrl} from "../../public/setting/setting_url";
import {HttpCodesEnum} from "../../public/setting/enums";

@Injectable({
  providedIn: 'root'
})
export class ${className}Service {

  constructor(private notification: NzNotificationService, private message: NzMessageService) {
  }


  /**
   * 查询供应商列表
   * @param params {curPage:number,pageSize:number,name?:any)
   * @returns {any<T>}
   */
  get${className}List(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.get({
        url: SettingUrl.URL.${classNameLower}.list,
        data: params,
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            resolve(res.data);
          } else {
            reject(false);
            me.notification.error(`error`, res.info);
          }
        },
        error: (res) => {
          reject(false);
          me.notification.error(`error`, res.message)
        }
      });
    })
  }

  /**
   * 添加供应商
   * @param params
   * @returns {Promise<T>}
   */
  add${className}(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.post({
        url: SettingUrl.URL.${classNameLower}.add,
        data: params,
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            me.message.success(res.info);
            resolve(true);
          } else {
            reject(false);
            me.notification.error(`error`, res.info);
          }
        },
        error: (res) => {
          reject(false);
          me.notification.error(`error`, res.message)
        }
      });
    })
  }

  /**
   * 修改供应商
   * @param params
   * @returns {Promise<T>}
   */
  modify${className}(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.put({
        url: SettingUrl.URL.${classNameLower}.modify,
        data: params,
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            me.message.success(res.info);
            resolve(res.data);
          } else {
            reject(false);
            me.notification.error(`error`, res.info);
          }
        },
        error: (res) => {
          reject(false);
          me.notification.error(`error`, res.message)
        }
      });
    })
  }

  /**
   * 修改供应商状态
   * @param code 供应商编码
   * @param state 供应商状态
   * @returns {Promise<T>}
   */
  modify${className}State(code, state) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.put({
        url: SettingUrl.URL.${classNameLower}.updateState,
        data: {
          code: code,
          state: state
        },
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            me.message.success(res.info);
          } else {
            reject(false);
            me.notification.error(`error`, res.info);
          }
        },
        error: (res) => {
          reject(false);
          me.notification.error(`error`, res.message)
        }
      });
    })
  }

  /**
   * 查询供应商详细信息
   * @param code 供应商编码
   * @returns {Promise<T>}
   */
  load${className}ByCode(code) {
    let me = this;
    return new Promise(function (resolve) {
      AjaxService.get({
        url: SettingUrl.URL.${classNameLower}.load + code,
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            resolve(res.data);
          } else {
            me.notification.error(`error`, res.info);
          }
        },
        error: (res) => {
          me.notification.error(`error`, res.message)
        }
      });
    })
  }
}
