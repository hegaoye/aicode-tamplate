import {Component, OnDestroy, OnInit} from "@angular/core";
import {${className}Service} from "../${classNameLower}.service";
import {Enums} from "../../../public/setting/enums";
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {PatternService} from "../../../public/service/pattern.service";
import {MainService} from "../../../public/service/main.service";
import {ActivatedRoute} from "@angular/router";
import {Location} from "@angular/common";

@Component({
  selector: 'app-${classNameLower}-edit',
  templateUrl: './${classNameLower}-edit.component.html',
  styleUrls: ['./${classNameLower}-edit.component.css']
})
export class ${className}EditComponent implements OnInit, OnDestroy {
  public isConfirmLoading: boolean = false;
  private code: string; //供应商编码，修改时会传过来
  public validateForm: FormGroup;//企业登录的表单
  public companyNature = MainService.getEnumDataList(Enums.companyNature);       // 公司性质
  public creditRating: number = 0;       // 状态
  public supplierCategorys: Array<any>;//供应商类型
  public paymentList: Array<any>;//支付方式
  private routeListener: any;//路由监听

  constructor(private fb: FormBuilder, private suppliersService: ${className}Service, private route: ActivatedRoute, public location: Location) {
    this.validateForm = this.fb.group({
      name: [null, Validators.compose([Validators.required, Validators.minLength(2), Validators.maxLength(32)])],//中文名
      englishName: [null, Validators.compose([Validators.required, Validators.minLength(2), Validators.maxLength(64)])],//英文名
      contacts: [null, [Validators.required]],//负责人姓名
      email: [null, Validators.compose([Validators.email])],//邮箱
      fax: [null, Validators.compose([Validators.pattern(PatternService.faxCode)])],//传真
      mobile: [null, Validators.compose([Validators.required, Validators.pattern(PatternService.mobile)])],//负责人手机号
      telephone: [null, Validators.compose([Validators.pattern(PatternService.telephone)])],//固定电话
      zipCode: [null, Validators.compose([Validators.pattern(PatternService.zipCode)])],//邮编
      website: [null, Validators.compose([Validators.pattern(PatternService.website)])],//网址
      creditRating: [null],//信用等级

      bank: [null, Validators.compose([Validators.required])],//银行
      bankAccount: [null, Validators.compose([Validators.required, Validators.pattern(PatternService.bankcard)])],//银行账户
      paymentTerm: [null, [Validators.required]],//支付方式
      supplierCategoryCode: [null, Validators.compose([Validators.required])],//供应商类型编码
      address: [null, Validators.compose([Validators.required, Validators.maxLength(64)])],//地址
      englishAddress: [null, Validators.compose([Validators.maxLength(128)])],//英文地址
      companyNature: [null, Validators.compose([Validators.required])],//公司性质
      summary: [null, Validators.compose([Validators.maxLength(128)])],//备注
    });
  }

  ngOnInit() {
    this.getSupplierCategoryList();//查询供应商类型列表
    this.getPaymentList();//查询供应商支付方式
    this.routeListener = this.route.url.subscribe(url => {
      const curPath = url[0].path;
      if (curPath === 'modify') {
        this.code = this.route.snapshot.params.code;//获取参数
        this.loadSupplierInfo();
      }//修改前查询出供应商信息
    })
  }

  /**
   * 确认
   */
  addSupplier($event) {
    $event.preventDefault();
    let me = this;
    //1.进行脏检查，提示未填的必填字段
    for (const key in me.validateForm.controls) {
      me.validateForm.controls[key].markAsDirty();
      me.validateForm.controls[key].updateValueAndValidity();
    }
    if (me.validateForm.invalid) return;
    me.isConfirmLoading = true;
    let formData = Object.assign({},this.validateForm.value);
    //添加供应商
    if (this.code) {
      formData.code = this.code;
      this.suppliersService.modifySupplier(formData).then((data: any) => {
        this.isConfirmLoading = false;
        this.validateForm.reset();
        this.location.back();
      }).catch(res => this.isConfirmLoading = false)
    } else {
      this.suppliersService.addSupplier(formData).then((data: any) => {
        this.isConfirmLoading = false;
        this.location.back();
      }).catch(res => this.isConfirmLoading = false)
    }
  }

  /**
   * 查询供应商类型信息
   */
  getSupplierCategoryList() {
    let params = {
      curPage: 1,
      pageSize: 1000
    };
    this.suppliersService.getSupplierCategoryList(params).then((data: any) => {
      if (data && data.voList) this.supplierCategorys = data.voList;
    }).catch(res => console.log(res));
  }

  /**
   * 查询供应商支付方式
   */
  getPaymentList() {
    let params = {
      curPage: 1,
      pageSize: 1000
    };
    this.suppliersService.getPaymentList(params).then((data: any) => {
      if (data && data.voList) this.paymentList = data.voList;
    }).catch(res => console.log(res));
  }

  /**
   * 查询供应商信息
   */
  loadSupplierInfo() {
    this.suppliersService.loadSupplierByCode(this.code).then((data: any) => {
      this.validateForm.patchValue(data);
    })
  }


  getFormControl(name) {
    return this.validateForm.controls[name];
  }

  ngOnDestroy(): void {
    this.routeListener.unsubscribe();
  }
}
