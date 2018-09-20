import { Pipe, PipeTransform } from '@angular/core';

@Pipe({
  name: 'spliceStr'
})
export class SpliceStrPipe implements PipeTransform {

  transform(str:string, args:any): any {
    if(!str) return;
    let stars: string = '',
      starsLength = str.length - args[0] - args[1],
      startPlace = args[0],
      endPlace = str.length - args[1];
    for (let i = 0; i < starsLength; i++) stars += '*';
    let strr = str.substr(0, startPlace) + stars + str.substr(endPlace);
    return strr;
  }

}
