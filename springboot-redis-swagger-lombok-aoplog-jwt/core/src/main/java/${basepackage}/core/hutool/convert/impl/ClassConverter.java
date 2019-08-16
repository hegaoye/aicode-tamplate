package ${basePackage}.core.hutool.convert.impl;

import ${basePackage}.core.hutool.convert.AbstractConverter;
import ${basePackage}.core.hutool.util.ClassUtil;

/**
 * 类转换器<br>
 * 将类名转换为类
 *
 * @author Looly
 */
public class ClassConverter extends AbstractConverter<Class<?>> {

    @Override
    protected Class<?> convertInternal(Object value) {
        String valueStr = convertToStr(value);
        try {
            return ClassUtil.getClassLoader().loadClass(valueStr);
        } catch (Exception e) {
            // Ignore Exception
        }
        return null;
    }

}
