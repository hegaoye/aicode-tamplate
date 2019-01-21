import {NgModule, Optional, SkipSelf} from "@angular/core";
import {CommonModule} from "@angular/common";
import {throwIfAlreadyLoaded} from "./module-import-guard";

@NgModule({
  imports: [
    CommonModule
  ],
  declarations: [],
  providers: []
})
export class PublicModule {
  constructor(@Optional() @SkipSelf() parentModule: PublicModule) {
    throwIfAlreadyLoaded(parentModule, 'PublicModule');
  }
}
