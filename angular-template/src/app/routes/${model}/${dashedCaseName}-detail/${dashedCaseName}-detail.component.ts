import {Component, OnInit} from '@angular/core';
import {ActivatedRoute, Router} from '@angular/router';
import {${model?cap_first}Service} from "../${model}.service";
import {SettingUrl} from "../../../public/setting/setting_url";

@Component({
  selector: 'app-${dashedCaseName}-detail',
  templateUrl: './${dashedCaseName}-detail.component.html',
  styleUrls: ['./${dashedCaseName}-detail.component.css']
})
export class ${className}DetailComponent implements OnInit {
  private code: string;
  public ${classNameLower}Info: any = {};//${classNameLower}信息

  constructor(private ${model}Service: ${model?cap_first}Service, private route: ActivatedRoute, private router: Router) {
  }

  ngOnInit() {
    this.code = this.route.snapshot.params.code;//获取参数
    this.load${className}Info();//查询${classNameLower}类型列表
  }

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
