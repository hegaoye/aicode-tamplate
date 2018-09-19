import {Component, OnInit} from "@angular/core";
import {Page} from "../../../public/util/page";
import {${className}Service} from "../${classNameLower}.service";
import {NzModalService} from "ng-zorro-antd";
import {Enums, States} from "../../../public/setting/enums";
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
  public companyNature = Enums.companyNature;       // 公司性质码
  public states = States;       // 状态

  constructor(private ${classNameLower}Service: ${className}Service, public modalService: NzModalService) {
  }

  ngOnInit() {
    this.query${className}List()
  }

  /**
   * 查询供应商
   * @param curPage 当前页
   */
  query${className}List(curPage?: number) {
    let me = this;
    me._loading = true;
    if (curPage) me.${classNameLower}List.curPage = curPage;//当有页码时，查询该页数据
    me.${classNameLower}List.params = {
      curPage: me.${classNameLower}List.curPage, //目标页码
      pageSize: me.${classNameLower}List.pageSize, //每页条数
      name: me.searchParams.name, //供应商名称
    };
    me.${classNameLower}Service.get${className}List(me.${classNameLower}List.params).then((res: Page) => {
      me._loading = false;
      me.${classNameLower}List = res;
    }).catch(err => {
      me._loading = false;
    })
  }

  /**
   * 修改禁用状态
   * @param code
   * @param event
   */
  modify${className}State(code, event) {
    let state = event ? States.enable : States.disable;
    this.${classNameLower}Service.modify${className}State(code, state).catch((res) => {
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
