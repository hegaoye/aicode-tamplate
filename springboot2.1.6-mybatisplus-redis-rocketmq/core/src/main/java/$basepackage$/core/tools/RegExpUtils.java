package $package$.core.tools;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegExpUtils {

  /**
   * 手机格式验证
   *
   * @param phone
   */
  public static boolean checkPhone(String phone) {
    String regExp =
        "^[1](([3][0-9])|([4][5,7,9])|([5][^4,6,9])|([6][6])|([7][3,5,6,7,8])|([8][0-9])|([9][8,9]))[0-9]{8}\$"; // 验证手机号
    Pattern p = Pattern.compile(regExp);
    Matcher m = p.matcher(phone);
    return m.matches();
  }

  public static boolean checkEmail(String eMail) {
    String RULE_EMAIL =
        "^\\w+((-\\w+)|(\\.\\w+))*\\@[A-Za-z0-9]+((\\.|-)[A-Za-z0-9]+)*\\.[A-Za-z0-9]+\$";
    // 正则表达式的模式 编译正则表达式
    Pattern p = Pattern.compile(RULE_EMAIL);
    // 正则表达式的匹配器
    Matcher m = p.matcher(eMail);
    // 进行正则匹配\
    return m.matches();
  }

  public static void main(String[] args) {
    RegExpUtils regExpUtils = new RegExpUtils();
    System.out.print("电话验证匹配------" + regExpUtils.checkPhone("17722198275") + "\n");

    System.out.print(
        "邮箱验证匹配------" + regExpUtils.checkEmail("ajlkfdja1287@dfk9163.com.cfdjaljfdkaln") + "\n");
  }
}
