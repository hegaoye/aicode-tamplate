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
public class URIConverter extends AbstractConverter<URI> {

    @Override
    protected URI convertInternal(Object value) {
        try {
            if (value instanceof File) {
                return ((File) value).toURI();
            }

            if (value instanceof URL) {
                return ((URL) value).toURI();
            }
            return new URI(convertToStr(value));
        } catch (Exception e) {
            // Ignore Exception
        }
        return null;
    }

}
