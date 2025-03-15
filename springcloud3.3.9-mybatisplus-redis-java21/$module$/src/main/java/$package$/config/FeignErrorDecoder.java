package $package$.config;

import $package$.core.exceptions.BaseException;
import feign.Response;
import feign.Util;
import feign.codec.ErrorDecoder;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.annotation.Configuration;

import java.io.IOException;

@Configuration
@Slf4j
public class FeignErrorDecoder implements ErrorDecoder {

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
