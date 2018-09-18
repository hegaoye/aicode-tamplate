import {Component, OnInit} from "@angular/core";
import {Page} from "../../../public/util/page";
import {SuppliersService} from "../suppliers.service";
import {NzModalService} from "ng-zorro-antd";
import {Enums, States} from "../../../public/setting/enums";
import {SettingUrl} from "../../../public/setting/setting_url.ts";

@Component({
  selector: 'app-suppliers',
  templateUrl: './${module}.component.html',
  styleUrls: ['./${module}.component.scss']
})
export class SuppliersComponent implements OnInit {
  public searchParams: any = {};//搜索参数
  public suppliers: Page = new Page(); //供应商
  public _loading: boolean = false;
  public routerLinks = SettingUrl.ROUTERLINK;//路由
  public companyNature = Enums.companyNature;       // 公司性质码
  public states = States;       // 状态

  constructor(private suppliersService: SuppliersService, public modalService: NzModalService) {
  }

  ngOnInit() {
    this.querySuppliersList()
  }

  /**
   * 查询供应商
   * @param curPage 当前页
   */
  querySuppliersList(curPage?: number) {
    let me = this;
    me._loading = true;
    if (curPage) me.suppliers.curPage = curPage;//当有页码时，查询该页数据
    me.suppliers.params = {
      curPage: me.suppliers.curPage, //目标页码
      pageSize: 1000, //每页条数
      name: me.searchParams.name, //供应商名称
    };
    me.suppliersService.getSuppliersList(me.suppliers.params).then((res: Page) => {
      me._loading = false;
      me.suppliers = res;
    }).catch(err => {
      me._loading = false;
    })
  }

  /**
   * 修改禁用状态
   * @param code
   * @param event
   */
  modifySupplierState(code, event) {
    let state = event ? States.enable : States.disable;
    this.suppliersService.modifySupplierState(code, state).catch((res) => {
      this.querySuppliersList();//由于switch的特殊性，因此在失败的时候刷新页面
    })
  }

  /**
   * 重置搜索
   */
  resetSearch() {
    this.searchParams = {};
    this.querySuppliersList(1)
  }
}
