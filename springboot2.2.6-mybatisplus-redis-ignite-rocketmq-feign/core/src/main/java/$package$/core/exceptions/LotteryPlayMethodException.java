/*
 * $copyright$
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class LotteryPlayMethodException extends BaseException implements Serializable {
    public LotteryPlayMethodException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public LotteryPlayMethodException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public LotteryPlayMethodException(String message) {
        super(message);
    }

    public LotteryPlayMethodException(String message, Throwable cause) {
        super(message, cause);
    }
}
