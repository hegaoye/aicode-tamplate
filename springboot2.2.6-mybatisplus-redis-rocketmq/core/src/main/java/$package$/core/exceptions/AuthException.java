/*
* ds
 */
package $package$.core.exceptions;

import java.io.Serializable;

public class AuthException extends BaseException implements Serializable {
    public AuthException(BaseExceptionEnum exceptionMessage) {
        super(exceptionMessage);
    }

    public AuthException(BaseExceptionEnum exceptionMessage, Object... params) {
        super(exceptionMessage, params);
    }

    public AuthException(String message) {
        super(message);
    }

    public AuthException(String message, Throwable cause) {
        super(message, cause);
    }
}
