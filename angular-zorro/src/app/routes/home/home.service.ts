import {Injectable} from '@angular/core';
import {SettingUrl} from "../../public/setting/setting_url.ts";
import {AjaxService} from "../../public/service/ajax.service";
import {NzNotificationService} from "ng-zorro-antd";

@Injectable({
  providedIn: 'root'
})
export class HomeService {

  constructor(private notification: NzNotificationService) {
  }


  /**
   * 加载首页统计信息
   * @returns {any<T>}
   */
  loadHomePageInfo() {
    let me = this;
    return new Promise(function (resolve, reject) {
      AjaxService.post({
        url: SettingUrl.URL.home.homePageInfo,
        success: (res) => {
          if (res.success) {
            resolve(res.data);
          } else {
            me.notification.error(`错误提示`, res.info);
          }
        },
        error: () => {
          me.notification.error(`错误提示`, '失败，请稍后重试')
        }
      });
    })
  }
}
