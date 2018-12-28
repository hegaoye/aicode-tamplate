import {Pipe, PipeTransform} from '@angular/core';
import {MainService} from "../service/main.service";

@Pipe({
  name: 'enumName'
})
export class EnumNamePipe implements PipeTransform {
  constructor(private mainService: MainService) {
  }

  transform(value: any, args?: any): any {
    return this.mainService.getEnumDataValByKey(args, value);
  }

}
