import { Component, OnInit } from '@angular/core';
import { _HttpClient } from '@delon/theme';
import { MainService } from '@shared/service/main.service';

@Component({
  selector: 'app-dashboard',
  templateUrl: './dashboard.component.html',
})
export class DashboardComponent implements OnInit {
  a: string = 'Y';
  b = 1001;

  constructor(private http: _HttpClient, private main: MainService) {
  }

  ngOnInit() {
  }

  ceshi() {
    this.main.getEnumDataList(1001).subscribe(res => {
      console.log(res);
    });
  }
}
