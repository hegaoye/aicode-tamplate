/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class SubHandicapException extends BaseException implements Serializable {
    public SubHandicapException(BaseException.BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public SubHandicapException(BaseException.BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public SubHandicapException(String message) {
        super(message);
    }

    public SubHandicapException(String message, Throwable cause) {
        super(message, cause);
    }
}
