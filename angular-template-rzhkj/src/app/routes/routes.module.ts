import {NgModule} from "@angular/core";
import {SharedModule} from "../shared/shared.module";
import {RouterModule} from "@angular/router";
import {routes} from "./routes";

@NgModule({
  imports: [
    SharedModule,
    RouterModule.forRoot(routes,{useHash: true})
  ],
  declarations: []
})
export class RoutesModule { }
