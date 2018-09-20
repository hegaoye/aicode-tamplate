/**
 * Created by Administrator on 2018/9/4 0004.
 */
import {MainComponent} from "../layout/main/main.component";
import {PageComponent} from "../layout/page/page.component";
import {SettingUrl} from "../public/setting/setting_url";
import {Routes} from "@angular/router";

export const routes:Routes = [
  {
    path: 'main',
    component: MainComponent,
    children: [
      {path: 'home', loadChildren: './home/home.module#HomeModule'}, //首页
      <#list modelDatas as modelData>
      {path: '${modelData.model}', loadChildren: './${modelData.model}/${modelData.model}.module#${modelData.model?cap_first}Module'}, //供应商
      </#list>
    ]
  },
  {
    path: 'page',
    component: PageComponent,
    children: [
      {path: '', loadChildren: './pages/pages.module#PagesModule'},
    ]
  },
  // 路由指向找不到时，指向这里
  {path: '**', redirectTo: SettingUrl.ROUTERLINK.basic.home}
];
