package ${basePackage}.core.hutool.convert.impl;

import ${basePackage}.core.hutool.convert.AbstractConverter;
import ${basePackage}.core.hutool.convert.ConverterRegistry;
import ${basePackage}.core.hutool.util.ArrayUtil;

/**
 * byte 类型数组转换器
 *
 * @author Looly
 */
public class ByteArrayConverter extends AbstractConverter<byte[]> {

    @Override
    protected byte[] convertInternal(Object value) {
        final Byte[] result = ConverterRegistry.getInstance().convert(Byte[].class, value);
        return ArrayUtil.unWrap(result);
    }

}
