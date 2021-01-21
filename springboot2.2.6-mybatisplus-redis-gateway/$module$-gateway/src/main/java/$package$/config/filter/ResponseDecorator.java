package $package$.config.filter;

import lombok.extern.slf4j.Slf4j;
import org.reactivestreams.Publisher;
import org.springframework.core.io.buffer.DataBuffer;
import org.springframework.core.io.buffer.DataBufferFactory;
import org.springframework.core.io.buffer.DataBufferUtils;
import org.springframework.core.io.buffer.DefaultDataBufferFactory;
import org.springframework.http.server.reactive.ServerHttpResponse;
import org.springframework.http.server.reactive.ServerHttpResponseDecorator;
import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

import java.nio.charset.Charset;

/**
 * 响应包装器
 *
 * @author hello50
 * @date 2021/1/20 4:43 下午
 */
@Slf4j
public class ResponseDecorator extends ServerHttpResponseDecorator {

    public ResponseDecorator(ServerHttpResponse delegate) {
        super(delegate);
    }

    @Override
    @SuppressWarnings(value = "unchecked")
    public Mono<Void> writeWith(Publisher<? extends DataBuffer> body) {
        if (body instanceof Flux) {
            Flux<DataBuffer> fluxBody = (Flux<DataBuffer>) body;

            return super.writeWith(fluxBody.buffer().map(dataBuffers -> {
                DataBufferFactory dataBufferFactory = new DefaultDataBufferFactory();
                DataBuffer join = dataBufferFactory.join(dataBuffers);

                byte[] content = new byte[join.readableByteCount()];
                join.read(content);
                DataBufferUtils.release(join);

                String bodyStr = new String(content, Charset.forName("UTF-8"));
                log.info("返回值数据-{}", bodyStr);

                getDelegate().getHeaders().setContentLength(bodyStr.getBytes().length);
                return bufferFactory().wrap(bodyStr.getBytes());
            }));
        }
        return super.writeWith(body);
    }

}
