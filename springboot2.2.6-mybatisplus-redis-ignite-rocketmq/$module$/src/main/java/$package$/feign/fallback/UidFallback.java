package $package$.feign.fallback;

import $package$.feign.UidClient;
import org.springframework.stereotype.Component;

@Component
public class UidFallback implements UidClient {


    @Override
    public Long uid() {
        return null;
    }


}
