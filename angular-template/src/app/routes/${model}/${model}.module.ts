import {NgModule} from "@angular/core";
import {RouterModule, Routes} from "@angular/router";
import {SharedModule} from "../../shared/shared.module";

<#list modelClasses as class>
import {${class.className}ListComponent} from "./${class.className?uncap_first}-list/${class.className?uncap_first}-list.component";
import {${class.className}DetailComponent} from "./${class.className?uncap_first}-detail/${class.className?uncap_first}-detail.component";
import {${class.className}EditComponent} from "./${class.className?uncap_first}-edit/${class.className?uncap_first}-edit.component";
</#list>

const routes: Routes = [
  <#if modelClasses?size gt 1>
  {path: '', redirectTo: ' ${classNameLower}'},
  </#if>

  <#list modelClasses as class>
    <#if modelClasses?size gt 1>{
      path: '${class.className?uncap_first}', children: [
    </#if>
        {path: '', redirectTo: 'list'},
        {path: 'list', component: ${class.className}ListComponent},
        {path: 'add', component: ${class.className}EditComponent},
        {path: 'modify/:code', component: ${class.className}EditComponent},
        {path: 'detail/:code', component: ${class.className}DetailComponent}
      <#if modelClasses?size gt 1>
        ]
      }<#if class_has_next>,</#if>
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
