import {NgModule, Optional, SkipSelf} from "@angular/core";
import {CommonModule} from "@angular/common";
import {throwIfAlreadyLoaded} from "./module-import-guard";
import {AjaxService} from "./service/ajax.service";
import {PatternService} from "./service/pattern.service";
import {Page} from "./util/page";
import {Setting} from "./setting/setting";
import {MainService} from "./service/main.service";

@NgModule({
  imports: [
    CommonModule
  ],
  declarations: [],
  providers: [
    AjaxService,          //ajax服务
    MainService,          //MainService
    PatternService,       //正则
    Page,                 //分页信息
    Setting,               //基本属性配置
  ]
})
export class PublicModule {
  constructor(@Optional() @SkipSelf() parentModule: PublicModule) {
    throwIfAlreadyLoaded(parentModule, 'PublicModule');
  }
}
