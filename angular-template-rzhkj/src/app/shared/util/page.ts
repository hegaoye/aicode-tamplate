/**
 * 分页对象
 */
import {Injectable} from "@angular/core";

@Injectable()
export class Page {
  curPage: number = 1; //当前页
  lastPage: boolean = true; //是否最后一页
  pageSize: number = 25; //每页条数
  params: any = null; //查询参数
  sortColumns: string = null;
  totalPage: number = 0; //总页数
  totalRow: number = 0; //总条数
  voList: Array<any> = new Array(); //查询结果

  constructor() {
  }
}
