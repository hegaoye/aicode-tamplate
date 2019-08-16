package ${basePackage}.core.tools;

import ${basePackage}.core.common.Constants;
import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.hutool.util.RandomUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

import java.util.regex.Pattern;

/**
 * @Author borong
 * @Date 2019/5/17 15:08
 * @Description: 密码生成器
 */
@Slf4j
public class SecretTools {

    /**
     * 定义生成密码的长度
     */
    private final static int PASSWORD_LENGTH = 32;

    /**
     * 测试生成阿里云服务 各服务连接的 最长密码
     *
     * @param args
     */
    public static void main(String[] args) {

        if (log.isInfoEnabled()) {
            log.info(">>> [ {} ] {} 位密码，redis 缓存库；包含：\t{}", genRedisPwd(), PASSWORD_LENGTH, "大写字母\t小写字母\t数字");
            log.info(">>> [ {} ] {} 位密码，mysql 数据库；包含：\t{}", genDbMysqlPwd(), PASSWORD_LENGTH, "大写字母\t小写字母\t数字\t!@#$%^&*()_+-=");
            log.info(">>> [ {} ] {} 位密码，ECS 云服务器；包含：\t{}", genECSPwd(), PASSWORD_LENGTH, "大写字母\t小写字母\t数字\t()`~!@#$%^&*-+=|{}[]:;'<>,.?/");
            log.info(">>> [ {} ] {} 位密码，高复杂登录密码；包含：\t{}", genAliyunLoginPwd(), PASSWORD_LENGTH, "大写字母\t小写字母\t数字\t()`~!@#$%^&*-+=|{}[]:;'<>,.?/");
            log.info(">>> 检查密码 [ {} ] 是否符合要求 [{}]", "`~!@#$%^&*()_+/*-+[]{}\\<>/?", PwdType.isValidPwd("`~!@#$%^&*()_+/*-+[]{}\\<>/?", PwdType.LETTERS_AND_NUMBERS_AND_SYMBOLS_ALL));
        }
    }


    /**
     * 密码类型
     */
    public enum PwdType {
        LETTERS_AND_NUMBERS("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"),
        LETTERS_AND_NUMBERS_AND_SYMBOLS_Partial("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\\!\\@\\#\\$\\%\\^\\&\\*\\(\\)\\_\\+\\-\\="),
        LETTERS_AND_NUMBERS_AND_SYMBOLS_ALL("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789\\(\\)\\`\\~\\!\\@\\#\\$\\%\\^\\&\\*\\_\\-\\+\\=\\|\\{\\}\\[\\]\\:\\;\\'\\<\\>\\,\\.\\?\\/\\\\"),
        ;
        public String allowCharacter;

        PwdType(String allowCharacter) {
            this.allowCharacter = allowCharacter;
        }

        //通过值获得枚举对象
        public static PwdType getEnum(String name) {
            for (PwdType enums : PwdType.values()) {
                if (enums.name().equalsIgnoreCase(name)) {
                    return enums;
                }
            }
            throw new BaseException(BaseException.ExceptionEnums.enumUndefined(name));
        }

        /**
         * 校验密码是否符合类型要求
         * @param pwd  要校验的密码
         * @param type 密码类型
         * @return
         */
        public static boolean isValidPwd(String pwd, PwdType type) {
            String regex = "["+type.allowCharacter+"]*";
            boolean isMatch = Pattern.matches(regex, pwd);
            return isMatch;
        }
    }

    /**
     * 判断密码长度是否在允许的长度内
     * 默认最小长度 Constants.USER_LOGIN_PWD_MIN_LENGTH
     * 默认最小大度 Constants.USER_LOGIN_PWD_MAX_LENGTH
     * @param pwd 参与判断的密码
     * @return
     */
    public static boolean pwdLengthIsValid(String pwd) {
        return pwdLengthIsValid(pwd, Constants.USER_LOGIN_PWD_MIN_LENGTH, Constants.USER_LOGIN_PWD_MAX_LENGTH);
    }

