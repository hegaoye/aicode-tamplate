import {Component} from '@angular/core';
import {Router} from "@angular/router";
import {CookieService} from "angular2-cookie/core";
import {Setting} from "./public/setting/setting";
import {MENUS} from "./public/setting/menus";

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {

  constructor(public router: Router, public cookieService: CookieService) {
    //判断是否已经登录，已经登录，引导进入首页
    // let menusInfo: any = localStorage.getItem(Setting.cookie.menusInfo); //localStorage中取出menu菜单
    // if (menusInfo) Setting.MENUS = JSON.parse(menusInfo); //menu菜单

    Setting.MENUS = MENUS;//开发菜单
  }

}
