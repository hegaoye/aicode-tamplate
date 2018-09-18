import {Injectable} from '@angular/core';
import {NzMessageService, NzNotificationService} from "ng-zorro-antd";
import {AjaxService} from "../../public/service/ajax.service";
import {SettingUrl} from "../../public/setting/setting_url.ts";
import {HttpCodesEnum} from "../../public/setting/enums";

@Injectable({
  providedIn: 'root'
})
export class ${classNameLower?cap_first}Service {

  constructor(private notification: NzNotificationService, private message: NzMessageService) {
  }

  /**
   * 查询供应商列表
   * @param params {curPage:number,pageSize:number,name?:any)
   * @returns {any<T>}
   */
  get${classNameLower?cap_first}List(params) {
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
   * 查询供应商类型列表
   * @param params {curPage:number,pageSize:number,name?:any)
   * @returns {any<T>}
   */
  getSupplierCategoryList(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.get({
        url: SettingUrl.URL.supplierCategory.list,
        data: params,
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            resolve(res.data);
          } else {
            reject(res.info);
            me.notification.error(`error`, res.info);
          }
        },
        error: (res) => {
          reject(res.message);
          me.notification.error(`error`, res.message)
        }
      });
    })
  }

  /**
   * 查询供应商支付方式
   * @param params {curPage:number,pageSize:number,name?:any)
   * @returns {any<T>}
   */
  getPaymentList(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.get({
        url: SettingUrl.URL.payment.list,
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
  addSupplier(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.post({
        url: SettingUrl.URL.supplier.add,
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
   * 添加供应商类型
   * @param params {name:string, code?:string}
   * @returns {Promise<T>}
   */
  addSupplierCategory(params) {
    let me = this;
    return new Promise(function (resolve) {
      AjaxService.post({
        url: SettingUrl.URL.supplierCategory.add,
        data: params,
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            me.message.success(res.info);
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

  /**
   * 添加支付方式
   * @param params 表单数据
   * @returns {Promise<T>}
   */
  addPayment(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.post({
        url: SettingUrl.URL.payment.add,
        data: params,
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            me.message.success(res.info);
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

  /**
   * 修改供应商
   * @param params
   * @returns {Promise<T>}
   */
  modifySupplier(params) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.put({
        url: SettingUrl.URL.supplier.modify,
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
  modifySupplierState(code, state) {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.put({
        url: SettingUrl.URL.supplier.updateState,
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
   * 修改供应商类型
   * @param params {name:string, code?:string}
   * @returns {Promise<T>}
   */
  modifySupplierCategory(params) {
    let me = this;
    return new Promise(function (resolve) {
      AjaxService.put({
        url: SettingUrl.URL.supplierCategory.modify,
        data: params,
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            me.message.success(res.info);
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

  /**
   * 修改支付方式
   * @param params {name:string, code?:string}
   * @returns {Promise<T>}
   */
  modifyPayment(params) {
    let me = this;
    return new Promise(function (resolve) {
      AjaxService.put({
        url: SettingUrl.URL.payment.modify,
        data: params,
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            me.message.success(res.info);
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

  /**
   * 查询供应商详细信息
   * @param code 供应商编码
   * @returns {Promise<T>}
   */
  loadSupplierByCode(code) {
    let me = this;
    return new Promise(function (resolve) {
      AjaxService.get({
        url: SettingUrl.URL.supplier.load + code,
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

  /**
   * 查询供应商类型信息
   * @param code 供应商类型编码
   * @returns {Promise<T>}
   */
  loadSupplierCategoryByCode(code) {
    let me = this;
    return new Promise(function (resolve) {
      AjaxService.get({
        url: SettingUrl.URL.supplierCategory.load + code,
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
