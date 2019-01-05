import { Injectable } from '@angular/core';
import { SettingUrl } from '@shared/setting/setting_url';
import { Observable, Observer } from 'rxjs';
import { Setting } from '@shared/setting/setting';
import { _HttpClient } from '@delon/theme';
import { catchError } from 'rxjs/operators';
import { HttpErrorResponse } from '@angular/common/http';

@Injectable({
  providedIn: 'root',
})
export class ${model?cap_first}Service {

  constructor(private http: _HttpClient) {
  }

<#list modelClasses as modelClass>
  /**
   * 查询${modelClass.className}列表
   * @param params {curPage:number,pageSize:number,name?:any)
   * @returns {any<T>}
   */
  get${modelClass.className}List(params) {
    let me = this;
    return new Observable((observer: Observer<any>) => {
      me.http
        .get(SettingUrl.URL.${modelClass.className?uncap_first}.list, params)
        .pipe(catchError((err: HttpErrorResponse) => Setting.RETURNINFO))
        .subscribe((res: any) => {
          observer.next(res);
          observer.complete();
        });
    });
  }
</#list>
}
