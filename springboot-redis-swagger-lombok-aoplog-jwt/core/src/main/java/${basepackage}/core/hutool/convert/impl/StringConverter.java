package ${basePackage}.core.hutool.convert.impl;

import ${basePackage}.core.hutool.convert.AbstractConverter;

/**
 * 字符串转换器
 *
 * @author Looly
 */
public class StringConverter extends AbstractConverter<String> {

    @Override
    protected String convertInternal(Object value) {
        return convertToStr(value);
    }

}
