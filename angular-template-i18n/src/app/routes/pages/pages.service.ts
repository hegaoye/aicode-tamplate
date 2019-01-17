import {Injectable} from '@angular/core';
import {AjaxService} from "../../public/service/ajax.service";
import {SettingUrl} from "../../public/setting/setting_url";
import {HttpCodesEnum} from "../../public/setting/enums";
import {NzMessageService, NzNotificationService} from "ng-zorro-antd";

@Injectable({
  providedIn: 'root'
})
export class PagesService {

  constructor(private notification: NzNotificationService,
              private ajaxService: AjaxService,
              private message: NzMessageService) {
  }

  /**
   * 登录
   * @param params
   */
  login(params) {
    let me = this;
    return new Promise(function (resolve) {
      me.ajaxService.post({
        url: SettingUrl.URL.supplier.add,
        data: params,
        success: (res) => {
          if (res.success && res.code === HttpCodesEnum.Success) {
            me.message.success(res.info);
            resolve(true);
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
