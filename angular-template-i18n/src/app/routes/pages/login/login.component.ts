import {Component, OnInit} from '@angular/core';
import {FormBuilder, FormGroup, Validators} from "@angular/forms";
import {PagesService} from "../pages.service";
import {Setting} from "../../../public/setting/setting";

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.less']
})
export class LoginComponent implements OnInit {
  public validateForm: FormGroup;//登录的表单
  public app = Setting.APP; //平台信息

  constructor(public fb: FormBuilder, private pagesService: PagesService) {
    this.validateForm = this.fb.group({
      loginCode: [null, [Validators.required]],
      pwd: [null, [Validators.required]],
    });
  }

  ngOnInit() {
  }

  /**
   * 登录
   * @param $event
   * @param value
   */

  login = ($event) => {
    $event.preventDefault();
    let me = this;
    for (const key in me.validateForm.controls) {
      me.validateForm.controls[key].markAsDirty();
      me.validateForm.controls[key].updateValueAndValidity();
    }
    if (me.validateForm.invalid) return;

    // me.pagesService.login(me.validateForm.value, callback);
  };


  /**
   * from表单
   * @param name
   * @returns {AbstractControl}
   */
  getFormControl(name) {
    return this.validateForm.controls[name];
  }

}
