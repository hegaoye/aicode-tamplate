import {MenuItem} from "./model";

/**
 * Created by Administrator on 2018/9/4 0004.
 * 本地开发使用菜单
 * 生产环境中菜单信息将由登录接口返回
 */
<#list classes as class>
const ${class.classModel}: MenuItem = {
  menuName: "${class.classModel}",
  menuIcon: 'anticon anticon-shop',
  menuUrl: '/main/${class.classModel}'
};

</#list>
export const MENUS = [
  <#list classes as class>${class.classModel},</#list>
];

