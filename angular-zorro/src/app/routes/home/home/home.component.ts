import {Component, OnInit, ViewEncapsulation} from '@angular/core';
import {Setting} from "../../../public/setting/setting";
import {HomeService} from "../home.service";
import {SettingUrl} from "../../../public/setting/setting_url.ts";
import {Util} from "../../../public/util/util";
import {Page} from "../../../public/util/page";

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
  encapsulation: ViewEncapsulation.None
})
export class HomeComponent implements OnInit {
  public homeInfo: any;
  public contactUs: Array<any> = [];
  public commonFunctions: Array<any> = [];//常用功能
  public statisticsDatas: Array<any> = [];//统计数据
  public chartOptionOfUserRatio: any;//用户比例
  public chartOptionOfUserRise: any;//用户增长

  constructor(private homeService: HomeService) {
  }

  ngOnInit() {
    // this.loadHomePageInfo()
  }

  /**
   * 加载首页数据
   */
  loadHomePageInfo() {
    this.homeService.loadHomePageInfo().then((res: any) => {
      this.homeInfo = res;

      //设置联系我们的信息内容
      this.setCommonFns();
      this.setStatisticsDatas();
      setTimeout(_ => {
        this.setChartOptionOfUserRatio();
        this.setChartOptionOfUserRise();
      })
    })
  }

  /*统计数据*/
  private setStatisticsDatas() {
    let me = this;
    this.statisticsDatas = [
      {
        icon: 'anticon anticon-bank',
        themeColor: {
          bdColor: 'bd-red',
          ftColor: 'color-red',
          bgColor: 'bg-red'
        },
        data: me.homeInfo.balance,
        unit: "￥",
        description: '平台账户金额'
      },
      {
        icon: 'anticon anticon-bank',
        themeColor: {
          bdColor: 'bd-orange',
          ftColor: 'color-orange',
          bgColor: 'bg-orange'
        },
        data: me.homeInfo.settleMoney,
        unit: "￥",
        description: '待结算金额'
      },
      {
        icon: 'anticon anticon-bank',
        themeColor: {
          bdColor: 'bd-pink',
          ftColor: 'color-pink',
          bgColor: 'bg-pink'
        },
        data: me.homeInfo.normalBiddingCount,
        description: '进行中的招标'
      }
    ]
  }

  /*常用功能*/
  private setCommonFns() {
    const routerLinks = SettingUrl.ROUTERLINK;
    this.commonFunctions = [
      {
        icon: "anticon anticon-notification color-blue",
        info: "供应商管理",
        url: routerLinks.supplier.list,
        isShow: Util.haveJurisdiction(Setting.MENUS, routerLinks.supplier.list)
      },
      {
        icon: "anticon anticon-pay-circle-o color-red",
        info: "供应商管理",
        url: routerLinks.supplier.list,
        isShow: Util.haveJurisdiction(Setting.MENUS, routerLinks.supplier.list)
      },
      {
        icon: "anticon anticon-global color-orange",
        info: "供应商管理",
        url: routerLinks.supplier.list,
        isShow: Util.haveJurisdiction(Setting.MENUS, routerLinks.supplier.list)
      },
      {
        icon: "anticon anticon-usergroup-add color-blue",
        info: "供应商管理",
        url: routerLinks.supplier.list,
        isShow: Util.haveJurisdiction(Setting.MENUS, routerLinks.supplier.list)
      }
    ];
  }

  /*用户状态统计表*/
  private setChartOptionOfUserRatio() {
    let me = this;
    this.chartOptionOfUserRatio = {
      title: {
        text: '用户账户统计',
        subtext: '平台注册用户的角色分布',
        x: 'center'
      },
      tooltip: {
        trigger: 'item',
        formatter: "{a} <br/>{b} : {c} ({d}%)"
      },
      legend: {
        orient: 'vertical',
        left: 'left',
        data: ['企业', '用户']
      },
      series: [
        {
          name: '角色',
          type: 'pie',
          radius: '55%',
          center: ['50%', '60%'],
          data: [
            {value: me.homeInfo.enterCount, name: '企业'},
            {value: me.homeInfo.custCount, name: '用户'}
          ],
          color: ['#8378ea', '#e7bcf3'],
          itemStyle: {
            emphasis: {
              shadowBlur: 10,
              shadowOffsetX: 0,
              shadowColor: 'rgba(0, 0, 0, 0.5)'
            }
          }
        }
      ]
    };
  }

  /*用户增长统计*/
  private setChartOptionOfUserRise() {
    let me = this, dataAry: Array<any> = [];
    for (let obj in me.homeInfo.biddingMap) {
      dataAry.push(me.homeInfo.biddingMap[obj]);
    }
    console.log("data", dataAry)
    this.chartOptionOfUserRise = {
      title: {
        text: '招标数量变化情况',
        subtext: '招标数量变化情况',
        x: 'center'
      },
      tooltip: {
        trigger: 'axis'
      },
      legend: {
        data: ['新招标']
      },
      color: ['#ff9f7f'],
      toolbox: {
        show: true,
        feature: {
          dataView: {show: true, readOnly: false},
          magicType: {show: true, type: ['line', 'bar']},
          restore: {show: true},
          saveAsImage: {show: true}
        }
      },
      calculable: true,
      xAxis: [
        {
          type: 'category',
          name: '时间',
          data: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月']
        }
      ],
      yAxis: [
        {
          type: 'value',
          name: '招标数量',
          min: 0,
          max: 100,
          interval: 10
        }
      ],
      series: [
        {
          name: '招标数量',
          type: 'bar',
          data: dataAry
        }
      ]
    };
  }

}
