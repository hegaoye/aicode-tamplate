package ${basePackage}.core.hutool.convert.impl;

import ${basePackage}.core.hutool.convert.AbstractConverter;
import ${basePackage}.core.hutool.convert.ConverterRegistry;
import ${basePackage}.core.hutool.util.ClassUtil;

import java.util.concurrent.atomic.AtomicReference;

/**
 * {@link AtomicReference}转换器
 *
 * @author Looly
 * @since 3.0.8
 */
@SuppressWarnings("rawtypes")
public class AtomicReferenceConverter extends AbstractConverter<AtomicReference> {

    @Override
    protected AtomicReference<?> convertInternal(Object value) {

        //尝试将值转换为Reference泛型的类型
        Object targetValue = null;
        final Class<?> paramType = ClassUtil.getTypeArgument(AtomicReference.class);
        if (null != paramType) {
            targetValue = ConverterRegistry.getInstance().convert(paramType, value);
        }
        if (null == targetValue) {
            targetValue = value;
        }

        return new AtomicReference<>(targetValue);
    }

}
