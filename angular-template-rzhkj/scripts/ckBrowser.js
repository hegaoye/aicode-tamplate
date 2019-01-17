/********************************* 浏览器版本判断及引导 ***************************************************************/
//当ie版本小于10时，引导下载谷歌浏览器
var bAskInfo = "尊敬的用户，系统检测到您的浏览器太老了~ 为了方便您的使用，建议下载谷歌浏览器。去下载？",
  bCancelInfo = "您取消了下载，因为您浏览器太老了，已经跑不动了.... 这将影响您的使用",
  bUrl = "https://www.google.cn/chrome/";
if (navigator.appName == "Microsoft Internet Explorer" && parseInt(navigator.appVersion.split(";")[1].replace(/[ ]/g, "").replace("MSIE", "")) < 11) {
  if (window.confirm(bAskInfo)) window.location.href = bUrl; else alert(bCancelInfo);
}
