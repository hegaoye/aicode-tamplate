import {NgModule} from "@angular/core";
import {HomeComponent} from "./home/home.component";
import {RouterModule, Routes} from "@angular/router";
import {SharedModule} from "../../shared/shared.module";
import {NgxEchartsModule} from "ngx-echarts";
import {NgZorroAntdModule} from "ng-zorro-antd";

const routes: Routes = [
  {path: '', component: HomeComponent},
]

@NgModule({
  imports: [
    NgxEchartsModule,
    SharedModule.forRoot(),
    RouterModule.forChild(routes)
  ],
  declarations: [HomeComponent]
})
export class HomeModule { }