    /**
     * 判断密码长度是否在允许的长度内
     * @param pwd 参与判断的密码
     * @param min 最小长度 可为空 默认最小长度 Constants.USER_LOGIN_PWD_MIN_LENGTH
     * @param max 最大长度 可为空 默认最大长度 Constants.USER_LOGIN_PWD_MAX_LENGTH
     * @return
     */
    public static boolean pwdLengthIsValid(String pwd, Integer min, Integer max) {
        if (StringUtils.isBlank(pwd)) {
            return false;
        }

        if (min == null) {
            min = Constants.USER_LOGIN_PWD_MIN_LENGTH;
        }
        if (max == null) {
            max = Constants.USER_LOGIN_PWD_MAX_LENGTH;
        }

        if (pwd.length() < min || pwd.length() > max) {
            return false;
        }
        return true;
    }

    /**
     * 判断密码长度是否在允许的长度内
     * 默认最小长度 Constants.USER_LOGIN_PWD_MIN_LENGTH
     * 默认最小大度 Constants.USER_LOGIN_PWD_MAX_LENGTH
     * @param pwd 参与判断的密码
     * @return
     */
    public static void checkPwdLengthIsValid(String pwd) {
        checkPwdLengthIsValid(pwd, Constants.USER_LOGIN_PWD_MIN_LENGTH, Constants.USER_LOGIN_PWD_MAX_LENGTH);
    }

    /**
     * 判断密码长度是否在允许的长度内
     * @param pwd 参与判断的密码
     * @param min 最小长度 可为空 默认最小长度 Constants.USER_LOGIN_PWD_MIN_LENGTH
     * @param max 最大长度 可为空 默认最大长度 Constants.USER_LOGIN_PWD_MAX_LENGTH
     * @return
     */
    public static void checkPwdLengthIsValid(String pwd, Integer min, Integer max) {
        if (StringUtils.isBlank(pwd)) {
            throw new BaseException(BaseException.ExceptionEnums.lengthBetween("密码", min, max));
        }

        if (min == null) {
            min = Constants.USER_LOGIN_PWD_MIN_LENGTH;
        }
        if (max == null) {
            max = Constants.USER_LOGIN_PWD_MAX_LENGTH;
        }

        if (pwd.length() < min || pwd.length() > max) {
            throw new BaseException(BaseException.ExceptionEnums.handleException("设置的密码长度，请保持" + min + "-" + max + "位"));
        }
    }

    /**
     * aliyun 登录 密码 6-20位字符， 只能包含大小写字母、数字以及标点符号（除空格）； 大写字母、小写字母、数字和标点符号至少包含2种
     * </ul>
     *
     * @return String
     */
    private static String genAliyunLoginPwd() {
        StringBuffer sb = new StringBuffer();
        sb.append("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                .append("abcdefghijklmnopqrstuvwxyz")
                .append("0123456789")
                .append("()`~!@#$%^&*-+=|{}[]:;'<>,.?/");
        return RandomUtil.randomString(sb.toString(), PASSWORD_LENGTH);
    }

    /**
     * redis 密码 8-30个字符，需同时包含大写字母、小写字母和数字
     *
     * @return String
     */
    private static String genRedisPwd() {
        StringBuffer sb = new StringBuffer();
        sb.append("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                .append("abcdefghijklmnopqrstuvwxyz")
                .append("0123456789");
        return RandomUtil.randomString(sb.toString(), PASSWORD_LENGTH);
    }

    /**
     * db_mysql 连接密码 大写、小写、数字、特殊字符占三种，长度为8－32位；特殊字符为!@#$%^&*()_+-=
     *
     * @return String
     */
    private static String genDbMysqlPwd() {
        StringBuffer sb = new StringBuffer();
        sb.append("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                .append("abcdefghijklmnopqrstuvwxyz")
                .append("0123456789")
                .append("!@#$%^&*()_+-=");
        return RandomUtil.randomString(sb.toString(), PASSWORD_LENGTH);
    }

    /**
     * ECS 服务器管理密码 8-30个字符
     * 必须同时包含下面四项中的三项：
     * 1. 大写字母
     * 2. 小写字母
     * 3. 数字
     * 4. 特殊字符（仅支持下列特殊字符： ( ) ` ~ ! @ # $ % ^ & * - + = | { } [ ] : ; ' < > , . ? / ）
     *
     * @return String
     */
    private static String genECSPwd() {
        StringBuffer sb = new StringBuffer();
        sb.append("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
                .append("abcdefghijklmnopqrstuvwxyz")
                .append("0123456789")
                .append("()`~!@#$%^&*-+=|{}[]:;'<>,.?/");
        return RandomUtil.randomString(sb.toString(), PASSWORD_LENGTH);
    }
}