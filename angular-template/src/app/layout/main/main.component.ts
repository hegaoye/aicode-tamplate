import {Component, OnDestroy, OnInit} from "@angular/core";
import {NavigationStart, Router} from "@angular/router";
import {Setting} from "../../public/setting/setting";
import {SettingUrl} from "../../public/setting/setting_url";
import {AjaxService} from "../../public/service/ajax.service";

@Component({
  selector: 'app-main',
  templateUrl: './main.component.html',
  styleUrls: ['./main.component.less']
})
export class MainComponent implements OnInit, OnDestroy {
  public isCollapsed = false; //menu折叠
  public app = Setting.APP; //平台信息
  public menus: Array<any> = []; //菜单信息
  public home: string = SettingUrl.ROUTERLINK.basic.home; //首页路由
  public curComponent: any;
  public listenedRouter: any;//路由监听
  public settings = Setting;

  constructor(public router: Router,
              private ajaxService: AjaxService) {
  }

  ngOnInit() {
    const _this = this;
    _this.menus = Setting.MENUS; //菜单信息
    //监听路由变化，反选menu信息
    // _this.selMenu(_this.menus, location.pathname);//取刷新等初始化页面的路由
    _this.selMenu(_this.menus, location.hash.substring(1));//锚点路由时，获取刷新等初始化页面的路由

    this.listenedRouter = _this.router.events.subscribe((event) => {
      if (event instanceof NavigationStart) {
        _this.selMenu(_this.menus, event["url"]);
      }
    })
  }

  ngOnDestroy(): void {
    this.listenedRouter.unsubscribe();
  }


  /**
   * 监听子路由，找到当前激活的组件
   * @param e
   */
  activate(e) {
    this.curComponent = e;
  }

  openHandler(i) {
    this.menus.forEach((menu, idx) => {
      if (i == idx) menu.isOpen = true;
      else menu.isOpen = false;
    })
  }

  /**
   * 反选中menu
   * @param {string} url
   */
  selMenu(menuList: Array<any>, url: string) {
    menuList.forEach(menu => {
      menu.isOpen = false;
      if (menu.subMenuList && menu.subMenuList.length > 0) {
        menu.subMenuList.forEach(childMenu => {
          if ((url).indexOf(childMenu.menuUrl) == 0) {
            childMenu.isSel = true;
            menu.isOpen = true;
          } else {
            childMenu.isSel = false;
          }
        });
      } else if ((url).indexOf(menu.menuUrl) == 0) {
        menu.isSel = true;
        menu.isOpen = true;
      } else {
        menu.isSel = false;
      }
    });
  }

  /**
   * 退出登录
   */
  logout() {
    localStorage.clear(); //清空所有storage
    //执行查询（异步）
    this.ajaxService.get({
      url: SettingUrl.URL.login.logout,
      success: (result) => {
        if (result.success) {
          this.router.navigate([SettingUrl.ROUTERLINK.pass.login])//跳到登录页面
        }
      }
    });
  }

  /**
   * 前往指定页面
   * @param {string} url
   */
  goUrl(url: string) {
    const _this = this;
    if (url) _this.router.navigate([url]);
  }

}
