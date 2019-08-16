package ${basePackage}.core.hutool.convert.impl;

import ${basePackage}.core.hutool.convert.AbstractConverter;

import java.util.TimeZone;

/**
 * TimeZone转换器
 *
 * @author Looly
 */
public class TimeZoneConverter extends AbstractConverter<TimeZone> {

    @Override
    protected TimeZone convertInternal(Object value) {
        return TimeZone.getTimeZone(convertToStr(value));
    }

}
