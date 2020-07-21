/*
 * $copyright$
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class BetOptionValueException extends BaseException implements Serializable {
    public BetOptionValueException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public BetOptionValueException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public BetOptionValueException(String message) {
        super(message);
    }

    public BetOptionValueException(String message, Throwable cause) {
        super(message, cause);
    }
}
