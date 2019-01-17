import {Component, OnInit} from '@angular/core';
import {Setting} from "../../public/setting/setting";

@Component({
  selector: 'app-page',
  templateUrl: './page.component.html',
  styleUrls: ['./page.component.scss']
})
export class PageComponent implements OnInit {
  public app = Setting.APP; //平台信息

  constructor() {
  }

  ngOnInit() {
  }

}
