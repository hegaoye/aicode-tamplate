import {Injectable} from '@angular/core';
import {NzMessageService, NzNotificationService} from "ng-zorro-antd";
import {AjaxService} from "../../public/service/ajax.service";
import {SettingUrl} from "../../public/setting/setting_url";
import {HttpCodesEnum} from "../../public/setting/enums";

@Injectable({
  providedIn: 'root'
})
export class ${model?cap_first}Service {

  constructor(private notification: NzNotificationService,
              private ajaxService: AjaxService,
              private message: NzMessageService) {
  }

<#list modelClasses as modelClass>
  /**
   * 查询${modelClass.className}列表
   * @param params {curPage:number,pageSize:number,name?:any)
   * @returns {any<T>}
   */
  get${modelClass.className}List(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      me.ajaxService.get({
        url: SettingUrl.URL.${modelClass.className?uncap_first}.list,
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
   * 添加${modelClass.className}
   * @param params
   * @returns {Promise<T>}
   */
  add${modelClass.className}(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      me.ajaxService.post({
        url: SettingUrl.URL.${modelClass.className?uncap_first}.add,
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
   * 修改${modelClass.className}
   * @param params
   * @returns {Promise<T>}
   */
  modify${modelClass.className}(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      me.ajaxService.put({
        url: SettingUrl.URL.${modelClass.className?uncap_first}.modify,
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
   * 修改${modelClass.className}状态
   * @param code 供应商编码
   * @param state 供应商状态
   * @returns {Promise<T>}
   */
  modify${modelClass.className}State(code, state) {
    let me = this;
    return new Promise(function (resolve, reject) {
      me.ajaxService.put({
        url: SettingUrl.URL.${modelClass.className?uncap_first}.updateState,
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
   * 查询${modelClass.className}详细信息
   * @param code ${modelClass.className}编码
   * @returns {Promise<T>}
   */
  load${modelClass.className}ByCode(code) {
    let me = this;
    return new Promise(function (resolve) {
      me.ajaxService.get({
        url: SettingUrl.URL.${modelClass.className?uncap_first}.load,
        data: {
          id: code
        },
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
