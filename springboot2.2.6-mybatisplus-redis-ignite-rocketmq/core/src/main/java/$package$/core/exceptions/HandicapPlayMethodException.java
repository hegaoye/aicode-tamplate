/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class HandicapPlayMethodException extends BaseException implements Serializable {
    public HandicapPlayMethodException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public HandicapPlayMethodException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public HandicapPlayMethodException(String message) {
        super(message);
    }

    public HandicapPlayMethodException(String message, Throwable cause) {
        super(message, cause);
    }
}
