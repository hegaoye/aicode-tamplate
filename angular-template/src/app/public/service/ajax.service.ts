import {Injectable} from "@angular/core";
import {Util} from "../util/util";

import * as $ from "jquery";

@Injectable()
export class AjaxService {
  constructor() {
  }

  //get方式提交，一般用于查询
  public get(config) {
    if (!config) {
      console.log('ajax调用参数不能为空');
      return;
    }
    config.method = 'get';  //设定提交方式为get
    this.post(config);   //执行ajax
  };

  //post方式提交，一般用于新增对象
  public post(config) {
    if (!config) {
      console.log('ajax调用参数不能为空');
      return;
    }
    config.url += ".shtml"; //为所有请求带上后缀
    let async = true, method = 'post', dataType = 'json';
    if (!config.hasOwnProperty('async')) config.async = async;
    if (!config.method) config.method = method;
    if (!config.dataType) config.dataType = dataType;


    //提交前显示遮罩层
    config.beforeSend = function (xhr) {
      if (config.mask === true) Util.showMask();//显示遮罩层
    };

    //设置全局ajax登录拦截
    let success = config.success;
    config.success = function (result, status, xhr) {
      if (config.mask === true) Util.hideMask();//隐藏遮罩层
      //过滤登录，登陆过期或没有登陆
      if (xhr.getResponseHeader("serverError") || xhr.getResponseHeader("serverError") === "sessionOut") {
        // window.location.href = SettingUrl.ROUTERLINK.pass.login; //去往登录页面
      } else {
        if (typeof success === "function") success(result, status, xhr);
      }
    };
    let error = config.error;
    config.error = function (result, status, xhr) {
      if (config.mask === true) Util.hideMask(); //隐藏遮罩层
      //回调
      if (typeof error === 'function') error(result, status, xhr);
    };
    $.ajax(config);
  };

  //put方式提交，一般用于更新，会返回更新的所有信息
  public put(config) {
    if (!config) {
      console.log('ajax调用参数不能为空');
      return;
    }
    if (!config.data) {
      console.log('更新数据不能为空');
    }
    config.data._method = "put";
    this.post(config);   //执行ajax
  };

  //delete方式提交，用于删除
  public del(config) {
    if (!config) {
      console.log("ajax调用参数不能为空");
      return;
    }
    config.data._method = "delete";
    this.post(config);   //执行ajax
  };

  //patch方式提交，一般用于更新，会返回更新的部分信息
  public patch(config) {
    if (!config) {
      console.log("ajax调用参数不能为空");
      return;
    }
    config.data._method = "patch";
    this.post(config);   //执行ajax
  };
}
