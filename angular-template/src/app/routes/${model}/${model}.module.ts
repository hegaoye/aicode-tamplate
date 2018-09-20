import {NgModule} from "@angular/core";
import {${className}ListComponent} from "./${classNameLower}-list/${classNameLower}-list.component";
import {RouterModule, Routes} from "@angular/router";
import {SharedModule} from "../../shared/shared.module";
import {${className}DetailComponent} from "./${classNameLower}-detail/${classNameLower}-detail.component";
import {${className}EditComponent} from "./${classNameLower}-edit/${classNameLower}-edit.component";

const routes: Routes = [
  {path: '', redirectTo: 'list'},
  <#list classes as class>
    {
      path: '${class.classModel}', children: [
        {path: '', redirectTo: 'list'},
        {path: 'list', component: ${class.className}ListComponent},
        {path: 'add', component: ${class.className}EditComponent},
        {path: 'modify/:code', component: ${class.className}EditComponent},
        {path: 'detail/:code', component: ${class.className}DetailComponent}
      ]
    }<#if class_has_next>,</#if>
  </#list>
]

@NgModule({
  imports: [
    SharedModule.forRoot(),
    RouterModule.forChild(routes)
  ],
  declarations: [
    ${className}ListComponent,
    ${className}DetailComponent,
    ${className}EditComponent],
  providers: []
})
export class ${model?cap_first}Module {
}
