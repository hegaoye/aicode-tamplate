import { Pipe, PipeTransform } from '@angular/core';
import {isNullOrUndefined} from "util";
import {MainService} from "../service/main.service";

@Pipe({
  name: 'level2AreaName'
})
export class Level2AreaNamePipe implements PipeTransform {

  constructor() {  }

  transform(value: any, args?: any): any {
    let fullName = [];
    let codes = value.split(',');
    for(let value of codes){
      if(!isNullOrUndefined(value)){
        let result = MainService.getAreaByTwelveBitCode(value);
        if(!isNullOrUndefined(result) && !isNullOrUndefined(result.fullName)){
          fullName.push(result.fullName);
        }
      }
    }
    return fullName.join('、');
  }

}
