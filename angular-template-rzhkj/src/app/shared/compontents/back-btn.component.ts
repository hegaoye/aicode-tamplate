import {Component, OnInit} from '@angular/core';
import {Location} from "@angular/common";

@Component({
  selector: 'app-back-btn',
  template: `<button nz-button [nzType]="'primary'" [nzShape]="'circle'" class="page-back btn-warning" (click)="back()" title="返回">
              <i nz-icon type="rollback" theme="outline" class="font20"></i>
            </button>`
})
export class BackBtnComponent implements OnInit {

  constructor(public location: Location) { }

  ngOnInit() {
  }

  back(){
    this.location.back()
  }

}
