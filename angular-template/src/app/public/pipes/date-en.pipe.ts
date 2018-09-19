import {Pipe, PipeTransform} from '@angular/core';

@Pipe({
  name: 'dateEn'
})

/**
 * 将YYYY-MM-DD格式日期转换成YYYY/MM/DD格式
 */
export class DateEnPipe implements PipeTransform {

  transform(value: any, args?: any): any {
    let date;
    date = value.replace(/\-/g, '/');
    return date;
  }

}
