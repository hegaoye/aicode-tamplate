/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class HandicapException extends BaseException implements Serializable {
    public HandicapException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public HandicapException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public HandicapException(String message) {
        super(message);
    }

    public HandicapException(String message, Throwable cause) {
        super(message, cause);
    }
}
