import { Component, OnInit } from '@angular/core';
import { Page } from '@shared/util/page';
import { NzNotificationService } from 'ng-zorro-antd';
import { FormBuilder, FormGroup, Validators } from '@angular/forms';
import { PatternService } from '@shared/service/pattern.service';
import { ${model?cap_first}Service } from '../${model}.service';

@Component({
  selector: 'app-${dashedCaseName}-list',
  templateUrl: './${dashedCaseName}-list.component.html',
  styles: [],
})
export class ${className}SettingsListComponent implements OnInit {
  searchData: string; //搜索参数
  ${classNameLower}List: Page = new Page(); //数据源
  _loading: boolean = false;
  isAdd: boolean = false;
  addForm: FormGroup;
  isEdit: boolean = false;
  editForm: FormGroup;

  constructor(private ${model}Service: ${model?cap_first}Service, private notification: NzNotificationService, private fb: FormBuilder) {
    let me = this;
    me.addForm = me.fb.group({
      phone: [null, [Validators.required, Validators.pattern(PatternService.phone)]],
    });
    me.editForm = me.fb.group({
      email: [null, [Validators.required, Validators.email]],
    });
  }

  ngOnInit() {
    let me = this;
    me.query${className}List(); //查询数据集合
  }

  /**
   * 搜索
   */
  search() {
    console.log(this.searchData);
  }

  /**
   * 查询${classNameLower}列表
   * @param curPage 当前页
   */
  query${className}List(curPage?: number) {
    let me = this;
    me._loading = true;
    if (curPage) me.${classNameLower}List.curPage = curPage;//当有页码时，查询该页数据
    me.${classNameLower}List.params = {
      curPage: me.${classNameLower}List.curPage, //目标页码
      pageSize: me.${classNameLower}List.pageSize, //每页条数
    };
    me.${model}Service.get${className}List(this.${classNameLower}List.params).subscribe((res: any) => {
      me._loading = false;
      res.success ? me.${classNameLower}List = res.data : me.notification.error('操作有误', res.info);
    });
  }

  /**
   * 开启添加信息弹框
   */
  showAdd() {
    this.isAdd = true;
  }

  /**
   * 关闭添加信息弹框
   */
  closeAdd() {
    this.isAdd = false;
  }

  /**
   * 添加信息
   */
  add() {
    let me = this;
    me.addForm.valid ? console.log('ok') : console.log('no');
    me.addForm.reset();
  }

  /**
   * 开启编辑信息弹框
   */
  showEdit() {
    this.isEdit = true;
  }

  /**
   * 关闭编辑信息弹框
   */
  closeEdit() {
    this.isEdit = false;
  }

  /**
   * 编辑信息
   */
  edit() {
    let me = this;
    me.editForm.valid ? console.log('ok') : console.log('no');
    me.editForm.reset();
  }

  /**
   * 删除数据
   */
  del() {
    console.log('del...');
  }

}
