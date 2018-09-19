import {NgModule} from "@angular/core";
import {${className}ListComponent} from "./${classNameLower}-list/${classNameLower}-list.component";
import {RouterModule, Routes} from "@angular/router";
import {SharedModule} from "../../shared/shared.module";
import {${className}DetailComponent} from "./${classNameLower}-detail/${classNameLower}-detail.component";
import {${className}EditComponent} from "./${classNameLower}-edit/${classNameLower}-edit.component";
import {${className}InfoComponent} from "./${classNameLower}-info/${classNameLower}-info.component";

const routes: Routes = [
  {path: '', redirectTo: 'list'},
  {path: 'list', component: ${className}ListComponent},
  {path: 'add', component: ${className}EditComponent},
  {path: 'modify/:code', component: ${className}EditComponent},
  {path: 'detail/:code', component: ${className}DetailComponent},
]

@NgModule({
  imports: [
    SharedModule.forRoot(),
    RouterModule.forChild(routes)
  ],
  declarations: [
    ${className}ListComponent,
    ${className}DetailComponent,
    ${className}EditComponent,
    ${className}InfoComponent],
  providers: []
})
export class ${className}Module {
}
