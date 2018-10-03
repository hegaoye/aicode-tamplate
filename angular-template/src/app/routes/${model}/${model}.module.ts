import {NgModule} from "@angular/core";
import {RouterModule, Routes} from "@angular/router";
import {SharedModule} from "../../shared/shared.module";

<#list modelClasses as class>
import {${class.className}ListComponent} from "./${class.dashedCaseName}-list/${class.dashedCaseName}-list.component";
import {${class.className}DetailComponent} from "./${class.dashedCaseName}-detail/${class.dashedCaseName}-detail.component";
import {${class.className}EditComponent} from "./${class.dashedCaseName}-edit/${class.dashedCaseName}-edit.component";
</#list>

const routes: Routes = [
  <#list modelClasses as class>
    <#if modelClasses?size gt 1>
    <#if modelClasses?size == 1>{path: '', redirectTo: ' ${class.dashedCaseName}'},</#if>
    {path: '${class.dashedCaseName}', children: [
    </#if>
        {path: '', redirectTo: 'list'},
        {path: 'list', component: ${class.className}ListComponent},
        {path: 'add', component: ${class.className}EditComponent},
        {path: 'modify/:code', component: ${class.className}EditComponent},
        {path: 'detail/:code', component: ${class.className}DetailComponent}
    <#if modelClasses?size gt 1>
    ]}<#if class_has_next>,</#if>
    </#if>
  </#list>
]

@NgModule({
  imports: [
    SharedModule.forRoot(),
    RouterModule.forChild(routes)
  ],
  declarations: [
    <#list modelClasses as class>
    ${class.className}ListComponent,
    ${class.className}DetailComponent,
    ${class.className}EditComponent<#if class_has_next>,</#if>
    </#list>
  ],
  providers: []
})
export class ${model?cap_first}Module {
}
