import {Directive, ElementRef, Input, Renderer} from '@angular/core';
import {Setting} from "../setting/setting";
import {isNullOrUndefined} from "util";

@Directive({
  selector: '[appImgErr]'
})

/**
 * 检测图片加载是否正确，如果不正确，返回默认图片
 * 用法：
 * 1、<img appImgErr src="... 此时，如果图片加载错误，则显示平台默认图片
 * 2、<img appImgErr="user" src="... 此时，如果图片加载错误，则显示用户默认图片
 */
export class ImgErrDirective {
  @Input('appImgErr')
  defaultType: string; // 当前显示默认的图片类型（支持：user）
  constructor(private elementRef: ElementRef) {
    setTimeout(() => {
      let defaultImg = Setting.APP.defaultImg;
      if (this.defaultType == "user") defaultImg = Setting.APP.userDefaultImg; //type为user时，显示用户默认图片
      let src = elementRef.nativeElement.src; //获取当前节点的图片路径
      if (isNullOrUndefined(src) || src == "") { //如果图片路径为空或没值，返回默认图片
        elementRef.nativeElement.src = defaultImg;
      } else { //判断图片的路径是否有效，无效时，返回默认图片
        let theImage = new Image();
        theImage.src = src;
        // 为Image对象添加图片加载失败的处理方法
        theImage.onerror = function () {
          elementRef.nativeElement.src = defaultImg;
        }
      }
    });
  }

}
