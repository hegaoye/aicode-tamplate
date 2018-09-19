import {Component, Input, OnInit} from '@angular/core';
import {Enums} from "../../../public/setting/enums";
import {SettingUrl} from "../../../public/setting/setting_url";
import {ActivatedRoute, Router} from "@angular/router";

@Component({
  selector: 'app-${classNameLower}-info',
  templateUrl: './${classNameLower}-info.component.html',
  styleUrls: ['./${classNameLower}-info.component.css']
})
export class ${className}InfoComponent implements OnInit {
  @Input() supplierInfo: any;
  public companyNature = Enums.companyNature;       // 公司性质码

  constructor(private router: Router) {
  }

  ngOnInit() {
  }

  /**
   * 修改未设置数据
   */
  toModifyTheUnSetData() {
    this.router.navigate([SettingUrl.ROUTERLINK.supplier.modify, this.supplierInfo.code])
  }

}
