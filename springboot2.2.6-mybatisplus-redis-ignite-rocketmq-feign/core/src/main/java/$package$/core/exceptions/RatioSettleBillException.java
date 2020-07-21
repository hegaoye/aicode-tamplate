/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class RatioSettleBillException extends BaseException implements Serializable {
    public RatioSettleBillException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public RatioSettleBillException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public RatioSettleBillException(String message) {
        super(message);
    }

    public RatioSettleBillException(String message, Throwable cause) {
        super(message, cause);
    }
}
