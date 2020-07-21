/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class HandicapBetOptionException extends BaseException implements Serializable {
    public HandicapBetOptionException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public HandicapBetOptionException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public HandicapBetOptionException(String message) {
        super(message);
    }

    public HandicapBetOptionException(String message, Throwable cause) {
        super(message, cause);
    }
}
