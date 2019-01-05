import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { SettingUrl } from '@shared/setting/setting_url';

<#list modelClasses as class>
import {${class.className}ListComponent} from "./${class.dashedCaseName}-list/${class.dashedCaseName}-list.component";
</#list>

const routes: Routes = [
  <#list modelClasses as class>
    <#if modelClasses?size gt 1>
      <#if class_index == 0>{ path: '', redirectTo: SettingUrl.ROUTERLINK.admin.${model}.${class.className?uncap_first}},</#if>
      {
        path: SettingUrl.ROUTERLINK.admin.${model}.${class.className?uncap_first}}, children: [
    </#if>
          { path: '', redirectTo: SettingUrl.ROUTERLINK.admin.${model}.${class.className?uncap_first}List },
          { path: SettingUrl.ROUTERLINK.admin.${model}.${class.className?uncap_first}List, component: ${class.className}ListComponent },
    <#if modelClasses?size gt 1>
        ]
      }<#if class_has_next>,</#if>
    </#if>
  </#list>

];

@NgModule({
  imports: [RouterModule.forChild(routes)],
  exports: [RouterModule],
})
export class ${model?cap_first}RoutingModule {
}
