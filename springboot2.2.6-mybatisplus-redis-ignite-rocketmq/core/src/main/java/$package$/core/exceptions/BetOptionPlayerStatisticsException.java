/*
* 投注项统计
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class BetOptionPlayerStatisticsException extends BaseException implements Serializable {
    public BetOptionPlayerStatisticsException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public BetOptionPlayerStatisticsException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public BetOptionPlayerStatisticsException(String message) {
        super(message);
    }

    public BetOptionPlayerStatisticsException(String message, Throwable cause) {
        super(message, cause);
    }
}
