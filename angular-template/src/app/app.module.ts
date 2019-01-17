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
import {PageComponent} from "./layout/page/page.component";
import {NgxEchartsModule} from "ngx-echarts";

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
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule {
}
