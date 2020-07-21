/*
 * $copyright$
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class BetOptionException extends BaseException implements Serializable {
    public BetOptionException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public BetOptionException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public BetOptionException(String message) {
        super(message);
    }

    public BetOptionException(String message, Throwable cause) {
        super(message, cause);
    }
}
