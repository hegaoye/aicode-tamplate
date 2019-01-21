/**
 * Created by Administrator on 2018/9/4 0004.
 * 可以将枚举信息都放在这里
 */

/**
 * http请求返回的状态码枚举
 */
export enum HttpCodesEnum {
  Success = '0000', //返回成功
  logout = '9001', //已退出登录
}

/**
 *获取枚举信息的传入状态码枚举
 */
export enum Enums {
  state = 1010,  // 状态
}

export enum States {
  enable = "Enable",//启用
  disable = "Disable",//禁用
}
