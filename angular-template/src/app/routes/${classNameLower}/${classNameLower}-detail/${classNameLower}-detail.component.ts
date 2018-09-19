import {Component, OnInit} from '@angular/core';
import {ActivatedRoute} from "@angular/router";
import {${className}Service} from "../${classNameLower}.service";

@Component({
  selector: 'app-${classNameLower}-detail',
  templateUrl: './${classNameLower}-detail.component.html',
  styleUrls: ['./${classNameLower}-detail.component.css']
})
export class ${className}DetailComponent implements OnInit {
  private code: string;
  public supplierInfo: any = {};//供应商信息

  constructor(private ${classNameLower}Service: ${className}Service, private route: ActivatedRoute) {
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
    this.${classNameLower}Service.loadSupplierByCode(this.code).then((data: any) => {
      if (data) this.supplierInfo = data;
    })
  }


}
