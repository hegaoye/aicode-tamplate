package ${basePackage}.core.hutool.convert.impl;

import ${basePackage}.core.hutool.convert.AbstractConverter;

/**
 * 波尔转换器
 *
 * @author Looly
 */
public class BooleanConverter extends AbstractConverter<Boolean> {

    @Override
    protected Boolean convertInternal(Object value) {
        if (boolean.class == value.getClass()) {
            return Boolean.valueOf((boolean) value);
        }
        String valueStr = convertToStr(value);
        return Boolean.valueOf(PrimitiveConverter.parseBoolean(valueStr));
    }

}
