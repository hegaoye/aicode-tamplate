import { Injector, Pipe, PipeTransform } from '@angular/core';
import { MainService } from '../service/main.service';

@Pipe({
  name: 'stateName',
})
/**
 * 把状态改为对应的汉字状态信息
 * 如：START--启动，STOP--停止
 * 使用方式：{{data.state | stateName : stateEnum | async}}   stateEnum参数为状态码，如：1001
 *
 */
export class StateNamePipe implements PipeTransform {

  constructor(private  injector: Injector) {
  }

  transform(value: any, args?: any): any {
    return this.injector.get(MainService).getEnumDataValByKey(args, value);
  }

}
