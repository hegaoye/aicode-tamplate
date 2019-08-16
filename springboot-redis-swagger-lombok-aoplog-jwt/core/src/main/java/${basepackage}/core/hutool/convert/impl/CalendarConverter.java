package ${basePackage}.core.hutool.convert.impl;

import ${basePackage}.core.hutool.convert.AbstractConverter;
import ${basePackage}.core.hutool.date.DateUtil;
import ${basePackage}.core.hutool.util.StrUtil;

import java.util.Calendar;
import java.util.Date;

/**
 * 日期转换器
 *
 * @author Looly
 */
public class CalendarConverter extends AbstractConverter<Calendar> {

    /**
     * 日期格式化
     */
    private String format;

    /**
     * 获取日期格式
     *
     * @return 设置日期格式
     */
    public String getFormat() {
        return format;
    }

    /**
     * 设置日期格式
     *
     * @param format 日期格式
     */
    public void setFormat(String format) {
        this.format = format;
    }

    @Override
    protected Calendar convertInternal(Object value) {
        // Handle Date
        if (value instanceof Date) {
            return DateUtil.calendar((Date) value);
        }

        // Handle Long
        if (value instanceof Long) {
            //此处使用自动拆装箱
            return DateUtil.calendar((Long) value);
        }

        final String valueStr = convertToStr(value);
        return DateUtil.calendar(StrUtil.isBlank(format) ? DateUtil.parse(valueStr) : DateUtil.parse(valueStr, format));
    }

}
