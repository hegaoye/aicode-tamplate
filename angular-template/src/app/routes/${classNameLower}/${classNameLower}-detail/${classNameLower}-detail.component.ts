import {Component, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {${className}Service} from "../${classNameLower}.service";
import {SettingUrl} from "../../../public/setting/setting_url";

@Component({
  selector: 'app-${classNameLower}-detail',
  templateUrl: './${classNameLower}-detail.component.html',
  styleUrls: ['./${classNameLower}-detail.component.css']
})
export class ${className}DetailComponent implements OnInit {
  private code: string;
  public ${classNameLower}Info: any = {};//供应商信息

  constructor(private ${classNameLower}Service: ${className}Service, private route: ActivatedRoute, private router: Router) {
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

  /**
   * 修改未设置数据
   */
  toModifyTheUnSetData() {
    this.router.navigate([SettingUrl.ROUTERLINK.${classNameLower}.modify, this.code])
  }

}
