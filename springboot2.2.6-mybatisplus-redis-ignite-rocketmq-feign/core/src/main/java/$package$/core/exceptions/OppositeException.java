/*
* kg
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class OppositeException extends BaseException implements Serializable {
    public OppositeException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public OppositeException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public OppositeException(String message) {
        super(message);
    }

    public OppositeException(String message, Throwable cause) {
        super(message, cause);
    }
}
