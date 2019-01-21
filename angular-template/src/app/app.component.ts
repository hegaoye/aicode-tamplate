import {Component} from '@angular/core';
import {Router} from "@angular/router";
import {Setting} from "./public/setting/setting";
import {MENUS} from "./public/util/menus";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.less']
})
export class AppComponent {
  public isSpinning = Setting.isSpinning;

  constructor(public router: Router) {
    //判断是否已经登录，已经登录，引导进入首页
    // let menusInfo: any = localStorage.getItem(Setting.cookie.menusInfo); //localStorage中取出menu菜单
    // if (menusInfo) Setting.MENUS = JSON.parse(menusInfo); //menu菜单

    Setting.MENUS = MENUS;//开发菜单
  }

}
