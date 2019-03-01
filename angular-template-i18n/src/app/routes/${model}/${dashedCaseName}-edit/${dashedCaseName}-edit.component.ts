import {Component, OnInit} from "@angular/core";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {ActivatedRoute} from "@angular/router";
import {Location} from "@angular/common";
import {${model?cap_first}Service} from "../${model}.service";

@Component({
  selector: 'app-${dashedCaseName}-add',
  templateUrl: './${dashedCaseName}-modify.component.html',
  styleUrls: ['./${dashedCaseName}-modify.component.less']
})
export class ${className}EditComponent implements OnInit {
  public isConfirmLoading: boolean = false;
  public code: string; //${classNameLower}
  public validateForm: FormGroup;//企业登录的表单

  constructor(private fb: FormBuilder, private ${model}Service: ${model?cap_first}Service, private route: ActivatedRoute, public location: Location) {
    this.validateForm = this.fb.group({
    <#list fields as field>
    <#if field.field!='id' && field.field!='code' && field.field!='state' && !field.checkDate>
      ${field.field}: [null, Validators.compose([Validators.required])]<#if field_has_next>,</#if> // ${field.notes}
    </#if>
    </#list>
    });
  }

  ngOnInit() {
    this.route.url.subscribe(url => {
      const curPath = url[0].path;
      if (curPath === 'modify') {
        this.code = this.route.snapshot.params.code;//获取参数
        this.load${className}Info();
      }//修改前查询出供应商信息
    })
  }

  /**
   * 表单确认
   */
  add${className}($event) {
    $event.preventDefault();
    //1.进行脏检查，提示未填的必填字段
    for (const key in this.validateForm.controls) {
      this.validateForm.controls[key].markAsDirty();
      this.validateForm.controls[key].updateValueAndValidity();
    }
    if (this.validateForm.invalid) return;
    this.isConfirmLoading = true;
    let formData = Object.assign({},this.validateForm.value);
    //添加${classNameLower}
    if (this.code) {
      formData.code = this.code;
      this.${model}Service.modify${className}(formData).then((data: any) => {
        this.isConfirmLoading = false;
        this.validateForm.reset();
        this.location.back();
      }).catch(res => this.isConfirmLoading = false)
    } else {
      this.${model}Service.add${className}(formData).then((data: any) => {
        this.isConfirmLoading = false;
        this.location.back();
      }).catch(res => this.isConfirmLoading = false)
    }
  }

  /**
   * 查询${classNameLower}信息
   */
  load${className}Info() {
    this.${model}Service.load${className}ByCode(this.code).then((data: any) => {
      this.validateForm.patchValue(data);
    })
  }


  getFormControl(name) {
    return this.validateForm.controls[name];
  }
}
