import {NgModule} from "@angular/core";
import {${classNameLower?cap_first}Component} from "./${classNameLower}/${classNameLower}.component";
import {RouterModule, Routes} from "@angular/router";
import {SharedModule} from "../../shared/shared.module";
import {SupplierDetailComponent} from "./supplier-detail/supplier-detail.component";
import {SupplierEditComponent} from "./supplier-edit/supplier-edit.component";
import {SupplierInfoComponent} from "./supplier-info/supplier-info.component";

const routes: Routes = [
  {path: '', redirectTo: 'suppliers'},
  {
    path: 'suppliers', children: [
      {path: '', redirectTo: 'list'},
      {path: 'list', component: ClassNameLowerComponent},
      {path: 'add', component: SupplierEditComponent},
      {path: 'modify/:code', component: SupplierEditComponent},
      {path: 'detail/:code', component: SupplierDetailComponent},
    ]
  }
]

@NgModule({
  imports: [
    SharedModule.forRoot(),
    RouterModule.forChild(routes)
  ],
  declarations: [
      ${classNameLower?cap_first}Component,
    SupplierDetailComponent,
    SupplierEditComponent,
    SupplierInfoComponent],
  providers: []
})
export class ${classNameLower?cap_first}Module {
}
