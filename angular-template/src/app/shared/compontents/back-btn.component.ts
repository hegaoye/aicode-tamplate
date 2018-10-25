import {Component, OnInit} from '@angular/core';
import {Location} from "@angular/common";

@Component({
  selector: 'app-back-btn',
  template: `<button nz-button [nzType]="'primary'" [nzShape]="'circle'" class="page-back btn-warning" (click)="back()" title="返回">
              <i class="anticon anticon-rollback font20"></i>
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
