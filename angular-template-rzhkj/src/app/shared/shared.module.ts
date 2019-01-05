import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ReactiveFormsModule, FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';
// delon
import { AlainThemeModule } from '@delon/theme';
import { DelonABCModule } from '@delon/abc';
import { DelonACLModule } from '@delon/acl';
import { DelonFormModule } from '@delon/form';

// #region third libs
import { NgZorroAntdModule } from 'ng-zorro-antd';
import { CountdownModule } from 'ngx-countdown';
import { MainService } from '@shared/service/main.service';
import { StateNamePipe } from '@shared/pipes/state-name.pipe';
import { ImgErrDirective } from '@shared/directives/img-err.directive';
import { DashboardComponent } from '../routes/dashboard/dashboard.component';

const THIRDMODULES = [
  NgZorroAntdModule,
  CountdownModule,
];
// #endregion

// #region your componets & directives
const COMPONENTS = [];
const DIRECTIVES = [
  ImgErrDirective,
];
const PIPES = [
  StateNamePipe,
];
const SERVICES = [
  MainService,
];

// #endregion

@NgModule({
  imports: [
    CommonModule,
    FormsModule,
    RouterModule,
    ReactiveFormsModule,
    AlainThemeModule.forChild(),
    DelonABCModule,
    DelonACLModule,
    DelonFormModule,
    // third libs
    ...THIRDMODULES,
  ],
  declarations: [
    // your components
    ...COMPONENTS,
    ...DIRECTIVES,
    ...PIPES,
  ],
  exports: [
    CommonModule,
    FormsModule,
    ReactiveFormsModule,
    RouterModule,
    AlainThemeModule,
    DelonABCModule,
    DelonACLModule,
    DelonFormModule,
    // third libs
    ...THIRDMODULES,
    // your components
    ...COMPONENTS,
    ...DIRECTIVES,
    ...PIPES,
  ],
  providers: [
    ...SERVICES,
  ],
})
export class SharedModule {
}
