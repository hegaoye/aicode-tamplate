import { Component, HostListener } from '@angular/core';
import { NzModalService, NzMessageService } from 'ng-zorro-antd';
import { Router } from '@angular/router';
import { SettingUrl } from '@shared/setting/setting_url';

@Component({
  selector: 'header-storage',
  template: `
    <i nz-icon type="tool"></i>
    清理本地缓存
  `,
  host: {
    '[class.d-block]': 'true',
  },
})
export class HeaderStorageComponent {
  constructor(
    private confirmServ: NzModalService,
    private messageServ: NzMessageService,
    private router: Router,
  ) {
  }

  @HostListener('click')
  _click() {
    this.confirmServ.confirm({
      nzTitle: '确定要清理所有缓存？清理后您需要重新登录',
      nzOnOk: () => {
        localStorage.clear();
        this.messageServ.success('清理完成！');
        setTimeout(ret => {
          this.router.navigate([SettingUrl.ROUTERLINK.passport.loginFull]);
        }, 2000);
      },
    });
  }
}
