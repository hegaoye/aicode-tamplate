/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class HandicapBetOptionValueException extends BaseException implements Serializable {
    public HandicapBetOptionValueException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public HandicapBetOptionValueException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public HandicapBetOptionValueException(String message) {
        super(message);
    }

    public HandicapBetOptionValueException(String message, Throwable cause) {
        super(message, cause);
    }
}
