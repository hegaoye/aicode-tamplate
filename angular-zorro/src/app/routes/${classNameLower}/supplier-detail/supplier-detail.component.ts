import {Component, OnInit} from '@angular/core';
import {ActivatedRoute} from "@angular/router";
import {ClassNameLowerService} from "../${classNameLower}.service";

@Component({
  selector: 'app-supplier-detail',
  templateUrl: './supplier-detail.component.html',
  styleUrls: ['./supplier-detail.component.css']
})
export class SupplierDetailComponent implements OnInit {
  private code: string;
  public supplierInfo: any = {};//供应商信息

  constructor(private suppliersService: ClassNameLowerService, private route: ActivatedRoute) {
    this.code = this.route.snapshot.queryParams['code'];
  }

  ngOnInit() {
    this.code = this.route.snapshot.params.code;//获取参数
    this.loadSupplierInfo();//查询供应商类型列表
  }

  /**
   * 查询供应商信息
   */
  loadSupplierInfo() {
    this.suppliersService.loadSupplierByCode(this.code).then((data: any) => {
      if (data) this.supplierInfo = data;
    })
  }


}
