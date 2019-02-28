import {Component, OnInit} from "@angular/core";
import {${model?cap_first}Service} from "../${model}.service";
import {States} from "../../../public/util/enums";
import {SettingUrl} from "../../../public/setting/setting_url";
import {Page} from "../../../public/util/model";
import {Util} from "../../../public/util/util";

@Component({
  selector: 'app-${dashedCaseName}-list',
  templateUrl: './${dashedCaseName}-list.component.html',
  styleUrls: ['./${dashedCaseName}-list.component.less']
})
export class ${className}ListComponent implements OnInit {
  public searchParams: any = {};//搜索参数
  public ${classNameLower}List: Page = new Page(); //供应商
  public _loading: boolean = false;
  public routerLinks = SettingUrl.ROUTERLINK;//路由
  public states = States;       // 状态
  public options = [{
    value: 'zhejiang',
    label: 'Zhejiang',
    children: [{
      value: 'hangzhou',
      label: 'Hangzhou',
      children: [{
        value: 'xihu',
        label: 'West Lake',
        isLeaf: true
      }]
    }, {
      value: 'ningbo',
      label: 'Ningbo',
      isLeaf: true
    }]
  }, {
    value: 'jiangsu',
    label: 'Jiangsu',
    children: [{
      value: 'nanjing',
      label: 'Nanjing',
      children: [{
        value: 'zhonghuamen',
        label: 'Zhong Hua Men',
        isLeaf: true
      }]
    }]
  }];

  constructor(private ${model}Service: ${model?cap_first}Service) {
  }

  ngOnInit() {
    this.query${className}List()
  }

  /**
   * 查询${classNameLower}列表
   * @param curPage 当前页
   */
  query${className}List(curPage?: number) {
    this._loading = true;
    if (curPage) this.${classNameLower}List.curPage = curPage;//当有页码时，查询该页数据
    this.searchParams.curPage = this.${classNameLower}List.curPage; //目标页码
    this.searchParams.pageSize = this.${classNameLower}List.pageSize; //每页条数
    this.${model}Service.get${className}List(this.searchParams).then((res: Page) => {
      this._loading = false;
      this.${classNameLower}List = res;
    }).catch(err => {
      this._loading = false;
    })
  }

  <#list fields as field>
  <#if (field.isState)>
  /**
   * 修改禁用状态
   * @param code
   * @param event:boolean
   */
  modify${className}State(code, event) {
    let state = event ? States.enable : States.disable;//转换为对应的枚举
    this.${model}Service.modify${className}State(code, state).catch((res) => {
      this.query${className}List();//由于switch的特殊性，因此在失败的时候刷新页面
    })
  }
  <#else>
  <#if (field.isQueryRequired)>
  <#elseif (field.isDate || field.displayType == 'datePicker')>
  /**
   * 日期选择变更
   */
  dateChange(date:Array<any>) {
    if (date && date.length === 2) {
      this.searchParams.dateBegin = Util.formateGBDate(date[0]);
      this.searchParams.dateEnd = Util.formateGBDate(date[1]);
    } else {
      this.searchParams.dateBegin = undefined;
      this.searchParams.dateEnd = undefined;
    }
  }
  <#elseif (field.displayType == 'timePicker')>

  /**
   * 时间选择变更
   */
  timeChange(time:Date){
    console.log(time && time.toTimeString());
  }
  <#elseif (field.displayType == 'cascader')>
  /**
   * 级联选择
   */
  onChanges(event){
    console.log("█ event ►►►", event);
  }
  <#else>

  </#if>
  </#if>
  </#list>
  /**
   * 重置搜索
   */
  resetSearch() {
    this.searchParams = {};
    this.query${className}List(1)
  }
}
