import {MenuItem} from "./model";

/**
 * Created by Administrator on 2018/9/4 0004.
 * 本地开发使用菜单
 * 生产环境中菜单信息将由登录接口返回
 */
const suppliers: MenuItem = {
  menuName: "MenuSupplier0000",
  menuIcon: 'anticon anticon-shop',
  menuUrl: '/main/supplier',
  subMenuList: [
    {
      menuName: "MenuSupplier0001",
      menuUrl: '/main/supplier/${module}'
    }
  ]
};
export const MENUS = [suppliers];

