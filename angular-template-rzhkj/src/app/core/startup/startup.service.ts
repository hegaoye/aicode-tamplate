import { Injectable, Injector, Inject } from '@angular/core';
import { Router } from '@angular/router';
import { HttpClient } from '@angular/common/http';
import { zip } from 'rxjs';
import { catchError } from 'rxjs/operators';
import { MenuService, SettingsService, TitleService, ALAIN_I18N_TOKEN } from '@delon/theme';
import { DA_SERVICE_TOKEN, ITokenService } from '@delon/auth';
import { ACLService } from '@delon/acl';

import { NzIconService } from 'ng-zorro-antd';
import { ICONS_AUTO } from '../../../style-icons-auto';
import { ICONS } from '../../../style-icons';
import { SettingUrl } from '@shared/setting/setting_url';
import { Setting } from '@shared/setting/setting';

/**
 * 用于应用启动时
 * 一般用来获取应用所需要的基础数据等
 */
@Injectable()
export class StartupService {
  constructor(
    iconSrv: NzIconService,
    private menuService: MenuService,
    private settingService: SettingsService,
    private aclService: ACLService,
    private titleService: TitleService,
    @Inject(DA_SERVICE_TOKEN) private tokenService: ITokenService,
    private httpClient: HttpClient,
    private injector: Injector,
  ) {
    iconSrv.addIcon(...ICONS_AUTO, ...ICONS);
  }

  private viaHttp(resolve: any, reject: any) {
    zip(
      this.httpClient.get('assets/tmp/app-data.json'),
    ).pipe(
      // 接收其他拦截器后产生的异常消息
      catchError(([appData]) => {
        resolve(null);
        return [appData];
      }),
    ).subscribe(([appData]) => {

        // application data
        const res: any = appData;
        // 应用信息：包括站点名、描述、年份
        this.settingService.setApp(res.app);
        // 用户信息：包括姓名、头像、邮箱地址
        this.settingService.setUser(res.user);
        // ACL：设置权限为全量
        this.aclService.setFull(true);
        // 初始化菜单
        this.menuService.add(res.menu);
        // 设置页面标题的后缀
        this.titleService.suffix = res.app.name;
      },
      () => {
      },
      () => {
        resolve(null);
      });
  }

  //基础信息
  private baseInfo(resolve: any, reject: any) {
    const app: any = {
      name: Setting.APP.name,
      description: Setting.APP.description,
    };
    const user: any = {
      name: Setting.APP.simpleName,
      email: Setting.APP.contactInformation.email,
      avatar: './assets/tmp/img/avatar.jpg',
      token: '123456789',
    };
    // 应用信息：包括站点名、描述、年份
    this.settingService.setApp(app);
    // 用户信息：包括姓名、头像、邮箱地址
    this.settingService.setUser(user);
    // ACL：设置权限为全量
    this.aclService.setFull(true);
    // 初始化菜单
    this.menuService.add([
      {
        text: '导航栏',
        group: true,
        hideInBreadcrumb: true,
        children: Setting.MENUDATAS,
      },
    ]);
    // 设置页面标题的后缀
    this.titleService.suffix = app.name;
    resolve({});
  }

  //加载系统基础信息
  load(): Promise<any> {
    return new Promise((resolve, reject) => {
      this.baseInfo(resolve, reject);
    });
  }
}
