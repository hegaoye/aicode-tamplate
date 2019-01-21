import {NgModule, Optional, SkipSelf} from "@angular/core";
import {CommonModule} from "@angular/common";
import {throwIfAlreadyLoaded} from "./module-import-guard";
import {AjaxService} from "./service/ajax.service";
import {MainService} from "./service/main.service";

@NgModule({
  imports: [
    CommonModule
  ],
  declarations: [],
  providers: [
    AjaxService,          //ajax服务
    MainService          //MainService
  ]
})
export class PublicModule {
  constructor(@Optional() @SkipSelf() parentModule: PublicModule) {
    throwIfAlreadyLoaded(parentModule, 'PublicModule');
  }
}
