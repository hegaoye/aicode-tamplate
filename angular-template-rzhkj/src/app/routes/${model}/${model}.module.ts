import { NgModule } from '@angular/core';
import { SharedModule } from '@shared/shared.module';
import { ${model?cap_first}RoutingModule } from './${model}-routing.module';
import { ${model?cap_first}Service } from './${model}.service';

<#list modelClasses as class>
import {${class.className}ListComponent} from "./${class.dashedCaseName}-list/${class.dashedCaseName}-list.component";
</#list>

@NgModule({
  imports: [
    SharedModule,
    ${model?cap_first}RoutingModule
  ],
  declarations: [
    <#list modelClasses as class>
      ${class.className}ListComponent<#if class_has_next>,</#if>
    </#list>
  ],
  providers: [
    ${model?cap_first}Service
  ]
})
export class ${model?cap_first}Module { }
