package ${basePackage}.core.hutool.convert.impl;

import ${basePackage}.core.hutool.convert.AbstractConverter;
import ${basePackage}.core.hutool.util.CharsetUtil;

import java.nio.charset.Charset;

/**
 * 编码对象转换器
 *
 * @author Looly
 */
public class CharsetConverter extends AbstractConverter<Charset> {

    @Override
    protected Charset convertInternal(Object value) {
        return CharsetUtil.charset(convertToStr(value));
    }

}
