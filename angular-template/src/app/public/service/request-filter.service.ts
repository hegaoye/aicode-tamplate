import {Injectable} from '@angular/core';
import {Setting} from "../setting/setting";
import {Util} from "../util/util";
import {SettingUrl} from "../setting/setting_url";
import {HttpCodesEnum} from "../util/enums";
import {Router} from "@angular/router";
import {NzNotificationService} from "ng-zorro-antd";

@Injectable({
  providedIn: 'root'
})
export class RequestFilterService {

  constructor(private notification: NzNotificationService, private router: Router) {
  }

  /**
   * 过滤请求参数
   * @param config
   * mask: false,//是否需要显示遮罩层
   * auth: false,//是否需要权限验证
   * suffix: string = '.shtml',//是否需要添加.shtml后缀
   */
  requestConfigFilter(config) {
    const me = this;
    if (!config.hasOwnProperty('suffix')) {
      // if (config.url.indexOf('***') === 0) config.url += '.do'; //特定类型接口，统一为请求URL添加指定(eg. .do)后缀
      // else
        config.url += ".shtml"; //如果没有指定suffix参数，则会为请求URL添加.shtml后缀
    } else {
      config.url += config.suffix
    }
    let async = true, method = 'post', dataType = 'json', timeout = 10000;
    if (!config.hasOwnProperty('async')) config.async = async;
    if (!config.method) config.method = method;
    if (!config.dataType) config.dataType = dataType;
    // if (!config.timeout) config.timeout = timeout;
    let token = localStorage.getItem(Setting.storage.authorizationToken);
    // 当没有单独指定headers，并且auth参数不为空且不为false，并且token存在，给请求加headers
    if (!config.headers && !(config.hasOwnProperty('auth') && !config.auth) && token) {
      config.headers = {'Authorization': token};
    }//给请求头加token


    //提交前显示遮罩层
    config.beforeSend = function (xhr) {
      if (config.mask === true) Util.showMask();//显示遮罩层
    };

    //设置全局ajax登录拦截
    let success = config.success;
    config.success = function (result, status, xhr) {
      if (config.mask === true) Util.hideMask();//隐藏遮罩层
      //每次请求成功都更新本地缓存的token
      if (xhr.getResponseHeader("authorization")) {
        localStorage.setItem(Setting.storage.authorizationToken, xhr.getResponseHeader("authorization"));
      }
      result = me.responseFilter(result);//处理返回信息
      if (typeof success === "function") success(result, status, xhr);
    };

    let error = config.error;
    config.error = function (result, status, xhr) {
      if (config.mask === true) Util.hideMask(); //隐藏遮罩层
      //回调
      result = me.responseFilter(result);//处理返回信息
      if (typeof error === 'function') error(result, status, xhr);
    };
    return config;
  }

  /**
   * 请求结果处理
   */
  responseFilter(result) {
    if (!result.code) return result;
    if (result.code == HttpCodesEnum.logout) {//如果token过期
      localStorage.removeItem(Setting.storage.authorizationToken);//移除token，跳转到登录页
      this.router.navigate([SettingUrl.ROUTERLINK.pass.login], {replaceUrl: true})
    }
    return result;
  }
}
