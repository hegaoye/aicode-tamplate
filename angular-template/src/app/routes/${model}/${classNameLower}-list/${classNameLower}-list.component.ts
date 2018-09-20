import {Component, OnInit} from "@angular/core";
import {Page} from "../../../public/util/page";
import {${model?cap_first}Service} from "../${model}.service";
import {States} from "../../../public/setting/enums";
import {SettingUrl} from "../../../public/setting/setting_url";

@Component({
  selector: 'app-${classNameLower}-list',
  templateUrl: './${classNameLower}-list.component.html',
  styleUrls: ['./${classNameLower}-list.component.scss']
})
export class ${className}ListComponent implements OnInit {
  public searchParams: any = {};//搜索参数
  public ${classNameLower}List: Page = new Page(); //供应商
  public _loading: boolean = false;
  public routerLinks = SettingUrl.ROUTERLINK;//路由
  public states = States;       // 状态

  constructor(private ${model}Service: ${model?cap_first}Service) {
  }

  ngOnInit() {
    this.query${className}List()
  }

  /**
   * 查询${classNameLower}列表
   * @param curPage 当前页
   */
  query${className}List(curPage?: number) {
    this._loading = true;
    if (curPage) this.${classNameLower}List.curPage = curPage;//当有页码时，查询该页数据
    this.${classNameLower}List.params = {
      curPage: this.${classNameLower}List.curPage, //目标页码
      pageSize: this.${classNameLower}List.pageSize, //每页条数
    };
    this.${model}Service.get${className}List(this.${classNameLower}List.params).then((res: Page) => {
      this._loading = false;
      this.${classNameLower}List = res;
    }).catch(err => {
      this._loading = false;
    })
  }

  /**
   * 修改禁用状态
   * @param code
   * @param event:boolean
   */
  modify${className}State(code, event) {
    let state = event ? States.enable : States.disable;//转换为对应的枚举
    this.${model}Service.modify${className}State(code, state).catch((res) => {
      this.query${className}List();//由于switch的特殊性，因此在失败的时候刷新页面
    })
  }

  /**
   * 重置搜索
   */
  resetSearch() {
    this.searchParams = {};
    this.query${className}List(1)
  }
}
