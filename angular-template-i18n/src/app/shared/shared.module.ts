import {ModuleWithProviders, NgModule} from "@angular/core";
import {CommonModule} from "@angular/common";
import {FormsModule, ReactiveFormsModule} from "@angular/forms";
import {RouterModule} from "@angular/router";
import {TranslateModule} from "@ngx-translate/core";
import {NgZorroAntdModule} from "ng-zorro-antd";
import {ImgSizePipe} from "./pipes/img-size.pipe";
import {EnumNamePipe} from "./pipes/enum-name.pipe";
import {ImgPreviewPipe} from "./pipes/img-preview.pipe";
import {BackBtnComponent} from "./compontents/back-btn.component";

@NgModule({
  imports: [
    CommonModule,                 //核心模块，必须
    FormsModule,                  //表单支持
    RouterModule,           //路由依赖模块
    TranslateModule,           //国际化
    ReactiveFormsModule,         //表单支持
    NgZorroAntdModule,            //zorro
  ],
  declarations: [
    BackBtnComponent,         //返回按钮
    ImgSizePipe,              //图片尺寸
    ImgPreviewPipe,           //图片预览
    EnumNamePipe,
  ],
  exports: [
    CommonModule,           //核心模块，必须
    RouterModule,           //路由依赖模块
    FormsModule,            //表单支持
    ReactiveFormsModule,    //表单支持
    TranslateModule,            //国际化
    NgZorroAntdModule,            //zorro
    ImgSizePipe,              //图片尺寸
    ImgPreviewPipe,           //图片预览
    EnumNamePipe,
    BackBtnComponent,         //返回按钮
  ]
})
export class SharedModule {
  static forRoot(): ModuleWithProviders {
    return {
      ngModule: SharedModule
    };
  }
}
