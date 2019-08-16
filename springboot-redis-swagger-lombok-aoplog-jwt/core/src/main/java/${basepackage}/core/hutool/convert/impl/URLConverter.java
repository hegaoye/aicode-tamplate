package ${basePackage}.core.hutool.convert.impl;

import ${basePackage}.core.hutool.convert.AbstractConverter;

import java.io.File;
import java.net.URI;
import java.net.URL;

/**
 * 字符串转换器
 *
 * @author Looly
 */
public class URLConverter extends AbstractConverter<URL> {

    @Override
    protected URL convertInternal(Object value) {
        try {
            if (value instanceof File) {
                return ((File) value).toURI().toURL();
            }

            if (value instanceof URI) {
                return ((URI) value).toURL();
            }
            return new URL(convertToStr(value));
        } catch (Exception e) {
            // Ignore Exception
        }
        return null;
    }

}
