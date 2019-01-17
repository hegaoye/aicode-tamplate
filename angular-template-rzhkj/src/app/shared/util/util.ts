/*公共JS库*/
import { Injectable } from '@angular/core';
import { isUndefined } from 'util';

@Injectable()
export class Util {

  constructor() {
  }

  /**
   * 格式化日期
   * @param date 日期对象
   * @param fmt  格式化形式
   * @returns {any}
   */
  public static dataFormat = function(date: Date, fmt?: string) {
    if (!fmt) fmt = 'yyyy-MM-dd HH:mm:ss';
    var o = {
      'M+': date.getMonth() + 1, //月份
      'd+': date.getDate(), //日
      'H+': date.getHours(), //小时
      'm+': date.getMinutes(), //分
      's+': date.getSeconds(), //秒
      'q+': Math.floor((date.getMonth() + 3) / 3), //季度
      'S': date.getMilliseconds(), //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));
    for (var k in o)
      if (new RegExp('(' + k + ')').test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (('00' + o[k]).substr(('' + o[k]).length)));
    return fmt;
  };


  /**
   * 获取时间间隔
   * @param {Date} date 参与计算的时间（被减数）
   * @param {Date} myDate 参与计算的时间（减数--默认为当前时间）
   * 返回结果：
   * {
      state: state,     //状态判断，1：代表时间未到，-1：代表时间已过
      day: day,         //间隔的天数
      hour: hour,       //间隔的小时
      minute: minute,   //间隔的分钟
      second: second    //间隔的秒数
    }
   */
  public static getTimeInterval(date: Date, myDate?: Date) {
    if (!myDate) myDate = new Date(); //默认当前时间
    let time = date.getTime() - myDate.getTime(), state = 1;
    if (time < 0) state = -1, time = myDate.getTime() - date.getTime();
    var day = Math.floor(time / 1000 / 60 / 60 / 24);//天
    var hour = Math.floor(time / 1000 / 60 / 60 % 24);//时
    var minute = Math.floor(time / 1000 / 60 % 60);//分
    var second = Math.floor(time / 1000 % 60);//秒
    return {
      state: state,
      day: day,
      hour: hour,
      minute: minute,
      second: second,
    };
  }

  /**
   * 根据指定日期，获取其前后月份
   * @param date 指定日期
   * @param num  时间 （1代表后一月，2代表后两月，-1代表前一月......等等）
   */
  public static getAroundDateByMonth = function(date: Date, num: number) {
    date.setMonth(date.getMonth() + num);
    return date;
  };

  /**
   * 根据指定日期，获取其前后日期
   * @param date 指定日期
   * @param num  时间 （1代表后一天，2代表后两天，-1代表前一天......等等）
   */
  public static getAroundDateByDate = function(date: Date, num: number) {
    return new Date(date.getTime() + (1000 * 60 * 60 * 24) * num);
  };

  /**
   * 根据指定时间，获取其前后日期
   * @param date 指定日期
   * @param num  时间 （1代表后一小时，2代表后两小时，-1代表前一小时......等等）
   */
  public static getAroundDateByHour = function(date: Date, num: number) {
    return new Date(date.getTime() + (1000 * 60 * 60) * num);
  };

  /**
   *
   * 根据日期获取是星期几
   * @param date 日期
   * @param lan 语言（'cn':中文，'en':英语）默认中文
   * @returns {string}
   */
  public static getWeek = function(date: Date, lan?) {
    let today = new Array('周日', '周一', '周二', '周三', '周四', '周五', '周六');
    if (!isUndefined(lan) && lan == 'en') today = new Array('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
    let week = today[date.getDay()];
    return week;
  };

  /**
   * 获取日期时间戳
   * @param string 日期：2017-08-14 或 2017-08-14 15:30:00
   * @returns {number}
   * @constructor
   */
  public static dateToUnix = function(string) {
    var f = string.split(' ', 2);
    var d = (f[0] ? f[0] : '').split('-', 3);
    var t = (f[1] ? f[1] : '').split(':', 3);
    return (new Date(
      parseInt(d[0], 10) || null,
      (parseInt(d[1], 10) || 1) - 1,
      parseInt(d[2], 10) || null,
      parseInt(t[0], 10) || null,
      parseInt(t[1], 10) || null,
      parseInt(t[2], 10) || null,
    )).getTime();
  };

  /**
   *最近十年 (已当前的年份为起点，获取之前十年的信息)
   * @returns {Array} ["2017", "2016", "2015", "2014", "2013", "2012", "2011", "2010", "2009", "2008"]
   */
  public static tenYear = function() {
    let nowYear: number = new Date().getFullYear(), tenYearArr: Array<string> = new Array();
    for (let i = 0; i < 10; i++) {
      tenYearArr.push(nowYear.toString());
      nowYear--;
    }
    return tenYearArr;
  };

  /**
   * 获取月份
   * @returns {Array} 如：["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
   */
  public static getMonth = function() {
    let monthArr: Array<string> = new Array();
    for (let i = 0; i < 12; i++) {
      if (i < 9) monthArr.push('0' + (i + 1).toString());
      else monthArr.push((i + 1).toString());
    }
    return monthArr;
  };

}
