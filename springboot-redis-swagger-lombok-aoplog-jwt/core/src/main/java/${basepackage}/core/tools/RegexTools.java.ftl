/*
 * ${copyright}
 */
package ${basePackage}.core.tools;

import org.apache.commons.lang3.StringUtils;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static java.util.regex.Pattern.compile;

/**
 * @Author borong
 * @Date 2019/5/17 15:08
 * @Description: 正则表达式工具类
 */
public class RegexTools {

    /**
     * 检查邮箱地址格式
     *
     * @param email 邮箱
     * @return boolean
     */
    public static boolean isEmail(String email) {
        if (StringUtils.isBlank(email)) {
            return false;
        }
        Pattern pattern = compile("^\\w[-\\w.+]*@([A-Za-z0-9][-A-Za-z0-9]+\\.)+[A-Za-z]{2,14}$");
        Matcher matcher = pattern.matcher(email);
        return matcher.matches();
    }

    /**
     * 判断是否是数字
     *
     * @param str 被检查的字符串
     * @return boolean
     */
    public static boolean isNumeric(String str) {
        if (StringUtils.isBlank(str)) {
            return false;
        }
        Pattern pattern = compile("^-?[0-9]+$");
        return pattern.matcher(str).matches();
    }

    /**
     * 判断是否是浮点数字
     *
     * @param str 被检查的字符串
     * @return boolean
     */
    public static boolean isFloat(String str) {
        if (StringUtils.isBlank(str)) {
            return false;
        }
        Pattern pattern = compile("(^-?[0-9]+$)|(^-?[0-9]+(.?[0-9]+)$)");
        return pattern.matcher(str).matches();
    }

    /**
     * 判断是否是手机号码
     *
     * @param str 被检查的字符串
     * @return boolean
     */
    public static boolean isPhone(String str) {
        if (StringUtils.isBlank(str)) {
            return false;
        }
        Pattern pattern = compile("^(\\+\\d{2,5}-?)?1\\d{10}$");
        return pattern.matcher(str).matches();
    }

    /**
     * 判断是否是座机号
     *
     * @param str 被检查的字符串
     * @return boolean
     */
    public static boolean isTelePhone(String str) {
        if (StringUtils.isBlank(str)) {
            return false;
        }
        Pattern pattern = compile("(^\\+?(\\d{2,5})-(\\d{7,8})$)|(^\\+?(\\d{2,5})-(\\d{7,8})-(\\d+)$)");
        return pattern.matcher(str).matches();
    }

    /**
     * 判断是否符合（字母数字组合，且以字母开头）
     *
     * @param str 被检查的字符串
     * @return boolean
     */
    public static boolean isLetterAndNumberAndStartWithLetter(String str) {
        if (StringUtils.isBlank(str)) {
            return false;
        }
        Pattern pattern = compile("^[A-Za-z]+[0-9]*[A-Za-z0-9]*$");;
        return pattern.matcher(str).matches();
    }
}