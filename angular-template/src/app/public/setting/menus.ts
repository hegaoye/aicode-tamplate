import {MenuItem} from "./model";

/**
 * Created by Administrator on 2018/9/4 0004.
 * 本地开发使用菜单
 * 生产环境中菜单信息将由登录接口返回
 */
<#list modelDatas as modelData>
const ${modelDatas.model}: MenuItem = {
  menuName: "${class.classModel}",
  menuIcon: 'anticon anticon-shop',
  menuUrl: '/main/${modelDatas.model}',
  subMenuList: [
    <#list modelData.classes as class>
    <#if modelData.classes?size gt 1>
    {
      menuName: ${class.className},
      menuUrl: '/main/${modelDatas.model}/${class.className?uncap_first}'
    }<#if class_has_next>,</#if>
    </#if>

    </#list>
  ]
};
</#list>


export const MENUS = [
  <#list modelDatas as modelData>${modelDatas.model}<#if class_has_next>,</#if></#list>
];

