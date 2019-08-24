/*
 * ${copyright}
 */
package ${basePackage}.core.enums;

import ${basePackage}.core.exceptions.BaseException;
import ${basePackage}.core.hutool.util.NumberUtil;
import ${basePackage}.core.hutool.util.StrUtil;

import java.util.regex.Pattern;

import static java.util.regex.Pattern.compile;

/**
 * Copyright 2019 @http://www.rzhkj.com
 *
 * @Author borong
 * @Date 2019/8/22 10:31
 * @Description: 密码强度正则枚举
 */
public enum PasswordLevelRegexEnum {
    // 强度
    level_6(compile("^.*(?=.{6,20})(?=.*\\d)(?=.*[A-Z]{2,})(?=.*[a-z]{2,})(?=.*[!@#$%^&*?\\(\\)]).*$")),
    level_5(compile("^.*(?=.{6,20})(?=.*\\d)(?=.*[A-Z]{1,})(?=.*[a-z]{1,})(?=.*[!@#$%^&*?\\(\\)]).*$")),
    level_4(compile("^.*(?=.{6,20})(?=.*\\d)(?=.*[A-Z]{1,})(?=.*[a-z]{2,}).*$")),
    level_3(compile("^.*(?=.{6,20})(?=.*\\d)(?=.*[A-Z]{1,})(?=.*[a-z]{1,}).*$")),
    level_2(compile("^.*(?=.{6,20})(?=.*\\d)(?=.*[a-z]{1,}).*$")),
    // 最短6位，最长16位 {6,20}，必须包含1个数字，必须包含2个大写字母，必须包含2个小写字母，必须包含1个特殊字符
    level_1(compile("^[0-9]{6,20}$")),

    // 6至20位密码
    level_anyone_letter_and_number_6_to_20(compile("^[\\w]{6,20}$")),
    ;
    public Pattern pattern;

    private final static String LEVEL_HEADER = "level_";


    PasswordLevelRegexEnum(Pattern pattern) {
        this.pattern = pattern;
    }

    public static PasswordLevelRegexEnum getEnum(String name) {
        for (PasswordLevelRegexEnum enums : PasswordLevelRegexEnum.values()) {
            if (enums.pattern.equals(name)) {
                return enums;
            }
        }
        throw new BaseException(BaseException.ExceptionEnums.enumUndefined(name));
    }

    /**
     * 获取密码强度级别
     *
     * @param password
     * @return
     */
    public int getLevel(String password) {
        for (PasswordLevelRegexEnum enums : PasswordLevelRegexEnum.values()) {
            if (enums.pattern.matcher(password).matches()) {
                return enums.getLevel();
            }
        }
        return 0;
    }

    /**
     * 检查密码是否符合规则
     *
     * @param password
     * @param regexEnum
     * @return
     */
    public static boolean checkPassword(String password, PasswordLevelRegexEnum regexEnum) {
        return regexEnum.pattern.matcher(password).matches();
    }

    public int getLevel() {
        String level = StrUtil.removePrefix(this.name(), LEVEL_HEADER);
        return NumberUtil.isNumber(level) ? Integer.parseInt(level) : 0;
    }
}
