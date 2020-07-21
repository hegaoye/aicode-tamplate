/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class StaffException extends BaseException implements Serializable {
    public StaffException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public StaffException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public StaffException(String message) {
        super(message);
    }

    public StaffException(String message, Throwable cause) {
        super(message, cause);
    }
}
