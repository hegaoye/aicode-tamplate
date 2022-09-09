package $package$.config;

import $package$.core.exceptions.BaseException;
import feign.Response;
import feign.Util;
import feign.codec.ErrorDecoder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.ObjectProvider;
import org.springframework.boot.autoconfigure.condition.ConditionalOnMissingBean;
import org.springframework.boot.autoconfigure.http.HttpMessageConverters;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.converter.HttpMessageConverter;

import java.io.IOException;
import java.util.stream.Collectors;

/**
 * Created by $author$ on 2018/8/13.
 */
@Configuration
@Slf4j
public class FeignErrorDecoder implements ErrorDecoder {

    @Bean
    @ConditionalOnMissingBean
    public HttpMessageConverters messageConverters(ObjectProvider<HttpMessageConverter<?>> converters) {
        return new HttpMessageConverters(converters.orderedStream().collect(Collectors.toList()));
    }

    @Override
    public Exception decode(String methodKey, Response response) {
        log.debug("methodKey >>> " + methodKey);
        try {
            String message = Util.toString(response.body().asReader());
            return new BaseException(message);
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


}
