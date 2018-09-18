import {NgModule} from "@angular/core";

import {AppComponent} from "./app.component";
import {TranslateHttpLoader} from "@ngx-translate/http-loader";
import {TranslateLoader, TranslateModule} from "@ngx-translate/core";
import {HttpClient, HttpClientModule} from "@angular/common/http";
import {SharedModule} from "./shared/shared.module";
import {RoutesModule} from "./routes/routes.module";
import {PublicModule} from "./public/public.module";
import {MainComponent} from "./layout/main/main.component";
import {BrowserModule} from "@angular/platform-browser";
import {BrowserAnimationsModule} from "@angular/platform-browser/animations";
import {FormsModule} from "@angular/forms";
import {en_US, NZ_I18N, zh_CN} from "ng-zorro-antd";
import {registerLocaleData} from "@angular/common";
import zh from "@angular/common/locales/zh";
import {PageComponent} from "./layout/page/page.component";
import {CookieService} from "angular2-cookie/core";
import {NgxEchartsModule} from "ngx-echarts";
registerLocaleData(zh);

export function HttpLoaderFactory(http: HttpClient) {
  return new TranslateHttpLoader(http, './assets/i18n/', '.json');
  // return new TranslateHttpLoader(http, '/frontendI18n/', '.shtml');//请求服务器的语言数据
}

@NgModule({
  declarations: [
    AppComponent,
    MainComponent,
    PageComponent
  ],
  imports: [
    RoutesModule,
    SharedModule.forRoot(),
    PublicModule,
    FormsModule,
    NgxEchartsModule,
    BrowserModule,                //浏览器模块
    BrowserAnimationsModule,    //浏览器动画模块
    HttpClientModule,             //网络请求模块
    TranslateModule.forRoot({
      loader: {
        provide: TranslateLoader,
        useFactory: (HttpLoaderFactory),
        deps: [HttpClient]
      }
    })
  ],
  providers: [
    CookieService,
    {provide: NZ_I18N, useValue: en_US},
    {provide: NZ_I18N, useValue: zh_CN},
  ],
  bootstrap: [AppComponent]
})
export class AppModule {
}
