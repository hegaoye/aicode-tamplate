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
  public ${classNameLower}Info: any = {};//供应商信息

  constructor(private ${classNameLower}Service: ${className}Service, private route: ActivatedRoute) {
    this.code = this.route.snapshot.queryParams['code'];
  }

  ngOnInit() {
    this.code = this.route.snapshot.params.code;//获取参数
    this.load${className}Info();//查询供应商类型列表
  }

  /**
   * 查询供应商信息
   */
  load${className}Info() {
    this.${classNameLower}Service.load${className}ByCode(this.code).then((data: any) => {
      if (data) this.${classNameLower}Info = data;
    })
  }


}
