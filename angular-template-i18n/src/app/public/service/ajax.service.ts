import {Injectable} from "@angular/core";

import * as $ from "jquery";
import {RequestFilterService} from "./request-filter.service";

@Injectable()
export class AjaxService {
  constructor(private requestFilterService: RequestFilterService) {
  }

  /**
   * mask: false,//是否需要显示遮罩层
   * auth: false,//是否需要权限验证
   * shtml: false,//是否需要添加.shtml后缀
   * @param config
   */
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
    config = this.requestFilterService.requestConfigFilter(config);
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
