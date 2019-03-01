import {NgModule} from "@angular/core";
import {RouterModule, Routes} from "@angular/router";
import {SharedModule} from "../../shared/shared.module";

<#list modelClasses as class>
import {${class.className}ListComponent} from "./${class.dashedCaseName}-list/${class.dashedCaseName}-list.component";
import {${class.className}DetailComponent} from "./${class.dashedCaseName}-detail/${class.dashedCaseName}-detail.component";
import {${class.className}AddComponent} from "./${class.dashedCaseName}-edit/${class.dashedCaseName}-add.component";
import {${class.className}ModifyComponent} from "./${class.dashedCaseName}-edit/${class.dashedCaseName}-modify.component";
</#list>

const routes: Routes = [
  <#list modelClasses as class>
    <#if modelClasses?size == 1>
      {path: '', component: ${class.className}ListComponent},
    </#if>
    <#if modelClasses?size gt 1>
    <#if class_index == 0>{path: '', redirectTo: ' ${class.dashedCaseName}'},</#if>
    {path: '${class.dashedCaseName}', component: ${class.className}ListComponent, children: [
    </#if>
        {path: 'add', component: ${class.className}AddComponent},
        {path: 'modify/:code', component: ${class.className}ModifyComponent},
        {path: 'detail/:code', component: ${class.className}DetailComponent}
    <#if modelClasses?size gt 1>
    ]}<#if class_has_next>,</#if>
    </#if>
  </#list>
];

@NgModule({
  imports: [
    SharedModule.forRoot(),
    RouterModule.forChild(routes)
  ],
  declarations: [
    <#list modelClasses as class>
    ${class.className}ListComponent,
    ${class.className}DetailComponent,
    ${class.className}AddComponent,
    ${class.className}ModifyComponent<#if class_has_next>,</#if>
    </#list>
  ],
  providers: []
})
export class ${model?cap_first}Module {
}
