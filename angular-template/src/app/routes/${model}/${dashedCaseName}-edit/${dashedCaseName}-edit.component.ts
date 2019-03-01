import {Component, OnInit} from "@angular/core";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {ActivatedRoute} from "@angular/router";
import {Location} from "@angular/common";
import {${model?cap_first}Service} from "../${model}.service";
import { UploadFile } from 'ng-zorro-antd';
import {PatternService} from "../../../../../../angular-template-rzhkj/src/app/shared/service/pattern.service";

@Component({
  selector: 'app-${dashedCaseName}-edit',
  templateUrl: './${dashedCaseName}-edit.component.html',
  styleUrls: ['./${dashedCaseName}-edit.component.less']
})
export class ${className}EditComponent implements OnInit {
  public isConfirmLoading: boolean = false;
  public code: string; //${classNameLower}
  public validateForm: FormGroup;//企业登录的表单

  <#list fields as field>
  <#if (field.isAllowUpdate)>
  <#if (field.displayType == 'Autocomplete')>
  autocompleteOptions = [];
  autocompleteOnChange(value: string): void {
    if (!value || value.indexOf('@') >= 0) {
      this.autocompleteOptions = [];
    } else {
      this.autocompleteOptions = ['gmail.com', '163.com', 'qq.com'].map(domain => `${r'${value}@${domain}'}`);
    }
  }
  <#elseif (field.displayType == 'MultiSelect')>
  //多选模拟数据
  multiSelectListOfOption = [{label:a1,value:a1},{label:a2,value:a2},{label:a11,value:a11},{label:b1,value:b1}];

  <#elseif (field.displayType == 'Mention')>
  //Mention模拟数据
  webFrameworks = [
    { name: 'React', type: 'JavaScript', icon: 'https://zos.alipayobjects.com/rmsportal/LFIeMPzdLcLnEUe.svg' },
    { name: 'Angular', type: 'JavaScript', icon: 'https://zos.alipayobjects.com/rmsportal/PJTbxSvzYWjDZnJ.png' },
    { name: 'Dva', type: 'Javascript', icon: 'https://zos.alipayobjects.com/rmsportal/EYPwSeEJKxDtVxI.png' },
    { name: 'Flask', type: 'Python', icon: 'https://zos.alipayobjects.com/rmsportal/xaypBUijfnpAlXE.png' },
  ];
  valueWith = data => data.name;
  onMentionSelect(value: string): void {
    console.log(value);
  }

  <#elseif (field.displayType == 'TreeSelect')>
  //TreeSelect 模拟数据
  treeNodes = [ {
    title   : 'parent 1',
    key     : '100',
    children: [ {
      title   : 'parent 1-0',
      key     : '1001',
      children: [
        { title: 'leaf 1-0-0', key: '10010', isLeaf: true },
        { title: 'leaf 1-0-1', key: '10011', isLeaf: true }
      ]
    }, {
      title   : 'parent 1-1',
      key     : '1002',
      children: [
        { title: 'leaf 1-1-0', key: '10020', isLeaf: true }
      ]
    } ]
  } ];
  onTreeSelectChange($event: string): void {
    console.log($event);
  }

  <#elseif (field.displayType == 'Upload')>
  //Upload 模拟数据
  fileList = [
    {
      uid: -1,
      name: 'xxx.png',
      status: 'done',
      url: 'https://zos.alipayobjects.com/rmsportal/jkjgkEfvpUPVyRjUImniVslZfWPnJuuZ.png'
    }
  ];
  previewImage = '';
  previewVisible = false;
  handlePreview = (file: UploadFile) => {
    this.previewImage = file.url || file.thumbUrl;
    this.previewVisible = true;
  };
  </#if>
  </#if>
  </#list>

  constructor(private fb: FormBuilder, private ${model}Service: ${model?cap_first}Service, private route: ActivatedRoute, public location: Location) {
    this.validateForm = this.fb.group({
    <#list fields as field>
    <#if (field.isAllowUpdate)>
      ${field.field}: [null<#if (field.isRequired)>,
      <#if (field.displayType == 'Mobile')>
      Validators.compose([Validators.required,Validators.pattern(PatternService.mobile)])
      <#elseif (field.displayType == 'Phone')>
      Validators.compose([Validators.required,Validators.pattern(PatternService.phone)])
      <#elseif (field.displayType == 'MobileOrPhone')>
      Validators.compose([Validators.required,Validators.pattern(PatternService.tel)])
      <#elseif (field.displayType == 'Email')>
      Validators.compose([Validators.required,Validators.pattern(PatternService.email)])
      <#elseif (field.displayType == 'Website')>
      Validators.compose([Validators.required,Validators.pattern(PatternService.website)])
      <#elseif (field.displayType == 'IdCard')>
      Validators.compose([Validators.required,Validators.pattern(PatternService.idCard)])
      <#else> [Validators.required]
      </#if>
      <#else>
      <#if (field.isRequired && field.displayType == 'Mobile')>
      Validators.compose([Validators.pattern(PatternService.mobile)])
      <#elseif (field.displayType == 'Phone')>
      Validators.compose([Validators.pattern(PatternService.phone)])
      <#elseif (field.displayType == 'MobileOrPhone')>
      Validators.compose([Validators.pattern(PatternService.tel)])
      <#elseif (field.displayType == 'Email')>
      Validators.compose([Validators.pattern(PatternService.email)])
      <#elseif (field.displayType == 'Website')>
      Validators.compose([Validators.pattern(PatternService.website)])
      <#elseif (field.displayType == 'IdCard')>
      Validators.compose([Validators.pattern(PatternService.idCard)])
      </#if>
    </#if>
    ]<#if field_has_next>,</#if> // ${field.displayName}
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
