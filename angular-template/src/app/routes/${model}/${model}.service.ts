import {Injectable} from '@angular/core';
import {NzMessageService, NzNotificationService} from "ng-zorro-antd";
import {AjaxService} from "../../public/service/ajax.service";
import {SettingUrl} from "../../public/setting/setting_url";
import {HttpCodesEnum} from "../../public/setting/enums";

@Injectable({
  providedIn: 'root'
})
export class ${model?cap_first}Service {

  constructor(private notification: NzNotificationService, private message: NzMessageService) {
  }

<#list modelClasses as class>
  /**
   * 查询${class.className}列表
   * @param params {curPage:number,pageSize:number,name?:any)
   * @returns {any<T>}
   */
  get${class.className}List(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.get({
        url: SettingUrl.URL.${class.className?upcap_first}.list,
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
   * 添加${class.className}
   * @param params
   * @returns {Promise<T>}
   */
  add${class.className}(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.post({
        url: SettingUrl.URL.${class.className?uncap_first}.add,
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
   * 修改${class.className}
   * @param params
   * @returns {Promise<T>}
   */
  modify${class.className}(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.put({
        url: SettingUrl.URL.${class.className?uncap_first}.modify,
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
   * 修改${class.className}状态
   * @param code 供应商编码
   * @param state 供应商状态
   * @returns {Promise<T>}
   */
  modify${class.className}State(code, state) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.put({
        url: SettingUrl.URL.${class.className?uncap_first}.updateState,
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
   * 查询${class.className}详细信息
   * @param code ${class.className}编码
   * @returns {Promise<T>}
   */
  load${class.className}ByCode(code) {
    let me = this;
    return new Promise(function (resolve) {
      AjaxService.get({
        url: SettingUrl.URL.${class.className?uncap_first}.load + code,
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

</#list>
}
