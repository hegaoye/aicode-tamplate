/**
 * Created by Administrator on 2018/9/4 0004.
 * 所有interface/class定义的数据模板都放这里
 */
export interface MenuItem {
  menuName: string;  //菜单文字
  menuIcon?: string,  //菜单图标，二级菜单不需要的时候可以不写
  menuUrl: string,   //菜单链接
  subMenuList?: Array<MenuItem> //子菜单
}

export interface TableHeader {
  name: string; //表格列名
  width?: number;  //表格列宽
  position: 'text-center' | 'text-left' | 'text-right';
}
