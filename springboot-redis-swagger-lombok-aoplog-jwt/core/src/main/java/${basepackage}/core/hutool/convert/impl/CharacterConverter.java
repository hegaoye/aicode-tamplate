package ${basePackage}.core.hutool.convert.impl;

import ${basePackage}.core.hutool.convert.AbstractConverter;
import ${basePackage}.core.hutool.util.StrUtil;

/**
 * 字符转换器
 *
 * @author Looly
 */
public class CharacterConverter extends AbstractConverter<Character> {

    @Override
    protected Character convertInternal(Object value) {
        if (char.class == value.getClass()) {
            return Character.valueOf((char) value);
        } else {
            final String valueStr = convertToStr(value);
            if (StrUtil.isNotBlank(valueStr)) {
                return Character.valueOf(valueStr.charAt(0));
            }
        }
        return null;
    }

}
