import {Component, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {${model?cap_first}Service} from "../${model}.service";
import {SettingUrl} from "../../../public/setting/setting_url";
import {Page} from "../../../public/util/model";

@Component({
  selector: 'app-${dashedCaseName}-detail',
  templateUrl: './${dashedCaseName}-detail.component.html',
  styleUrls: ['./${dashedCaseName}-detail.component.less']
})
export class ${className}DetailComponent implements OnInit {
  private code: string;
  public ${classNameLower}Info: any = {};//${classNameLower}信息
  public searchParams: any = {};//搜索参数

<#if oneToManyList??&&(oneToManyList?size>0)>
<#list oneToManyList as oneToMany>
  public ${oneToMany.classNameLower}List: Page = new Page(); //供应商
  public _${oneToMany.classNameLower}Loading: boolean = false;
</#list>
</#if>

  constructor(private ${model}Service: ${model?cap_first}Service, private route: ActivatedRoute,
  <#if oneToManyList??&&(oneToManyList?size>0)>
  <#list oneToManyList as oneToMany>
  <#if oneToMany.model?cap_first != model?cap_first>
  ${oneToMany.model}Service:${oneToMany.model?cap_first}Service,
  </#if>
  </#list>
  </#if>
  private router: Router) {
  }

  ngOnInit() {
    this.code = this.route.snapshot.params.code;//获取参数
    this.load${className}Info();//查询${classNameLower}类型列表

    <#if oneToManyList??&&(oneToManyList?size>0)>
    <#list oneToManyList as oneToMany>
    this.query${oneToMany.className}List()
    </#list>
    </#if>
  }

<#if oneToManyList??&&(oneToManyList?size>0)>
<#list oneToManyList as oneToMany>
  /**
   * 查询${oneToMany.classNameLower}列表
   * @param curPage 当前页
   */
  query${oneToMany.className}List(curPage?: number) {
    this._${oneToMany.classNameLower}Loading = true;
    if (curPage) { this.${oneToMany.classNameLower}List.curPage = curPage; }// 当有页码时，查询该页数据
    this.searchParams.curPage = this.${oneToMany.classNameLower}List.curPage; // 目标页码
    this.searchParams.pageSize = this.${oneToMany.classNameLower}List.pageSize; // 目标页码
    this.searchParams.code = this.code;
    this.${oneToMany.model}Service.get${oneToMany.className}List(this.searchParams).then((res: Page) => {
      this._${oneToMany.classNameLower}Loading = false;
      this.${oneToMany.classNameLower}List = res;
    }).catch(err => {
      this._${oneToMany.classNameLower}Loading = false;
    })
  }
</#list>
</#if>

  /**
   * 查询${classNameLower}信息
   */
  load${className}Info() {
    this.${model}Service.load${className}ByCode(this.code).then((data: any) => {
      if (data) this.${classNameLower}Info = data;
    })
  }

  /**
   * 修改未设置数据
   */
  toModifyTheUnSetData() {
    this.router.navigate([SettingUrl.ROUTERLINK.${classNameLower}.modify, this.code])
  }

}
