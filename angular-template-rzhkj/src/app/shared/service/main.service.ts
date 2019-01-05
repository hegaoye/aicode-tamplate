import { SettingUrl } from '../setting/setting_url';
import { Setting } from '@shared/setting/setting';
import { HttpClient } from '@angular/common/http';
import { Observable, Observer } from 'rxjs';
import { Injectable } from '@angular/core';

@Injectable()
export class MainService {

  constructor(private http: HttpClient) {
  }

  /**
   * 根据类型标示获取枚举信息
   * @param code 类型标示（如：1001、1002、1003....）
   * @returns {any}
   */
  getEnumData(code) {
    let me = this;
    return new Observable((observer: Observer<any>) => {
      if (!Setting.enumData.hasOwnProperty(code)) {
        me.http
          .get(SettingUrl.URL.base.enum + code)
          .subscribe((res: any) => {
            res ? (observer.next(res), Setting.enumData[code] = res) : observer.next('');
            observer.complete();
          });
      } else {
        observer.next(Setting.enumData[code]);
        observer.complete();
      }
    });
  };

  /**
   * 根据类型标示获取枚举list信息
   * code 类型标示（如：1001、1002、1003....）
   * @param code
   * @returns {Array<any>}
   */
  getEnumDataList(code) {
    let list: Array<any> = new Array<any>(), me = this;
    return new Observable((observer: Observer<any>) => {
      me.getEnumData(code).subscribe((res: any) => {
        for (let prop in res) {
          if (res.hasOwnProperty(prop)) list.push({ 'value': prop, 'text': res[prop] });
        }
        observer.next(list);
        observer.complete();
      });
    });
  };

  /**
   * 根据类型标示和key获取信息值
   * @param code （如：1001、1002、1003....）
   * @param key （如：ILLNESSCASE、TYPELESS、NURSING....）
   * @returns {any}
   */
  getEnumDataValByKey(code, key) {
    let me = this;
    return new Observable((observer: Observer<any>) => {
      me.getEnumData(code).subscribe((res: any) => {
        (res && res[key]) ? observer.next(res[key]) : observer.next('');
        observer.complete();
      });
    });
  };

}
