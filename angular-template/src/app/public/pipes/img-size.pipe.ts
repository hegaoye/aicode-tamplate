import {Pipe, PipeTransform} from '@angular/core';

@Pipe({
  name: 'imgSize'
})
/**
 * 自定义显示图片大小，若不传大小，默认为200
 * 用法：
 * <img [src]="imgUrl | imgSize:'100'... 这是指长、宽最大为100px（等比缩放）
 * <img [src]="imgUrl | imgSize... 这是指长、宽最大为200px（等比缩放）
 */
export class ImgSizePipe implements PipeTransform {
  transform(value: any, args?: any): any {
    if(!args) args = "200";
    return value + `?imageView2/2/w/${args}/h/${args}`;
  }
}
