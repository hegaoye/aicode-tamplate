import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SimpleGuard } from '@delon/auth';
import { environment } from '@env/environment';
// layout
import { LayoutDefaultComponent } from '../layout/default/default.component';
import { LayoutFullScreenComponent } from '../layout/fullscreen/fullscreen.component';
import { LayoutPassportComponent } from '../layout/passport/passport.component';
// dashboard pages
import { DashboardComponent } from './dashboard/dashboard.component';
// passport pages
import { UserLoginComponent } from './passport/login/login.component';
import { UserRegisterComponent } from './passport/register/register.component';
import { UserRegisterResultComponent } from './passport/register-result/register-result.component';
// single pages
import { CallbackComponent } from './callback/callback.component';
import { UserLockComponent } from './passport/lock/lock.component';
import { Exception403Component } from './exception/403.component';
import { Exception404Component } from './exception/404.component';
import { Exception500Component } from './exception/500.component';
import { SettingUrl } from '@shared/setting/setting_url';

const routes: Routes = [
  {
    path: SettingUrl.ROUTERLINK.admin.admin,
    component: LayoutDefaultComponent,
    canActivate: [SimpleGuard],
    children: [
      { path: '', redirectTo: SettingUrl.ROUTERLINK.admin.dashboard, pathMatch: 'full' },
      {
        path: SettingUrl.ROUTERLINK.admin.dashboard,
        component: DashboardComponent,
        data: { title: '首页', titleI18n: SettingUrl.ROUTERLINK.admin.dashboard },
      },
      // 业务子模块
      <#list modelDatas as modelData>
        {path: SettingUrl.ROUTERLINK.admin.${modelData.model}Model.${modelData.model}Main, loadChildren: './${modelData.model}/${modelData.model}.module#${modelData.model?cap_first}Module'},
      </#list>
    ],
  },
  // 全屏布局
  // {
  //     path: 'fullscreen',
  //     component: LayoutFullScreenComponent,
  //     children: [
  //     ]
  // },
  // passport
  {
    path: SettingUrl.ROUTERLINK.passport.passport,
    component: LayoutPassportComponent,
    children: [
      { path: SettingUrl.ROUTERLINK.passport.login, component: UserLoginComponent, data: { title: '登录', titleI18n: 'pro-login' } },
      { path: SettingUrl.ROUTERLINK.passport.register, component: UserRegisterComponent, data: { title: '注册', titleI18n: 'pro-register' } },
      {
        path: SettingUrl.ROUTERLINK.passport.registerResult,
        component: UserRegisterResultComponent,
        data: { title: '注册结果', titleI18n: 'pro-register-result' },
      },
      { path: SettingUrl.ROUTERLINK.passport.lock, component: UserLockComponent, data: { title: '锁屏', titleI18n: 'lock' } }
    ],
  },
  // 单页不包裹Layout
  { path: SettingUrl.ROUTERLINK.page.callback, component: CallbackComponent },
  { path: SettingUrl.ROUTERLINK.page.p403, component: Exception403Component },
  { path: SettingUrl.ROUTERLINK.page.p404, component: Exception404Component },
  { path: SettingUrl.ROUTERLINK.page.p500, component: Exception500Component },
  { path: '**', redirectTo: SettingUrl.ROUTERLINK.admin.dashboardFull },
];

@NgModule({
  imports: [RouterModule.forRoot(routes, { useHash: environment.useHash })],
  exports: [RouterModule],
})
export class RouteRoutingModule {
}
