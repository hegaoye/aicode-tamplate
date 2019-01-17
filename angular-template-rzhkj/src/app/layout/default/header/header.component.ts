import { Component, ViewChild } from '@angular/core';
import { SettingsService } from '@delon/theme';
import { SettingUrl } from '@shared/setting/setting_url';

@Component({
  selector: 'layout-header',
  templateUrl: './header.component.html',
})
export class HeaderComponent {
  searchToggleStatus: boolean;
  lockUrl: string = SettingUrl.ROUTERLINK.passport.lockFull;

  constructor(public settings: SettingsService) {}

  toggleCollapsedSidebar() {
    this.settings.setLayout('collapsed', !this.settings.layout.collapsed);
  }

  searchToggleChange() {
    this.searchToggleStatus = !this.searchToggleStatus;
  }
}
