import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {TranslateService} from "@ngx-translate/core";
import {MainService} from "../../public/service/main.service";
import {Setting} from "../../public/setting/setting";

@Component({
  selector: 'app-page',
  templateUrl: './page.component.html',
  styleUrls: ['./page.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class PageComponent implements OnInit {
  public app = Setting.APP; //平台信息

  constructor(public translate: TranslateService, private mainService: MainService) {
    this.mainService.languageSupport();//添加语言支持
  }

  ngOnInit() {
  }

  changeLang(lang) {
    this.translate.use(lang);
    localStorage.setItem(Setting.storage.language, lang);//存入本地
  }

}
