import { Pipe, PipeTransform } from '@angular/core';
import {MainService} from "../service/main.service";

@Pipe({
  name: 'enumName'
})
export class EnumNamePipe implements PipeTransform {

  transform(value: any, args?: any): any {
    return MainService.getEnumDataValByKey(args,value);
  }

}
